Return-Path: <linux-arch+bounces-5164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B5191A492
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43AE281E92
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7704A1459F1;
	Thu, 27 Jun 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/EofhX+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4713E40C;
	Thu, 27 Jun 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486413; cv=none; b=ujnUrln77HDlgkO+kByXBlD89P/zR6NKVB+Mzh1YoHKSD5QNXiquUJacwGsKUGEaGqApiRxWVbd+YHhtYy4FiibZsxNRUUWJXhHVIbCkbvg6qpUkt5R6F+qXBBZQ9hWRb0ERz1NWl2DqukfHme1oxvKK+DwvW1V2ROZ+rJNTDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486413; c=relaxed/simple;
	bh=tZakNtC4I+vYJWJ6QdGkWTcq89B73krB//aJoneJSBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi7ElwHBool1ycOu81lNxXf+7a5E9XOTKu+0rP5hOAJbcidRiF1FemqA+g2fbijYGW2MyMSarhw8OvRPFFVyCkoydisDsG7BsIeBEGDV6w0p8bR/u/RIRP27Etj+4Kg5Fw6Y5vV82EesYLnmLqpga53ndXkjpXiQ00pPJm0vHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/EofhX+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1700162a12.2;
        Thu, 27 Jun 2024 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719486410; x=1720091210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZobcV7LUgT3AtmVz+YLZMFY8b9IQxrzUyiNj5oBAUM=;
        b=j/EofhX+dIzjeLqLDeOKDApspC/JC5+3pVcv4gu/WPdlE3wJJTtKcl8DG8qSCZCWcf
         v5uWiJ4MQ3ADWip6Cx8bIXWbULQdVnwUMcJtz5+p3ZodMHTkOwERfnQHBvjwmSW8Zb2v
         Z7pue3UrnF4lJHJ0C78aPlfvxPKHia/eXd6vB8XKHaZwDL2l8+sGhB/Yj7c4YFozZkMx
         KDGhNbNzVKoq9QJxahwzKcbbAp+pd93Nm8cYeykno2hvsFBUBuqjfaYZd9B8nFOKhKk6
         o2r7biBEU8m3tGnWhzb72MBFoPVNyu7geNihsf2Ul9eN/sz7jHd2jkJMJGt+9GUUq+LE
         vDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486410; x=1720091210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZobcV7LUgT3AtmVz+YLZMFY8b9IQxrzUyiNj5oBAUM=;
        b=rYOUo/aOjudmHmtQxScE7xqigCDStp8be0uCHW8+nuYS28gboe8DM1f/37iDzIKryU
         qPKqgftnBtpQI7rg+O8RI02ibYs2i0R7O2VaQROKJ+OJXJXRFhWaxSUJ/KeIE5Hv7ApZ
         PeCZd9BM2qOxUZ4b7PvfPIZjHLl0P14TnwGEhHoSOZL7ncYbkJ/VsAGt793JMUH7cECz
         xoPMEm6VnxpgYQwOXn/U2THJ6avr3zcrYtuIviDLOM1RSq0EXxvuyUX3li2QsWVfMvCy
         f6jgp28kJKazgzmJPGyXNqhV6ehTq9w8O5rhqf76LU4YDEYqRkd6kqptP6ucQ8C58nLj
         562w==
X-Forwarded-Encrypted: i=1; AJvYcCV/fuXcbgP7VsZHM7YLPjRUhNDcuz3DApVUBqn3RM4Zms4cSC2xDsvWBY6knX2+4H8QNYLSTKC+s3ju7te7P4qjac5h88v1sx9YvRDwgGtTZcOBdADSkoHy0D7jsu6lYlTISIvA96v7wV5pLBqbUZ2nvlbsl8vqYfaDR8A0WVNxgmfcdg==
X-Gm-Message-State: AOJu0YwJq+v2e1iYk7jJ29tX3uljlsJ2TJpgbDgcVWcumuUfBnO0AlJz
	/t1TRoxvHaHs5F4Ij3qcTrm+Evp7jXCfI0xTL/JKMJaXXkVjOQbk
X-Google-Smtp-Source: AGHT+IF9IGb+EAqcYH0xHZ8HF47kVV4+X97fRL+JfZxNkC2UpJv60e/BcSk/SP3WOORT9Eilh3uoUQ==
X-Received: by 2002:a50:c081:0:b0:57d:519:ba3c with SMTP id 4fb4d7f45d1cf-57d7004c60emr7710603a12.24.1719486409637;
        Thu, 27 Jun 2024 04:06:49 -0700 (PDT)
Received: from andrea ([217.201.220.159])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d1280e71sm718305a12.37.2024.06.27.04.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:06:49 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:06:42 +0200
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
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <Zn1Hwpcamaz1YaEM@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-2-alexghiti@rivosinc.com>

> -#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
> +#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
>  ({									\
> +	__label__ zacas, end;						\
>  	register unsigned int __rc;					\
>  									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
> +		asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,		\
> +				     RISCV_ISA_EXT_ZACAS, 1)		\
> +			 : : : : zacas);				\
> +	}								\
> +									\
>  	__asm__ __volatile__ (						\
>  		prepend							\
>  		"0:	lr" lr_sfx " %0, %2\n"				\
>  		"	bne  %0, %z3, 1f\n"				\
> -		"	sc" sc_sfx " %1, %z4, %2\n"			\
> +		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
>  		"	bnez %1, 0b\n"					\
>  		append							\
>  		"1:\n"							\
>  		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
>  		: "rJ" (co o), "rJ" (n)					\
>  		: "memory");						\
> +	goto end;							\
> +									\
> +zacas:									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
> +		__asm__ __volatile__ (					\
> +			prepend						\
> +			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
> +			append						\
> +			: "+&r" (r), "+A" (*(p))			\
> +			: "rJ" (n)					\
> +			: "memory");					\
> +	}								\

Is this second IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check actually needed?
(just wondering - no real objection)


> +end:;									\

Why the semicolon?


>  })
>  
>  #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
> @@ -156,7 +177,7 @@
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __old = (old);				\
>  	__typeof__(*(__ptr)) __new = (new);				\
> -	__typeof__(*(__ptr)) __ret;					\
> +	__typeof__(*(__ptr)) __ret = (old);				\

This is because the compiler doesn't realize __ret is actually
initialized, right?  IAC, seems a bit unexpected to initialize
with (old) (which indicates SUCCESS of the CMPXCHG operation);
how about using (new) for the initialization of __ret instead?
would (new) still work for you?

  Andrea

