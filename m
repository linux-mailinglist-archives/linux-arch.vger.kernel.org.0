Return-Path: <linux-arch+bounces-5169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737891A875
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72946B24FED
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B519539F;
	Thu, 27 Jun 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqOgmJWO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A736B0D;
	Thu, 27 Jun 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496724; cv=none; b=MgjynWol5fAuzHgKPXAqkEshY0ReFnsbv2NPU+atcJln41KUB41rEVy6EmsG8x0nkZhQPuB0wytBNZbX3s4Tgr0jcL5+P78iYGbzfplJKeuxyRL2eh2xqeozm2ritSlprV/h3URKlJAz12PfiXco4Datzu9w1f2IfJK5O3fOVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496724; c=relaxed/simple;
	bh=Krtgobrz5XtmWcEl9pd90GotXa5CTNcf+ipZnicN0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHwAxuWwmwt0FYUWQLXvWCf7jCFYkcff/epQV+d4/3u6R7T67s/q/c0Ch2IzBfuKXDGY+/yiQwWfpwxD7LICzxECSlkoUVK8iNpcJkpYr1zoPJW9TLTBDkh4KaGLYb4HMvuoF5u+2mfXQHebXCU1ONF6LVWMs+TYfRxOrxKUem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqOgmJWO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72988749f0so150534366b.0;
        Thu, 27 Jun 2024 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719496721; x=1720101521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq5kitpL+DNnXu/D9/hs8Bp0/3waJ/uTRKdNkzKgHOY=;
        b=jqOgmJWO/W1VwbR4joDNVzRuOwrnfiEVFLG3V6hfeKWV3vHfIp1AEK5Pa7YbvT1lXj
         Lto8BWv7qt54KZSilzyE86EKDOqiAdFrimchq6zCzb7Q45C5XW24q3i+yW9gOAqNcsDi
         UQZSuCHIGNP2sTyDOHkLEz87UzxV145w/cCCGuwtK2PU6Uu7SJxq77qH9u56bi8GbnUn
         TByrCNX0voIUC+wdOzGM9rZUkUVKsQldXtiziTOQS/wKAU1xgL35deoaFwpgIHQfSpdc
         uvfqujQNJj0ZlTqEq1hMMqatxW/pfzG+NErvohLOWmlcZZffghnt7uTfzplSibp/M63n
         QDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719496721; x=1720101521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq5kitpL+DNnXu/D9/hs8Bp0/3waJ/uTRKdNkzKgHOY=;
        b=OTcTNIU5vdBFWm2PP4Lzd/HksmPjBuZnJ27ThzGcWCaRd3V9ZLg5vFs6YG3lwfE/oS
         s24gZoGyq13Gd4By9Jp9hfC0jhe7Gwsq7o7OQU5OQqfPjgvpcK0fDCNob0cOdLYCIu8M
         n6VAhQMuKEPjD5B/PY3M6c3FOkRfRZdWYCRs5fhZUZPkZndYzPl6+d5z/TFtDOhVWdwN
         X2aNgcBmlcI/q/nwlUt1tSICKS03ktiTGjL8PYd5PcpBU7E91XNSmGaYhFIvTjD5NbOQ
         mh2X6/Z/4W2B3/Vu9crxIyTBe9oDKHjcU9kj24iN22vWwp0OzXAD9jF2DGUh0FnyrC82
         Nq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDm7oAxOg5YA8Nei3hEr2e2/dfGCjZV8tSCPXpyr0yndehP9faUCOq6DiNQOWNm9+FGHOlRXjwqT739LeOXs6+HGtz6h3ZDCPuuTGZj+HfxtQqeccDRKAFtPSjKAU8QB0Y823D3WtzK1ESlA83U7yrovQavByqQGovbkOp7h/1Ox3loQ==
X-Gm-Message-State: AOJu0YyAlwckCaa8GiBFt0i/Lqf9OLzLBPZgdxS1nWyWP9JCSNSw3gSw
	6oaPQBusaKbAen2zYt198/iS921gWDw4yQJAzPOHpViQPFBrlWjp
X-Google-Smtp-Source: AGHT+IHvyluvD0SP5UIJpy0mzv9Rb/yj78D4vKm/kObn4l7XWRh5tCnb+ua1oj/MkdIB7mBGiA7dTQ==
X-Received: by 2002:a17:906:48d0:b0:a69:13a2:4f6e with SMTP id a640c23a62f3a-a7245c70519mr687906566b.74.1719496720885;
        Thu, 27 Jun 2024 06:58:40 -0700 (PDT)
Received: from andrea ([217.201.220.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7c9628sm61491866b.202.2024.06.27.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:58:40 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:58:36 +0200
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
Subject: Re: [PATCH v2 07/10] riscv: Improve amoswap.X use in xchg()
Message-ID: <Zn1wDAXjBdJu48Oi@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-8-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-8-alexghiti@rivosinc.com>

On Wed, Jun 26, 2024 at 03:03:44PM +0200, Alexandre Ghiti wrote:
> xchg() uses amoswap.X instructions from Zabha but still uses
> the LR/SC acquire/release semantics which require barriers.
> 
> Let's improve that by using proper amoswap acquire/release semantics in
> order to avoid any of those barriers.
> 
> Suggested-by: Andrea Parri <andrea@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 35 +++++++++++++-------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index eb35e2d30a97..0e57d5fbf227 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -11,8 +11,8 @@
>  #include <asm/fence.h>
>  #include <asm/alternative.h>
>  
> -#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
> -			   swap_append, r, p, n)			\
> +#define __arch_xchg_masked(sc_sfx, swap_sfx, sc_prepend, sc_append,	\
> +			   r, p, n)					\
>  ({									\
>  	__label__ zabha, end;						\
>  									\
> @@ -31,7 +31,7 @@
>  	ulong __rc;							\
>  									\
>  	__asm__ __volatile__ (						\
> -	       prepend							\
> +	       sc_prepend							\
>  	       "0:	lr.w %0, %2\n"					\
>  	       "	and  %1, %0, %z4\n"				\
>  	       "	or   %1, %1, %z3\n"				\
> @@ -48,9 +48,7 @@
>  zabha:									\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>  		__asm__ __volatile__ (					\
> -			prepend						\
>  			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
> -			swap_append						\
>  			: "=&r" (r), "+A" (*(p))			\
>  			: "rJ" (n)					\
>  			: "memory");					\
> @@ -58,19 +56,17 @@ zabha:									\
>  end:;									\
>  })
>  
> -#define __arch_xchg(sfx, prepend, append, r, p, n)			\
> +#define __arch_xchg(sfx, r, p, n)					\
>  ({									\
>  	__asm__ __volatile__ (						\
> -		prepend							\
>  		"	amoswap" sfx " %0, %2, %1\n"			\
> -		append							\
>  		: "=r" (r), "+A" (*(p))					\
>  		: "r" (n)						\
>  		: "memory");						\
>  })
>  
> -#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
> -		   sc_append, swap_append)				\
> +#define _arch_xchg(ptr, new, sc_sfx, swap_sfx,				\
> +		   sc_prepend, sc_append)				\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __new = (new);				\
> @@ -79,21 +75,19 @@ end:;									\
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
>  		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
> -				   prepend, sc_append, swap_append,	\
> +				   sc_prepend, sc_append,		\
>  				   __ret, __ptr, __new);		\
>  		break;							\
>  	case 2:								\
>  		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
> -				   prepend, sc_append, swap_append,	\
> +				   sc_prepend, sc_append,		\
>  				   __ret, __ptr, __new);		\
>  		break;							\
>  	case 4:								\
> -		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
> -			      __ret, __ptr, __new);			\
> +		__arch_xchg(".w" swap_sfx,  __ret, __ptr, __new);	\
>  		break;							\
>  	case 8:								\
> -		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
> -			      __ret, __ptr, __new);			\
> +		__arch_xchg(".d" swap_sfx,  __ret, __ptr, __new);	\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -102,17 +96,16 @@ end:;									\
>  })
>  
>  #define arch_xchg_relaxed(ptr, x)					\
> -	_arch_xchg(ptr, x, "", "", "", "", "")
> +	_arch_xchg(ptr, x, "", "", "", "")
>  
>  #define arch_xchg_acquire(ptr, x)					\
> -	_arch_xchg(ptr, x, "", "", "",					\
> -		   RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
> +	_arch_xchg(ptr, x, "", ".aq", "", RISCV_ACQUIRE_BARRIER)
>  
>  #define arch_xchg_release(ptr, x)					\
> -	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
> +	_arch_xchg(ptr, x, "", ".rl", RISCV_RELEASE_BARRIER, "")
>  
>  #define arch_xchg(ptr, x)						\
> -	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER, "")
> +	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER)

I actually see no reason for this patch, please see also my remarks
/question on patch #4.

  Andrea

