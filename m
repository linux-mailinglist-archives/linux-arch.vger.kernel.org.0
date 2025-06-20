Return-Path: <linux-arch+bounces-12421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2FFAE2001
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA81895D29
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92E28A415;
	Fri, 20 Jun 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec0LxLk5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762419A297;
	Fri, 20 Jun 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436455; cv=none; b=FajMJmLlgcG0m1GQEY+BYEPcoWpmCPvYoGbSSy6FSFOsoNPmkZf9OfsVUNJLqSWR4YqC6Z+R36/3MyJBJghWVwcIYLBmDlY3xWF52PICCc3IjwtOVL1DDiry+QvoFjDvXxSh3d820Zp7sGd9MjA6N3/e/QValEUYJfoi/2TaM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436455; c=relaxed/simple;
	bh=cp0kw4T/GySkKxRMjIRuSd2w97N7TjVI1fQ0H5rFv50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/7eIwluQsi3ZJ/9EKETfjGw4HbtBnSx3eVwhjPkTQFXdcFp/g7yOk0Cnf19cNfe6lGctzQYlxMcHcAhoCz8CPFbsEO5yjuEXmESRahs4xBcFTPxL12FKmNIMigQ5coyky57T1ooOQXr0PKQY+tcIMbXzMo8/P8y/EroiLxSBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec0LxLk5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1655396b3a.2;
        Fri, 20 Jun 2025 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750436453; x=1751041253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRqS8yCp71M8J/v9FNUlPgqOmmjQL4d9Ouv9ykz1KGU=;
        b=ec0LxLk5hDmNCy36xVGvRkwMCsOjYGDrlovD7UD4yxos5G9QjCR8dStu3qrxdoSkmX
         keUIJVy6PIixIhP1QCM4Vy1EWUl7O+Dh+f0GnsXl8+INvY7luz+D/IiX8r+rfCu4zaEM
         OoZLejhuYQBKdrvv4vYqgc5XQATO1aDHJ2/eg0MOhg0hxSv0/ha7KRFCAMYmvFvwd+cY
         E0KqGpiDXCuKQWzqAfzg/HokZcoS68brKUJKGSbmuK7Auio1FuWJLWbR2d+hkBBbdQpc
         J6D/RK0RVhYiBmUzmYaHcNZNIaAuHiDaqiTz/HXarao8esJSJYaa3/6fHb0Eqn+dLxsF
         Uwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750436453; x=1751041253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRqS8yCp71M8J/v9FNUlPgqOmmjQL4d9Ouv9ykz1KGU=;
        b=jIDVCBwCaMf6lTs6U//6BSXE+ZADKgCrB/qjVDQtkiaODvppmkjHDQcUJkCnGKxZRo
         fK6rvY4lSwB/MHUVIHPZ2mzHuKabSgxy0k4zF4uczBl40BaLUhIT//VPKJ8ZdoZgYnNi
         oCWntK4z7tj3xX2VEn2Ye6hFHfxexV4fvJ3PdtwP8a126uDWHXYPPBmWDzZpnT0LMhpg
         pOfHYHTnxqt6y2tPBugFmKRpEG8OsK/+0xPpR8AmAP8Z791mmWx/3MEQyzbxTSiikKTA
         ttDBP2mrK9OMbqVErZRVwYkQjvjZYIqUKqkdKbNZJoFlQQfV+ddAX5DcsSE1bI0VbK8E
         hu7g==
X-Forwarded-Encrypted: i=1; AJvYcCUvBnRfsd5FGhUM7jVTcxjtJT4vZvs2t+/s1CzbvTIxKaGmh9ViG+X/9XwKJ9mAHyi3f2xx5gHh/w+ITois@vger.kernel.org, AJvYcCXkw0yXikrZUyVUzQ2biMpf2FDkfaI3ZFlfgagyXKgjZPcUxiZV0f+t1IDnANrmLNoQ1EJaY1EEHyby@vger.kernel.org
X-Gm-Message-State: AOJu0YxZy+RavRCk0Vis9aHSz4gr+b6WzNRISi3RGvhR+MOwls6WHkB6
	OjhAiNjpXa4NzMFOpHCjXa+RXe8zU3xSdG/+PuQFzhlIfOlaoZhw1un1
X-Gm-Gg: ASbGnctixs5pCRaICabtkmSU7humQrKgz3DHeoq55qjFOpIBJRbGSyle+WaqpWJvKn0
	+rtrwAk9Gyw1eQ84XoWmbeNdoUkFvRM+JBxQzOghhWKm+FXkPiP2lBNybFNS5aEV6WZgA/HuHVV
	ak1ogdc25N2Iqef1gvqvj3Q3P2p78TTZFzbMmD+qVEa8RKU2P6+KC66SCe+c+5xLv5fAl5MjDGB
	6CmzLa0rfMFDWxh0M8+CnqkBIPpe3seaFGxSdKnIHsbtldCPoCQUyVTX1qEkkHFDSi+pbI6/Tzh
	FCh5s0AFfTtTo3N110qX5TkPUfkzsN4ItezEHiTzNcFXNYZN/iq/pX3OxeXbjbjPOmKCEXkA
X-Google-Smtp-Source: AGHT+IEWxjdwWEc3fO2QlYsxczv0i4+WeKU2EtbTY6IkJyPa6vf0ImD2eIaO/NXQMX7yrumuW68/Cg==
X-Received: by 2002:a05:6a21:4612:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-22026ff9abcmr5656587637.39.1750436452658;
        Fri, 20 Jun 2025 09:20:52 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6c203bsm2386636b3a.171.2025.06.20.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:20:51 -0700 (PDT)
Date: Fri, 20 Jun 2025 12:20:47 -0400
From: Yury Norov <yury.norov@gmail.com>
To: cp0613@linux.alibaba.com
Cc: linux@rasmusvillemoes.dk, arnd@arndb.de, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <aFWKX4rpuNCDBP67@yury>
References: <20250620111610.52750-1-cp0613@linux.alibaba.com>
 <20250620111610.52750-3-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620111610.52750-3-cp0613@linux.alibaba.com>

On Fri, Jun 20, 2025 at 07:16:10PM +0800, cp0613@linux.alibaba.com wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> The RISC-V Zbb extension[1] defines bitwise rotation instructions,
> which can be used to implement rotate related functions.
> 
> [1] https://github.com/riscv/riscv-bitmanip/
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/bitops.h | 172 ++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index d59310f74c2b..be247ef9e686 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -20,17 +20,20 @@
>  #include <asm-generic/bitops/__fls.h>
>  #include <asm-generic/bitops/ffs.h>
>  #include <asm-generic/bitops/fls.h>
> +#include <asm-generic/bitops/rotate.h>
>  
>  #else
>  #define __HAVE_ARCH___FFS
>  #define __HAVE_ARCH___FLS
>  #define __HAVE_ARCH_FFS
>  #define __HAVE_ARCH_FLS
> +#define __HAVE_ARCH_ROTATE
>  
>  #include <asm-generic/bitops/__ffs.h>
>  #include <asm-generic/bitops/__fls.h>
>  #include <asm-generic/bitops/ffs.h>
>  #include <asm-generic/bitops/fls.h>
> +#include <asm-generic/bitops/rotate.h>
>  
>  #include <asm/alternative-macros.h>
>  #include <asm/hwcap.h>
> @@ -175,6 +178,175 @@ static __always_inline int variable_fls(unsigned int x)
>  	 variable_fls(x_);					\
>  })

...

> +static inline u8 variable_ror8(u8 word, unsigned int shift)
> +{
> +	u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;

Can you add a comment about what is happening here? Are you sure it's
optimized out in case of the 'legacy' alternative?

> +
> +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> +				      RISCV_ISA_EXT_ZBB, 1)
> +			  : : : : legacy);
> +
> +	asm volatile(
> +		".option push\n"
> +		".option arch,+zbb\n"
> +		"rorw %0, %1, %2\n"
> +		".option pop\n"
> +		: "=r" (word32) : "r" (word32), "r" (shift) :);
> +
> +	return (u8)word32;
> +
> +legacy:
> +	return generic_ror8(word, shift);
> +}
> +
> +#define rol64(word, shift) variable_rol64(word, shift)
> +#define ror64(word, shift) variable_ror64(word, shift)
> +#define rol32(word, shift) variable_rol32(word, shift)
> +#define ror32(word, shift) variable_ror32(word, shift)
> +#define rol16(word, shift) variable_rol16(word, shift)
> +#define ror16(word, shift) variable_ror16(word, shift)
> +#define rol8(word, shift)  variable_rol8(word, shift)
> +#define ror8(word, shift)  variable_ror8(word, shift)

Here you wire ror/rol() to the variable_ror/rol() unconditionally, and
that breaks compile-time rotation if the parameter is known at compile
time.

I believe, generic implementation will allow compiler to handle this
case better. Can you do a similar thing to what fls() does in the same
file?

Thanks,
Yury

> +
>  #endif /* !(defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)) || defined(NO_ALTERNATIVE) */
>  
>  #include <asm-generic/bitops/ffz.h>
> -- 
> 2.49.0

