Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A723A1BC1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFIR3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhFIR3N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 13:29:13 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53957C061574;
        Wed,  9 Jun 2021 10:27:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w9so13198907qvi.13;
        Wed, 09 Jun 2021 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oq0U9syyq9gEYvYWSfO8Ak3QWaboE7VXuduo27+0taY=;
        b=ZEaAQnHsAwx4hAmrPKVfEUyqpkkW8U8//DkiVJJhBbVgHyp++3qeNnaIgEFRMIZRcD
         8exH95wqcqNhl8lSU4aTFK+eaprWMh8qTagLhnZ4V9PDngSK4BXBaNhq6hOGkRp5N97s
         PinaGHQXn7V25YNIT5tj9bnpyf7X8VxOT0fH5Y2mAyUBj5wjYrLeajfLFilxRWicI/Ty
         14qmrZqwoRTv4L1VGQa1wp7H99nGTnXXtFJzI3yHkFUo6JdbYYqz1lqkT5BxfVkWrOlq
         /NaUy3yD6yE6u9ojkWUGbVHmJUc1f4Y71njcxP6R4QB0dlOpeiXSCqRNuyM5ORB8bX1L
         GHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oq0U9syyq9gEYvYWSfO8Ak3QWaboE7VXuduo27+0taY=;
        b=m1eKSh4Wo6xRqN3EI7aTgjMmJvuEoeNkM6RpVRIPAaAzw0PFABI/NhN6Pcj/XWkYLb
         Oz7cbP0jzSYs17itztiXpKQVo1yNZiolJGJYa4yO9bYMTYSHL/dI5/7QJLH/z0FA8JSC
         eXKlax7DLZID0z1s0xD8BIOLReNfddpej3r9c9z7UpV+o8c5Sip7ZRuRnue0nK95bTV+
         RfvDrhTXjTcdRUYgV2gD2EsUdfQLPz3FlTHgJydP39IhHoLstM8R5VfrBDpN1419CMTH
         cF/o6QJ7I+T++IvSuwJ8bdWaSQ74BN4anBoLsr7jBZLEzBsqEHpswcn4PTp3sfzwCzxI
         TDgg==
X-Gm-Message-State: AOAM533Xx+ZFYcty21RczmcPxb/fQTesFwmz5tkh+wh0lnnZHFZSsA60
        wc4hvTizqE9iX0v9DZL5MIw=
X-Google-Smtp-Source: ABdhPJxrK2J1QFO9AQaalUYvDdBf0h7q0CqU3wWBZnQ3t5X5oRhNzuSbpBxHyBbd11BRIPZpsHs2KA==
X-Received: by 2002:a0c:e54c:: with SMTP id n12mr1147526qvm.20.1623259621272;
        Wed, 09 Jun 2021 10:27:01 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id c9sm528142qke.8.2021.06.09.10.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:27:00 -0700 (PDT)
Date:   Wed, 9 Jun 2021 10:27:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nick Terrell <terrelln@fb.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, Yogesh Lal <ylal@codeaurora.org>
Subject: Re: [PATCH] all: remove GENERIC_FIND_FIRST_BIT
Message-ID: <YMD566T1cGfy7DJA@yury-ThinkPad>
References: <20210510233421.18684-1-yury.norov@gmail.com>
 <YL49uhT6e2TlWzu8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL49uhT6e2TlWzu8@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 06:39:38PM +0300, Andy Shevchenko wrote:
> On Mon, May 10, 2021 at 04:34:21PM -0700, Yury Norov wrote:
> > In the 5.12 cycle we enabled the GENERIC_FIND_FIRST_BIT config option
> > for ARM64 and MIPS. It increased performance and shrunk .text size; and
> > so far I didn't receive any negative feedback on the change.
> > 
> > https://lore.kernel.org/linux-arch/20210225135700.1381396-1-yury.norov@gmail.com/
> > 
> > I think it's time to make all architectures use find_{first,last}_bit()
> > unconditionally and remove the corresponding config option.
> > 
> > This patch doesn't introduce functional changes for arc, arm64, mips,
> > s390 and x86 because they already enable GENERIC_FIND_FIRST_BIT. There
> > will be no changes for arm because it implements find_{first,last}_bit
> > in arch code. For other architectures I expect improvement both in
> > performance and .text size.
> 
> Subject like s/all:/arch:/.

Ok, thanks. I will resend shortly as part of series, to fix m68k
issue.
 
> > It would be great if people with an access to real hardware would share
> > the output of bloat-o-meter and lib/find_bit_benchmark.
> 
> This is rather comment (should be below cutter '---' line).
> 
> Anyway, seems good to my by the code:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/arc/Kconfig                  |  1 -
> >  arch/arm64/Kconfig                |  1 -
> >  arch/mips/Kconfig                 |  1 -
> >  arch/s390/Kconfig                 |  1 -
> >  arch/x86/Kconfig                  |  1 -
> >  arch/x86/um/Kconfig               |  1 -
> >  include/asm-generic/bitops/find.h | 12 ------------
> >  lib/Kconfig                       |  3 ---
> >  8 files changed, 21 deletions(-)
> > 
> > diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> > index bc8d6aecfbbd..9c991ba50db3 100644
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -19,7 +19,6 @@ config ARC
> >  	select COMMON_CLK
> >  	select DMA_DIRECT_REMAP
> >  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
> > -	select GENERIC_FIND_FIRST_BIT
> >  	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
> >  	select GENERIC_IRQ_SHOW
> >  	select GENERIC_PCI_IOMAP
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e09a9591af45..9d5b36f7d981 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -108,7 +108,6 @@ config ARM64
> >  	select GENERIC_CPU_AUTOPROBE
> >  	select GENERIC_CPU_VULNERABILITIES
> >  	select GENERIC_EARLY_IOREMAP
> > -	select GENERIC_FIND_FIRST_BIT
> >  	select GENERIC_IDLE_POLL_SETUP
> >  	select GENERIC_IRQ_IPI
> >  	select GENERIC_IRQ_PROBE
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index b72458215d20..3ddae7918386 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -27,7 +27,6 @@ config MIPS
> >  	select GENERIC_ATOMIC64 if !64BIT
> >  	select GENERIC_CMOS_UPDATE
> >  	select GENERIC_CPU_AUTOPROBE
> > -	select GENERIC_FIND_FIRST_BIT
> >  	select GENERIC_GETTIMEOFDAY
> >  	select GENERIC_IOMAP
> >  	select GENERIC_IRQ_PROBE
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index c1ff874e6c2e..3a10ceb8a097 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -125,7 +125,6 @@ config S390
> >  	select GENERIC_CPU_AUTOPROBE
> >  	select GENERIC_CPU_VULNERABILITIES
> >  	select GENERIC_ENTRY
> > -	select GENERIC_FIND_FIRST_BIT
> >  	select GENERIC_GETTIMEOFDAY
> >  	select GENERIC_PTDUMP
> >  	select GENERIC_SMP_IDLE_THREAD
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index b83364a15d34..6a7d8305365e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -123,7 +123,6 @@ config X86
> >  	select GENERIC_CPU_VULNERABILITIES
> >  	select GENERIC_EARLY_IOREMAP
> >  	select GENERIC_ENTRY
> > -	select GENERIC_FIND_FIRST_BIT
> >  	select GENERIC_IOMAP
> >  	select GENERIC_IRQ_EFFECTIVE_AFF_MASK	if SMP
> >  	select GENERIC_IRQ_MATRIX_ALLOCATOR	if X86_LOCAL_APIC
> > diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> > index 95d26a69088b..40d6a06e41c8 100644
> > --- a/arch/x86/um/Kconfig
> > +++ b/arch/x86/um/Kconfig
> > @@ -8,7 +8,6 @@ endmenu
> >  
> >  config UML_X86
> >  	def_bool y
> > -	select GENERIC_FIND_FIRST_BIT
> >  
> >  config 64BIT
> >  	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
> > diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> > index 0d132ee2a291..8a7b70c79e15 100644
> > --- a/include/asm-generic/bitops/find.h
> > +++ b/include/asm-generic/bitops/find.h
> > @@ -95,8 +95,6 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >  }
> >  #endif
> >  
> > -#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
> > -
> >  /**
> >   * find_first_bit - find the first set bit in a memory region
> >   * @addr: The address to start the search at
> > @@ -136,16 +134,6 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
> >  
> >  	return _find_first_zero_bit(addr, size);
> >  }
> > -#else /* CONFIG_GENERIC_FIND_FIRST_BIT */
> > -
> > -#ifndef find_first_bit
> > -#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
> > -#endif
> > -#ifndef find_first_zero_bit
> > -#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
> > -#endif
> > -
> > -#endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
> >  
> >  #ifndef find_last_bit
> >  /**
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index a38cc61256f1..8346b3181214 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -59,9 +59,6 @@ config GENERIC_STRNLEN_USER
> >  config GENERIC_NET_UTILS
> >  	bool
> >  
> > -config GENERIC_FIND_FIRST_BIT
> > -	bool
> > -
> >  source "lib/math/Kconfig"
> >  
> >  config NO_GENERIC_PCI_IOPORT_MAP
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
