Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADB3CC921
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhGRMmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 08:42:36 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:62029 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRMmg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 08:42:36 -0400
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-03.nifty.com with ESMTP id 16ICb5Tp031773
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 21:37:05 +0900
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 16ICabv0016307;
        Sun, 18 Jul 2021 21:36:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 16ICabv0016307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626611798;
        bh=Z7Y6MKvjHBLx3XfKJNGwbkgZLTPhlTzY3EDPtspyw8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OYOC7lGfq2DXR/g05emm/mxdKzds9sP9hS3QQ3J56oWVe4HhlamBHqXu1iCJQvvWE
         RorgQ1btB3smTcq+Snzn31tWzL7fT1Tl8Pm3YfPDFL9TrTBOTkei1VRGIkQNPblMKi
         l58eH+SOdcbmRfIjC2sm6T4xhTWBgd8kIvZ0v588hghW1n0AzgbwfFMoVRa3xvbNBA
         ucsB04HFmYiXbGXbAP8rOrcLJArEDxqy0N7ikVq1nqHhcgkx+ALEh3uR8UqB2m9jgC
         x1ys/ZfGd8atPq7do1ObRw60MUCQ4qke6Lp04/2I5DtJkSquuc+fcoUuvnsizZvB+L
         /w30DIuTzv8vA==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso10431338pjp.5;
        Sun, 18 Jul 2021 05:36:37 -0700 (PDT)
X-Gm-Message-State: AOAM531R7eT8UPI9NJVK99BfTVm5hV5grffVecCkqq9ybl0DdSAskJU2
        yT3yFVByn8DLLTaLUSrDpHUXywpH7gFQXSP0tFo=
X-Google-Smtp-Source: ABdhPJzdtxwhf+bxbS33sjH7orq0F564NAAExBhJrqDYpzo/C2KZHJicyJT8bJWZizaz2Gl474SM2ShFoxA7xLwsM/Y=
X-Received: by 2002:a17:90a:c506:: with SMTP id k6mr25485599pjt.198.1626611796963;
 Sun, 18 Jul 2021 05:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <YO3txvw87MjKfdpq@localhost.localdomain> <YO8ioz4sHwcUAkdt@localhost.localdomain>
 <YPClYgoJOTUn4V0w@localhost.localdomain>
In-Reply-To: <YPClYgoJOTUn4V0w@localhost.localdomain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 18 Jul 2021 21:36:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASq9DwxTF90u_8XZJo8VBLbEPDbP8kVk6c+AHpaCtH01g@mail.gmail.com>
Message-ID: <CAK7LNASq9DwxTF90u_8XZJo8VBLbEPDbP8kVk6c+AHpaCtH01g@mail.gmail.com>
Subject: Re: [PATCH -mm] fixup "Decouple build from userspace headers"
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 16, 2021 at 6:15 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Allow to find SIMD headers where necessary.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>         fold into decouple-build-from-userspace-headers.patch
>
>  arch/arm64/lib/Makefile   |    2 +-
>  arch/powerpc/lib/Makefile |    2 +-
>  lib/raid6/Makefile        |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)


OK. Perhaps, we can import <arm_neon.h> and  <altivec.h>
into the kernel tree as we did for <stdarg.h>,
then remove "-isystem $(shell $(CC) -print-file-name=include)"
entirely, but I did not look into it.


If we can avoid the arm_neon.h mess,
we can clean up arch/arm/include/uapi/asm/types.h as well.
It is a possible future work.

Anyway, could you add some comments?
(see blew)



> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -8,7 +8,7 @@ lib-y           := clear_user.o delay.o copy_from_user.o                \
>  ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
>  obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
>  CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
> -CFLAGS_xor-neon.o              += -ffreestanding

Can you add comment, # for <arm_neon.h>

> +CFLAGS_xor-neon.o              += -ffreestanding -isystem $(shell $(CC) -print-file-name=include)
>  endif
>
>  lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -64,6 +64,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
>  obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
>
>  obj-$(CONFIG_ALTIVEC)  += xor_vmx.o xor_vmx_glue.o
> -CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)

Can you add comment, # for <altivec.h>

> +CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec) -isystem $(shell $(CC) -print-file-name=include)
>
>  obj-$(CONFIG_PPC64) += $(obj64-y)
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -13,7 +13,7 @@ raid6_pq-$(CONFIG_S390) += s390vx8.o recov_s390xc.o
>  hostprogs      += mktables
>
>  ifeq ($(CONFIG_ALTIVEC),y)
> -altivec_flags := -maltivec $(call cc-option,-mabi=altivec)

Can you add comment, # for <altivec.h>

> +altivec_flags := -maltivec $(call cc-option,-mabi=altivec) -isystem $(shell $(CC) -print-file-name=include)
>
>  ifdef CONFIG_CC_IS_CLANG
>  # clang ppc port does not yet support -maltivec when -msoft-float is
> @@ -33,7 +33,7 @@ endif
>  # The GCC option -ffreestanding is required in order to compile code containing
>  # ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> -NEON_FLAGS := -ffreestanding

Can you add comment, # for <arm_neon.h>

> +NEON_FLAGS := -ffreestanding -isystem $(shell $(CC) -print-file-name=include)
>  ifeq ($(ARCH),arm)
>  NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>  endif



-- 
Best Regards
Masahiro Yamada
