Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206D839E0BA
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFGPlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 11:41:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:38495 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhFGPlo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 11:41:44 -0400
IronPort-SDR: 625sZc+yuCfYs0SBsG8HP5awRZEVJf9INIKxBPu24NaUALAAmw9xQ0d0I+4nRK49dnhjO/V3Hn
 EeuJbHCbFgXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="191973139"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="191973139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 08:39:49 -0700
IronPort-SDR: JEulWHbYEZ0vI+ChaCM0Jf62WFEqLfTtyUICPiiKAbbMQemuErGwBHuNSraEJ79byY2DnDuCVG
 Uirel1mH5lCQ==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="449130585"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 08:39:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqHLm-000I2j-6H; Mon, 07 Jun 2021 18:39:38 +0300
Date:   Mon, 7 Jun 2021 18:39:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
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
Message-ID: <YL49uhT6e2TlWzu8@smile.fi.intel.com>
References: <20210510233421.18684-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510233421.18684-1-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 10, 2021 at 04:34:21PM -0700, Yury Norov wrote:
> In the 5.12 cycle we enabled the GENERIC_FIND_FIRST_BIT config option
> for ARM64 and MIPS. It increased performance and shrunk .text size; and
> so far I didn't receive any negative feedback on the change.
> 
> https://lore.kernel.org/linux-arch/20210225135700.1381396-1-yury.norov@gmail.com/
> 
> I think it's time to make all architectures use find_{first,last}_bit()
> unconditionally and remove the corresponding config option.
> 
> This patch doesn't introduce functional changes for arc, arm64, mips,
> s390 and x86 because they already enable GENERIC_FIND_FIRST_BIT. There
> will be no changes for arm because it implements find_{first,last}_bit
> in arch code. For other architectures I expect improvement both in
> performance and .text size.

Subject like s/all:/arch:/.

> It would be great if people with an access to real hardware would share
> the output of bloat-o-meter and lib/find_bit_benchmark.

This is rather comment (should be below cutter '---' line).

Anyway, seems good to my by the code:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/arc/Kconfig                  |  1 -
>  arch/arm64/Kconfig                |  1 -
>  arch/mips/Kconfig                 |  1 -
>  arch/s390/Kconfig                 |  1 -
>  arch/x86/Kconfig                  |  1 -
>  arch/x86/um/Kconfig               |  1 -
>  include/asm-generic/bitops/find.h | 12 ------------
>  lib/Kconfig                       |  3 ---
>  8 files changed, 21 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index bc8d6aecfbbd..9c991ba50db3 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -19,7 +19,6 @@ config ARC
>  	select COMMON_CLK
>  	select DMA_DIRECT_REMAP
>  	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
> -	select GENERIC_FIND_FIRST_BIT
>  	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e09a9591af45..9d5b36f7d981 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -108,7 +108,6 @@ config ARM64
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
> -	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_IPI
>  	select GENERIC_IRQ_PROBE
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b72458215d20..3ddae7918386 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -27,7 +27,6 @@ config MIPS
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CMOS_UPDATE
>  	select GENERIC_CPU_AUTOPROBE
> -	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_GETTIMEOFDAY
>  	select GENERIC_IOMAP
>  	select GENERIC_IRQ_PROBE
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c1ff874e6c2e..3a10ceb8a097 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -125,7 +125,6 @@ config S390
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_ENTRY
> -	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_GETTIMEOFDAY
>  	select GENERIC_PTDUMP
>  	select GENERIC_SMP_IDLE_THREAD
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b83364a15d34..6a7d8305365e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -123,7 +123,6 @@ config X86
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_ENTRY
> -	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IOMAP
>  	select GENERIC_IRQ_EFFECTIVE_AFF_MASK	if SMP
>  	select GENERIC_IRQ_MATRIX_ALLOCATOR	if X86_LOCAL_APIC
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 95d26a69088b..40d6a06e41c8 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -8,7 +8,6 @@ endmenu
>  
>  config UML_X86
>  	def_bool y
> -	select GENERIC_FIND_FIRST_BIT
>  
>  config 64BIT
>  	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 0d132ee2a291..8a7b70c79e15 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -95,8 +95,6 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  }
>  #endif
>  
> -#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
> -
>  /**
>   * find_first_bit - find the first set bit in a memory region
>   * @addr: The address to start the search at
> @@ -136,16 +134,6 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
>  
>  	return _find_first_zero_bit(addr, size);
>  }
> -#else /* CONFIG_GENERIC_FIND_FIRST_BIT */
> -
> -#ifndef find_first_bit
> -#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
> -#endif
> -#ifndef find_first_zero_bit
> -#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
> -#endif
> -
> -#endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>  
>  #ifndef find_last_bit
>  /**
> diff --git a/lib/Kconfig b/lib/Kconfig
> index a38cc61256f1..8346b3181214 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -59,9 +59,6 @@ config GENERIC_STRNLEN_USER
>  config GENERIC_NET_UTILS
>  	bool
>  
> -config GENERIC_FIND_FIRST_BIT
> -	bool
> -
>  source "lib/math/Kconfig"
>  
>  config NO_GENERIC_PCI_IOPORT_MAP
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


