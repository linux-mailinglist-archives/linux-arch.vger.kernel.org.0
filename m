Return-Path: <linux-arch+bounces-4843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B39047AC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 01:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF02B224F8
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26592155CAF;
	Tue, 11 Jun 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g3b8BxSm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10D1553B5
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148581; cv=none; b=Uu69giz4ZjyR9vmOt1Yc/pl1+P9Mx15wol30wG+IcYirjWUjUDmmnVzPnYKZr0PHUCO8LIECHljPoA/jkCOyWR9mTgYTddbp7EE45HWSjyNinPEHOrmxYJ3z7X6BKRGHwHJqORMbvaFts8JakggFzRoy9KDFJVO8eVpM+Cgd9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148581; c=relaxed/simple;
	bh=vnTp5C1q32ULDWsVgiiLtkZ6zL+dpM1Y6tx5qcG0Wgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWQUegb2F6S+11G/Ax+s3PIkeFgYtP7jDvQKPusakhiy7y+eXFWa7xJTRkpzlo4KGmzxEPzpQRRVVuq6SKhFF1UoDu3Be7/HBYLpD+yXOKTKhrlJWKFFaJvXCPjmacefKKDJJb8ZAM2YbWKWVqpmupuZpnz8QhPfcb2WRqi30bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g3b8BxSm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295e488248so6918232e87.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718148577; x=1718753377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6aiBpkg+Y6Isx66NjusATX/r6xtB4QNiCkHibX6jkg=;
        b=g3b8BxSmpEXa9PdAAiMV3oAfIZauiKz8+Q/o4Btvn1jJjxyUenBfd3wrB3Uss7mup6
         NSXuYWKMu7vy5zUTQgQ9egzd1ZSqF+j5YaMm7r2BE79e3FzVwf4HwntgXGIi7fXZpWhj
         1A0nZQMue3Qec0zjlhuKOi1YD0nlBX1CFN8FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718148577; x=1718753377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6aiBpkg+Y6Isx66NjusATX/r6xtB4QNiCkHibX6jkg=;
        b=Q8TN1lCX5SaAgZSvCtQd7WEGQOTsjog2pmqHIj0fXTtCV4RRP+MIkg2rhYCJhsplFN
         mI6ffGHwOAFdrfdovmBOp8sE+wvnrlnjStspD3QxOkPPm2h2uQ9qQuvB/v9demG/o7ep
         kZXeAB91EniVuZWN10sVcyrSTMnClcFZU46AYoTzApPmxfl87wxn8AEc/CdQ4+IxmAWe
         /DGOLtb2jw4hfHg+vo50DddVdTrpyPSrWCvcDJMwctRYrTa+AfiV0JnP/Zs0GazwCrKm
         QMybwwgzBUm4xlg0kB6gtr52JgNRnX6n3JSz6Qo+w2phr5Y+6/ks4kxErOmoXiy49xd/
         Xp8A==
X-Forwarded-Encrypted: i=1; AJvYcCUCf+1li2jfWcjItiLGnjf2rucBZ0MMC9/HRCCYNSNHCBTkGb5T8MQnjmjNV+cEDmylWuFg7TgdQfwO8QC+D6j0nd5lebdBW0y/dA==
X-Gm-Message-State: AOJu0YzmrWDY5WGPg2/PezY8cGXGstkwBy2R5MXcKHdbnhg0RDsjbfIR
	nmIT1/1RspxuPBH7nKrF0ligulnm7t4P//ApGB1KAdfxWAhI8boASRH+74C8wQooLjoH/QMAtMI
	8JYhelg==
X-Google-Smtp-Source: AGHT+IEdhaLUYUe+5ZRhybDwb+iMO2UbQrKotGSpgSRdUVNBaByfl9WDQBpj1jyUcQmZQpxNsd0poA==
X-Received: by 2002:a05:6512:210c:b0:52c:83cf:d8f9 with SMTP id 2adb3069b0e04-52c9a3b7961mr65421e87.13.1718148576905;
        Tue, 11 Jun 2024 16:29:36 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb4e1adebsm2201875e87.77.2024.06.11.16.29.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:29:34 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5295e488248so6918209e87.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 16:29:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUocNohAEdtfKZLwfSPho0Mq9GDeA/Tl5OLuqdYysYDrZ1zfwns6pOTfxDaHWvlH55lYGqVzPFYKE1uYbZnrntB33b68nweaP2DpQ==
X-Received: by 2002:a05:6512:3b9d:b0:52c:82d9:66b8 with SMTP id
 2adb3069b0e04-52c9a3e0935mr101179e87.36.1718148574257; Tue, 11 Jun 2024
 16:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-7-torvalds@linux-foundation.org> <20240611215556.GA3021057@thelio-3990X>
In-Reply-To: <20240611215556.GA3021057@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 16:29:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4mwfbUQwEVDhEsA9MxZKTdTyOKTQa7n8M68_6fxo5Aw@mail.gmail.com>
Message-ID: <CAHk-=wg4mwfbUQwEVDhEsA9MxZKTdTyOKTQa7n8M68_6fxo5Aw@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: start using 'asm goto' for put_user() when available
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 14:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> > +#ifdef CONFIG_CC_HAS_ASM_GOTO
>
> This symbol was eliminated two years ago with commit a0a12c3ed057 ("asm
> goto: eradicate CC_HAS_ASM_GOTO") since all supported compilers have
> support for it.

Hah. And I was trying to be a good boy and keep the old setup working.

Instead - because the HAS_ASM_GOTO config variable no longer exists -
I didn't actually test the new case at all, and it only worked because
the old case did in fact work.

Because fixing the broken #ifdef also showed that the

  +       _ASM_EXTABLE_##type##ACCESS_ZERO(1b, %l2)

line was wrong and was a copy-and-paste error from the get_user case
(that zeroes the result register on error).

It should be just

  +       _ASM_EXTABLE_##type##ACCESS(1b, %l2)

and to make the nasty copy_to_kernel_nofault_loop() build I also need
to do the proper _ASM_EXTABLE_KACCESS macro without the zeroing that
didn't exist.

Oops.

It would be nice to get rid of the CC_HAS_ASM_GOTO_OUTPUT thing too,
but that's probably a decade away ;(

But at least  this made me now go and actually test the _actual_ old
compiler case (no asm goto output). Perhaps ironically, I did get
*that* one right. That's the case where I had actually checked the new
code for get_user().

             Linus

