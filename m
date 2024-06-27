Return-Path: <linux-arch+bounces-5166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBD91A7E7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02899282253
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27C179950;
	Thu, 27 Jun 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R40Pv9H/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194E13E41F;
	Thu, 27 Jun 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495091; cv=none; b=SMTRlS19D4tvRXVe26vWUurzcTpdIr0uE1IKEb4qrMYyxtDTgxFLWiPYJyVtaGJA8ItYpwFP1fq53jONSOJhRa3DRmc0hB8UvEwnSlBlvRNPpssXC4SgARP5UFofyhMOqJdK/nySRneik4cq98BikNmIF8E1S2DG+8wlfJoUBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495091; c=relaxed/simple;
	bh=d//UJmlqu8RbuMZrmt9fgYLBdY30MUVizK7nEF1hXRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHj5v+s82MBABxD6n/pq3p+ZOCUG6mxLWqVf4XlOyko6L25bO0Uzz5SOU+j7n3N/NLxrMZd3m8fFB5CRMdm1q+wiFRvp8gQaV8I17uqFxPUcWZvjleJe/N9TfISnEhvuVJ4kzkyaTqQGBj3qppeMjisTIIvRkoB5D3l+56SrBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R40Pv9H/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so1830463a12.2;
        Thu, 27 Jun 2024 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719495088; x=1720099888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lP+sVvrhd6DReJOWrP3HQzV+W33wFRZLKWVuhhNnzJs=;
        b=R40Pv9H/8H4QWadaC1fXS585aYbY3FX3Sgrok0p9vjTl9Ymt6kDoRnqTBo08FZWmII
         2RHS1MH0QJ4Bjpljgy1ca4+//a2AEpRrPVH4B30IanwMEK84LXe2hhRBFsxbsKFNdgLV
         zoDb7V8gO37m9m+/Cw2Ue8KlQXj6VGBzjP4wp7uBppOGIQxhOQSbvOAwzenClEIve1tI
         OFMwk/nRkb293OcTWCyC6+BbN+sjmo30Tku3P7j8HDFOhNfQRq25UU/cD3ISRhsavSiR
         3ldwGD08HedDYq7ZMjjgbH68c0LtseOuRfm0puDvqlwCl/iMgHTf94G7SS7nzQxuMUb6
         1+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719495088; x=1720099888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP+sVvrhd6DReJOWrP3HQzV+W33wFRZLKWVuhhNnzJs=;
        b=Ye2vofbC/OBWZa4GkWs75pB3Cqweysm8xhsleSdp+Iutn5y+l0gejrBanrScOSSure
         IKna+OPjYtKQuI1bvWcNUSkiuWQbM3oFEhWc1DTt4awPiQeES1ETygv5mqRWDcqKip3/
         o0eGhGJsNqWPW5NmWyE36wQGBP+gBVAz+ysikqBIulFumc6KQmbUeyC1MksNXHmlJfvR
         FLgogAMl+nxb7fKimFLUP/vkCk/5FXYXx1w3TqLTxICqV8J5F+8+fzozv3IGYRt0wHSF
         K/c0Cm4P3xOdRTFQIJ/hC2cTuovr8bVOsN6kk6+xXpfDUx80QtUGISBQp9M1hbPL2lLJ
         UHTg==
X-Forwarded-Encrypted: i=1; AJvYcCVRPnuYymBJgVu+Xl3Td0rDT4ORb6nDFMga+Dp3+CUGAJF2xsJFx+fe/9VjaEnIoyv+B4zDnuzMe9J7Dk148h8bV/wpQ1/LiaUT6x4DQuQojrVE2Ku4J2QTDG6fgHCXZUzgAF8AUvdGQ7ZO0WWYjJk+WvjYdTreGWHMfF4ca096iFfNQA==
X-Gm-Message-State: AOJu0YwaAzsSa+KMkq4dtj6Eylu/nam52vu+4s2yc32Dv0Xj3bMk+5z4
	Eb4DDLDhWNAV+mR8S577as5b31kU+nhPZvlY1upqL86L4cpBIh8X
X-Google-Smtp-Source: AGHT+IEevBVKU5K21V3Vq/SktLrOLQKyBerQQj9QaS7MnXQfPuSD08AVh5Mvwuw5cmNmKbShIjuhSg==
X-Received: by 2002:a17:906:8a50:b0:a6f:1e88:37c1 with SMTP id a640c23a62f3a-a715f9798bemr854472266b.45.1719495086226;
        Thu, 27 Jun 2024 06:31:26 -0700 (PDT)
Received: from andrea ([217.201.220.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d778baesm60437266b.100.2024.06.27.06.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:31:25 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:31:20 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, Andrea Parri <andrea@rivosinc.com>
Subject: Re: [PATCH v2 04/10] riscv: Improve amocas.X use in cmpxchg()
Message-ID: <Zn1pqD7Aruo4XwN8@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-5-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-5-alexghiti@rivosinc.com>

On Wed, Jun 26, 2024 at 03:03:41PM +0200, Alexandre Ghiti wrote:
> cmpxchg() uses amocas.X instructions from Zacas and Zabha but still uses
> the LR/SC acquire/release semantics which require barriers.
> 
> Let's improve that by using proper amocas acquire/release semantics in
> order to avoid any of those barriers.

I can't really parse this changelog...


> Suggested-by: Andrea Parri <andrea@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 60 ++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index b9a3fdcec919..3c65b00a0d36 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -105,7 +105,9 @@
>   * indicated by comparing RETURN with OLD.
>   */
>  
> -#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,				\
> +			      sc_prepend, sc_append,			\
> +			      r, p, o, n)				\
>  ({									\
>  	__label__ no_zacas, zabha, end;					\
>  									\
> @@ -129,7 +131,7 @@ no_zacas:;								\
>  	ulong __rc;							\
>  									\
>  	__asm__ __volatile__ (						\
> -		prepend							\
> +		sc_prepend							\
>  		"0:	lr.w %0, %2\n"					\
>  		"	and  %1, %0, %z5\n"				\
>  		"	bne  %1, %z3, 1f\n"				\
> @@ -137,7 +139,7 @@ no_zacas:;								\
>  		"	or   %1, %1, %z4\n"				\
>  		"	sc.w" sc_sfx " %1, %1, %2\n"			\
>  		"	bnez %1, 0b\n"					\
> -		append							\
> +		sc_append							\
>  		"1:\n"							\
>  		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
>  		: "rJ" ((long)__oldx), "rJ" (__newx),			\
> @@ -150,9 +152,7 @@ no_zacas:;								\
>  zabha:									\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>  		__asm__ __volatile__ (					\
> -			prepend						\
>  			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> -			append						\
>  			: "+&r" (r), "+A" (*(p))			\
>  			: "rJ" (n)					\
>  			: "memory");					\
> @@ -160,7 +160,9 @@ zabha:									\
>  end:;									\
>  })
>  
> -#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
> +#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
> +		       sc_prepend, sc_append,				\
> +		       r, p, co, o, n)					\
>  ({									\
>  	__label__ zacas, end;						\
>  	register unsigned int __rc;					\
> @@ -172,12 +174,12 @@ end:;									\
>  	}								\
>  									\
>  	__asm__ __volatile__ (						\
> -		prepend							\
> +		sc_prepend							\
>  		"0:	lr" lr_sfx " %0, %2\n"				\
>  		"	bne  %0, %z3, 1f\n"				\
> -		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
> +		"	sc" sc_sfx " %1, %z4, %2\n"			\
>  		"	bnez %1, 0b\n"					\
> -		append							\
> +		sc_append							\
>  		"1:\n"							\
>  		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
>  		: "rJ" (co o), "rJ" (n)					\
> @@ -187,9 +189,7 @@ end:;									\
>  zacas:									\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
>  		__asm__ __volatile__ (					\
> -			prepend						\
> -			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
> -			append						\
> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
>  			: "+&r" (r), "+A" (*(p))			\
>  			: "rJ" (n)					\
>  			: "memory");					\
> @@ -197,7 +197,8 @@ zacas:									\
>  end:;									\
>  })
>  
> -#define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
> +#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
> +		      sc_prepend, sc_append)				\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __old = (old);				\
> @@ -206,22 +207,24 @@ end:;									\
>  									\
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
> -		__arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,		\
> -					prepend, append,		\
> -					__ret, __ptr, __old, __new);    \
> +		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
> +				      sc_prepend, sc_append,		\
> +				      __ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 2:								\
> -		__arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,		\
> -					prepend, append,		\
> -					__ret, __ptr, __old, __new);	\
> +		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
> +				      sc_prepend, sc_append,		\
> +				      __ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 4:								\
> -		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
> -				__ret, __ptr, (long), __old, __new);	\
> +		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
> +			       sc_prepend, sc_append,			\
> +			       __ret, __ptr, (long), __old, __new);	\
>  		break;							\
>  	case 8:								\
> -		__arch_cmpxchg(".d", ".d" sc_sfx, prepend, append,	\
> -				__ret, __ptr, /**/, __old, __new);	\
> +		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
> +			       sc_prepend, sc_append,			\
> +			       __ret, __ptr, /**/, __old, __new);	\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -230,16 +233,19 @@ end:;									\
>  })
>  
>  #define arch_cmpxchg_relaxed(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", "", "")
> +	_arch_cmpxchg((ptr), (o), (n), "", "", "", "")
>  
>  #define arch_cmpxchg_acquire(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
> +	_arch_cmpxchg((ptr), (o), (n), "", ".aq",			\
> +		      "", RISCV_ACQUIRE_BARRIER)
>  
>  #define arch_cmpxchg_release(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
> +	_arch_cmpxchg((ptr), (o), (n), "", ".rl",			\
> +		      RISCV_RELEASE_BARRIER, "")
>  
>  #define arch_cmpxchg(ptr, o, n)						\
> -	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
> +	_arch_cmpxchg((ptr), (o), (n), ".rl", ".aqrl",			\
> +		      "", RISCV_FULL_BARRIER)

... but this is not what I suggested: my suggestion [1] was about (limited
to) the fully-ordered macro arch_cmpxchg().  In fact, I've recently raised
some concern about similar changes to the acquire/release macros, cf. [2].

Any particular reasons for doing this?

  Andrea

[1] https://lore.kernel.org/lkml/ZlYff9x12FICHoP0@andrea/
[2] https://lore.kernel.org/lkml/20240505123340.38495-1-puranjay@kernel.org/

