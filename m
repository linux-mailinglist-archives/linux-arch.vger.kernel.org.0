Return-Path: <linux-arch+bounces-11884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47DAB27F1
	for <lists+linux-arch@lfdr.de>; Sun, 11 May 2025 13:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F71895CA0
	for <lists+linux-arch@lfdr.de>; Sun, 11 May 2025 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F81C84D9;
	Sun, 11 May 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVY4u+9B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A372219E4;
	Sun, 11 May 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746962619; cv=none; b=aXjKEUG/vQGtH9RcpdmbNs38I0CILGwOTN0bMQc9k7pjzIIBjknG+SEQJOze7LS83qyw9speFnasP87BbXO+NzD/ZORoj0gno4WtgLMsiOIu2gk54CrxdN3JRH32VUhfKC0DEcjVlUYe6ozkpZubMCNF3PvnkKUVw+A19+RjKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746962619; c=relaxed/simple;
	bh=/Gbhq9OEP7Q5EqNR6lXTOPYylSQbyvdVHSXkwAmjPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfFhskivnxKpFHO0SItKmRCo227Clke6EvONkXtsMG+R4SOAWQKtGJsr5f2LZSE/uOONQweE/bNa76HDQPBG9012N+rf9AeZ9laSTV3xByw73lVgbihTu2N+0lA8sDef8HOSX9bvz5zCQR+Muizp5+RF4QktuStyidQgqYWG/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVY4u+9B; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso1938952f8f.1;
        Sun, 11 May 2025 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746962616; x=1747567416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr62AM3KoGEBAH10wBbEzrU82okG3T/6xZVPR3kGFKE=;
        b=iVY4u+9BE9miIUAGEkM3Ycz7zgL0/PaBVi5N46O5HQAQBNx7vhdkBRQHCRS3jEOb9C
         PA9JPUqHZj6F5tO4fkC51fEt9GVxaTqfLTa0AGHt7JD6XBZwP4FsXSEx7vgj6vAC4Aon
         hRXopnQPNCsacYnDFu7IcdCwsJENgnoP8bQ7YbTU4ztPNTBdSSuDSybli5WIojolDGdi
         uteZkdIUCGhAYLTibCPZYBt90FD8xeVM9DTg4lv7H8Vq1+C5dpYPrbWchKUl7BP7THi0
         Q9rUSUSdwS3IYoeMzgoHdRU3Xqr3VNZHnUoDVPZjfDftfR7zKmL0FF3tmqgFqA6rPc1g
         Rr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746962616; x=1747567416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr62AM3KoGEBAH10wBbEzrU82okG3T/6xZVPR3kGFKE=;
        b=Tmv4FrUnqQN7PJBeGIlk+bEKcXOEgn6Zdo+NUNY2NG/zOLEqwEpKVv5oKZeZeonrzW
         GR6LPxbeuaz8MOg/jegEqC6YciAFU2c7jqo1AcRPx4O+XoySJsr8MM3ViO3kILkGcQ4a
         jcRo0P7VCb/iWJldldczXEbg3iUL0ju/rUqnaBX2JJxeJe7uMXKEPcDSWPXALuNiv0A+
         +UykenZlXVG3f+YSgOdUlD1qCSYnDMQam27bz/qkSFcGggu/gg8vp8vPwzKNSmMIRqef
         1yfn0blBv6OecsmoZxUKM07X0/V790OWF/jS8q2J7zkNwbZ/DM0EowMfc78m7idl0794
         KniA==
X-Forwarded-Encrypted: i=1; AJvYcCUYxuAKx1DaTIgTGVuXfj+zJK3JJr3VIe0ZQ6Hwh42e/t+NMaLPu/z9D9IIn0TmM+FXBAMCBuxiskwK7e+g@vger.kernel.org, AJvYcCVt9+7XhPkmrcPuAP3uU6Q8y9kQ9iZNempkIsysv052wNkC+aotxZba9jeseSQRnz3z4Yr3aQAjFUz1@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtV4/KpcMQbCGTx7Jj3rgamtpXaXUOEVDDWWAgvKOVE0lYqzc
	50Lr7oCVW37ENBx3oY8fNlkRpAva3JaWtPT5YJBMQMN90Gd+BTEI
X-Gm-Gg: ASbGnctxRNPAPB6b7A2loRsPdW408PG7+2YxIUQJ+cb9jZ8SXq6zmFgzIa0QpOrdhhy
	/OsuIUrN2oGbU/em/eEsIqcL+aPB5CgGRRgJMqpJUD9PfK13uyiqYnYQkQ1iP2+HwhfCzXDPgfZ
	5rQgHKWKErlnCI/VT8gghx3S20ikakEW1jOq2d6Q8M4iGB0RGeELXD3E6a+6JlUF6tJ3g9VCeQS
	Vg8Ubwb+RoJx7B2S5hRl5SRmLLmE/xnaMdP1DB2H+xFe1LQBKf+KwZBsj2y2j/8LOaO10xhXaSe
	96FYhFueSu6pJnNUYaUE0m5uL2OV3H01vM0b9oLw2zfSunh/fsNvLgBt+GAUyMLyXR/OjU6+N4j
	2x5XDVQeHspl49woFGRxVIxLK
X-Google-Smtp-Source: AGHT+IGqYzj25cJHQkUXe9+tpC/pNhXG07X1IG93ZPDwcMrzYGRzVt+SJJU2Lolx8RxeBWOFjdnGRQ==
X-Received: by 2002:a05:6000:2dc7:b0:3a0:b84f:46de with SMTP id ffacd0b85a97d-3a0b9941bd0mr11326589f8f.21.1746962616029;
        Sun, 11 May 2025 04:23:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf38sm8956991f8f.77.2025.05.11.04.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 04:23:35 -0700 (PDT)
Date: Sun, 11 May 2025 12:23:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann
 <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, Zhihang
 Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
Message-ID: <20250511122328.79e9a2d4@pumpkin>
In-Reply-To: <20250426-riscv-swab-v4-1-64201404a68c@iencinas.com>
References: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
	<20250426-riscv-swab-v4-1-64201404a68c@iencinas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 16:56:18 +0200
Ignacio Encinas <ignacio@iencinas.com> wrote:

> Move the default byteswap implementation into asm-generic so that it can
> be included from arch code.
> 
> This is required by RISC-V in order to have a fallback implementation
> without duplicating it.
> 
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
>  include/uapi/asm-generic/swab.h | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/swab.h       | 33 +--------------------------------
>  2 files changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/swab.h b/include/uapi/asm-generic/swab.h
> index f2da4e4fd4d1..232e81661dc5 100644
> --- a/include/uapi/asm-generic/swab.h
> +++ b/include/uapi/asm-generic/swab.h
> @@ -3,6 +3,7 @@
>  #define _ASM_GENERIC_SWAB_H
>  
>  #include <asm/bitsperlong.h>
> +#include <linux/types.h>
>  
>  /*
>   * 32 bit architectures typically (but not always) want to
> @@ -16,4 +17,36 @@
>  #endif
>  #endif
>  
> +/*
> + * casts are necessary for constants, because we never know how for sure
> + * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.

I know you are just moving the code, but that comment just isn't right.
Linux pretty much assumes that ULL is 64bit and U 32bit (UL varies).

So the UL constants should just be U ones (int isn't going to be 16 bits).

Not only that, but the code requires that the (__unn) casts don't
truncate the values. Performing the maths on a larger type isn't
going to change the value of the result.

Then we get to the integer promotion that does an implicit conversion
of the return of all the (__u16) casts back to signed integer.
So it may be better to leave/make the result of swap16() unsigned int
rather than casting it to __u16 and getting it promoted to int.

The only plausibly necessary cast is a (__u32) one in the result
of (except swap64()) to stop the compiler doing 64bit maths with the
result when the constant has a 64bit type (and all the other casts are
removed).

	David

> + */
> +#define ___constant_swab16(x) ((__u16)(				\
> +	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
> +	(((__u16)(x) & (__u16)0xff00U) >> 8)))
> +
> +#define ___constant_swab32(x) ((__u32)(				\
> +	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
> +	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
> +	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
> +	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
> +
> +#define ___constant_swab64(x) ((__u64)(				\
> +	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
> +	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
> +	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
> +	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
> +	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
> +	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
> +	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
> +	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
> +
> +#define ___constant_swahw32(x) ((__u32)(			\
> +	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
> +	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
> +
> +#define ___constant_swahb32(x) ((__u32)(			\
> +	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
> +	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
> +
>  #endif /* _ASM_GENERIC_SWAB_H */
> diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
> index 01717181339e..ca808c492996 100644
> --- a/include/uapi/linux/swab.h
> +++ b/include/uapi/linux/swab.h
> @@ -6,38 +6,7 @@
>  #include <linux/stddef.h>
>  #include <asm/bitsperlong.h>
>  #include <asm/swab.h>
> -
> -/*
> - * casts are necessary for constants, because we never know how for sure
> - * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
> - */
> -#define ___constant_swab16(x) ((__u16)(				\
> -	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
> -	(((__u16)(x) & (__u16)0xff00U) >> 8)))
> -
> -#define ___constant_swab32(x) ((__u32)(				\
> -	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
> -	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
> -	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
> -	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
> -
> -#define ___constant_swab64(x) ((__u64)(				\
> -	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
> -	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
> -	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
> -	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
> -	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
> -	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
> -	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
> -	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
> -
> -#define ___constant_swahw32(x) ((__u32)(			\
> -	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
> -	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
> -
> -#define ___constant_swahb32(x) ((__u32)(			\
> -	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
> -	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
> +#include <asm-generic/swab.h>
>  
>  /*
>   * Implement the following as inlines, but define the interface using
> 


