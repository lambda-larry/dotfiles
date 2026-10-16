include pkg/pkg.mk

deploy-pkg:   deploy-qbe
clean-pkg:    clean-qbe
undeploy-pkg: undeploy-qbe

deploy-qbe: ${PREFIX}/lambda-larry/prefix/bin/qbe

undeploy-qbe:
	$(RM) ${PREFIX}/lambda-larry/prefix/bin/qbe

clean-qbe:
	$(RM) pkg/qbe/*.o pkg/qbe/*/*.o pkg/qbe/qbe

pkg/qbe/%.o: CC       := gcc
pkg/qbe/%.o: CFLAGS   := -std=c99 -pedantic
pkg/qbe/%.o: CFLAGS   += -O2
pkg/qbe/%.o: CPPFLAGS += -MMD

pkg/qbe/qbe: LDFLAGS  += -static

-include $(wildcard pkg/qbe/*.d)
-include $(wildcard pkg/qbe/*/*.d)

pkg/qbe/qbe: $(patsubst %.c, %.o, $(wildcard pkg/qbe/*.c))
pkg/qbe/qbe: $(patsubst %.c, %.o, $(wildcard pkg/qbe/amd64/*.c))
pkg/qbe/qbe: $(patsubst %.c, %.o, $(wildcard pkg/qbe/arm64/*.c))
pkg/qbe/qbe: $(patsubst %.c, %.o, $(wildcard pkg/qbe/rv64/*.c))

pkg/qbe/qbe:
	$(CC) $(LDFLAGS) $^ -o $@

pkg/qbe/config.h:
	@case `uname` in                               \
	*Darwin*)                                      \
		case `uname -m` in                     \
		*arm64*)                               \
			echo "#define Deftgt T_arm64_apple";\
			;;                             \
		*)                                     \
			echo "#define Deftgt T_amd64_apple";\
			;;                             \
		esac                                   \
		;;                                     \
	*)                                             \
		case `uname -m` in                     \
		*aarch64*|*arm64*)                     \
			echo "#define Deftgt T_arm64"; \
			;;                             \
		*riscv64*)                             \
			echo "#define Deftgt T_rv64";  \
			;;                             \
		*)                                     \
			echo "#define Deftgt T_amd64_sysv";\
			;;                             \
		esac                                   \
		;;                                     \
	esac > $@


${PREFIX}/lambda-larry/prefix/bin/%: pkg/qbe/%
	install -Dm 0755 $< $@
