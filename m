Return-Path: <linux-arch+bounces-15872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28ED3B4CD
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D36573002BB0
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3832D0C9;
	Mon, 19 Jan 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMtYY/zm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814707405A
	for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844855; cv=none; b=nQYZEUqaJuWGUCjRZoHEJWwlJVezGfh1mvaCQ1Vi5Ew/At19r+Y9ZeNrd5eWtQ9Wu/Cs2yQPqgvvXheifir6NA0wOhj+0X11Q8eyUP/NXbR01nwvxJRIW9g6UMqbixcEcUkFoinCGnWIgOOV5HQ5FpPQqxsBuODdDmB3BxrSovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844855; c=relaxed/simple;
	bh=uFWIzT/NGXdCZyvcgR0/FUoFNBord156hv8OfVms58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAOc5Pm+S3e0X5RJr1ailbFwx+e/khZADmZdLMFk3lEMXvMipc+g0ZCKMkkx8pSSYek8pHu3KzUY/xar+hvdNluvq4ZSQradSAEyK59L//MHJvLIXf0mQm3rJbRRbSLrNmZ/0CcddNMbMh00ZjcVnhOCeAXGU8+GPJrALfzQHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMtYY/zm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso21604615e9.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768844853; x=1769449653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2ACadv0hgsZtux+LBE5pG2d7aO4i+uY5axwwBu8vVQ=;
        b=GMtYY/zmJhPX5Xs7FJm3rgdUKdWIuhIklepJ1p4sddiSk/m48GgcuCFWYojivUWl0S
         ItcXWhV3LEwOv4TzwJv2L8CLKQ44AK3D7QBES/aeXyukZebzf2e+NZ46lwP+vS2RJDr5
         Fas+NRvNzp81+95dkDBYnUxXK/nnySKrAwae2kWZV4CNSP878KpANRKljUJLJ2uB15oC
         sAxiISTwz31imERKHeIZ9AEFL9R6RLEjaJRY0JjT2sDdN+s30Rb5I1AXTdLHzspGThuB
         tiCttjFFxbiQp8IPlnnIJDSDi/RKZC4j2b5/myFO+GiYQyFzJrxUbAtTdQo9bs/p5O/b
         sM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768844853; x=1769449653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2ACadv0hgsZtux+LBE5pG2d7aO4i+uY5axwwBu8vVQ=;
        b=b8B91y85HU9iJuUJ8d5FKMWXmr6eU8RM9uZ/xwV01fLjBYl8jR6oW3vhz+D7brb97C
         xwH3Ni6QGusnoXxq/FDXYwfyM5EZbKDA56FlS7f2UNnI2hJr8fzfpLfQgaqA8eW0DzDj
         KuiNGSub0dTqvV/9mcA4YaqSzOmITl7boUepG5qXPSzQft5Ott3bwJCbx/MRfJzmFTkx
         3nHI0FB/wsxDoVAPsLKADc/8AjpNwCjsSe+m/aYSXgI/dPFE6jsg9WNBl/GxEzDERO6L
         3bmtfFpV6NYn59rGhZMmgjqHbdMCj7YhksnjSgz/5V+ms1zFYk8oOKriSsR2n8QrAhl8
         cjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRtT4fz//hCagjHYccBv6E8+1cbxXVKJVIMqyWnEngraZl4sRgv1UaTOAr9pyWoMZbJXUn0Ul9vxlo@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYkPKWt0VZiC5fvq6yomgqFKqs5THOU1T/BVo7oeuHx8l/ogj
	dvPq9W2QC7V7RCNo8IWZKOrkvvWGOzi6toRoyuLp8BI+RKMe5HfXzx97
X-Gm-Gg: AZuq6aIf6s9C2LxPnQzAshgGINKJQHd+hDcQcTOW+A2QjiL8VzV1Q46auJOK6o3rKuw
	yomJ6/700fntAC/Xx9azh04MGfnxrtMhLFIozFmDk7TB1zohbLnB8mfuI1rQl54JS+jGTasyrHr
	FJcCH3VqgJpWRk62ZtFilnjbypRtOCjhONFPB3uXTU2P8IfND3Q7rxDYTufmYdgiR56kngu6phC
	/2LJ8js6HG6/KMsniwiO5Qi2RN6Tro+JPLDPuuaE4XYRkh901j3DEKu4q8IwvWsW/u2NKKPpvQr
	AeRe8WVtv486PUU7CqKlluW2iT8DHng2/WGqGvkLts7srZFcHL8Lsf5cJkvjmY33z0y5RRexFBr
	GRNbmzaLFP9KaYfhLuQHhHGJ6la4AEhDI8LyT1KPec6chDa/H9cAy2Cc0q1oY/FC9ETdpiSYPE3
	V0y41lSg6nXDcbaacqOJngm0H99rNuVZZl2mmUYXQ/evXHKxw13MD2
X-Received: by 2002:a5d:588e:0:b0:431:9b2:61b0 with SMTP id ffacd0b85a97d-4356a03dd73mr15899699f8f.25.1768844852626;
        Mon, 19 Jan 2026 09:47:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dedsm24242699f8f.9.2026.01.19.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:47:32 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>, "Andreas Larsson"
 <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119174730.5a20169d@pumpkin>
In-Reply-To: <4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<20260119100619.479bcff3@pumpkin>
	<20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
	<20260119103758.3afb5927@pumpkin>
	<20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
	<72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
	<20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
	<4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 15:57:49 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 19, 2026, at 14:41, Thomas Wei=C3=9Fschuh wrote:
> > On Mon, Jan 19, 2026 at 01:45:04PM +0100, Arnd Bergmann wrote: =20
> >> On Mon, Jan 19, 2026, at 11:56, Thomas Wei=C3=9Fschuh wrote: =20
> >> > On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote: =20
> >> >>=20
> >> >> Don't you need a check that it isn't wrong on a user system?
> >> >> Which is what I thought it was doing. =20
> >> >
> >> > Not really. The overrides defined by arch/*/include/uapi/asm/bitsper=
long.h are
> >> > being tested here. If they work in the kernel build I assume they al=
so work
> >> > in userspace. =20
> >>=20
> >> I think You could just move check into include/asm-generic/bitsperlong=
.h
> >> to make this more obvious with the #ifdef __KERNEL__, and remove the
> >> disabled check from my original version there. =20
> >
> > Ok. I'd like to keep your existing test though, as it tests something d=
ifferent
> > and it would be nice to have that too at some point. =20
>=20
> Sure, that works too. I wonder if one of the recent vdso cleanups
> also happened to address the problem with the incorrect BITS_PER_LONG
> being visible in the vdso code. Maybe we can already turn that on again.

There is vdso/bits.h, but everything actually includes linux/bits.h first.

I was wondering what happens if you are actually using the 'uapi' headers
to build programs (may nolibc ones).
On x86-64, 'gcc foo.c' might work, but 'gcc -m32 foo.c' will find exactly
the same headers and go badly wrong unless everything is based on
compiler defines.

An assert (of some kind) that checks the pre-processor BITS_PER_LONG
constant actually matches sizof (long) seems reasonable for all build.
The alternative is to (somehow) manage to avoid needing a pre-processor
constant at all, moving everything to 'integer constant expressions'
instead (good luck with that...).

I'm most of the way through a 'de-bloat' patchset for bits.h.
I'm sure there is a good reason why GENMASK(hi, lo) isn't defined
as '((type)2 << hi) - ((type)1 << lo)'.
Since that definition doesn't need the bit-width in any form.
(Just beat up any static checker that objects to '2 << hi' being zero.)
I've only made that change for ASM files - IIRC the assembler only
supports one size of signed integer.

	David


