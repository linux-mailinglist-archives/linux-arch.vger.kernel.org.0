Return-Path: <linux-arch+bounces-12455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF1DAE890E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B5717771B
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE45E1CEAD6;
	Wed, 25 Jun 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw4HQ/Qa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578D1A7264;
	Wed, 25 Jun 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867372; cv=none; b=E26Bg2zlynG6VgCRJ4VNT+5oaEg/MZrkgBXb0XaxbuuoSVEo4JsoMtRcO63gQ6vQBT1u+eewXRcWpcHy+0sZXgFR/ZCaBh9Z/OL6nSdMfkvQ/ODWgWaDz9YiwrL+tVVjWnlyHThJbY3Cp5JsV4R14WCe0leCMefjZ2qw4E5nejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867372; c=relaxed/simple;
	bh=W9vFSM3wGRWvN/ewlO7qF5+92t7fujQwUJ3xIBNeKn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC8T6cAOhrZPJEob0dgaKoZiXT11ZWAXo5NaL7lZyA0/FI+2EN8iOgbIqUCJH+h2LOxbp2cNsvA+a14WDsxRZTp3oVgq9Q2rFvmC7KTB6BNcjje7CHRPXy9UcC6xonFTSZismCH+8YRANwgpq5F/qxtat/9cp/p7gLfAinYXep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw4HQ/Qa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so50810305e9.1;
        Wed, 25 Jun 2025 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867369; x=1751472169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cINHqIFzOlIyPqhGj+q+rLlY+QbAuzwrgIP8a6FcGlk=;
        b=fw4HQ/QaYxV78ssbestN/kYiEaYP/6FytFqrQ6h5oDQXctvAGXLQWh6+fcq8rLOGWq
         w9nG9Zgh0RRKh5X78oKpsO2yVNlND5dN4aR8WwT/Q7cALp1Yw/z4Vm9L/p03K/viDaJd
         p5G0tYUpnJMpXk7+STV6QGp35cII9luHDrAV5FqohD51NelYFmpWb5gL2WgTKtqRfSqZ
         EHx3L1VXnD6SYFyAMo2KO0b/G0rPE+dRFAnm3i2aH1iWd5eliv9rVnEAuknRytN7QNAR
         FCMj6gjnRNy6SsfiBsNljrXmYMGVVIukFBvRsPrJRoOFopgEvcdd8CD5JcGv5Nr7A/Bq
         LW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867369; x=1751472169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cINHqIFzOlIyPqhGj+q+rLlY+QbAuzwrgIP8a6FcGlk=;
        b=YyaeZ4FOkDAOiw2Rp2tnHtfZXh5voSi/fbvlSm9wbEr7TeFeH9z68VO4oInwH4/UH8
         WHV+ZloG8p8QMEOEhGS8AlYoCNw5XZ7Wue4utGVAycJkcQgJJ/AcPh7nS8FSW9g0WLJv
         1y/hrKavc1iG1ko6BLwBuXrEAH4eUHMtPLKNdh6go9DI/5cNpWRaoWcEbicNt8SBHjn8
         iiDf/mf4t1cFv0j+rLy+GdKUBatUNySbIOBMqi76LZOBZp0tPNiDyQ99+uZtKO99Aom5
         tjxQ9VmoNXo1JQxKi6C1nRT5kQqFZ1nOVDcy10HmWlljrSZJAjriK5502Z/S6SICslLd
         o2cw==
X-Forwarded-Encrypted: i=1; AJvYcCVq4QugAUsXgqKyJUhpD9dvQGtIaS8fYJnh6Oab2y+oYUm0Sxu9MONvQG18vYSW1JRtbz8X0UMEclQu@vger.kernel.org, AJvYcCWVKvW5FNQlKKyU6W+Q1SdhMQ7kGc4Q7L00StdhUvV37gMOT45o1824JLNEWbPsgwhZr9dzguFSzqEF4QKu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh51M7E6+lTlORi2cmzk6is5USyL5CifHo2F0MALGUNkGo/u7/
	yWeBoBNTnQrEENRbHlbJaiKs1Pf0mDLwiXy4cR6V1GSxjMlIUzC2wTml
X-Gm-Gg: ASbGncvttBzg0FYf/2o8vrBfxVs4++aXlCGR0DT3Ww/G8wYqe9PD9f0oJ8Sbfkd5iCS
	CVfytSYhZr8WWI0iq35qA2/Gq4UOLz/Hoio8jj0Y7CIS2Ee3gX3mIjrLJosLu8QwemuM/J7KCkF
	PiopvM5Vvj8Nnf8d69G2F6tFKJXWvOgDZ+X9w0vd1iBN+EjEw4J2LldvjTK6xIhe++kzvq2wmYj
	wTL29INY/JCAOLcJC5Y+4tixT8tUhlemaPkNyiC5ZRJlMWOT+Vaxy2YxhjcXpef9pbhlSW+ZBZI
	3nAFX/DDwp41+VSWBh6NiunXIl8S3mlLYrktafqj1lCtGdWuhl03FFXEW9oHnSo61QW8VFh7LaJ
	+e3QvBFfkVvPbYD2i7rBvmumB
X-Google-Smtp-Source: AGHT+IEMB/YbssMtZ1NrMoQOmyfN0LtNB/8HKXUiqEQNnI7tYcd1rYZA65i7s1VULz2iDuXb5Pc0CQ==
X-Received: by 2002:a05:600c:5305:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45381ae787fmr35533775e9.6.1750867368666;
        Wed, 25 Jun 2025 09:02:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c05csm24091875e9.5.2025.06.25.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:02:48 -0700 (PDT)
Date: Wed, 25 Jun 2025 17:02:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: cp0613@linux.alibaba.com, linux@rasmusvillemoes.dk, arnd@arndb.de,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <20250625170234.29605eed@pumpkin>
In-Reply-To: <aFWKX4rpuNCDBP67@yury>
References: <20250620111610.52750-1-cp0613@linux.alibaba.com>
	<20250620111610.52750-3-cp0613@linux.alibaba.com>
	<aFWKX4rpuNCDBP67@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 12:20:47 -0400
Yury Norov <yury.norov@gmail.com> wrote:

> On Fri, Jun 20, 2025 at 07:16:10PM +0800, cp0613@linux.alibaba.com wrote:
> > From: Chen Pei <cp0613@linux.alibaba.com>
> > 
> > The RISC-V Zbb extension[1] defines bitwise rotation instructions,
> > which can be used to implement rotate related functions.
> > 
> > [1] https://github.com/riscv/riscv-bitmanip/
> > 
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> > ---
> >  arch/riscv/include/asm/bitops.h | 172 ++++++++++++++++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> > index d59310f74c2b..be247ef9e686 100644
> > --- a/arch/riscv/include/asm/bitops.h
> > +++ b/arch/riscv/include/asm/bitops.h
> > @@ -20,17 +20,20 @@
> >  #include <asm-generic/bitops/__fls.h>
> >  #include <asm-generic/bitops/ffs.h>
> >  #include <asm-generic/bitops/fls.h>
> > +#include <asm-generic/bitops/rotate.h>
> >  
> >  #else
> >  #define __HAVE_ARCH___FFS
> >  #define __HAVE_ARCH___FLS
> >  #define __HAVE_ARCH_FFS
> >  #define __HAVE_ARCH_FLS
> > +#define __HAVE_ARCH_ROTATE
> >  
> >  #include <asm-generic/bitops/__ffs.h>
> >  #include <asm-generic/bitops/__fls.h>
> >  #include <asm-generic/bitops/ffs.h>
> >  #include <asm-generic/bitops/fls.h>
> > +#include <asm-generic/bitops/rotate.h>
> >  
> >  #include <asm/alternative-macros.h>
> >  #include <asm/hwcap.h>
> > @@ -175,6 +178,175 @@ static __always_inline int variable_fls(unsigned int x)
> >  	 variable_fls(x_);					\
> >  })  
> 
> ...
> 
> > +static inline u8 variable_ror8(u8 word, unsigned int shift)
> > +{
> > +	u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;  
> 
> Can you add a comment about what is happening here? Are you sure it's
> optimized out in case of the 'legacy' alternative?

Is it even a gain in the zbb case?
The "rorw" is only ever going to help full word rotates.
Here you might as well do ((word << 8 | word) >> shift).

For "rol8" you'd need ((word << 24 | word) 'rol' shift).
I still bet the generic code is faster (but see below).

Same for 16bit rotates.

Actually the generic version is (probably) horrid for everything except x86.
See https://www.godbolt.org/z/xTxYj57To

unsigned char rol(unsigned char v, unsigned int shift)
{
    return (v << 8 | v) << shift >> 8;
}

unsigned char ror(unsigned char v, unsigned int shift)
{
    return (v << 8 | v) >> shift;
}

	David

