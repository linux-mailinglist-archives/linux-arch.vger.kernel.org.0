Return-Path: <linux-arch+bounces-5167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01C91A834
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A073B284096
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E515FD1A;
	Thu, 27 Jun 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjYwxKQ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B436B0D;
	Thu, 27 Jun 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495958; cv=none; b=C2nwG1zMh43gJEStEptaImw9llMwzN5O4c6+WuJ+gzs1fJ9+wSXZrDhHMXwXVyWHgoWJBpIq3PpXlwy3apkgkY8jbVy5mXayisUgYEO5o11S3kv31L8iX88Dy2dHC6gbuSGwCP+63xuRNZFBC9V/VW/Y6w7zoUKehDhNU6uXAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495958; c=relaxed/simple;
	bh=qiP0d03L48mBK02zh4Bwt6nO3EjGwVRa4rGnQijqKbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urCXq5SU3+ZqbVWaV05jIQEFlsV53sFutDE4J18s+5UVmULT+lJ2ilK86auIajN4d46FKOZBLmpk8Oc/hYxQX8UFtMmI3cy/pjnx1RO3u4y5gc58elXg7q1PJH1BOC1e812AlXO8p6Z2S9FBWJ6cZwvrZEsQdJMn6CStDub83oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjYwxKQ5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1955655a12.2;
        Thu, 27 Jun 2024 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719495955; x=1720100755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqCUxWciB9MbG2JQ9jtj996Vwl+0BU0fXmC1Jg/exqU=;
        b=JjYwxKQ57s/7Ps9NYHWEE7uq4uEDXf5XoEqo2WB3wvZ/ajGJXCoZ7hSZJhvg6t2E/T
         +rWyOSMehI2K4eQeMDwvWOgCzcgUu5lD0Kdj+5RXSqNSxVipvuxsm3odyycyPpFLy8y1
         ZHafjn4+8n6GBq/4VbMxFLmmzTKU52OGVjY48uLcVAD35uhYa6jbO2ScuhJKP55JSZvm
         hc2572WhQmwT/DbGRVtzHacSqQ3Oy35q/5mQPca6ZIFUuCeJjxdLY/sOTy/w6vBIoyS2
         N7hPJBPQw9nPqkRfygX25M5vnLTSU9Bjd2FZV+CCI6iFYAxAbmm5fg7pZ3bfy1HEWbsi
         tBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719495955; x=1720100755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqCUxWciB9MbG2JQ9jtj996Vwl+0BU0fXmC1Jg/exqU=;
        b=PvUs6OjKgRDzN0/vN8Ed403FPDIBeq0R7ffaHDbZxu0Ua0Ucm8rg8txnzbuw/4qwZH
         90/LrzWkTSBt26b7xK2bzFdt0VwT19tGtDcyqEJeoYP/PZe/1XYljxuVa0I3+WZeiLuy
         aABAVDNO4U/QIbtJWpG87q0p0YhS7XYndSvDleYQXr/HcEUnyL7JCp3uIp6pCvfvncNW
         10s6KXdSRmtYpJHUBvd9jqBypAsSl9MkR3PSkfzI40vqmtmdPr8eGpCrd0gBQBxiMBE5
         WsGQVbqkSuF5HZYkIKmX2sHVxK+xUtTGbgnG56CSIs1xDhn42gUwyj6uXyoQ4Nue4X5u
         cypQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/rvxyYFLacy30p5mnhAOVbjmH6KD5B1kG6QVY7sYho4OxIPVtzmmPxEOghXYcEO7myYz2vfwmIXduvVGOv8ur/StPTlqABB5fYkPI4gJA6Ksiuf2/4+qHVOdGyzyXBVykihX8NJj+K/e4xJuvKJeeCZWnCsb0UleKOLRuT9wopGjBaA==
X-Gm-Message-State: AOJu0YwhykvaLTyW/GlybwTnUOozvLhgd12XYKve4BMmidLDfELSTdUT
	JSjelkKH9piY3VrC+3x2Kt2/rNzxvgiqYqzczjaChoLbvCxuiSp8
X-Google-Smtp-Source: AGHT+IGKZ1CSUGDI4rs/M/a4ZH4Jj1812GjsMZF8LngzceqmSBm6tDeQ9YvrE+dUO5jhVyH6YeGZRA==
X-Received: by 2002:a05:6402:340d:b0:582:5195:3a7a with SMTP id 4fb4d7f45d1cf-58251957777mr6515379a12.35.1719495954679;
        Thu, 27 Jun 2024 06:45:54 -0700 (PDT)
Received: from andrea ([217.201.220.159])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d1280e93sm902182a12.33.2024.06.27.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:45:54 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:45:47 +0200
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
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 06/10] riscv: Implement xchg8/16() using Zabha
Message-ID: <Zn1tC1G6eiyIW/yJ@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-7-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-7-alexghiti@rivosinc.com>

> -#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
> +#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
> +			   swap_append, r, p, n)			\
>  ({									\
> +	__label__ zabha, end;						\
> +									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> +		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
> +				     RISCV_ISA_EXT_ZABHA, 1)		\
> +			 : : : : zabha);				\
> +	}								\
> +									\
>  	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>  	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>  	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
> @@ -28,12 +37,25 @@
>  	       "	or   %1, %1, %z3\n"				\
>  	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
>  	       "	bnez %1, 0b\n"					\
> -	       append							\
> +	       sc_append							\
>  	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
>  	       : "rJ" (__newx), "rJ" (~__mask)				\
>  	       : "memory");						\
>  									\
>  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> +	goto end;							\
> +									\
> +zabha:									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> +		__asm__ __volatile__ (					\
> +			prepend						\
> +			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
> +			swap_append						\
> +			: "=&r" (r), "+A" (*(p))			\
> +			: "rJ" (n)					\
> +			: "memory");					\
> +	}								\
> +end:;									\
>  })

As for patch #1: why the semicolon? and should the second IS_ENABLED()
be kept?


> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index e17d0078a651..f71ddd2ca163 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,7 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
> +#define RISCV_ISA_EXT_ZABHA		75
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 5ef48cb20ee1..c125d82c894b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> +	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),

To be squashed into patch #3?

  Andrea

