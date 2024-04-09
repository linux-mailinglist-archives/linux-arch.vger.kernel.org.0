Return-Path: <linux-arch+bounces-3525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6F89E1A9
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCAFB22EED
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A65156245;
	Tue,  9 Apr 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE+ItwPf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D84C85;
	Tue,  9 Apr 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684147; cv=none; b=tJUnrm8M1YVAUG/tHP0rZHWxWOy9jjw9lUFTrhmEdLkEN/pKzbLmQr/jzif2/MxhEi0qsvHng4N8UVUzWvakk0jSllWf3CUuzRZLfhIZS1EWKBHss+J6VAXoiQB+x+p+5IXxfWAPckuY02EmhUYDoosc5RjdcjUX2LYpPmKA4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684147; c=relaxed/simple;
	bh=g6XpcYsG78eMyUmVOhris5GkliBV/1yrHtY1DwTpRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDLhWzurIKvoAabMrpEXra148exaxDBFKM9GuZch+1tV8s0C9jeexusSWF/Mx0h1w+lFmL+PLdrtAWmCxG8eDaMBGKWHsQ4ibds4tK8/HljIABHhRCipFdkuBm9yzKYQEY1m+IXL5/zYwtUGDGywK6IPkWsVy8Ip6PZ5nJlJNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE+ItwPf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51b5633c9cso448878466b.2;
        Tue, 09 Apr 2024 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712684144; x=1713288944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oksDrDeNBIi1C7DVLaC+ql7QPqJVNO5mhvekClGdtck=;
        b=nE+ItwPfiAfhN9KRwf3rLC5HiCnj+m9tRMVy242/VEb41atlWBkOhMH9vOeBzr+hno
         Et6J3g1oQHBTXEoTgbshe/Z6xWLJYkqQKfDDR7jkwtqeXcFWXjskqFeFi6oUk4hgKlu1
         Q66kmv/C+KoHjxesl9DOX7B6AlTbaDQ5xb86E14uJWrK42p2V6KA+m5IaNG3TXnoLWW3
         jf4YImItMUCw9VThitqqHsBzcUcbs3N/q4wBET//DSGEbrvEkRXrRUUAvtGq7Q2puSeI
         XrMPEuSNOmAEKLn6H7zW4E70PpfwjodQV8Y9RRQICiwBmbLG0sSnAI6Xk60h1xdKKk7w
         SbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712684144; x=1713288944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oksDrDeNBIi1C7DVLaC+ql7QPqJVNO5mhvekClGdtck=;
        b=avqOSBybOqmAFrGTRa1SU+pwO65FPxMEvOgONUlSQdt2HIO6T02KLTrjCO9ocJgdt7
         Z3PJxKkGeM2S0C+2y22G2muGAkxbaxyxYsc2JBjsoDTU2RnBLI6l7GDB1dpClRZ78IzV
         z8wl2+FQPAk0NuUVV57Mmxe/YjG4Pi51aznzZ9d8gAEun2Fmth4/PfobsJY9uaZIo5+w
         hINxQc/WTnfvi4vMt6roVIF8r818wsJ2j/p2pq3WClj7V2JzjHPb/tTHu0fygdfHjwRd
         ZA2mbRxmPHlp+8ItaTSkUtZvmm8ytRGPcJI6vjbUjAham/qDbfMxk8N8A6jro3+V8qtN
         ePcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCpGzZdljeoCVwUKAkoYro7fU3rdyGdz3/zs8R1SKJJC8A/2XS/+5cfeMcI7ngfTfVJKU4pDgbZy2orXamXOM430ItXOWnoXalyM9
X-Gm-Message-State: AOJu0Yz0+It3xy4dqyUIYMts5qCIthipQJkC4mmDbGFxHbmuZNj3Arqv
	hsmtLRSwLCdwRrNj9W9Y64oRw6rQ08qE0UJHkTaEaOPoG4kCK2P0C+gC4epT9d4=
X-Google-Smtp-Source: AGHT+IEO/dT/EyFhl/Hqi0+rJYkm0yyrxPm+XU5vxXcOVNbNzgJ6NtA5sncFdXAPNsxKDtLVFhSDIQ==
X-Received: by 2002:a17:906:6a10:b0:a4e:3715:7f4a with SMTP id qw16-20020a1709066a1000b00a4e37157f4amr93587ejc.71.1712684143973;
        Tue, 09 Apr 2024 10:35:43 -0700 (PDT)
Received: from andrea ([31.189.89.249])
        by smtp.gmail.com with ESMTPSA id sa10-20020a1709076d0a00b00a4e6582edf8sm5855812ejc.102.2024.04.09.10.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 10:35:43 -0700 (PDT)
Date: Tue, 9 Apr 2024 19:35:39 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
	Yujie Liu <yujie.liu@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH cmpxchg 14/14] riscv: Emulate one-byte cmpxchg
Message-ID: <ZhV8a+pWAnJQ3Ljp@andrea>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-14-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408174944.907695-14-paulmck@kernel.org>

Hi Paul,

> @@ -170,6 +171,9 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +		break;							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\
> @@ -214,6 +218,9 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\
> @@ -260,6 +267,9 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			RISCV_RELEASE_BARRIER				\
> @@ -306,6 +316,9 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\

Seems the last three are missing uintptr_t casts?

  Andrea

