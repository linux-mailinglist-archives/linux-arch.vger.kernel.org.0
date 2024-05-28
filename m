Return-Path: <linux-arch+bounces-4568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1378C8D232F
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43784B21C85
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C123A1B5;
	Tue, 28 May 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDGn4m4r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790002E64C;
	Tue, 28 May 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920200; cv=none; b=frrFtK7uylhpCpY7l+3TP6eWGimBdrZEMO0uAWadIOxEHtopmjvSUFZsUoCSn2b7WOGmU+H73l6lV1ogDVtrVxAsr4xkckzxfszlRSQqjC9vvAHVPaIFfkuKQLzYadZO40pXnilrJq8m73WAyRS7qOPISCeVcSLvhjGv0Zhy6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920200; c=relaxed/simple;
	bh=1uRESX6KymYG8m8CUzqHk9mV+NXOdIDmZXgfbN7q8Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUqQi4O2eVPY4gxMj/cV0BgW02FBP8RWNoaMduAjmRU/xdi/hK5akF4BXusvtO21ldrBMyY0NYu6iErfRZazsT7x3WvTI+SlQ8gQ8L24hpBRSgVN/WJYg6iDDQbGvc4UoOsy6/+U+VUQ1Nou1dtGFHfALi/UsPI3F9cXHQjXkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDGn4m4r; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso109894a12.1;
        Tue, 28 May 2024 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716920197; x=1717524997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R++hvr7nzebtIxTs2CU6HsOf5klg6lcgJyuQ+SjZMnE=;
        b=PDGn4m4rH47SYgQrlVmr0x8XIT8fWWW9pcBx7GeBzFcsXxto6Ar70xaKIizDiCU8bD
         sJ3O2UvzdFFB/KWWCaBRUWpePZl4aUMFR48bMfL8v/o0t4SPYHoeX77p2Rp8rS3tiQdw
         anMFBcEjCQPvMLDOcIzC71YsASgLs+ZuiAAWAtOsWeytGEvXw5flKroABTVuWaVNgC4J
         Nb47LSjFFnP++9c+se693yuFimoji5p/7c+YdbIAxLUFiD85KjvpyhAxuahDl+D+CtjW
         9E8N3DDyH+A+APK8NOPDL1U9mpUrfTMmSb/1sqCBfgNwRNDTS2Prvr8yP/K1pLn0IQox
         SWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716920197; x=1717524997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R++hvr7nzebtIxTs2CU6HsOf5klg6lcgJyuQ+SjZMnE=;
        b=YjGvZf1hjuODKLYaOQ/skc7ZmG1ntqJFy0BAXDMHB5MDisB3W6yArSOV2t9CIlXtHh
         8jOMAaIj91pFi8vODt1jy5zke3hXNZ221HuICl2eOvw5V6VM1UihxhtId1SgKSUSqObF
         YxzlA5GjKF4eqosTZZWyi0hJ0eE46xyG97hJL6qdFXN9CmYsawpYrUwYWDT8Y5xZaYJA
         JGUDVd4pGkOCJIvAa3TFFjkPv1sm8e8wRGxnX+gqp8xLtXKvkkvxqdBgaV99Yw3NHjgu
         2Iuuob5nMgYKvyp4WyNHXpWezuTf5Ir1AYT/2lnNDEHTPh203nr93q4mS1xgcEBX1FUk
         g24Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgG9qOV5hYTt5occb2JeOYnmpEOqAMjk3ZB0nZGig2cClmmhzParJVZWdViPS5CRiWjLsQfVI9EXJjmzt6hQpKsFVCFWkk83WdSZomdGJOIn6NTMhl2bNwSBGOxnPuiEJnAQdbK/s/qLY7mE495zlhPuqANj/WQ0bsGV8SFp2LWZXSSw==
X-Gm-Message-State: AOJu0YwINaMlUR4g8o/jYwE4Obd7MPB+X6I1v0FQOx0y8nXjkD631WCN
	cPjl0kPGFpP1vlFLdIiQS3gLgFlRW6RTauGeOSVr+flnfQjxJjsD
X-Google-Smtp-Source: AGHT+IHHlxn9HQL0alkg34k8cLrkz+dMOEar28FIIBD1BfkeQ51ARQuTKg6QUl77or34Ks1j6M/LsA==
X-Received: by 2002:a17:906:d799:b0:a62:196e:ef45 with SMTP id a640c23a62f3a-a623e8f6f57mr1424154366b.19.1716920196587;
        Tue, 28 May 2024 11:16:36 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62c501e85dsm394788766b.117.2024.05.28.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:16:36 -0700 (PDT)
Date: Tue, 28 May 2024 20:16:31 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <ZlYff9x12FICHoP0@andrea>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-2-alexghiti@rivosinc.com>

> +	asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,			\
> +			     RISCV_ISA_EXT_ZACAS, 1)			\
> +			: : : : zacas);					\
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
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"	amocas" sc_cas_sfx " %0, %z2, %1\n"		\
> +		append							\
> +		: "+&r" (r), "+A" (*(p))				\
> +		: "rJ" (n)						\
> +		: "memory");						\

With this, a cmpxchg32() will result in something like

  amocas.w.rl     a5,a4,(s1)
  fence           rw,rw

(cf. my remarks in patch #4); this will/should provide enough sync,
but you might want to try the alternative and currently more common
mapping for "fully-ordered AMO sequences", aka

  amocas.w.aqrl   a5,a4,(s1)

Similarly for cmpxchg64 and other sizes.

  Andrea

