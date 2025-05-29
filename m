Return-Path: <linux-arch+bounces-12141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BEAC8318
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 22:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A421BC4DC1
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3929291F;
	Thu, 29 May 2025 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CUZW/Lz1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543229290C
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549693; cv=none; b=FxcAjounQKRiv6V0Jx9apxSwLMDIYvdalk+1PKMPRgBTw7N6vKBy8XcrXFxJgsg5jAclJ0KV6+6BNinDwGAwHRRLKbniXzGi/SBbeTyNXwzFrecHWLgkrEUVemuiXO/U+r/mXouvm1HAJrXOOWeNVcCDG2pTOxOrjJ8pafHd+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549693; c=relaxed/simple;
	bh=pEGh+FyMPK3zT/zV3uCRaiREChKfcHdnfIXKiv+KGVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkxCRXaV6yda4lcE1xtdqee7sfHsnDEUHlqiZnPbl4UAB6Es83aEBaxIkSlmd+XXSpmShYywEvr4+X44krocGfHbbdTEfto8mEJEexj/nQhCvg/mHoSMko7D4h/JDytP2geO2F5oVbHq8b9zcmMos4ZyxMxGzUWspl4qNGMl978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CUZW/Lz1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad55d6aeb07so209571866b.0
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748549689; x=1749154489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVSRhT5MS1pvdu2dqLDEs9T4cWr5CB+FRQ66tAe+RVE=;
        b=CUZW/Lz1rXNvL4/xDxoZhgf2TwOSc+gxLjvGZnb8SeB+HMXYaTJ4d67Lm4pEgp6I8z
         7uwhw/oxWedN3vTyBNo6HTPcLu1QPnqChVtgvXy5KDWfJy0ejD2iCLb3MNO8SX1SNNZv
         d2wNH+w49xoICvrrcmWZE6wfrPSKqYpF+M2iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748549689; x=1749154489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVSRhT5MS1pvdu2dqLDEs9T4cWr5CB+FRQ66tAe+RVE=;
        b=gJKKOOFoXOTC3ubsKvvfaUQFrnS/u03e/WU7Sk9VRx8lK799f1+6hPV9/XsterKAhv
         o517osO7q7CtgPiqAoih3+Yn3VsCZBODwiDI8nCljuf3Shw9jAlEJiWN94C9e/LJFn72
         9NB+Lg5KupJn9UT02Ol6g8RsL7i5V5tQZG+FSaEzBbBvRiHpepm4E3uRlgEYO93AzGL+
         hFi/qXMSm/7Zu42AayRWol2RL5/87FRyu4nLEZCMcQd8MP84ukN96E8AhNstYd2NutQr
         wnvhPv4N62LUAQY0GXMPoSqMMSe8mO4q+xsc/nnFSdISZ8FP772ttu6nM/wZi0u/zg+b
         Tj2A==
X-Forwarded-Encrypted: i=1; AJvYcCXP/sHG7Bm2U8kkjmhPC6YMo6Q1Qe6YO9GcLv4o8z/5vxuDAUuN72k2ncrOqiTjIC1AmiCEsDzT8tuE@vger.kernel.org
X-Gm-Message-State: AOJu0YzJh/i7E3HU6xVbE5E2UjhGaFqD99PiPtThbkfNCH7i7TGa7/3a
	g16UwAO0yvydA3PZG10o5L9hlLDjAvsq55vVhSV10AVHsitdC/U0tQcjeSjD4U8CrTFVFoxP33J
	xtRd330U=
X-Gm-Gg: ASbGnct7OlFSYgmEmCF/5fUMmrjd5SDjsOlYpUxjnqoFXv8o8MWspCR3xiuSU8Lx8EC
	zWn+zg4mIj5sDYu4oJpr/n/OIrcXweFAF/E8JdDbNNXSOvdMZng3t/masFroCPUUb82dnBFd4uK
	+IV0En/HakMK/buMMle1fLxAIyofd1AHW84rm68EqIRKrXu84Z6ROYwmIQcnYrRr7lAQ6GY4Phe
	M0ra8HVMKkl0M/jQnKC3f9V7pU+OI/bplHJ+C+/+1g0VumXgJIOke3C6UMo/5l7TblgHUOlBVr6
	iuhw5yQyXXfIJ1RWMFsSyqLWPUEQApVgD4xFzsrraq7HKn738zASFtmiBzi3gR65z3rCF//z82E
	ZR/jkvR25iot7rGXoAqJ3C9NRMw==
X-Google-Smtp-Source: AGHT+IEVmL8SOZ70gMgXyOkoluz9tr/ujrrcENQwtbPHC4r2x4SB+1M2Zt+9az6uNHRgoaFaAWR3nQ==
X-Received: by 2002:a17:907:3e1f:b0:ad8:9257:5724 with SMTP id a640c23a62f3a-adb3223f013mr77406666b.24.1748549689214;
        Thu, 29 May 2025 13:14:49 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c74edcsm463172a12.39.2025.05.29.13.14.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 13:14:48 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so2562144a12.3
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 13:14:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSm+echiD5htZdmtGt//EsNKwUvQPMrQ3zj5sN2FWSvL9f+dw+TeN2M5e1Q5uZHnietjlFX/FnkswS@vger.kernel.org
X-Received: by 2002:a05:6402:2346:b0:602:1d01:2883 with SMTP id
 4fb4d7f45d1cf-6056db10b4emr581444a12.1.1748549687775; Thu, 29 May 2025
 13:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
In-Reply-To: <20250529173702.GA3840196@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2025 13:14:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
X-Gm-Features: AX0GCFuiJcryO_X7sE1ePk8yCEY5HNa9j_jPT14Gm93VGY22kOHLk2kIn44ZkWY
Message-ID: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 10:37, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Long-term, I'd like to find a clean way to consolidate the library code for each
> algorithm into a single module.

No, while I think the current situation isn't great, I think the "make
it one single module" is even worse.

For most architectures - including s390 - you end up being in the
situation that these kinds of hw accelerated crypto things depend on
some CPU capability, and aren't necessarily statically always
available.

So these things end up having stupid extra overhead due to having some
conditional.

That extra overhead is then in turn minimized with tricks like static
branches, but that's all just just piling more ugly hacks on top
because it picked a bad choice to begin with.

So what's the *right* thing to do?

The right thing to do is to just link the right routine in the first
place, and *not* have static branch hackery at all. Because you didn't
need it.

And we already do runtime linking at module loading time. So if it's a
module, if the hardware acceleration doesn't exist, the module load
should just fail, and the loader should go on to load the next option.

Not any silly "one module to rule them all" hackery that only results
in worse code. Just a simple "if this module loads successfully,
you'll link the optimal hw acceleration".

Now, the problem with this all is the *non*modular case.

For modules, we already have the optimal solution in the form of
init-module error handling and runtime linking.

So I think the module case is "solved" (except the solution is not
what we actually do).

For the non-module case, the problem is that "I linked this
unconditionally, and now it turns out I run on hardware that doesn't
have the capability to run this".

And that's when you need to do things like static_call_update() to
basically do runtime re-linking of a static decision.

And currently we very much do this wrong. See how s390 and x86-64 (and
presumably others) basically have the *exact* same problems, but they
then mix static branches and static calls (in the case of x86-64) and
just have non-optimal code in general.

What I think the generic code should do (for the built-in case) is just have

        DEFINE_STATIC_CALL(sha256_blocks_fn, sha256_blocks_generic);

and do

        static_call(sha256_blocks_fn)(args..);

and then architecture code can do the static_call_update() to set
their optimal version.

And yeah, we'd presumably need multiple versions, since there's the
whole "is simd usable" thing. Although maybe that's going away?

                   Linus

