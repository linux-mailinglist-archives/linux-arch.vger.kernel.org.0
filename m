Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B8262657
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 06:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIIE1O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 00:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgIIE1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 00:27:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B09C061756
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 21:27:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so703791pjr.3
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 21:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KxYznu6/RaMBq3XnQcZXFLCOwvFdZBNPnHf5lL/gtks=;
        b=MtK9QLXzOhZk3vWk1zQ7UUZUYCXM3qd9bRt5KSABkJ4L8vbr/v+UbmS8f/RaSdqoBX
         GjURmZz8wJAx2hce99G5+t6B5cz7HtbSyZiLFOJ3INGrDhOti3NOlhaUu/6hudbuhGVx
         bHm6aWt52fZyuPch9HiXJZbflwaCaF8Ls1rlNXBuBbUObBc+2EaNGG9qXW3dUeScgaJR
         CRY198ws1rMH7JBWN5owtp36Suea7e4+RrSN9FlZd+uu0m3cswR0wqOCGDm2nhcR5BUQ
         82qFD58+ezefPhiyUQEgPpurMTn03A1GslE2/XtpFNEjOY/MjGpCGUZnNFQClwvKlhBI
         YqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KxYznu6/RaMBq3XnQcZXFLCOwvFdZBNPnHf5lL/gtks=;
        b=CeXA7AwHXTezHPjR4cOVve8Ai6c01EkJpHU+15rfkmQhLDUrBcQPdgL/C1MhHRKyU/
         l6Ng3N2Hz5WRzfXbLMa5rpHgVYi1qGV+UbBo2UmpE34h8QE6gGTruwN7xqwd5AKS7yhB
         nLwJHCyjFcXdBtn9yn9Hpo9/xZ1Jz8BYEyU7xJ6hkzepCgC5evsma6rb4EiyckJWbuph
         XUHN1w3WGDVSyJ5yfBHgWd3x6JA3ypl0Bdhu6rz3bD4NRYFJX2rUSK3RtGCMqwLtynwv
         JHLDFo3qXcjpQR1bc8N8eHtqFSTaSd/PJxkTgVp2P4Bgd0suVFLao0jFBEPD4enlO478
         Xz2Q==
X-Gm-Message-State: AOAM531xlZkrZaV10FNJGfQTtxrx+wv0EF7srpZfqllZpf0vD/jRtLkB
        j9cO0oL+jznJSJPu0jpvb1rZMQ==
X-Google-Smtp-Source: ABdhPJwdYcFaX2ADEhk739T179fDYwdfJE8FRUv6HiW4fv0EOhyxEYKQPL4AizpkC7OJU3f+nSIaMw==
X-Received: by 2002:a17:90a:a081:: with SMTP id r1mr1979398pjp.159.1599625626651;
        Tue, 08 Sep 2020 21:27:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l13sm731744pgq.33.2020.09.08.21.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:27:06 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:27:06 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:27:04 PDT (-0700)
Subject:     Re: [PATCH v2] kbuild: preprocess module linker script
In-Reply-To: <20200908042708.2511528-1-masahiroy@kernel.org>
CC:     linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        jeyu@kernel.org, will@kernel.org, aou@eecs.berkeley.edu,
        anton.ivanov@cambridgegreys.com, Arnd Bergmann <arnd@arndb.de>,
        benh@kernel.crashing.org, catalin.marinas@arm.com,
        fenghua.yu@intel.com, geert@linux-m68k.org, jdike@addtoit.com,
        mpe@ellerman.id.au, michal.lkml@markovi.net, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>, richard@nod.at,
        linux@armlinux.org.uk, tony.luck@intel.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-66fe209f-04d5-4177-a305-d67af7bbdb8b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 07 Sep 2020 21:27:08 PDT (-0700), masahiroy@kernel.org wrote:
> There was a request to preprocess the module linker script like we
> do for the vmlinux one. (https://lkml.org/lkml/2020/8/21/512)
>
> The difference between vmlinux.lds and module.lds is that the latter
> is needed for external module builds, thus must be cleaned up by
> 'make mrproper' instead of 'make clean'. Also, it must be created
> by 'make modules_prepare'.
>
> You cannot put it in arch/$(SRCARCH)/kernel/, which is cleaned up by
> 'make clean'. I moved arch/$(SRCARCH)/kernel/module.lds to
> arch/$(SRCARCH)/include/asm/module.lds.h, which is included from
> scripts/module.lds.S.
>
> scripts/module.lds is fine because 'make clean' keeps all the
> build artifacts under scripts/.
>
> You can add arch-specific sections in <asm/module.lds.h>.

for the arch/riscv stuff

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Jessica Yu <jeyu@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>
> Changes in v2:
>   - Fix the race between the two targets 'scripts' and 'asm-generic'
>
>  Makefile                                               | 10 ++++++----
>  arch/arm/Makefile                                      |  4 ----
>  .../{kernel/module.lds => include/asm/module.lds.h}    |  2 ++
>  arch/arm64/Makefile                                    |  4 ----
>  .../{kernel/module.lds => include/asm/module.lds.h}    |  2 ++
>  arch/ia64/Makefile                                     |  1 -
>  arch/ia64/{module.lds => include/asm/module.lds.h}     |  0
>  arch/m68k/Makefile                                     |  1 -
>  .../{kernel/module.lds => include/asm/module.lds.h}    |  0
>  arch/powerpc/Makefile                                  |  1 -
>  .../{kernel/module.lds => include/asm/module.lds.h}    |  0
>  arch/riscv/Makefile                                    |  3 ---
>  .../{kernel/module.lds => include/asm/module.lds.h}    |  3 ++-
>  arch/um/include/asm/Kbuild                             |  1 +
>  include/asm-generic/Kbuild                             |  1 +
>  include/asm-generic/module.lds.h                       | 10 ++++++++++
>  scripts/.gitignore                                     |  1 +
>  scripts/Makefile                                       |  3 +++
>  scripts/Makefile.modfinal                              |  5 ++---
>  scripts/{module-common.lds => module.lds.S}            |  3 +++
>  scripts/package/builddeb                               |  2 +-
>  21 files changed, 34 insertions(+), 23 deletions(-)
>  rename arch/arm/{kernel/module.lds => include/asm/module.lds.h} (72%)
>  rename arch/arm64/{kernel/module.lds => include/asm/module.lds.h} (76%)
>  rename arch/ia64/{module.lds => include/asm/module.lds.h} (100%)
>  rename arch/m68k/{kernel/module.lds => include/asm/module.lds.h} (100%)
>  rename arch/powerpc/{kernel/module.lds => include/asm/module.lds.h} (100%)
>  rename arch/riscv/{kernel/module.lds => include/asm/module.lds.h} (84%)
>  create mode 100644 include/asm-generic/module.lds.h
>  rename scripts/{module-common.lds => module.lds.S} (93%)
>
> diff --git a/Makefile b/Makefile
> index 37739ee53f27..97b1dae1783b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -505,7 +505,6 @@ KBUILD_CFLAGS_KERNEL :=
>  KBUILD_AFLAGS_MODULE  := -DMODULE
>  KBUILD_CFLAGS_MODULE  := -DMODULE
>  KBUILD_LDFLAGS_MODULE :=
> -export KBUILD_LDS_MODULE := $(srctree)/scripts/module-common.lds
>  KBUILD_LDFLAGS :=
>  CLANG_FLAGS :=
>
> @@ -1395,7 +1394,7 @@ endif
>  # using awk while concatenating to the final file.
>
>  PHONY += modules
> -modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_check
> +modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_check modules_prepare
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>
>  PHONY += modules_check
> @@ -1412,6 +1411,7 @@ targets += modules.order
>  # Target to prepare building external modules
>  PHONY += modules_prepare
>  modules_prepare: prepare
> +	$(Q)$(MAKE) $(build)=scripts scripts/module.lds
>
>  # Target to install modules
>  PHONY += modules_install
> @@ -1743,7 +1743,9 @@ help:
>  	@echo  '  clean           - remove generated files in module directory only'
>  	@echo  ''
>
> -PHONY += prepare
> +# no-op for external module builds
> +PHONY += prepare modules_prepare
> +
>  endif # KBUILD_EXTMOD
>
>  # Single targets
> @@ -1776,7 +1778,7 @@ MODORDER := .modules.tmp
>  endif
>
>  PHONY += single_modpost
> -single_modpost: $(single-no-ko)
> +single_modpost: $(single-no-ko) modules_prepare
>  	$(Q){ $(foreach m, $(single-ko), echo $(extmod-prefix)$m;) } > $(MODORDER)
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 4e877354515f..a0cb15de9677 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -16,10 +16,6 @@ LDFLAGS_vmlinux	+= --be8
>  KBUILD_LDFLAGS_MODULE	+= --be8
>  endif
>
> -ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
> -KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
> -endif
> -
>  GZFLAGS		:=-9
>  #KBUILD_CFLAGS	+=-pipe
>
> diff --git a/arch/arm/kernel/module.lds b/arch/arm/include/asm/module.lds.h
> similarity index 72%
> rename from arch/arm/kernel/module.lds
> rename to arch/arm/include/asm/module.lds.h
> index 79cb6af565e5..0e7cb4e314b4 100644
> --- a/arch/arm/kernel/module.lds
> +++ b/arch/arm/include/asm/module.lds.h
> @@ -1,5 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifdef CONFIG_ARM_MODULE_PLTS
>  SECTIONS {
>  	.plt : { BYTE(0) }
>  	.init.plt : { BYTE(0) }
>  }
> +#endif
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b45f0124cc16..76667ad47980 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -115,10 +115,6 @@ endif
>
>  CHECKFLAGS	+= -D__aarch64__
>
> -ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
> -KBUILD_LDS_MODULE	+= $(srctree)/arch/arm64/kernel/module.lds
> -endif
> -
>  ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
>    KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>    CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/include/asm/module.lds.h
> similarity index 76%
> rename from arch/arm64/kernel/module.lds
> rename to arch/arm64/include/asm/module.lds.h
> index 22e36a21c113..691f15af788e 100644
> --- a/arch/arm64/kernel/module.lds
> +++ b/arch/arm64/include/asm/module.lds.h
> @@ -1,5 +1,7 @@
> +#ifdef CONFIG_ARM64_MODULE_PLTS
>  SECTIONS {
>  	.plt (NOLOAD) : { BYTE(0) }
>  	.init.plt (NOLOAD) : { BYTE(0) }
>  	.text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
>  }
> +#endif
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> index 2876a7df1b0a..703b1c4f6d12 100644
> --- a/arch/ia64/Makefile
> +++ b/arch/ia64/Makefile
> @@ -20,7 +20,6 @@ CHECKFLAGS	+= -D__ia64=1 -D__ia64__=1 -D_LP64 -D__LP64__
>
>  OBJCOPYFLAGS	:= --strip-all
>  LDFLAGS_vmlinux	:= -static
> -KBUILD_LDS_MODULE += $(srctree)/arch/ia64/module.lds
>  KBUILD_AFLAGS_KERNEL := -mconstant-gp
>  EXTRA		:=
>
> diff --git a/arch/ia64/module.lds b/arch/ia64/include/asm/module.lds.h
> similarity index 100%
> rename from arch/ia64/module.lds
> rename to arch/ia64/include/asm/module.lds.h
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 4438ffb4bbe1..ea14f2046fb4 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -75,7 +75,6 @@ KBUILD_CPPFLAGS += -D__uClinux__
>  endif
>
>  KBUILD_LDFLAGS := -m m68kelf
> -KBUILD_LDS_MODULE += $(srctree)/arch/m68k/kernel/module.lds
>
>  ifdef CONFIG_SUN3
>  LDFLAGS_vmlinux = -N
> diff --git a/arch/m68k/kernel/module.lds b/arch/m68k/include/asm/module.lds.h
> similarity index 100%
> rename from arch/m68k/kernel/module.lds
> rename to arch/m68k/include/asm/module.lds.h
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 3e8da9cf2eb9..8935658fcd06 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -65,7 +65,6 @@ UTS_MACHINE := $(subst $(space),,$(machine-y))
>  ifdef CONFIG_PPC32
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
>  else
> -KBUILD_LDS_MODULE += $(srctree)/arch/powerpc/kernel/module.lds
>  ifeq ($(call ld-ifversion, -ge, 225000000, y),y)
>  # Have the linker provide sfpr if possible.
>  # There is a corresponding test in arch/powerpc/lib/Makefile
> diff --git a/arch/powerpc/kernel/module.lds b/arch/powerpc/include/asm/module.lds.h
> similarity index 100%
> rename from arch/powerpc/kernel/module.lds
> rename to arch/powerpc/include/asm/module.lds.h
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index fb6e37db836d..8edaa8bd86d6 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -53,9 +53,6 @@ endif
>  ifeq ($(CONFIG_CMODEL_MEDANY),y)
>  	KBUILD_CFLAGS += -mcmodel=medany
>  endif
> -ifeq ($(CONFIG_MODULE_SECTIONS),y)
> -	KBUILD_LDS_MODULE += $(srctree)/arch/riscv/kernel/module.lds
> -endif
>  ifeq ($(CONFIG_PERF_EVENTS),y)
>          KBUILD_CFLAGS += -fno-omit-frame-pointer
>  endif
> diff --git a/arch/riscv/kernel/module.lds b/arch/riscv/include/asm/module.lds.h
> similarity index 84%
> rename from arch/riscv/kernel/module.lds
> rename to arch/riscv/include/asm/module.lds.h
> index 295ecfb341a2..4254ff2ff049 100644
> --- a/arch/riscv/kernel/module.lds
> +++ b/arch/riscv/include/asm/module.lds.h
> @@ -1,8 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (C) 2017 Andes Technology Corporation */
> -
> +#ifdef CONFIG_MODULE_SECTIONS
>  SECTIONS {
>  	.plt (NOLOAD) : { BYTE(0) }
>  	.got (NOLOAD) : { BYTE(0) }
>  	.got.plt (NOLOAD) : { BYTE(0) }
>  }
> +#endif
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index 8d435f8a6dec..1c63b260ecc4 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -16,6 +16,7 @@ generic-y += kdebug.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> +generic-y += module.lds.h
>  generic-y += param.h
>  generic-y += pci.h
>  generic-y += percpu.h
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 74b0612601dd..7cd4e627e00e 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -40,6 +40,7 @@ mandatory-y += mmiowb.h
>  mandatory-y += mmu.h
>  mandatory-y += mmu_context.h
>  mandatory-y += module.h
> +mandatory-y += module.lds.h
>  mandatory-y += msi.h
>  mandatory-y += pci.h
>  mandatory-y += percpu.h
> diff --git a/include/asm-generic/module.lds.h b/include/asm-generic/module.lds.h
> new file mode 100644
> index 000000000000..f210d5c1b78b
> --- /dev/null
> +++ b/include/asm-generic/module.lds.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_GENERIC_MODULE_LDS_H
> +#define __ASM_GENERIC_MODULE_LDS_H
> +
> +/*
> + * <asm/module.lds.h> can specify arch-specific sections for linking modules.
> + * Empty for the asm-generic header.
> + */
> +
> +#endif /* __ASM_GENERIC_MODULE_LDS_H */
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 0d1c8e217cd7..a6c11316c969 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -8,3 +8,4 @@ asn1_compiler
>  extract-cert
>  sign-file
>  insert-sys-cert
> +/module.lds
> diff --git a/scripts/Makefile b/scripts/Makefile
> index bc018e4b733e..b5418ec587fb 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -29,6 +29,9 @@ endif
>  # The following programs are only built on demand
>  hostprogs += unifdef
>
> +# The module linker script is preprocessed on demand
> +targets += module.lds
> +
>  subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 411c1e600e7d..ae01baf96f4e 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -33,11 +33,10 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o =                                                     \
>  	$(LD) -r $(KBUILD_LDFLAGS)					\
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
> -		$(addprefix -T , $(KBUILD_LDS_MODULE))			\
> -		-o $@ $(filter %.o, $^);				\
> +		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
> -$(modules): %.ko: %.o %.mod.o $(KBUILD_LDS_MODULE) FORCE
> +$(modules): %.ko: %.o %.mod.o scripts/module.lds FORCE
>  	+$(call if_changed,ld_ko_o)
>
>  targets += $(modules) $(modules:.ko=.mod.o)
> diff --git a/scripts/module-common.lds b/scripts/module.lds.S
> similarity index 93%
> rename from scripts/module-common.lds
> rename to scripts/module.lds.S
> index d61b9e8678e8..69b9b71a6a47 100644
> --- a/scripts/module-common.lds
> +++ b/scripts/module.lds.S
> @@ -24,3 +24,6 @@ SECTIONS {
>
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  }
> +
> +/* bring in arch-specific sections */
> +#include <asm/module.lds.h>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 6df3c9f8b2da..44f212e37935 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -55,7 +55,7 @@ deploy_kernel_headers () {
>  		cd $srctree
>  		find . arch/$SRCARCH -maxdepth 1 -name Makefile\*
>  		find include scripts -type f -o -type l
> -		find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform
> +		find arch/$SRCARCH -name Kbuild.platforms -o -name Platform
>  		find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f
>  	) > debian/hdrsrcfiles
