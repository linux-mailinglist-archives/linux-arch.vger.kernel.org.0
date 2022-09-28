Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD575EE67A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiI1UQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiI1UQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 16:16:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716762ED;
        Wed, 28 Sep 2022 13:15:51 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1fag-1pNimD0d1E-0121k6; Wed, 28 Sep 2022 22:15:25 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 6F3C73C0EE;
        Wed, 28 Sep 2022 22:15:23 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 65B7D41C6; Wed, 28 Sep 2022 22:15:22 +0200 (CEST)
Date:   Wed, 28 Sep 2022 22:15:22 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
Message-ID: <YzSrWvVEt5fjpvlT@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/QPoIt3ndWsR+Znz"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-7-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:WCBaLdhDVR9+yc8dlgjPqUOZcia4YS1y26092HMRpAyxRjRru3i
 bWc/jARp0KliQTGteEQUatpjrkVHUaPEzzF3dJzS8pbZ7sdEDvM4MAME+KWggKj5BXBvpJy
 yNKkqy3eQTvw7wkxkmOBFsE1L0vtFQvd3Fiu8AxSdVB6scVxzw9IMntyh8MGiB7poyefftG
 WQJMd5gnCDZlA7c5sEhrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mgCUwzPsIdU=:qhAnBFGk+Euo61ixTd3o57
 Un20JFfAuPlcg54wWvM2cltxkpj8KZIzgNEQn9TkGw4WShhvLHKXNjJq/Edz/qxBRsHlTFNsY
 cC/p/xkBWFLDEI9Lswi8Tv3+71eQBuHHkeCzbTyLnnsAW2888ccqG8RWiGe6b7U1TKkQSwVgI
 WJ8tGDUfiUL27Pw5/EuD4BHusMm9/IQrdD0MnDO3FDGZS2sgVgjDMi1cfp128/gpdx0l3UfC9
 05+Obkw+LXzHKLv7OKfIUzxOrqW/SV7vVMHnsKg6lokUn1q/k1qPcF6mS2c7OGOL8dqXSd+IA
 pDyJ1QTjEPQiv2/bwBAe/hDXuz4DXvHW2+973QY7e4usnjv6C9eMZQO4T+KJZxK4T/ZrO4/Ar
 dzDrRpKsK395rUMb1Z0zWuL4kwVkQbAb7wQuKfGApuEmY4ffGhCYjERNHcCwdQ0tmfOZe0fNj
 3n/aVPwexWIiNRU6v6wVKU6UbdiOaSITE9VCnHF4M1LlH90CzErcCrPJXYCB8rDf79MZoc2OX
 wJrsJdwjSo6vklCyfXnUg2cZTQWizRpPtimlb4FFNNIRqD64WGI/4a+7bKjsmeF9f3cSNQ8bT
 8jyFI1/4WcX0rzy8+0jttrqDfp0Ue4dRiCPpiHifdizx5P5euL1MBSdbnfwEmG+jIGgDREz/G
 oIsb9GzAj7TbGUAIrKLiDLOm0MGtlCR5vbinyOqG1rSim7a+0un20l/g0Swg6rgi306oi4+mc
 vBwve7WDwfyrzNSNdyrtY2/Hn5Gq2sDiOgw0rOhP5pm0s+0YLWYBeyV9o23oU/qsQlaeqGA/O
 DlPcGcM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--/QPoIt3ndWsR+Znz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:14 +0900 Masahiro Yamada wrote:
> The objects placed at the head of vmlinux need special treatments:
>=20
>  - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
>    them before other archives in the linker command line.
>=20
>  - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
>    obj-y to avoid them going into built-in.a.
>=20
> This commit gets rid of the latter.
>=20
> Create vmlinux.a to collect all the objects that are unconditionally
> linked to vmlinux. The objects listed in head-y are moved to the head
> of vmlinux.a by using 'ar m'.
>=20
> With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> for builtin objects.
>=20
> There is no *.o that is directly linked to vmlinux. Drop unneeded code
> in scripts/clang-tools/gen_compile_commands.py.
>=20
> $(AR) mPi needs 'T' to workaround the llvm-ar bug. The fix was suggested
> by Nathan Chancellor [1].
>=20
> [1]: https://lore.kernel.org/llvm/YyjjT5gQ2hGMH0ni@dev-arch.thelio-3990X/
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


> Changes in v3:
>   - Fix build error for m68k
>   - Fix the bug for llvm-ar <=3D 14
>=20
>  Documentation/kbuild/makefiles.rst          | 18 +---------------
>  Makefile                                    | 23 ++++++++++++++++-----
>  arch/alpha/kernel/Makefile                  |  4 ++--
>  arch/arc/kernel/Makefile                    |  4 ++--
>  arch/arm/kernel/Makefile                    |  4 ++--
>  arch/arm64/kernel/Makefile                  |  4 ++--
>  arch/csky/kernel/Makefile                   |  4 ++--
>  arch/hexagon/kernel/Makefile                |  3 ++-
>  arch/ia64/kernel/Makefile                   |  4 ++--
>  arch/loongarch/kernel/Makefile              |  4 ++--
>  arch/m68k/68000/Makefile                    |  2 +-
>  arch/m68k/coldfire/Makefile                 |  2 +-
>  arch/m68k/kernel/Makefile                   | 23 +++++++++++----------
>  arch/microblaze/kernel/Makefile             |  4 ++--
>  arch/mips/kernel/Makefile                   |  4 ++--
>  arch/nios2/kernel/Makefile                  |  2 +-
>  arch/openrisc/kernel/Makefile               |  4 ++--
>  arch/parisc/kernel/Makefile                 |  4 ++--
>  arch/powerpc/kernel/Makefile                | 20 +++++++++---------
>  arch/riscv/kernel/Makefile                  |  2 +-
>  arch/s390/kernel/Makefile                   |  4 ++--
>  arch/sh/kernel/Makefile                     |  4 ++--
>  arch/sparc/kernel/Makefile                  |  3 +--
>  arch/x86/kernel/Makefile                    | 10 ++++-----
>  arch/xtensa/kernel/Makefile                 |  4 ++--
>  scripts/Makefile.modpost                    |  5 ++---
>  scripts/Makefile.vmlinux_o                  |  6 +++---
>  scripts/clang-tools/gen_compile_commands.py | 19 +----------------
>  scripts/link-vmlinux.sh                     | 10 ++++-----
>  29 files changed, 91 insertions(+), 113 deletions(-)
>=20
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/ma=
kefiles.rst
> index ee7e3ea1fbe1..5a6a8426cc97 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -340,19 +340,7 @@ more details, with real examples.
> =20
>  	Examples are:
> =20
> -	1) head objects
> -
> -	    Some objects must be placed at the head of vmlinux. They are
> -	    directly linked to vmlinux without going through built-in.a
> -	    A typical use-case is an object that contains the entry point.
> -
> -	    arch/$(SRCARCH)/Makefile should specify such objects as head-y.
> -
> -	    Discussion:
> -	      Given that we can control the section order in the linker script,
> -	      why do we need head-y?
> -
> -	2) vmlinux linker script
> +	1) vmlinux linker script
> =20
>  	    The linker script for vmlinux is located at
>  	    arch/$(SRCARCH)/kernel/vmlinux.lds
> @@ -360,10 +348,6 @@ more details, with real examples.
>  	Example::
> =20
>  		# arch/x86/kernel/Makefile
> -		extra-y	:=3D head_$(BITS).o
> -		extra-y	+=3D head$(BITS).o
> -		extra-y	+=3D ebda.o
> -		extra-y	+=3D platform-quirks.o
>  		extra-y	+=3D vmlinux.lds
> =20
>  	$(extra-y) should only contain targets needed for vmlinux.
> diff --git a/Makefile b/Makefile
> index cf9d7b1d8c14..a8c19f92ac9e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -645,6 +645,8 @@ else
>  __all: modules
>  endif
> =20
> +targets :=3D
> +
>  # Decide whether to build built-in, modular, or both.
>  # Normally, just do built-in.
> =20
> @@ -1107,7 +1109,7 @@ export ARCH_LIB		:=3D $(filter %/, $(libs-y))
>  export ARCH_DRIVERS	:=3D $(drivers-y) $(drivers-m)
>  # Externally visible symbols (used by link-vmlinux.sh)
> =20
> -KBUILD_VMLINUX_OBJS :=3D $(head-y) ./built-in.a
> +KBUILD_VMLINUX_OBJS :=3D ./built-in.a
>  ifdef CONFIG_MODULES
>  KBUILD_VMLINUX_OBJS +=3D $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
>  KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
> @@ -1115,7 +1117,7 @@ else
>  KBUILD_VMLINUX_LIBS :=3D $(patsubst %/,%/lib.a, $(libs-y))
>  endif
> =20
> -export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
> +export KBUILD_VMLINUX_LIBS
>  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
> =20
>  vmlinux-deps :=3D $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_=
LIBS)
> @@ -1142,7 +1144,18 @@ quiet_cmd_autoksyms_h =3D GEN     $@
>  $(autoksyms_h):
>  	$(call cmd,autoksyms_h)
> =20
> -vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_L=
IBS) FORCE
> +# '$(AR) mPi' needs 'T' to workaround the bug of llvm-ar <=3D 14
> +quiet_cmd_ar_vmlinux.a =3D AR      $@
> +      cmd_ar_vmlinux.a =3D \
> +	rm -f $@; \
> +	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> +	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $(head-y)
> +
> +targets +=3D vmlinux.a
> +vmlinux.a: $(KBUILD_VMLINUX_OBJS) FORCE
> +	$(call if_changed,ar_vmlinux.a)
> +
> +vmlinux.o: autoksyms_recursive vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
> =20
>  ARCH_POSTLINK :=3D $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postli=
nk)
> @@ -1155,7 +1168,7 @@ cmd_link-vmlinux =3D                               =
                  \
>  vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) modpost FORCE
>  	+$(call if_changed_dep,link-vmlinux)
> =20
> -targets :=3D vmlinux
> +targets +=3D vmlinux
> =20
>  # The actual objects are generated when descending,
>  # make sure no implicit rule kicks in
> @@ -1880,7 +1893,7 @@ quiet_cmd_gen_compile_commands =3D GEN     $@
>        cmd_gen_compile_commands =3D $(PYTHON3) $< -a $(AR) -o $@ $(filter=
-out $<, $(real-prereqs))
> =20
>  $(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_c=
ommands.py \
> -	$(if $(KBUILD_EXTMOD),,$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)) \
> +	$(if $(KBUILD_EXTMOD),, vmlinux.a $(KBUILD_VMLINUX_LIBS)) \
>  	$(if $(CONFIG_MODULES), $(MODORDER)) FORCE
>  	$(call if_changed,gen_compile_commands)
> =20
> diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
> index 5a74581bf0ee..5a5b0a8b7c6a 100644
> --- a/arch/alpha/kernel/Makefile
> +++ b/arch/alpha/kernel/Makefile
> @@ -3,11 +3,11 @@
>  # Makefile for the linux kernel.
>  #
> =20
> -extra-y		:=3D head.o vmlinux.lds
> +extra-y		:=3D vmlinux.lds
>  asflags-y	:=3D $(KBUILD_CFLAGS)
>  ccflags-y	:=3D -Wno-sign-compare
> =20
> -obj-y    :=3D entry.o traps.o process.o osf_sys.o irq.o \
> +obj-y    :=3D head.o entry.o traps.o process.o osf_sys.o irq.o \
>  	    irq_alpha.o signal.o setup.o ptrace.o time.o \
>  	    systbls.o err_common.o io.o bugs.o
> =20
> diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
> index 8c4fc4b54c14..0723d888ac44 100644
> --- a/arch/arc/kernel/Makefile
> +++ b/arch/arc/kernel/Makefile
> @@ -3,7 +3,7 @@
>  # Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.=
com)
>  #
> =20
> -obj-y	:=3D arcksyms.o setup.o irq.o reset.o ptrace.o process.o devtree.o
> +obj-y	:=3D head.o arcksyms.o setup.o irq.o reset.o ptrace.o process.o de=
vtree.o
>  obj-y	+=3D signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o
>  obj-$(CONFIG_ISA_ARCOMPACT)		+=3D entry-compact.o intc-compact.o
>  obj-$(CONFIG_ISA_ARCV2)			+=3D entry-arcv2.o intc-arcv2.o
> @@ -31,4 +31,4 @@ else
>  obj-y +=3D ctx_sw_asm.o
>  endif
> =20
> -extra-y :=3D vmlinux.lds head.o
> +extra-y :=3D vmlinux.lds
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 553866751e1a..8feaa3217ec5 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -89,7 +89,7 @@ obj-$(CONFIG_VDSO)		+=3D vdso.o
>  obj-$(CONFIG_EFI)		+=3D efi.o
>  obj-$(CONFIG_PARAVIRT)	+=3D paravirt.o
> =20
> -head-y			:=3D head$(MMUEXT).o
> +obj-y			+=3D head$(MMUEXT).o
>  obj-$(CONFIG_DEBUG_LL)	+=3D debug.o
>  obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
>  obj-$(CONFIG_ARM_PATCH_PHYS_VIRT)	+=3D phys2virt.o
> @@ -109,4 +109,4 @@ obj-$(CONFIG_HAVE_ARM_SMCCC)	+=3D smccc-call.o
> =20
>  obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) +=3D spectre.o
> =20
> -extra-y :=3D $(head-y) vmlinux.lds
> +extra-y :=3D vmlinux.lds
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 1add7b01efa7..b619ff207a57 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -85,8 +85,8 @@ $(obj)/vdso-wrap.o: $(obj)/vdso/vdso.so
>  $(obj)/vdso32-wrap.o: $(obj)/vdso32/vdso.so
> =20
>  obj-y					+=3D probes/
> -head-y					:=3D head.o
> -extra-y					+=3D $(head-y) vmlinux.lds
> +obj-y					+=3D head.o
> +extra-y					+=3D vmlinux.lds
> =20
>  ifeq ($(CONFIG_DEBUG_EFI),y)
>  AFLAGS_head.o +=3D -DVMLINUX_PATH=3D"\"$(realpath $(objtree)/vmlinux)\""
> diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
> index 6f14c924b20d..8a868316b912 100644
> --- a/arch/csky/kernel/Makefile
> +++ b/arch/csky/kernel/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -extra-y :=3D head.o vmlinux.lds
> +extra-y :=3D vmlinux.lds
> =20
> -obj-y +=3D entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
> +obj-y +=3D head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o =
vdso/
>  obj-y +=3D power.o syscall.o syscall_table.o setup.o io.o
>  obj-y +=3D process.o cpu-probe.o ptrace.o stacktrace.o
>  obj-y +=3D probes/
> diff --git a/arch/hexagon/kernel/Makefile b/arch/hexagon/kernel/Makefile
> index fae3dce32fde..e73cb321630e 100644
> --- a/arch/hexagon/kernel/Makefile
> +++ b/arch/hexagon/kernel/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -extra-y :=3D head.o vmlinux.lds
> +extra-y :=3D vmlinux.lds
> =20
> +obj-y +=3D head.o
>  obj-$(CONFIG_SMP) +=3D smp.o
> =20
>  obj-y +=3D setup.o irq_cpu.o traps.o syscalltab.o signal.o time.o
> diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
> index 08d4a2ba0652..4a1fcb121dda 100644
> --- a/arch/ia64/kernel/Makefile
> +++ b/arch/ia64/kernel/Makefile
> @@ -7,9 +7,9 @@ ifdef CONFIG_DYNAMIC_FTRACE
>  CFLAGS_REMOVE_ftrace.o =3D -pg
>  endif
> =20
> -extra-y	:=3D head.o vmlinux.lds
> +extra-y	:=3D vmlinux.lds
> =20
> -obj-y :=3D entry.o efi.o efi_stub.o gate-data.o fsys.o irq.o irq_ia64.o	\
> +obj-y :=3D head.o entry.o efi.o efi_stub.o gate-data.o fsys.o irq.o irq_=
ia64.o	\
>  	 irq_lsapic.o ivt.o pal.o patch.o process.o ptrace.o sal.o		\
>  	 salinfo.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o \
>  	 unwind.o mca.o mca_asm.o topology.o dma-mapping.o iosapic.o acpi.o \
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index e5be17009fe8..6c33b5c45573 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -3,9 +3,9 @@
>  # Makefile for the Linux/LoongArch kernel.
>  #
> =20
> -extra-y		:=3D head.o vmlinux.lds
> +extra-y		:=3D vmlinux.lds
> =20
> -obj-y		+=3D cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
> +obj-y		+=3D head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o=
 \
>  		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
>  		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
> =20
> diff --git a/arch/m68k/68000/Makefile b/arch/m68k/68000/Makefile
> index 674541fdf5b8..279560add577 100644
> --- a/arch/m68k/68000/Makefile
> +++ b/arch/m68k/68000/Makefile
> @@ -17,4 +17,4 @@ obj-$(CONFIG_DRAGEN2)	+=3D dragen2.o
>  obj-$(CONFIG_UCSIMM)	+=3D ucsimm.o
>  obj-$(CONFIG_UCDIMM)	+=3D ucsimm.o
> =20
> -extra-y 		:=3D head.o
> +obj-y			+=3D head.o
> diff --git a/arch/m68k/coldfire/Makefile b/arch/m68k/coldfire/Makefile
> index 9419a6c1f036..c56bc0dc7f2e 100644
> --- a/arch/m68k/coldfire/Makefile
> +++ b/arch/m68k/coldfire/Makefile
> @@ -45,4 +45,4 @@ obj-$(CONFIG_STMARK2)	+=3D stmark2.o
>  obj-$(CONFIG_PCI)	+=3D pci.o
> =20
>  obj-y			+=3D gpio.o
> -extra-y :=3D head.o
> +obj-y			+=3D head.o
> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
> index c0833da6a2ca..af015447dfb4 100644
> --- a/arch/m68k/kernel/Makefile
> +++ b/arch/m68k/kernel/Makefile
> @@ -3,19 +3,20 @@
>  # Makefile for the linux kernel.
>  #
> =20
> -extra-$(CONFIG_AMIGA)	:=3D head.o
> -extra-$(CONFIG_ATARI)	:=3D head.o
> -extra-$(CONFIG_MAC)	:=3D head.o
> -extra-$(CONFIG_APOLLO)	:=3D head.o
> -extra-$(CONFIG_VME)	:=3D head.o
> -extra-$(CONFIG_HP300)	:=3D head.o
> -extra-$(CONFIG_Q40)	:=3D head.o
> -extra-$(CONFIG_SUN3X)	:=3D head.o
> -extra-$(CONFIG_VIRT)	:=3D head.o
> -extra-$(CONFIG_SUN3)	:=3D sun3-head.o
>  extra-y			+=3D vmlinux.lds
> =20
> -obj-y	:=3D entry.o irq.o module.o process.o ptrace.o
> +obj-$(CONFIG_AMIGA)	:=3D head.o
> +obj-$(CONFIG_ATARI)	:=3D head.o
> +obj-$(CONFIG_MAC)	:=3D head.o
> +obj-$(CONFIG_APOLLO)	:=3D head.o
> +obj-$(CONFIG_VME)	:=3D head.o
> +obj-$(CONFIG_HP300)	:=3D head.o
> +obj-$(CONFIG_Q40)	:=3D head.o
> +obj-$(CONFIG_SUN3X)	:=3D head.o
> +obj-$(CONFIG_VIRT)	:=3D head.o
> +obj-$(CONFIG_SUN3)	:=3D sun3-head.o
> +
> +obj-y	+=3D entry.o irq.o module.o process.o ptrace.o
>  obj-y	+=3D setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
> =20
>  obj-$(CONFIG_MMU_MOTOROLA) +=3D ints.o vectors.o
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Mak=
efile
> index 15a20eb814ce..4393bee64eaf 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -12,9 +12,9 @@ CFLAGS_REMOVE_ftrace.o =3D -pg
>  CFLAGS_REMOVE_process.o =3D -pg
>  endif
> =20
> -extra-y :=3D head.o vmlinux.lds
> +extra-y :=3D vmlinux.lds
> =20
> -obj-y +=3D dma.o exceptions.o \
> +obj-y +=3D head.o dma.o exceptions.o \
>  	hw_exception_handler.o irq.o \
>  	process.o prom.o ptrace.o \
>  	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 7c96282bff2e..5d1addac5e28 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -3,9 +3,9 @@
>  # Makefile for the Linux/MIPS kernel.
>  #
> =20
> -extra-y		:=3D head.o vmlinux.lds
> +extra-y		:=3D vmlinux.lds
> =20
> -obj-y		+=3D branch.o cmpxchg.o elf.o entry.o genex.o idle.o irq.o \
> +obj-y		+=3D head.o branch.o cmpxchg.o elf.o entry.o genex.o idle.o irq.o=
 \
>  		   process.o prom.o ptrace.o reset.o setup.o signal.o \
>  		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
>  		   vdso.o cacheinfo.o
> diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
> index 0b645e1e3158..78a913181fa1 100644
> --- a/arch/nios2/kernel/Makefile
> +++ b/arch/nios2/kernel/Makefile
> @@ -3,9 +3,9 @@
>  # Makefile for the nios2 linux kernel.
>  #
> =20
> -extra-y	+=3D head.o
>  extra-y	+=3D vmlinux.lds
> =20
> +obj-y	+=3D head.o
>  obj-y	+=3D cpuinfo.o
>  obj-y	+=3D entry.o
>  obj-y	+=3D insnemu.o
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 2d172e79f58d..79129161f3e0 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -3,9 +3,9 @@
>  # Makefile for the linux kernel.
>  #
> =20
> -extra-y	:=3D head.o vmlinux.lds
> +extra-y	:=3D vmlinux.lds
> =20
> -obj-y	:=3D setup.o or32_ksyms.o process.o dma.o \
> +obj-y	:=3D head.o setup.o or32_ksyms.o process.o dma.o \
>  	   traps.o time.o irq.o entry.o ptrace.o signal.o \
>  	   sys_call_table.o unwinder.o
> =20
> diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
> index d0bfac89a842..3d138c9cf9ce 100644
> --- a/arch/parisc/kernel/Makefile
> +++ b/arch/parisc/kernel/Makefile
> @@ -3,9 +3,9 @@
>  # Makefile for arch/parisc/kernel
>  #
> =20
> -extra-y			:=3D head.o vmlinux.lds
> +extra-y		:=3D vmlinux.lds
> =20
> -obj-y	     	:=3D cache.o pacache.o setup.o pdt.o traps.o time.o irq.o \
> +obj-y		:=3D head.o cache.o pacache.o setup.o pdt.o traps.o time.o irq.o \
>  		   pa7300lc.o syscall.o entry.o sys_parisc.o firmware.o \
>  		   ptrace.o hardware.o inventory.o drivers.o alternative.o \
>  		   signal.o hpmc.o real2.o parisc_ksyms.o unaligned.o \
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 06d2d1f78f71..ad3decb9f20b 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -118,12 +118,12 @@ obj-$(CONFIG_PPC_FSL_BOOK3E)	+=3D cpu_setup_fsl_boo=
ke.o
>  obj-$(CONFIG_PPC_DOORBELL)	+=3D dbell.o
>  obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o
> =20
> -extra-$(CONFIG_PPC64)		:=3D head_64.o
> -extra-$(CONFIG_PPC_BOOK3S_32)	:=3D head_book3s_32.o
> -extra-$(CONFIG_40x)		:=3D head_40x.o
> -extra-$(CONFIG_44x)		:=3D head_44x.o
> -extra-$(CONFIG_FSL_BOOKE)	:=3D head_fsl_booke.o
> -extra-$(CONFIG_PPC_8xx)		:=3D head_8xx.o
> +obj-$(CONFIG_PPC64)		+=3D head_64.o
> +obj-$(CONFIG_PPC_BOOK3S_32)	+=3D head_book3s_32.o
> +obj-$(CONFIG_40x)		+=3D head_40x.o
> +obj-$(CONFIG_44x)		+=3D head_44x.o
> +obj-$(CONFIG_FSL_BOOKE)		+=3D head_fsl_booke.o
> +obj-$(CONFIG_PPC_8xx)		+=3D head_8xx.o
>  extra-y				+=3D vmlinux.lds
> =20
>  obj-$(CONFIG_RELOCATABLE)	+=3D reloc_$(BITS).o
> @@ -198,10 +198,10 @@ KCOV_INSTRUMENT_paca.o :=3D n
>  CFLAGS_setup_64.o		+=3D -fno-stack-protector
>  CFLAGS_paca.o			+=3D -fno-stack-protector
> =20
> -extra-$(CONFIG_PPC_FPU)		+=3D fpu.o
> -extra-$(CONFIG_ALTIVEC)		+=3D vector.o
> -extra-$(CONFIG_PPC64)		+=3D entry_64.o
> -extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+=3D prom_init.o
> +obj-$(CONFIG_PPC_FPU)		+=3D fpu.o
> +obj-$(CONFIG_ALTIVEC)		+=3D vector.o
> +obj-$(CONFIG_PPC64)		+=3D entry_64.o
> +obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+=3D prom_init.o
> =20
>  extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+=3D prom_init_check
> =20
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 33bb60a354cd..db6e4b1294ba 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -28,9 +28,9 @@ KASAN_SANITIZE_cpufeature.o :=3D n
>  endif
>  endif
> =20
> -extra-y +=3D head.o
>  extra-y +=3D vmlinux.lds
> =20
> +obj-y	+=3D head.o
>  obj-y	+=3D soc.o
>  obj-$(CONFIG_RISCV_ALTERNATIVE) +=3D alternative.o
>  obj-y	+=3D cpu.o
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 3cbfa9fddd9a..7ce00816b8df 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -33,7 +33,7 @@ CFLAGS_stacktrace.o	+=3D -fno-optimize-sibling-calls
>  CFLAGS_dumpstack.o	+=3D -fno-optimize-sibling-calls
>  CFLAGS_unwind_bc.o	+=3D -fno-optimize-sibling-calls
> =20
> -obj-y	:=3D traps.o time.o process.o earlypgm.o early.o setup.o idle.o vt=
ime.o
> +obj-y	:=3D head64.o traps.o time.o process.o earlypgm.o early.o setup.o =
idle.o vtime.o
>  obj-y	+=3D processor.o syscall.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
>  obj-y	+=3D debug.o irq.o ipl.o dis.o diag.o vdso.o cpufeature.o
>  obj-y	+=3D sysinfo.o lgr.o os_info.o machine_kexec.o
> @@ -42,7 +42,7 @@ obj-y	+=3D entry.o reipl.o relocate_kernel.o kdebugfs.o=
 alternative.o
>  obj-y	+=3D nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
>  obj-y	+=3D smp.o text_amode31.o stacktrace.o
> =20
> -extra-y				+=3D head64.o vmlinux.lds
> +extra-y				+=3D vmlinux.lds
> =20
>  obj-$(CONFIG_SYSFS)		+=3D nospec-sysfs.o
>  CFLAGS_REMOVE_nospec-branch.o	+=3D $(CC_FLAGS_EXPOLINE)
> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
> index aa0fbc9202b1..69cd9ac4b2ab 100644
> --- a/arch/sh/kernel/Makefile
> +++ b/arch/sh/kernel/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for the Linux/SuperH kernel.
>  #
> =20
> -extra-y	:=3D head_32.o vmlinux.lds
> +extra-y	:=3D vmlinux.lds
> =20
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
> @@ -12,7 +12,7 @@ endif
> =20
>  CFLAGS_REMOVE_return_address.o =3D -pg
> =20
> -obj-y	:=3D debugtraps.o dumpstack.o 		\
> +obj-y	:=3D head_32.o debugtraps.o dumpstack.o				\
>  	   idle.o io.o irq.o irq_32.o kdebugfs.o			\
>  	   machvec.o nmi_debug.o process.o				\
>  	   process_32.o ptrace.o ptrace_32.o				\
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index d3a0e072ebe8..b328e4a0bd57 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -7,8 +7,6 @@
>  asflags-y :=3D -ansi
>  ccflags-y :=3D -Werror
> =20
> -extra-y     :=3D head_$(BITS).o
> -
>  # Undefine sparc when processing vmlinux.lds - it is used
>  # And teach CPP we are doing $(BITS) builds (for this case)
>  CPPFLAGS_vmlinux.lds :=3D -Usparc -m$(BITS)
> @@ -22,6 +20,7 @@ CFLAGS_REMOVE_perf_event.o :=3D -pg
>  CFLAGS_REMOVE_pcr.o :=3D -pg
>  endif
> =20
> +obj-y                   :=3D head_$(BITS).o
>  obj-$(CONFIG_SPARC64)   +=3D urtt_fill.o
>  obj-$(CONFIG_SPARC32)   +=3D entry.o wof.o wuf.o
>  obj-$(CONFIG_SPARC32)   +=3D etrap_32.o
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index a20a5ebfacd7..956e50ca06e0 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -3,10 +3,6 @@
>  # Makefile for the linux kernel.
>  #
> =20
> -extra-y	:=3D head_$(BITS).o
> -extra-y	+=3D head$(BITS).o
> -extra-y	+=3D ebda.o
> -extra-y	+=3D platform-quirks.o
>  extra-y	+=3D vmlinux.lds
> =20
>  CPPFLAGS_vmlinux.lds +=3D -U$(UTS_MACHINE)
> @@ -42,7 +38,11 @@ KCOV_INSTRUMENT		:=3D n
> =20
>  CFLAGS_irq.o :=3D -I $(srctree)/$(src)/../include/asm/trace
> =20
> -obj-y			:=3D process_$(BITS).o signal.o
> +obj-y			+=3D head_$(BITS).o
> +obj-y			+=3D head$(BITS).o
> +obj-y			+=3D ebda.o
> +obj-y			+=3D platform-quirks.o
> +obj-y			+=3D process_$(BITS).o signal.o
>  obj-$(CONFIG_COMPAT)	+=3D signal_compat.o
>  obj-y			+=3D traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
>  obj-y			+=3D time.o ioport.o dumpstack.o nmi.o
> diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
> index 897c1c741058..f28b8e3d717e 100644
> --- a/arch/xtensa/kernel/Makefile
> +++ b/arch/xtensa/kernel/Makefile
> @@ -3,9 +3,9 @@
>  # Makefile for the Linux/Xtensa kernel.
>  #
> =20
> -extra-y :=3D head.o vmlinux.lds
> +extra-y :=3D vmlinux.lds
> =20
> -obj-y :=3D align.o coprocessor.o entry.o irq.o platform.o process.o \
> +obj-y :=3D head.o align.o coprocessor.o entry.o irq.o platform.o process=
=2Eo \
>  	 ptrace.o setup.o signal.o stacktrace.o syscall.o time.o traps.o \
>  	 vectors.o
> =20
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 2daf760eeb25..ceb1d78140e7 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -70,13 +70,12 @@ quiet_cmd_vmlinux_objs =3D GEN     $@
>  	for f in $(real-prereqs); do	\
>  		case $${f} in		\
>  		*libgcc.a) ;;		\
> -		*.a) $(AR) t $${f} ;;	\
> -		*) echo $${f} ;;	\
> +		*) $(AR) t $${f} ;;	\
>  		esac			\
>  	done > $@
> =20
>  targets +=3D .vmlinux.objs
> -.vmlinux.objs: $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> +.vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
>  	$(call if_changed,vmlinux_objs)
> =20
>  vmlinux.o-if-present :=3D $(wildcard vmlinux.o)
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 84019814f33f..81a4e0484457 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -18,7 +18,7 @@ quiet_cmd_gen_initcalls_lds =3D GEN     $@
>  	$(PERL) $(real-prereqs) > $@
> =20
>  .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
> -		$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> +		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
>  	$(call if_changed,gen_initcalls_lds)
> =20
>  targets :=3D .tmp_initcalls.lds
> @@ -55,7 +55,7 @@ quiet_cmd_ld_vmlinux.o =3D LD      $@
>        cmd_ld_vmlinux.o =3D \
>  	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
>  	$(addprefix -T , $(initcalls-lds)) \
> -	--whole-archive $(KBUILD_VMLINUX_OBJS) --no-whole-archive \
> +	--whole-archive vmlinux.a --no-whole-archive \
>  	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
>  	$(cmd_objtool)
> =20
> @@ -64,7 +64,7 @@ define rule_ld_vmlinux.o
>  	$(call cmd,gen_objtooldep)
>  endef
> =20
> -vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS=
) FORCE
> +vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
>  	$(call if_changed_rule,ld_vmlinux.o)
> =20
>  targets +=3D vmlinux.o
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index 47da25b3ba7d..d800b2c0af97 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -109,20 +109,6 @@ def to_cmdfile(path):
>      return os.path.join(dir, '.' + base + '.cmd')
> =20
> =20
> -def cmdfiles_for_o(obj):
> -    """Generate the iterator of .cmd files associated with the object
> -
> -    Yield the .cmd file used to build the given object
> -
> -    Args:
> -        obj: The object path
> -
> -    Yields:
> -        The path to .cmd file
> -    """
> -    yield to_cmdfile(obj)
> -
> -
>  def cmdfiles_for_a(archive, ar):
>      """Generate the iterator of .cmd files associated with the archive.
> =20
> @@ -211,13 +197,10 @@ def main():
>      for path in paths:
>          # If 'path' is a directory, handle all .cmd files under it.
>          # Otherwise, handle .cmd files associated with the file.
> -        # Most of built-in objects are linked via archives (built-in.a o=
r lib.a)
> -        # but some objects are linked to vmlinux directly.
> +        # built-in objects are linked via vmlinux.a
>          # Modules are listed in modules.order.
>          if os.path.isdir(path):
>              cmdfiles =3D cmdfiles_in_dir(path)
> -        elif path.endswith('.o'):
> -            cmdfiles =3D cmdfiles_for_o(path)
>          elif path.endswith('.a'):
>              cmdfiles =3D cmdfiles_for_a(path, ar)
>          elif path.endswith('modules.order'):
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 6a197d8a88ac..23ac13fd9d89 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -3,17 +3,15 @@
>  #
>  # link vmlinux
>  #
> -# vmlinux is linked from the objects selected by $(KBUILD_VMLINUX_OBJS) =
and
> -# $(KBUILD_VMLINUX_LIBS). Most are built-in.a files from top-level direc=
tories
> -# in the kernel tree, others are specified in arch/$(ARCH)/Makefile.
> +# vmlinux is linked from the objects in vmlinux.a and $(KBUILD_VMLINUX_L=
IBS).
> +# vmlinux.a contains objects that are linked unconditionally.
>  # $(KBUILD_VMLINUX_LIBS) are archives which are linked conditionally
>  # (not within --whole-archive), and do not require symbol indexes added.
>  #
>  # vmlinux
>  #   ^
>  #   |
> -#   +--< $(KBUILD_VMLINUX_OBJS)
> -#   |    +--< init/built-in.a drivers/built-in.a mm/built-in.a + more
> +#   +--< vmlinux.a
>  #   |
>  #   +--< $(KBUILD_VMLINUX_LIBS)
>  #   |    +--< lib/lib.a + more
> @@ -67,7 +65,7 @@ vmlinux_link()
>  		objs=3Dvmlinux.o
>  		libs=3D
>  	else
> -		objs=3D"${KBUILD_VMLINUX_OBJS}"
> +		objs=3Dvmlinux.a
>  		libs=3D"${KBUILD_VMLINUX_LIBS}"
>  	fi
> =20
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--/QPoIt3ndWsR+Znz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0q1UACgkQB1IKcBYm
EmnRYQ//bYokMQAP3LVzCMyRt/KZry5l5IWk22+hS+VReJ/1LuN2V+fpi443x93s
Wz80BtP2FNCrUPoeRyI70BOoF1MeLw4KAfXF4qzRn+6c8O6dBWGP28f6/6DsP6yl
MowSHRsBNJznQiU3lGXHStrcvDd9+5euym0D1+v89ZuduH12zsLpv1VzFIeC2msv
EW09lK9H/JzjocbyX3HgxMLM8W0Y7cWA42/CzVYWSl9fbbwOonox4X8zVFARmFgf
BKJbLHGBjCFR0nMaaINe0DLsJRZaHVbch2viW+WurTuCTZts8Eh9U4YRMRvGEYNi
QnxFWPeGg39IaWWwbWuv8DQHmvyC0LPkVCPr3qjI3PND6fJZYQj78MA1uVQydQBz
xKlq68XEflsWHvIJTBdEDTeeQgvyDmoi+DJbpS/eFcnCqQ43uJsFQnQyOaO0W5US
j9W4uTj+glmK7bajFiKNG0pJFp4NOFMIc9PuATgGphu/xM0eNoifV8/8DBLgBC6V
rG7zyOFvu2HhALSZFHHi6zwBQFKCMnKoRZv2HO9jzZmlX+54oLgQZQuIxwQmTo/a
GRBs2JGlMZ5QueCZET92CDdOi7tTCseHqdGE5Ss6NsarhtzyaMiZNnhg1e5uygPf
FD5ag3CG8PeW9e3LVuJS2kzsHW8g5yVKHKKrQGpXjgCPqEbRS1g=
=lZFY
-----END PGP SIGNATURE-----

--/QPoIt3ndWsR+Znz--
