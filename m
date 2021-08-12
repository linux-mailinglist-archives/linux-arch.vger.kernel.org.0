Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87573EAB32
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhHLTrH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 15:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhHLTrG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Aug 2021 15:47:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD59560FBF;
        Thu, 12 Aug 2021 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628797601;
        bh=FB/3JXubUJqc+EUesD4OCWgL312JeTESVV+Ra/v4hdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MJA8LHF5KUCiP0sTl4iurA3fDS7AgIYzwMkVRxQd6P+Zzc8ZakNgX4P3asf1FKDNB
         UbXBHwUJdCJ6kdN6CbXHKvkkwoSlyh/19gNstxaAXvsIoYR37CipfOmHFcW7w/8zrJ
         BlU1dv71mF+AmDc7QlexVfXwJMtQgVkPVu9vlnl+FQmMbbVQ8lV7z22x6q0rZbKh2q
         TnrSVTKXCNgJs2nrqsXem3Iby46GXQTdXgicmdrfSsM1euQN+HrZ/l6Tb6ZFlyQT8E
         iyRV/bO+EVrfGZgIcLVddiSAVDvWhB3qv7lUAWv4x86HaLDNshBdsr3l63+uODvXS2
         mVdS96JaUFIDQ==
Date:   Thu, 12 Aug 2021 14:46:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 10/15] asm/io.h: Add ioremap_shared fallback
Message-ID: <20210812194639.GA2502520@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-11-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 04, 2021 at 05:52:13PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> This function is for declaring memory that should be shared with
> a hypervisor in a confidential guest. If the architecture doesn't
> implement it it's just ioremap.

I would assume ioremap_shared() would "map" something, not "declare"
it.

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/alpha/include/asm/io.h    | 1 +
>  arch/mips/include/asm/io.h     | 1 +
>  arch/parisc/include/asm/io.h   | 1 +
>  arch/sparc/include/asm/io_64.h | 1 +
>  include/asm-generic/io.h       | 4 ++++
>  5 files changed, 8 insertions(+)
> 
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index 0fab5ac90775..701b44909b94 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -283,6 +283,7 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
>  }
>  
>  #define ioremap_wc ioremap
> +#define ioremap_shared ioremap
>  #define ioremap_uc ioremap
>  
>  static inline void iounmap(volatile void __iomem *addr)
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 6f5c86d2bab4..3713ff624632 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -179,6 +179,7 @@ void iounmap(const volatile void __iomem *addr);
>  #define ioremap(offset, size)						\
>  	ioremap_prot((offset), (size), _CACHE_UNCACHED)
>  #define ioremap_uc		ioremap
> +#define ioremap_shared		ioremap
>  
>  /*
>   * ioremap_cache -	map bus memory into CPU space
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index 0b5259102319..73064e152df7 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -129,6 +129,7 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
>   */
>  void __iomem *ioremap(unsigned long offset, unsigned long size);
>  #define ioremap_wc			ioremap
> +#define ioremap_shared			ioremap
>  #define ioremap_uc			ioremap
>  
>  extern void iounmap(const volatile void __iomem *addr);
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index 5ffa820dcd4d..18cc656eb712 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -409,6 +409,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>  #define ioremap_uc(X,Y)			ioremap((X),(Y))
>  #define ioremap_wc(X,Y)			ioremap((X),(Y))
>  #define ioremap_wt(X,Y)			ioremap((X),(Y))
> +#define ioremap_shared(X, Y)		ioremap((X), (Y))
>  static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
>  {
>  	return NULL;
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index e93375c710b9..bfcaee1691c8 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -982,6 +982,10 @@ static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
>  #define ioremap_wt ioremap
>  #endif
>  
> +#ifndef ioremap_shared
> +#define ioremap_shared ioremap
> +#endif

"ioremap_shared" is a very generic term for a pretty specific thing:
"memory shared with a hypervisor in a confidential guest".

Maybe deserves a comment with at least a hint here.  "Hypervisors in a
confidential guest" isn't the first thing that comes to mind when I
read "shared".

>  /*
>   * ioremap_uc is special in that we do require an explicit architecture
>   * implementation.  In general you do not want to use this function in a
> -- 
> 2.25.1
> 
