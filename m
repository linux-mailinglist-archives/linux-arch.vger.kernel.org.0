Return-Path: <linux-arch+bounces-955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAE8107FC
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4181F216F5
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489217D3;
	Wed, 13 Dec 2023 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="elOtuGb0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A9AA
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 18:10:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d347b4d676so7365205ad.2
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 18:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702433434; x=1703038234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndcvt02y9ljNyhF0KeHVzOxJZIgWnhmY4KgAU4EvNjI=;
        b=elOtuGb02YBA5Cme14TBTVJK896fEcN1rxJpztvoBFVFKi07DX0/Nh1KxFAr1SLiqC
         wDyuH72S5zUHF6+i/QBq53evMaeUo4wj3YwpM1U0Fe08Ce5Y4lzwZP7uUixvZS5wPprw
         Vik8k0gCJS5lpWsiAcjaQ02DBFSmgyOf7uFBD5wdgYssGnadG+VucvJME3xOps9bw5w5
         6PGLfsXYKllqNrPmq66g1VYax1DtbF12iEE+hRXzSy9ScK1zv6bFUqR+WsBRAWI3ViFC
         b7/zDv5nONsyoUWaZ9DCryvBhlDMrDVg/5fI1hK43lWxUOUmR65qeXPm7Zf0KWBp6ZzB
         CXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702433434; x=1703038234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndcvt02y9ljNyhF0KeHVzOxJZIgWnhmY4KgAU4EvNjI=;
        b=NyHKM3fXcHi0YRKtdUzLKMBNt7bQfBvvkaM1SKpalCkl3CH46D0s9V46rbn08qX65o
         h+RuBL0JmQZ/j7OdY5fUM20W3rYRHzypDNRauwzlDm3yjYhSA06xEZ6s6MMhuFuivGis
         oJQ05sJSwzlw56OJZYbhkGN1FsaEKtPfnNvA8sglklxLwY17qcXQxMAkWIk79W2krtsu
         TbbIsVyfKjgJLaemvLXNJHx4PBGOu15b7MVtbeqHrIC848cQe0ExfVekCLz9Dw7hJPmr
         L4LDTKHeV/QBmSFgzojNYKXfldJ91UImHDjyUhiJaInoQ3rrGdyAbVboD9cFDy7eyB2P
         uF9g==
X-Gm-Message-State: AOJu0YxRG81pHHFfp/Ya0DOdoinmm9xuWWAkGZAtyk2569txqFQ7EXjK
	GH+TD2tSuyXpBJtneBfq6zNqFA==
X-Google-Smtp-Source: AGHT+IFV6LtBwL0pXHMscRakGa58wihO0UeC2U3udA7Ut79cIgVJhsX3zVZq0nBv5Ysi4y3fYZObbg==
X-Received: by 2002:a17:903:234c:b0:1d0:c418:1758 with SMTP id c12-20020a170903234c00b001d0c4181758mr8635921plh.66.1702433434510;
        Tue, 12 Dec 2023 18:10:34 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id be9-20020a170902aa0900b001d07d83fdd0sm9263089plb.238.2023.12.12.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 18:10:34 -0800 (PST)
Date: Tue, 12 Dec 2023 18:10:30 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	David Laight <David.Laight@aculab.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v12 4/5] riscv: Add checksum library
Message-ID: <ZXkSlocykTJKILyn@ghost>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
 <20231212-optimize_checksum-v12-4-419a4ba6d666@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-optimize_checksum-v12-4-419a4ba6d666@rivosinc.com>

On Tue, Dec 12, 2023 at 05:18:41PM -0800, Charlie Jenkins wrote:
> Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> will load from the buffer in groups of 32 bits, and when compiled for
> 64-bit will load in groups of 64 bits.
> 
> Additionally provide riscv optimized implementation of csum_ipv6_magic.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/checksum.h |  13 +-
>  arch/riscv/lib/Makefile           |   1 +
>  arch/riscv/lib/csum.c             | 326 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 339 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> index 2fcf864186e7..3fa04ff1eda8 100644
> --- a/arch/riscv/include/asm/checksum.h
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -12,6 +12,17 @@
>  
>  #define ip_fast_csum ip_fast_csum
>  
> +extern unsigned int do_csum(const unsigned char *buff, int len);
> +#define do_csum do_csum
> +
> +/* Default version is sufficient for 32 bit */
> +#ifndef CONFIG_32BIT
> +#define _HAVE_ARCH_IPV6_CSUM
> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +			const struct in6_addr *daddr,
> +			__u32 len, __u8 proto, __wsum sum);
> +#endif
> +
>  /* Define riscv versions of functions before importing asm-generic/checksum.h */
>  #include <asm-generic/checksum.h>
>  
> @@ -69,7 +80,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  			.option pop"
>  			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
>  		}
> -		return csum >> 16;
> +		return (__force __sum16) (csum >> 16);
>  	}
>  no_zbb:
>  #ifndef CONFIG_32BIT
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 26cb2502ecf8..2aa1a4ad361f 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -6,6 +6,7 @@ lib-y			+= memmove.o
>  lib-y			+= strcmp.o
>  lib-y			+= strlen.o
>  lib-y			+= strncmp.o
> +lib-y			+= csum.o
>  lib-$(CONFIG_MMU)	+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o
>  lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> new file mode 100644
> index 000000000000..06ce8e7250d9
> --- /dev/null
> +++ b/arch/riscv/lib/csum.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Checksum library
> + *
> + * Influenced by arch/arm64/lib/csum.c
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +#include <linux/bitops.h>
> +#include <linux/compiler.h>
> +#include <linux/jump_label.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/cpufeature.h>
> +
> +#include <net/checksum.h>
> +
> +/* Default version is sufficient for 32 bit */
> +#ifndef CONFIG_32BIT
> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +			const struct in6_addr *daddr,
> +			__u32 len, __u8 proto, __wsum csum)
> +{
> +	unsigned int ulen, uproto;
> +	unsigned long sum = (__force unsigned long)csum;
> +
> +	sum += (__force unsigned long)saddr->s6_addr32[0];
> +	sum += (__force unsigned long)saddr->s6_addr32[1];
> +	sum += (__force unsigned long)saddr->s6_addr32[2];
> +	sum += (__force unsigned long)saddr->s6_addr32[3];
> +
> +	sum += (__force unsigned long)daddr->s6_addr32[0];
> +	sum += (__force unsigned long)daddr->s6_addr32[1];
> +	sum += (__force unsigned long)daddr->s6_addr32[2];
> +	sum += (__force unsigned long)daddr->s6_addr32[3];
> +
> +	ulen = (__force unsigned int)htonl((unsigned int)len);
> +	sum += ulen;
> +
> +	uproto = (__force unsigned int)htonl(proto);
> +	sum += uproto;
> +
> +	/*
> +	 * Zbb support saves 4 instructions, so not worth checking without
> +	 * alternatives if supported
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		unsigned long fold_temp;
> +
> +		/*
> +		 * Zbb is likely available when the kernel is compiled with Zbb
> +		 * support, so nop when Zbb is available and jump when Zbb is
> +		 * not available.
> +		 */
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +				  :
> +				  :
> +				  :
> +				  : no_zbb);
> +		asm(".option push					\n\
> +		.option arch,+zbb					\n\
> +			rori	%[fold_temp], %[sum], 32		\n\
> +			add	%[sum], %[fold_temp], %[sum]		\n\
> +			srli	%[sum], %[sum], 32			\n\
> +			not	%[fold_temp], %[sum]			\n\
> +			roriw	%[sum], %[sum], 16			\n\
> +			subw	%[sum], %[fold_temp], %[sum]		\n\
> +		.option pop"
> +		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
> +		return (__force __sum16)(sum >> 16);
> +	}
> +no_zbb:
> +	sum += ror64(sum, 32);
> +	sum >>= 32;
> +	return csum_fold((__force __wsum)sum);
> +}
> +EXPORT_SYMBOL(csum_ipv6_magic);
> +#endif /* !CONFIG_32BIT */
> +
> +#ifdef CONFIG_32BIT
> +#define OFFSET_MASK 3
> +#elif CONFIG_64BIT
> +#define OFFSET_MASK 7
> +#endif
> +
> +static inline __no_sanitize_address unsigned long
> +do_csum_common(const unsigned long *ptr, const unsigned long *end,
> +	       unsigned long data)
> +{
> +	unsigned int shift;
> +	unsigned long csum = 0, carry = 0;
> +
> +	/*
> +	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
> +	 * faster than doing 32-bit reads on architectures that support larger
> +	 * reads.
> +	 */
> +	while (ptr < end) {
> +		csum += data;
> +		carry += csum < data;
> +		data = *(ptr++);
> +	}
> +
> +	/*
> +	 * Perform alignment (and over-read) bytes on the tail if any bytes
> +	 * leftover.
> +	 */
> +	shift = ((long)ptr - (long)end) * 8;
> +#ifdef __LITTLE_ENDIAN
> +	data = (data << shift) >> shift;
> +#else
> +	data = (data >> shift) << shift;
> +#endif
> +	csum += data;
> +	carry += csum < data;
> +	csum += carry;
> +	csum += csum < carry;
> +
> +	return csum;
> +}
> +
> +/*
> + * Algorithm accounts for buff being misaligned.
> + * If buff is not aligned, will over-read bytes but not use the bytes that it
> + * shouldn't. The same thing will occur on the tail-end of the read.
> + */
> +static inline __no_sanitize_address unsigned int
> +do_csum_with_alignment(const unsigned char *buff, int len)
> +{
> +	unsigned int offset, shift;
> +	unsigned long csum, data;
> +	const unsigned long *ptr, *end;
> +
> +	/*
> +	 * Align address to closest word (double word on rv64) that comes before
> +	 * buff. This should always be in the same page and cache line.
> +	 * Directly call KASAN with the alignment we will be using.
> +	 */
> +	offset = (unsigned long)buff & OFFSET_MASK;
> +	kasan_check_read(buff, len);
> +	ptr = (const unsigned long *)(buff - offset);
> +
> +	/*
> +	 * Clear the most significant bytes that were over-read if buff was not
> +	 * aligned.
> +	 */
> +	shift = offset * 8;
> +	data = *(ptr++);
> +#ifdef __LITTLE_ENDIAN
> +	data = (data >> shift) << shift;
> +#else
> +	data = (data << shift) >> shift;
> +#endif
> +	end = (const unsigned long *)(buff + len);
> +	csum = do_csum_common(ptr, end, data);
> +
> +	/*
> +	 * Zbb support saves 6 instructions, so not worth checking without
> +	 * alternatives if supported
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		unsigned long fold_temp;
> +
> +		/*
> +		 * Zbb is likely available when the kernel is compiled with Zbb
> +		 * support, so nop when Zbb is available and jump when Zbb is
> +		 * not available.
> +		 */
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +				  :
> +				  :
> +				  :
> +				  : no_zbb);
> +
> +#ifdef CONFIG_32BIT
> +		asm_volatile_goto(".option push			\n\
> +		.option arch,+zbb				\n\
> +			rori	%[fold_temp], %[csum], 16	\n\
> +			andi	%[offset], %[offset], 1		\n\
> +			add	%[csum], %[fold_temp], %[csum]	\n\
> +			beq	%[offset], zero, %l[end]	\n\
> +			rev8	%[csum], %[csum]		\n\
> +		.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> +			: [offset] "r" (offset)
> +			:
> +			: end);
> +
> +		return (unsigned short)csum;
> +#else /* !CONFIG_32BIT */
> +		asm_volatile_goto(".option push			\n\
> +		.option arch,+zbb				\n\
> +			rori	%[fold_temp], %[csum], 32	\n\
> +			add	%[csum], %[fold_temp], %[csum]	\n\
> +			srli	%[csum], %[csum], 32		\n\
> +			roriw	%[fold_temp], %[csum], 16	\n\
> +			addw	%[csum], %[fold_temp], %[csum]	\n\
> +			andi	%[offset], %[offset], 1		\n\
> +			beq	%[offset], zero, %l[end]	\n\
> +			rev8	%[csum], %[csum]		\n\
> +		.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> +			: [offset] "r" (offset)
> +			:
> +			: end);
> +
> +		return (csum << 16) >> 48;
> +#endif /* !CONFIG_32BIT */
> +end:
> +		return csum >> 16;
> +	}
> +no_zbb:
> +#ifndef CONFIG_32BIT
> +	csum += ror64(csum, 32);
> +	csum >>= 32;
> +#endif
> +	csum = (u32)csum + ror32((u32)csum, 16);
> +	if (offset & 1)
> +		return (u16)swab32(csum);
> +	return csum >> 16;
> +}
> +
> +/*
> + * Does not perform alignment, should only be used if machine has fast
> + * misaligned accesses, or when buff is known to be aligned.
> + */
> +static inline __no_sanitize_address unsigned int
> +do_csum_no_alignment(const unsigned char *buff, int len)
> +{
> +	unsigned long csum, data;
> +	const unsigned long *ptr, *end;
> +
> +	ptr = (const unsigned long *)(buff);
> +	data = *(ptr++);
> +
> +	kasan_check_read(buff, len);
> +
> +	end = (const unsigned long *)(buff + len);
> +	csum = do_csum_common(ptr, end, data);
> +
> +	/*
> +	 * Zbb support saves 6 instructions, so not worth checking without
> +	 * alternatives if supported
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		unsigned long fold_temp;
> +
> +		/*
> +		 * Zbb is likely available when the kernel is compiled with Zbb
> +		 * support, so nop when Zbb is available and jump when Zbb is
> +		 * not available.
> +		 */
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +				  :
> +				  :
> +				  :
> +				  : no_zbb);
> +
> +#ifdef CONFIG_32BIT
> +		asm (".option push				\n\
> +		.option arch,+zbb				\n\
> +			rori	%[fold_temp], %[csum], 16	\n\
> +			add	%[csum], %[fold_temp], %[csum]	\n\
> +		.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> +			:
> +			: );
> +
> +#else /* !CONFIG_32BIT */
> +		asm (".option push				\n\
> +		.option arch,+zbb				\n\
> +			rori	%[fold_temp], %[csum], 32	\n\
> +			add	%[csum], %[fold_temp], %[csum]	\n\
> +			srli	%[csum], %[csum], 32		\n\
> +			roriw	%[fold_temp], %[csum], 16	\n\
> +			addw	%[csum], %[fold_temp], %[csum]	\n\
> +		.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> +			:
> +			: );
> +#endif /* !CONFIG_32BIT */
> +		return csum >> 16;
> +	}
> +no_zbb:
> +#ifndef CONFIG_32BIT
> +	csum += ror64(csum, 32);
> +	csum >>= 32;
> +#endif
> +	csum = (u32)csum + ror32((u32)csum, 16);
> +	return csum >> 16;
> +}
> +
> +/*
> + * Perform a checksum on an arbitrary memory address.
> + * Will do a light-weight address alignment if buff is misaligned, unless
> + * cpu supports fast misaligned accesses.
> + */
> +unsigned int do_csum(const unsigned char *buff, int len)
> +{
> +	if (unlikely(len <= 0))
> +		return 0;
> +
> +	/*
> +	 * Significant performance gains can be seen by not doing alignment
> +	 * on machines with fast misaligned accesses.
> +	 *
> +	 * There is some duplicate code between the "with_alignment" and
> +	 * "no_alignment" implmentations, but the overlap is too awkward to be
> +	 * able to fit in one function without introducing multiple static
> +	 * branches. The largest chunk of overlap was delegated into the
> +	 * do_csum_common function.
> +	 */
> +	if (static_branch_likely(&fast_misaligned_access_speed_key))
> +		return do_csum_no_alignment(buff, len);
> +
> +	if (((unsigned long)buff & OFFSET_MASK) == 0)
> +		return do_csum_no_alignment(buff, len);
> +
> +	return do_csum_with_alignment(buff, len);
> +}
> 
> -- 
> 2.43.0
> 

There is potentially a code size concern here. These changes do require
alternatives, and as such it increases the resulting binary size. The
bloat-o-meter script reports that the do_csum function grows to twice
the size with this patch:

Function                                     old     new   delta
do_csum                                      238     514    +276

The other functions are harder to measure because they get inlined or
are not included in generic code. However the do_csum is the most
impacted because of the misaligned access behavior.

The performance improvements afforded by alternatives (with the Zbb
extension) and with the misaligned access checking are significant. In
my testing these optimizations alone contribute to over a 20% performance
improvement.

- Charlie


