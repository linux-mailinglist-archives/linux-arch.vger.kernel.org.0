Return-Path: <linux-arch+bounces-586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F414800327
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 06:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC83CB21001
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 05:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A035666;
	Fri,  1 Dec 2023 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DvBFTnzn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828261725
	for <linux-arch@vger.kernel.org>; Thu, 30 Nov 2023 21:44:24 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1fa21f561a1so86484fac.3
        for <linux-arch@vger.kernel.org>; Thu, 30 Nov 2023 21:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701409464; x=1702014264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S566PVY0OEY56vpzJTLANuberH+LTJgX6nfbZ1a8fs=;
        b=DvBFTnznQGuaZnGNEYhSFUvCq8A1T4EvIWSXTt8NRq1b7YUIxmWZfBTFlLPAdWVH0A
         BvrG5sJ6M/QyLbJY3w676u9fAMQB1akycxbGe/LNE0kLFCyhlJSOtbEkmDN2iH+5GhBT
         PM+HA+lDU7RTKAqkeQDNjv7pCjUPgn+IoMvEkdIPZaLu49DQUM7XNCZSRSDuwzMqKpY7
         v9oPNYh/tO7H1Bg4q5O/5MADSvDkiTLoBaeoby87ks2hYaY/B275PmjUm82/BddfDnuU
         YSMebrafvDaoAAfYn+kcs9B7a3W/KE3OJ1ln8Qg39vlPFsFy2giCe+ecjL6pUabQ81NH
         kJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701409464; x=1702014264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S566PVY0OEY56vpzJTLANuberH+LTJgX6nfbZ1a8fs=;
        b=atMRL398BgnnQF4bOIJfE9gC1UFVKIZTqJPHWPYgd4UWAAAVGUv6Zf3BGsRL0Of69I
         kUstepxZE8Y+bYyLlcc6cBUn+2w8RP8ykoO0w5L3mLPuMlEJV2kTZvzhRN3g7ACiD0py
         bzUVC98Kt7IZHB9og23R8+g6szxKDZST+hXwAzpGj3cKE4u9WOSO4tZBDjOMXi8OzyoI
         tTMm4rNQgRw0cUv7cquAIjPHJlw8Q0GSVeExPdpvWUM/OsqEayjow1JfTfWGAVY8vigv
         QjPXmqSLe21mBxNFDQfeEseNQgF0DUb2ErcnaiB5XbTMGjFwt4eFVul8jQMJgAYP2bGt
         TLUQ==
X-Gm-Message-State: AOJu0Yxa7Ki0k9mzu/bdFoQjwhG+LvdWk1iZqIgIL77Z65WKw3xjlhR9
	AtcxEHHxb4QyeKG6IbZjXA/5Yg==
X-Google-Smtp-Source: AGHT+IERUsdz1dXDqmJ/lutuyLyILH+SZmPT37h9d3tu12jgAdQJPBclLsMgs+ybmqXuMSmdo4slUQ==
X-Received: by 2002:a05:6871:8903:b0:1fa:ecf1:8b67 with SMTP id ti3-20020a056871890300b001faecf18b67mr882373oab.59.1701409463729;
        Thu, 30 Nov 2023 21:44:23 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:9075:c975:12d3:f5fb])
        by smtp.gmail.com with ESMTPSA id l20-20020a9d6a94000000b006d81fbeede9sm397380otq.27.2023.11.30.21.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 21:44:23 -0800 (PST)
Date: Thu, 30 Nov 2023 21:44:20 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, geert@linux-m68k.org, haicheng.li@intel.com,
	linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Avoid code duplication with generic bitops
 implementation
Message-ID: <ZWlytChnvmXFJlb4@ghost>
References: <20231112094421.4014931-1-xiao.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112094421.4014931-1-xiao.w.wang@intel.com>

On Sun, Nov 12, 2023 at 05:44:21PM +0800, Xiao Wang wrote:
> There's code duplication between the fallback implementation for bitops
> __ffs/__fls/ffs/fls API and the generic C implementation in
> include/asm-generic/bitops/. To avoid this duplication, this patch renames
> the generic C implementation by adding a "generic_" prefix to them, then we
> can use these generic APIs as fallback.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/bitops.h    | 138 +++++------------------------
>  include/asm-generic/bitops/__ffs.h |   8 +-
>  include/asm-generic/bitops/__fls.h |   8 +-
>  include/asm-generic/bitops/ffs.h   |   8 +-
>  include/asm-generic/bitops/fls.h   |   8 +-
>  5 files changed, 48 insertions(+), 122 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index f7c167646460..23f7c122b151 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -22,6 +22,16 @@
>  #include <asm-generic/bitops/fls.h>
>  
>  #else
> +#define __HAVE_ARCH___FFS
> +#define __HAVE_ARCH___FLS
> +#define __HAVE_ARCH_FFS
> +#define __HAVE_ARCH_FLS
> +
> +#include <asm-generic/bitops/__ffs.h>
> +#include <asm-generic/bitops/__fls.h>
> +#include <asm-generic/bitops/ffs.h>
> +#include <asm-generic/bitops/fls.h>
> +
>  #include <asm/alternative-macros.h>
>  #include <asm/hwcap.h>
>  
> @@ -37,8 +47,6 @@
>  
>  static __always_inline unsigned long variable__ffs(unsigned long word)
>  {
> -	int num;
> -
>  	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
> @@ -52,32 +60,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
>  	return word;
>  
>  legacy:
> -	num = 0;
> -#if BITS_PER_LONG == 64
> -	if ((word & 0xffffffff) == 0) {
> -		num += 32;
> -		word >>= 32;
> -	}
> -#endif
> -	if ((word & 0xffff) == 0) {
> -		num += 16;
> -		word >>= 16;
> -	}
> -	if ((word & 0xff) == 0) {
> -		num += 8;
> -		word >>= 8;
> -	}
> -	if ((word & 0xf) == 0) {
> -		num += 4;
> -		word >>= 4;
> -	}
> -	if ((word & 0x3) == 0) {
> -		num += 2;
> -		word >>= 2;
> -	}
> -	if ((word & 0x1) == 0)
> -		num += 1;
> -	return num;
> +	return generic___ffs(word);
>  }
>  
>  /**
> @@ -93,8 +76,6 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
>  
>  static __always_inline unsigned long variable__fls(unsigned long word)
>  {
> -	int num;
> -
>  	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
> @@ -108,32 +89,7 @@ static __always_inline unsigned long variable__fls(unsigned long word)
>  	return BITS_PER_LONG - 1 - word;
>  
>  legacy:
> -	num = BITS_PER_LONG - 1;
> -#if BITS_PER_LONG == 64
> -	if (!(word & (~0ul << 32))) {
> -		num -= 32;
> -		word <<= 32;
> -	}
> -#endif
> -	if (!(word & (~0ul << (BITS_PER_LONG - 16)))) {
> -		num -= 16;
> -		word <<= 16;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG - 8)))) {
> -		num -= 8;
> -		word <<= 8;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG - 4)))) {
> -		num -= 4;
> -		word <<= 4;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG - 2)))) {
> -		num -= 2;
> -		word <<= 2;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG - 1))))
> -		num -= 1;
> -	return num;
> +	return generic___fls(word);
>  }
>  
>  /**
> @@ -149,46 +105,23 @@ static __always_inline unsigned long variable__fls(unsigned long word)
>  
>  static __always_inline int variable_ffs(int x)
>  {
> -	int r;
> -
> -	if (!x)
> -		return 0;
> -
>  	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
>  
> +	if (!x)
> +		return 0;
> +
>  	asm volatile (".option push\n"
>  		      ".option arch,+zbb\n"
>  		      CTZW "%0, %1\n"
>  		      ".option pop\n"
> -		      : "=r" (r) : "r" (x) :);
> +		      : "=r" (x) : "r" (x) :);
>  
> -	return r + 1;
> +	return x + 1;
>  
>  legacy:
> -	r = 1;
> -	if (!(x & 0xffff)) {
> -		x >>= 16;
> -		r += 16;
> -	}
> -	if (!(x & 0xff)) {
> -		x >>= 8;
> -		r += 8;
> -	}
> -	if (!(x & 0xf)) {
> -		x >>= 4;
> -		r += 4;
> -	}
> -	if (!(x & 3)) {
> -		x >>= 2;
> -		r += 2;
> -	}
> -	if (!(x & 1)) {
> -		x >>= 1;
> -		r += 1;
> -	}
> -	return r;
> +	return generic_ffs(x);
>  }
>  
>  /**
> @@ -204,46 +137,23 @@ static __always_inline int variable_ffs(int x)
>  
>  static __always_inline int variable_fls(unsigned int x)
>  {
> -	int r;
> -
> -	if (!x)
> -		return 0;
> -
>  	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
>  
> +	if (!x)
> +		return 0;
> +
>  	asm volatile (".option push\n"
>  		      ".option arch,+zbb\n"
>  		      CLZW "%0, %1\n"
>  		      ".option pop\n"
> -		      : "=r" (r) : "r" (x) :);
> +		      : "=r" (x) : "r" (x) :);
>  
> -	return 32 - r;
> +	return 32 - x;
>  
>  legacy:
> -	r = 32;
> -	if (!(x & 0xffff0000u)) {
> -		x <<= 16;
> -		r -= 16;
> -	}
> -	if (!(x & 0xff000000u)) {
> -		x <<= 8;
> -		r -= 8;
> -	}
> -	if (!(x & 0xf0000000u)) {
> -		x <<= 4;
> -		r -= 4;
> -	}
> -	if (!(x & 0xc0000000u)) {
> -		x <<= 2;
> -		r -= 2;
> -	}
> -	if (!(x & 0x80000000u)) {
> -		x <<= 1;
> -		r -= 1;
> -	}
> -	return r;
> +	return generic_fls(x);
>  }
>  
>  /**
> diff --git a/include/asm-generic/bitops/__ffs.h b/include/asm-generic/bitops/__ffs.h
> index 39e56e1c7203..446fea6dda78 100644
> --- a/include/asm-generic/bitops/__ffs.h
> +++ b/include/asm-generic/bitops/__ffs.h
> @@ -5,12 +5,12 @@
>  #include <asm/types.h>
>  
>  /**
> - * __ffs - find first bit in word.
> + * generic___ffs - find first bit in word.
>   * @word: The word to search
>   *
>   * Undefined if no bit exists, so code should check against 0 first.
>   */
> -static __always_inline unsigned long __ffs(unsigned long word)
> +static __always_inline unsigned long generic___ffs(unsigned long word)
>  {
>  	int num = 0;
>  
> @@ -41,4 +41,8 @@ static __always_inline unsigned long __ffs(unsigned long word)
>  	return num;
>  }
>  
> +#ifndef __HAVE_ARCH___FFS
> +#define __ffs(word) generic___ffs(word)
> +#endif
> +
>  #endif /* _ASM_GENERIC_BITOPS___FFS_H_ */
> diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
> index 03f721a8a2b1..54ccccf96e21 100644
> --- a/include/asm-generic/bitops/__fls.h
> +++ b/include/asm-generic/bitops/__fls.h
> @@ -5,12 +5,12 @@
>  #include <asm/types.h>
>  
>  /**
> - * __fls - find last (most-significant) set bit in a long word
> + * generic___fls - find last (most-significant) set bit in a long word
>   * @word: the word to search
>   *
>   * Undefined if no set bit exists, so code should check against 0 first.
>   */
> -static __always_inline unsigned long __fls(unsigned long word)
> +static __always_inline unsigned long generic___fls(unsigned long word)
>  {
>  	int num = BITS_PER_LONG - 1;
>  
> @@ -41,4 +41,8 @@ static __always_inline unsigned long __fls(unsigned long word)
>  	return num;
>  }
>  
> +#ifndef __HAVE_ARCH___FLS
> +#define __fls(word) generic___fls(word)
> +#endif
> +
>  #endif /* _ASM_GENERIC_BITOPS___FLS_H_ */
> diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
> index 323fd5d6ae26..4c43f242daeb 100644
> --- a/include/asm-generic/bitops/ffs.h
> +++ b/include/asm-generic/bitops/ffs.h
> @@ -3,14 +3,14 @@
>  #define _ASM_GENERIC_BITOPS_FFS_H_
>  
>  /**
> - * ffs - find first bit set
> + * generic_ffs - find first bit set
>   * @x: the word to search
>   *
>   * This is defined the same way as
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from ffz (man ffs).
>   */
> -static inline int ffs(int x)
> +static inline int generic_ffs(int x)
>  {
>  	int r = 1;
>  
> @@ -39,4 +39,8 @@ static inline int ffs(int x)
>  	return r;
>  }
>  
> +#ifndef __HAVE_ARCH_FFS
> +#define ffs(x) generic_ffs(x)
> +#endif
> +
>  #endif /* _ASM_GENERIC_BITOPS_FFS_H_ */
> diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
> index b168bb10e1be..26f3ce1dd6e4 100644
> --- a/include/asm-generic/bitops/fls.h
> +++ b/include/asm-generic/bitops/fls.h
> @@ -3,14 +3,14 @@
>  #define _ASM_GENERIC_BITOPS_FLS_H_
>  
>  /**
> - * fls - find last (most-significant) bit set
> + * generic_fls - find last (most-significant) bit set
>   * @x: the word to search
>   *
>   * This is defined the same way as ffs.
>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>   */
>  
> -static __always_inline int fls(unsigned int x)
> +static __always_inline int generic_fls(unsigned int x)
>  {
>  	int r = 32;
>  
> @@ -39,4 +39,8 @@ static __always_inline int fls(unsigned int x)
>  	return r;
>  }
>  
> +#ifndef __HAVE_ARCH_FLS
> +#define fls(x) generic_fls(x)
> +#endif
> +
>  #endif /* _ASM_GENERIC_BITOPS_FLS_H_ */
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Apologies I missed this, looks great.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


