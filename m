Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAB5467A8
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbiFJNvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jun 2022 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbiFJNvE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jun 2022 09:51:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E503BA41;
        Fri, 10 Jun 2022 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654869062; x=1686405062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NjRi64oZzw3bIR6cpALKiyGfu+UUTmbnv3awOawt6NI=;
  b=dLB9qgojpcN1KNAJTsgWL9M8T6R4e9mw9Hdx+8lG1yABBOoYfBfWAukZ
   eG0c/qyY/kzI9pDCWZnH02FR5pmDoo5H3zHoR9vh/ViTLskCPk4QznLuS
   HYr7PPvuryUMIo0iKW/UE+WDgU90XgYoQr7qkLphRHO1xtyH5PRIQT5Cy
   ImUzdgwVvkLsVa0g8Dt6CBPBtwoQWxneSlmlOkqr0FzY0ND0L5I72CEVd
   dkpTg2T7zPJYB/IgmXS+bCOYcWmQYMptn7BU5KcD48bh6Uu6qRR2KznIJ
   Jkxa3bfdn2uHu2xPV3b0meUUGLiFivo/RR07WB9vkItaTmKmbLXD/eidj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278433706"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="278433706"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 06:51:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="760515774"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 06:50:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzf2K-000YpO-5k;
        Fri, 10 Jun 2022 16:50:52 +0300
Date:   Fri, 10 Jun 2022 16:50:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Message-ID: <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610113427.908751-3-alexandr.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 10, 2022 at 01:34:23PM +0200, Alexander Lobakin wrote:
> Move generic non-atomic bitops from the asm-generic header which
> gets included only when there are no architecture-specific
> alternatives, to a separate independent file to make them always
> available.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But see below.

> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 124 ++++++++++++++++++
>  include/asm-generic/bitops/non-atomic.h       | 109 ++-------------
>  2 files changed, 132 insertions(+), 101 deletions(-)
>  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
> 
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> new file mode 100644
> index 000000000000..808bc4469886
> --- /dev/null
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
> +#define __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
> +
> +#include <linux/bits.h>
> +
> +#ifndef _LINUX_BITOPS_H
> +#error only <linux/bitops.h> can be included directly
> +#endif
> +
> +/*
> + * Generic definitions for bit operations, should not be used in regular code
> + * directly.
> + */
> +
> +/**
> + * generic___set_bit - Set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * Unlike set_bit(), this function is non-atomic and may be reordered.
> + * If it's called on the same region of memory simultaneously, the effect
> + * may be that only one operation succeeds.
> + */
> +static __always_inline void
> +generic___set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p  |= mask;
> +}
> +
> +static __always_inline void
> +generic___clear_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p &= ~mask;
> +}
> +
> +/**
> + * generic___change_bit - Toggle a bit in memory
> + * @nr: the bit to change
> + * @addr: the address to start counting from
> + *
> + * Unlike change_bit(), this function is non-atomic and may be reordered.
> + * If it's called on the same region of memory simultaneously, the effect
> + * may be that only one operation succeeds.
> + */
> +static __always_inline
> +void generic___change_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p ^= mask;
> +}
> +
> +/**
> + * generic___test_and_set_bit - Set a bit and return its old value
> + * @nr: Bit to set
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic and can be reordered.
> + * If two examples of this operation race, one can appear to succeed
> + * but actually fail.  You must protect multiple accesses with a lock.
> + */
> +static __always_inline int
> +generic___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long old = *p;
> +
> +	*p = old | mask;
> +	return (old & mask) != 0;
> +}
> +
> +/**
> + * generic___test_and_clear_bit - Clear a bit and return its old value
> + * @nr: Bit to clear
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic and can be reordered.
> + * If two examples of this operation race, one can appear to succeed
> + * but actually fail.  You must protect multiple accesses with a lock.
> + */
> +static __always_inline int
> +generic___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long old = *p;
> +
> +	*p = old & ~mask;
> +	return (old & mask) != 0;
> +}
> +
> +/* WARNING: non atomic and it can be reordered! */
> +static __always_inline int
> +generic___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long old = *p;
> +
> +	*p = old ^ mask;
> +	return (old & mask) != 0;
> +}
> +
> +/**
> + * generic_test_bit - Determine whether a bit is set
> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + */

Shouldn't we add in this or in separate patch a big NOTE to explain that this
is actually atomic and must be kept as a such?

> +static __always_inline int
> +generic_test_bit(unsigned int nr, const volatile unsigned long *addr)
> +{
> +	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> +}
> +
> +#endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> index 078cc68be2f1..a05bc090a6a3 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -2,121 +2,28 @@
>  #ifndef _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
>  #define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
>  
> +#include <asm-generic/bitops/generic-non-atomic.h>
>  #include <asm/types.h>
>  
> -/**
> - * arch___set_bit - Set a bit in memory
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * Unlike set_bit(), this function is non-atomic and may be reordered.
> - * If it's called on the same region of memory simultaneously, the effect
> - * may be that only one operation succeeds.
> - */
> -static __always_inline void
> -arch___set_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -
> -	*p  |= mask;
> -}
> +#define arch___set_bit generic___set_bit
>  #define __set_bit arch___set_bit
>  
> -static __always_inline void
> -arch___clear_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -
> -	*p &= ~mask;
> -}
> +#define arch___clear_bit generic___clear_bit
>  #define __clear_bit arch___clear_bit
>  
> -/**
> - * arch___change_bit - Toggle a bit in memory
> - * @nr: the bit to change
> - * @addr: the address to start counting from
> - *
> - * Unlike change_bit(), this function is non-atomic and may be reordered.
> - * If it's called on the same region of memory simultaneously, the effect
> - * may be that only one operation succeeds.
> - */
> -static __always_inline
> -void arch___change_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -
> -	*p ^= mask;
> -}
> +#define arch___change_bit generic___change_bit
>  #define __change_bit arch___change_bit
>  
> -/**
> - * arch___test_and_set_bit - Set a bit and return its old value
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic and can be reordered.
> - * If two examples of this operation race, one can appear to succeed
> - * but actually fail.  You must protect multiple accesses with a lock.
> - */
> -static __always_inline int
> -arch___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -	unsigned long old = *p;
> -
> -	*p = old | mask;
> -	return (old & mask) != 0;
> -}
> +#define arch___test_and_set_bit generic___test_and_set_bit
>  #define __test_and_set_bit arch___test_and_set_bit
>  
> -/**
> - * arch___test_and_clear_bit - Clear a bit and return its old value
> - * @nr: Bit to clear
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic and can be reordered.
> - * If two examples of this operation race, one can appear to succeed
> - * but actually fail.  You must protect multiple accesses with a lock.
> - */
> -static __always_inline int
> -arch___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -	unsigned long old = *p;
> -
> -	*p = old & ~mask;
> -	return (old & mask) != 0;
> -}
> +#define arch___test_and_clear_bit generic___test_and_clear_bit
>  #define __test_and_clear_bit arch___test_and_clear_bit
>  
> -/* WARNING: non atomic and it can be reordered! */
> -static __always_inline int
> -arch___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -	unsigned long old = *p;
> -
> -	*p = old ^ mask;
> -	return (old & mask) != 0;
> -}
> +#define arch___test_and_change_bit generic___test_and_change_bit
>  #define __test_and_change_bit arch___test_and_change_bit
>  
> -/**
> - * arch_test_bit - Determine whether a bit is set
> - * @nr: bit number to test
> - * @addr: Address to start counting from
> - */
> -static __always_inline int
> -arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> -{
> -	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> -}
> +#define arch_test_bit generic_test_bit
>  #define test_bit arch_test_bit
>  
>  #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
> -- 
> 2.36.1
> 

-- 
With Best Regards,
Andy Shevchenko


