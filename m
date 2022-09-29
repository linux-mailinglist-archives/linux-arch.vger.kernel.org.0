Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E555EF892
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiI2PWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiI2PWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 11:22:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9463F14FE00;
        Thu, 29 Sep 2022 08:22:02 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.59]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtOX2-1pWIr92Ly2-00use3; Thu, 29 Sep 2022 17:21:29 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A94883C015;
        Thu, 29 Sep 2022 17:21:27 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 4B78F234; Thu, 29 Sep 2022 17:21:25 +0200 (CEST)
Date:   Thu, 29 Sep 2022 17:21:25 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 7/7] kbuild: remove head-y syntax
Message-ID: <YzW39dPc5T0nllMR@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="efySUFyLQCRvleuI"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-8-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:9KU+yT6ohAIjObmzAa/Y7qG0AoJbPHF/exDYRf2hcxLaNf6ZapX
 aHu1eoVjcFOhl2ZrMBGA+xhHSxQuCyfW07Ccq5JAcZuVLv5ZqY6WKncnHdo3GqioVrOPguP
 K2xTkupA0jKHVWzTShQlWAYL5rZUrIJeoYMt3WQb5TOMpwwDwj/7/D2CMDlh5Dq8g6zQYWw
 GIfw7XPtsKuro98tzHjsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPHiCEufAqU=:oShWQ+Dq6IUiyv/qcsPY1V
 mtJ4xIwEno7aoSCwjoCvqhHqNkkpPvQsAnIruZH/P+Gz0uJSblMnHZV72hlzq6kO7hFBm0Maz
 p0ZxxKy06ELuuMLeY9cNt/nEbRChpE3uM6vmDoJGjUqXGTa+hqkqPlEVF/MgRaGC2mH4l/VXC
 JfO8viwPjwZ90X7EQ2P60PSQAQMWTVXvLTbnyqveTwIr05rmPiuCknt+DJyWK218Bsi5ACl2o
 v3zGBuFWozSDJ9oIh5kwaCmGqX4UVK4KL/urNy4PGS/pYBXFhNYo/kqfRm0nJj66flWknhYjD
 mCt1UTbDy3kSJG0+eNfZger5v7AWwUj0qzZIBhaxaZkAWF56sERKPUe5z3T65N5OBJQRVz6/b
 NHdQtwcx0E9GChIg9Qx2docdgT8LQjVGiz3OotnnO1eKq4p8Ca0YhCW1TeeBxTvvv1WCGn+uv
 ebjO0QCHlkAvBP/ZxQBXo/Ob0j6F2vQnZEUcccf+VU39AiyEIQSkrNhoJn1EE+wIntvbUVhrj
 Fm+QCkrpfB/0Sr0yn0gxMD8wRHkCr5pFktfDZJ6qCxIz6clZwpP+NUYLQbz5wO+EfZIsdN4dZ
 oucQFQPKtqkhGD/reqFQ6O68cKR4OecPGnCc6a7j1A+gBGWjp0dCMXDC2/bkd25iz5LHEZKz9
 XEJ6gMwutNJmgvWmBjb0P+PvVRW9XPH6P1PyP3UFUpDZCI5g6hQzeTVQYad13uSVEIZ0MMIwY
 B0rtx+PFiY7XblmJsi7rX4Z3swdYTHFpkxPBtoLZFTNdioAI7sOb7zIfDGQ6wlsNELmuNQb3Z
 b2PHpDZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--efySUFyLQCRvleuI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:15 +0900 Masahiro Yamada wrote:
> Kbuild puts the objects listed in head-y at the head of vmlinux.
> Conventionally, we do this for head*.S, which contains the kernel entry
> point.
>=20
> A counter approach is to control the section order by the linker script.
> Actually, the code marked as __HEAD goes into the ".head.text" section,
> which is placed before the normal ".text" section.
>=20
> I do not know if both of them are needed. From the build system
> perspective, head-y is not mandatory. If you can achieve the proper code
> placement by the linker script only, it would be cleaner.
>=20
> I collected the current head-y objects into head-object-list.txt. It is
> a whitelist. My hope is it will be reduced in the long run.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

(sorry for the sending this one so late, it got lost yesterday.)

> (no changes since v1)
>=20
>  Documentation/kbuild/makefiles.rst |  9 ++---
>  Makefile                           |  4 +--
>  arch/alpha/Makefile                |  2 --
>  arch/arc/Makefile                  |  2 --
>  arch/arm/Makefile                  |  3 --
>  arch/arm64/Makefile                |  3 --
>  arch/csky/Makefile                 |  2 --
>  arch/hexagon/Makefile              |  2 --
>  arch/ia64/Makefile                 |  1 -
>  arch/loongarch/Makefile            |  2 --
>  arch/m68k/Makefile                 |  9 -----
>  arch/microblaze/Makefile           |  1 -
>  arch/mips/Makefile                 |  2 --
>  arch/nios2/Makefile                |  1 -
>  arch/openrisc/Makefile             |  2 --
>  arch/parisc/Makefile               |  2 --
>  arch/powerpc/Makefile              | 12 -------
>  arch/riscv/Makefile                |  2 --
>  arch/s390/Makefile                 |  2 --
>  arch/sh/Makefile                   |  2 --
>  arch/sparc/Makefile                |  2 --
>  arch/x86/Makefile                  |  5 ---
>  arch/xtensa/Makefile               |  2 --
>  scripts/head-object-list.txt       | 53 ++++++++++++++++++++++++++++++
>  24 files changed, 60 insertions(+), 67 deletions(-)
>  create mode 100644 scripts/head-object-list.txt
>=20
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/ma=
kefiles.rst
> index 5a6a8426cc97..60134ddf3db1 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -1070,8 +1070,7 @@ When kbuild executes, the following steps are follo=
wed (roughly):
>     - The values of the above variables are expanded in arch/$(SRCARCH)/M=
akefile.
>  5) All object files are then linked and the resulting file vmlinux is
>     located at the root of the obj tree.
> -   The very first objects linked are listed in head-y, assigned by
> -   arch/$(SRCARCH)/Makefile.
> +   The very first objects linked are listed in scripts/head-object-list.=
txt.
>  6) Finally, the architecture-specific part does any required post proces=
sing
>     and builds the final bootimage.
>     - This includes building boot records
> @@ -1219,6 +1218,9 @@ When kbuild executes, the following steps are follo=
wed (roughly):
>  	All object files for vmlinux. They are linked to vmlinux in the same
>  	order as listed in KBUILD_VMLINUX_OBJS.
> =20
> +	The objects listed in scripts/head-object-list.txt are exceptions;
> +	they are placed before the other objects.
> +
>      KBUILD_VMLINUX_LIBS
> =20
>  	All .a "lib" files for vmlinux. KBUILD_VMLINUX_OBJS and
> @@ -1262,8 +1264,7 @@ When kbuild executes, the following steps are follo=
wed (roughly):
>  	machinery is all architecture-independent.
> =20
> =20
> -	head-y, core-y, libs-y, drivers-y
> -	    $(head-y) lists objects to be linked first in vmlinux.
> +	core-y, libs-y, drivers-y
> =20
>  	    $(libs-y) lists directories where a lib.a archive can be located.
> =20
> diff --git a/Makefile b/Makefile
> index a8c19f92ac9e..ab986e4c5189 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1149,10 +1149,10 @@ quiet_cmd_ar_vmlinux.a =3D AR      $@
>        cmd_ar_vmlinux.a =3D \
>  	rm -f $@; \
>  	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $(head-y)
> +	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=
=3D$(srctree)/scripts/head-object-list.txt)
> =20
>  targets +=3D vmlinux.a
> -vmlinux.a: $(KBUILD_VMLINUX_OBJS) FORCE
> +vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt FORCE
>  	$(call if_changed,ar_vmlinux.a)
> =20
>  vmlinux.o: autoksyms_recursive vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
> index 881cb913e23a..45158024085e 100644
> --- a/arch/alpha/Makefile
> +++ b/arch/alpha/Makefile
> @@ -36,8 +36,6 @@ cflags-y				+=3D $(cpuflags-y)
>  # BWX is most important, but we don't really want any emulation ever.
>  KBUILD_CFLAGS +=3D $(cflags-y) -Wa,-mev6
> =20
> -head-y :=3D arch/alpha/kernel/head.o
> -
>  libs-y				+=3D arch/alpha/lib/
> =20
>  # export what is needed by arch/alpha/boot/Makefile
> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> index efc54f3e35e0..329400a1c355 100644
> --- a/arch/arc/Makefile
> +++ b/arch/arc/Makefile
> @@ -82,8 +82,6 @@ KBUILD_CFLAGS	+=3D $(cflags-y)
>  KBUILD_AFLAGS	+=3D $(KBUILD_CFLAGS)
>  KBUILD_LDFLAGS	+=3D $(ldflags-y)
> =20
> -head-y		:=3D arch/arc/kernel/head.o
> -
>  # w/o this dtb won't embed into kernel binary
>  core-y		+=3D arch/arc/boot/dts/
> =20
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 56f655deebb1..29d15c9a433e 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -134,9 +134,6 @@ KBUILD_AFLAGS	+=3D$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-=
y) $(tune-y) -include asm/uni
> =20
>  CHECKFLAGS	+=3D -D__arm__
> =20
> -#Default value
> -head-y		:=3D arch/arm/kernel/head$(MMUEXT).o
> -
>  # Text offset. This list is sorted numerically by address in order to
>  # provide a means to avoid/resolve conflicts in multi-arch kernels.
>  # Note: the 32kB below this value is reserved for use by the kernel
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6d9d4a58b898..6e03f15bb041 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -133,9 +133,6 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
>    CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
>  endif
> =20
> -# Default value
> -head-y		:=3D arch/arm64/kernel/head.o
> -
>  ifeq ($(CONFIG_KASAN_SW_TAGS), y)
>  KASAN_SHADOW_SCALE_SHIFT :=3D 4
>  else ifeq ($(CONFIG_KASAN_GENERIC), y)
> diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> index 4e1d619fd5c6..0e4237e55758 100644
> --- a/arch/csky/Makefile
> +++ b/arch/csky/Makefile
> @@ -59,8 +59,6 @@ LDFLAGS +=3D -EL
> =20
>  KBUILD_AFLAGS +=3D $(KBUILD_CFLAGS)
> =20
> -head-y :=3D arch/csky/kernel/head.o
> -
>  core-y +=3D arch/csky/$(CSKYABI)/
> =20
>  libs-y +=3D arch/csky/lib/ \
> diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
> index 44312bc147d8..92d005958dfb 100644
> --- a/arch/hexagon/Makefile
> +++ b/arch/hexagon/Makefile
> @@ -32,5 +32,3 @@ KBUILD_LDFLAGS +=3D $(ldflags-y)
>  TIR_NAME :=3D r19
>  KBUILD_CFLAGS +=3D -ffixed-$(TIR_NAME) -DTHREADINFO_REG=3D$(TIR_NAME) -D=
__linux__
>  KBUILD_AFLAGS +=3D -DTHREADINFO_REG=3D$(TIR_NAME)
> -
> -head-y :=3D arch/hexagon/kernel/head.o
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> index e55c2f138656..56c4bb276b6e 100644
> --- a/arch/ia64/Makefile
> +++ b/arch/ia64/Makefile
> @@ -44,7 +44,6 @@ quiet_cmd_objcopy =3D OBJCOPY $@
>  cmd_objcopy =3D $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
> =20
>  KBUILD_CFLAGS +=3D $(cflags-y)
> -head-y :=3D arch/ia64/kernel/head.o
> =20
>  libs-y				+=3D arch/ia64/lib/
> =20
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ec3de6191276..131fc210c2bf 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -72,8 +72,6 @@ CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -=
x c /dev/null | \
>  	sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$/&&/g')
>  endif
> =20
> -head-y :=3D arch/loongarch/kernel/head.o
> -
>  libs-y +=3D arch/loongarch/lib/
> =20
>  ifeq ($(KBUILD_EXTMOD),)
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index e358605b70ba..43e39040d3ac 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -86,15 +86,6 @@ ifdef CONFIG_KGDB
>  KBUILD_CFLAGS :=3D $(subst -fomit-frame-pointer,,$(KBUILD_CFLAGS)) -g
>  endif
> =20
> -#
> -# Select the assembler head startup code. Order is important. The default
> -# head code is first, processor specific selections can override it afte=
r.
> -#
> -head-y				:=3D arch/m68k/kernel/head.o
> -head-$(CONFIG_SUN3)		:=3D arch/m68k/kernel/sun3-head.o
> -head-$(CONFIG_M68000)		:=3D arch/m68k/68000/head.o
> -head-$(CONFIG_COLDFIRE)		:=3D arch/m68k/coldfire/head.o
> -
>  libs-y				+=3D arch/m68k/lib/
> =20
> =20
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 1826d9ce4459..3f8a86c4336a 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -48,7 +48,6 @@ CPUFLAGS-1 +=3D $(call cc-option,-mcpu=3Dv$(CPU_VER))
>  # r31 holds current when in kernel mode
>  KBUILD_CFLAGS +=3D -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
> =20
> -head-y :=3D arch/microblaze/kernel/head.o
>  libs-y +=3D arch/microblaze/lib/
> =20
>  boot :=3D arch/microblaze/boot
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 4d2a3e73fc45..b296e33f8e33 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -324,8 +324,6 @@ endif
> =20
>  OBJCOPYFLAGS		+=3D --remove-section=3D.reginfo
> =20
> -head-y :=3D arch/mips/kernel/head.o
> -
>  libs-y			+=3D arch/mips/lib/
>  libs-$(CONFIG_MIPS_FP_SUPPORT) +=3D arch/mips/math-emu/
> =20
> diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
> index 3f34e6831863..f1ff4ce0f1a2 100644
> --- a/arch/nios2/Makefile
> +++ b/arch/nios2/Makefile
> @@ -37,7 +37,6 @@ KBUILD_CFLAGS +=3D -DUTS_SYSNAME=3D\"$(UTS_SYSNAME)\"
>  KBUILD_CFLAGS +=3D -fno-builtin
>  KBUILD_CFLAGS +=3D -G 0
> =20
> -head-y		:=3D arch/nios2/kernel/head.o
>  libs-y		+=3D arch/nios2/lib/ $(LIBGCC)
> =20
>  INSTALL_PATH ?=3D /tftpboot
> diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
> index b446510173cd..68249521db5a 100644
> --- a/arch/openrisc/Makefile
> +++ b/arch/openrisc/Makefile
> @@ -55,8 +55,6 @@ ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
>  	KBUILD_CFLAGS +=3D $(call cc-option,-msext)
>  endif
> =20
> -head-y 		:=3D arch/openrisc/kernel/head.o
> -
>  libs-y		+=3D $(LIBGCC)
> =20
>  PHONY +=3D vmlinux.bin
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index e38d993d87f2..a2d8600521f9 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -113,8 +113,6 @@ cflags-$(CONFIG_PA7100LC)	+=3D -march=3D1.1 -mschedul=
e=3D7100LC
>  cflags-$(CONFIG_PA7300LC)	+=3D -march=3D1.1 -mschedule=3D7300
>  cflags-$(CONFIG_PA8X00)		+=3D -march=3D2.0 -mschedule=3D8000
> =20
> -head-y			:=3D arch/parisc/kernel/head.o=20
> -
>  KBUILD_CFLAGS	+=3D $(cflags-y)
>  LIBGCC		:=3D $(shell $(CC) -print-libgcc-file-name)
>  export LIBGCC
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 02742facf895..89c27827a11f 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -226,18 +226,6 @@ KBUILD_CFLAGS +=3D $(cpu-as-y)
>  KBUILD_AFLAGS +=3D $(aflags-y)
>  KBUILD_CFLAGS +=3D $(cflags-y)
> =20
> -head-$(CONFIG_PPC64)		:=3D arch/powerpc/kernel/head_64.o
> -head-$(CONFIG_PPC_BOOK3S_32)	:=3D arch/powerpc/kernel/head_book3s_32.o
> -head-$(CONFIG_PPC_8xx)		:=3D arch/powerpc/kernel/head_8xx.o
> -head-$(CONFIG_40x)		:=3D arch/powerpc/kernel/head_40x.o
> -head-$(CONFIG_44x)		:=3D arch/powerpc/kernel/head_44x.o
> -head-$(CONFIG_FSL_BOOKE)	:=3D arch/powerpc/kernel/head_fsl_booke.o
> -
> -head-$(CONFIG_PPC64)		+=3D arch/powerpc/kernel/entry_64.o
> -head-$(CONFIG_PPC_FPU)		+=3D arch/powerpc/kernel/fpu.o
> -head-$(CONFIG_ALTIVEC)		+=3D arch/powerpc/kernel/vector.o
> -head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  +=3D arch/powerpc/kernel/prom_ini=
t.o
> -
>  # Default to zImage, override when needed
>  all: zImage
> =20
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 3fa8ef336822..e013df8e7b8b 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -110,8 +110,6 @@ else
>  KBUILD_IMAGE	:=3D $(boot)/Image.gz
>  endif
> =20
> -head-y :=3D arch/riscv/kernel/head.o
> -
>  libs-y +=3D arch/riscv/lib/
>  libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
=2Ea
> =20
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 4cb5d17e7ead..de6d8b2ea4d8 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -119,8 +119,6 @@ export KBUILD_CFLAGS_DECOMPRESSOR
> =20
>  OBJCOPYFLAGS	:=3D -O binary
> =20
> -head-y		:=3D arch/s390/kernel/head64.o
> -
>  libs-y		+=3D arch/s390/lib/
>  drivers-y	+=3D drivers/s390/
> =20
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index b39412bf91fb..5c8776482530 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -114,8 +114,6 @@ endif
> =20
>  export ld-bfd
> =20
> -head-y	:=3D arch/sh/kernel/head_32.o
> -
>  # Mach groups
>  machdir-$(CONFIG_SOLUTION_ENGINE)		+=3D mach-se
>  machdir-$(CONFIG_SH_HP6XX)			+=3D mach-hp6xx
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index fe58a410b4ce..a4ea5b05f288 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -56,8 +56,6 @@ endif
> =20
>  endif
> =20
> -head-y                 :=3D arch/sparc/kernel/head_$(BITS).o
> -
>  libs-y                 +=3D arch/sparc/prom/
>  libs-y                 +=3D arch/sparc/lib/
> =20
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index bafbd905e6e7..9afd323c6916 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -234,11 +234,6 @@ archheaders:
>  ###
>  # Kernel objects
> =20
> -head-y :=3D arch/x86/kernel/head_$(BITS).o
> -head-y +=3D arch/x86/kernel/head$(BITS).o
> -head-y +=3D arch/x86/kernel/ebda.o
> -head-y +=3D arch/x86/kernel/platform-quirks.o
> -
>  libs-y  +=3D arch/x86/lib/
> =20
>  # drivers-y are linked after core-y
> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> index 5097caa7bf0c..bfd8e433ed62 100644
> --- a/arch/xtensa/Makefile
> +++ b/arch/xtensa/Makefile
> @@ -55,8 +55,6 @@ KBUILD_CPPFLAGS +=3D $(patsubst %,-I$(srctree)/%include=
,$(vardirs) $(plfdirs))
> =20
>  KBUILD_DEFCONFIG :=3D iss_defconfig
> =20
> -head-y		:=3D arch/xtensa/kernel/head.o
> -
>  libs-y		+=3D arch/xtensa/lib/
> =20
>  boot		:=3D arch/xtensa/boot
> diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> new file mode 100644
> index 000000000000..dd2ba2eda636
> --- /dev/null
> +++ b/scripts/head-object-list.txt
> @@ -0,0 +1,53 @@
> +# Head objects
> +#
> +# The objects listed here are placed at the head of vmlinux. A typical u=
se-case
> +# is an object that contains the entry point. This is kept for compatibi=
lity
> +# with head-y, which Kbuild used to support.
> +#
> +# A counter approach is to control the section placement by the linker s=
cript.
> +# The code marked as __HEAD goes into the ".head.text" section, which is=
 placed
> +# before the normal ".text" section.
> +#
> +# If you can achieve the correct code ordering by linker script, please =
delete
> +# the entry from this file.
> +#
> +arch/alpha/kernel/head.o
> +arch/arc/kernel/head.o
> +arch/arm/kernel/head-nommu.o
> +arch/arm/kernel/head.o
> +arch/arm64/kernel/head.o
> +arch/csky/kernel/head.o
> +arch/hexagon/kernel/head.o
> +arch/ia64/kernel/head.o
> +arch/loongarch/kernel/head.o
> +arch/m68k/68000/head.o
> +arch/m68k/coldfire/head.o
> +arch/m68k/kernel/head.o
> +arch/m68k/kernel/sun3-head.o
> +arch/microblaze/kernel/head.o
> +arch/mips/kernel/head.o
> +arch/nios2/kernel/head.o
> +arch/openrisc/kernel/head.o
> +arch/parisc/kernel/head.o
> +arch/powerpc/kernel/head_40x.o
> +arch/powerpc/kernel/head_44x.o
> +arch/powerpc/kernel/head_64.o
> +arch/powerpc/kernel/head_8xx.o
> +arch/powerpc/kernel/head_book3s_32.o
> +arch/powerpc/kernel/head_fsl_booke.o
> +arch/powerpc/kernel/entry_64.o
> +arch/powerpc/kernel/fpu.o
> +arch/powerpc/kernel/vector.o
> +arch/powerpc/kernel/prom_init.o
> +arch/riscv/kernel/head.o
> +arch/s390/kernel/head64.o
> +arch/sh/kernel/head_32.o
> +arch/sparc/kernel/head_32.o
> +arch/sparc/kernel/head_64.o
> +arch/x86/kernel/head_32.o
> +arch/x86/kernel/head_64.o
> +arch/x86/kernel/head32.o
> +arch/x86/kernel/head64.o
> +arch/x86/kernel/ebda.o
> +arch/x86/kernel/platform-quirks.o
> +arch/xtensa/kernel/head.o
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--efySUFyLQCRvleuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM1t/AACgkQB1IKcBYm
EmkSXBAA6ammM1yLzwPGK4izrNBt2x6ZGG1LpcYnIOUgJzRENXi8QkojgVdzu0yr
/g+k79JlplgguI94dw0kXWjYXANjMsik62WTq3cagwuI4UaqPYEWbp70ja6HEMMh
mhnvlQDj/EMgaHG5XRMUWOgMKyaE+X5FB7abfh5++fm65B7zaj5Shfo6GwxpkLvh
8zaEWFSve8zg6F7UNSk2cr87UgKTqO1cUyEn3CvkAt2FqzHZyb/I5+mRpiqAQZyy
KU+pUXFQ7cRUTTkamyXAuO0gjwwyTSQQWagGy7pN84M8kLkLZZoU6fTcGZNje0Dj
ngVm5h3FP50Zs05VrIYB9xo1NazVsT0B5/wYerBXgel24Vtj7f8gjWEqkeWxUn/T
1vtV/79OFPByFQVIpcDOwUHDrIqyzq01gOq+gR1lhWhbzXsWZt6+uskNwLIqDDe/
AuNuN2exHk3KZQ7FFZGPvCQzwbXdnzkqpqZ/+ve0lxacLxqSfCt4TNJrABLFLr6l
/anoTb9bpenDhZXsXxRS3L/y1F3fJqMOGeLdbrUm6DxB6cAbTwBFsbc6xPghQ2K/
jvXTQ6JSUODavG1jyQ6OUBl5B1xCtFr9AZhGcxnRIX8EDUR9mGMhpNP6quBLAhQ+
lfDrNK6XsVFDu2alkXMZh9WlxYgDRHjDhK/+PmTHp1OE+0jgyhc=
=ZjAE
-----END PGP SIGNATURE-----

--efySUFyLQCRvleuI--
