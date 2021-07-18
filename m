Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE06A3CC942
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhGRNJQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 09:09:16 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:34946 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRNJQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 09:09:16 -0400
X-Greylist: delayed 1753 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 09:09:15 EDT
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 16ID5rKn018956;
        Sun, 18 Jul 2021 22:05:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 16ID5rKn018956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626613554;
        bh=yhIG4/mhI0KryuwCf2e2wfoiwF06SUSrgf+QazUPih0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HVdJHdW33JE2DKbYfa52ylLKWvow/QKW+Yz0USvVhpnEvfuEHxhuTA5H86pDxTZ+F
         qT4ZlLQ+BV9Ay6N7WaPiFo6YQ79aBS6t2ABBWz0z7IA9XOn/D0HG0qchorRPIkr9es
         QodHbUu9t1vqFK80IDvdG2hHE4cclWUOtY34qw0MhHl+ngoQsEV+oV+M4qeq2J39EA
         e4Mwqu/DhVIxU2/y3kqsMp8A1lL4WZjyL2Sji9RaxXxTxQhyMiRwbXs8QrqaA53NrC
         F3pG5WzpL98QsvnBocc4guS3ZqqBdDgrljZfwhemCXpj43JvxTPUM47ywxxXGpkv8Z
         Bz43S/iXaMPfA==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id b12so13714554pfv.6;
        Sun, 18 Jul 2021 06:05:54 -0700 (PDT)
X-Gm-Message-State: AOAM531DRPJCD29rOx9WUe7RmLq52AC1esmdsOSE1LhQFayW7A1cqjRc
        w7w5ToJzAjIEaEgZgM26RcFfk8IRoN1jFz6um9Q=
X-Google-Smtp-Source: ABdhPJyjXGKYkI7wwmKtSIF62hypxKul4sPRb/pA9o4M0fHbfT1nhsBgBrNsct1dlu8o/a+RHGdP1J2xeUaHynBP5zw=
X-Received: by 2002:a62:1d84:0:b029:304:5af1:65f6 with SMTP id
 d126-20020a621d840000b02903045af165f6mr20225303pfd.80.1626613553400; Sun, 18
 Jul 2021 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <YO3txvw87MjKfdpq@localhost.localdomain> <YO8ioz4sHwcUAkdt@localhost.localdomain>
 <YPClYgoJOTUn4V0w@localhost.localdomain> <CAK7LNASq9DwxTF90u_8XZJo8VBLbEPDbP8kVk6c+AHpaCtH01g@mail.gmail.com>
In-Reply-To: <CAK7LNASq9DwxTF90u_8XZJo8VBLbEPDbP8kVk6c+AHpaCtH01g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 18 Jul 2021 22:05:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQonQAo00hGjxZX6TE9hBYadYiwBrdfiE9eaUjSKxLPPw@mail.gmail.com>
Message-ID: <CAK7LNAQonQAo00hGjxZX6TE9hBYadYiwBrdfiE9eaUjSKxLPPw@mail.gmail.com>
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

On Sun, Jul 18, 2021 at 9:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jul 16, 2021 at 6:15 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Allow to find SIMD headers where necessary.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >
> >         fold into decouple-build-from-userspace-headers.patch
> >
> >  arch/arm64/lib/Makefile   |    2 +-
> >  arch/powerpc/lib/Makefile |    2 +-
> >  lib/raid6/Makefile        |    4 ++--


I did not compile-test it yet, but
I see more <arm_neon.h> inclusion.



crypto/aegis128-neon-inner.c:



#ifdef CONFIG_ARM64
#include <asm/neon-intrinsics.h>

#define AES_ROUND       "aese %0.16b, %1.16b \n\t aesmc %0.16b, %0.16b"
#else
#include <arm_neon.h>

#define AES_ROUND       "aese.8 %q0, %q1 \n\t aesmc.8 %q0, %q0"
#endif




Can you test crypto/aegis128-neon-inner.c
with CONFIG_ARM64=n  (i.e. CONFIG_ARM=y) ?

















> >  3 files changed, 4 insertions(+), 4 deletions(-)
>
>
> OK. Perhaps, we can import <arm_neon.h> and  <altivec.h>
> into the kernel tree as we did for <stdarg.h>,
> then remove "-isystem $(shell $(CC) -print-file-name=include)"
> entirely, but I did not look into it.
>
>
> If we can avoid the arm_neon.h mess,
> we can clean up arch/arm/include/uapi/asm/types.h as well.
> It is a possible future work.
>
> Anyway, could you add some comments?
> (see blew)
>
>
>
> > --- a/arch/arm64/lib/Makefile
> > +++ b/arch/arm64/lib/Makefile
> > @@ -8,7 +8,7 @@ lib-y           := clear_user.o delay.o copy_from_user.o                \
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> >  obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
> >  CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
> > -CFLAGS_xor-neon.o              += -ffreestanding
>
> Can you add comment, # for <arm_neon.h>
>
> > +CFLAGS_xor-neon.o              += -ffreestanding -isystem $(shell $(CC) -print-file-name=include)
> >  endif
> >
> >  lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
> > --- a/arch/powerpc/lib/Makefile
> > +++ b/arch/powerpc/lib/Makefile
> > @@ -64,6 +64,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
> >  obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
> >
> >  obj-$(CONFIG_ALTIVEC)  += xor_vmx.o xor_vmx_glue.o
> > -CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
>
> Can you add comment, # for <altivec.h>
>
> > +CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec) -isystem $(shell $(CC) -print-file-name=include)
> >
> >  obj-$(CONFIG_PPC64) += $(obj64-y)
> > --- a/lib/raid6/Makefile
> > +++ b/lib/raid6/Makefile
> > @@ -13,7 +13,7 @@ raid6_pq-$(CONFIG_S390) += s390vx8.o recov_s390xc.o
> >  hostprogs      += mktables
> >
> >  ifeq ($(CONFIG_ALTIVEC),y)
> > -altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
>
> Can you add comment, # for <altivec.h>
>
> > +altivec_flags := -maltivec $(call cc-option,-mabi=altivec) -isystem $(shell $(CC) -print-file-name=include)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> >  # clang ppc port does not yet support -maltivec when -msoft-float is
> > @@ -33,7 +33,7 @@ endif
> >  # The GCC option -ffreestanding is required in order to compile code containing
> >  # ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> > -NEON_FLAGS := -ffreestanding
>
> Can you add comment, # for <arm_neon.h>
>
> > +NEON_FLAGS := -ffreestanding -isystem $(shell $(CC) -print-file-name=include)
> >  ifeq ($(ARCH),arm)
> >  NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >  endif
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
