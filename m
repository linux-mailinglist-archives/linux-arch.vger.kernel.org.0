Return-Path: <linux-arch+bounces-14121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A6BDEDAD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0728D357229
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BCC24A06A;
	Wed, 15 Oct 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2RoqtRc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98789215191
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536419; cv=none; b=fL+jcox/6OI5FkIj3UqYbv28KeqqdbIjZmV/lZYN64B/LkS6OsTwLuq1Wxa1OjFquf3731Y8s7d13xJjEo/fr+9guuFLrH/LA8W5gRDGU1JVzxcto+uNJ1+0CWhyY1nWEmp3uInL/jH/9W0fgu9emTEQp62fzFuuw9n2Inqre8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536419; c=relaxed/simple;
	bh=nAMaEtaGYdQF7zxrims38eySXuR9N44DgyDjL/b4jdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/qwYhrmqs/tlZEwmnCSrups6N1VdQfMcQsqpP9z5IVbMNuGxW5OB/Hdwy+NGa3I3jhMybsX4UzHlmbb5FoUkBv0h+uhy3Rb4alwfyMYRq0QrNXirCINrO55C5dqvnlScBGgOYgroVBIBErU8r3cSO3gKBR/TDogqKGvG5wBEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2RoqtRc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so29771395e9.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760536416; x=1761141216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqOmoGsO8trYgMWNWNZ7iS8eeHupXqHvme7XfA7g8fw=;
        b=d2RoqtRcNZZ7OgIbR6a/B+bnakofR0frrNNrsUBx2J8Fk+ktFT8VUo+5/GLVyCArVZ
         cf9CI3VHUTSyBKDAw9TNicpa7Mz2NTB6o5pRT/af41tc/CvnPmwAirRjox10xgYyt0rV
         aStuPuqsh9vabgPGVRi0j0snuMlinXF27o9tuBwTyNEPgKef0V5DEidH7jzkbHnUl1Rd
         qrtkm1AWD4YsHUvdx3Xf/TljeZfzTcYKHetT8k3YEFq9UBDmu8rHzO6vvsjiT0UysEYH
         YOYRsCywIhdpKPOI7/x2e2hNDJpiT1AIfT/uyshIsOA/mtN2fGDkxEphVKpXw9cKHBsT
         IJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536416; x=1761141216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqOmoGsO8trYgMWNWNZ7iS8eeHupXqHvme7XfA7g8fw=;
        b=GgdXmbScCIZYYmvymThitKySUseJcWlbYMvmWl1JP0PziwVe7HicJhYdk7Wab8Xln1
         SNZJyvQxBm4InFIO470JqcYia/W8TOgic26yTo2/UBN8OB0Iy/64VeFhyZYRGSy53SP0
         6YZvcg2ojrDhCFIDt7cu7C42o/qPktx77Gtjg3v/gqjyYHVIBUbHb51sCDGPG25ZuDT4
         xM4UJZ/GO9iVHkzfIDo3rtv/k3F2nnf87S0p+mecer+oCd2WnhXD1o5Mlp20J3RIw5OY
         EH0bF6PJJGDfuBVl2ty01DCedDEdqkQZD8yE/wUTqYaViFa6C8P4kDMXY/eNpeJ8rkXh
         KUCA==
X-Forwarded-Encrypted: i=1; AJvYcCVF6N0eBU2OdxwkX3FDvTolfrr2Wug31n/0figXZjVuK5XPwIPhna9YKV7ge5zqJdcuUcL2Npju1tX5@vger.kernel.org
X-Gm-Message-State: AOJu0YxudYqnx6vn/7QKFp42zYgU6xxlLUe5ThILjIOfFGcEaCIAQUYl
	mbVW0UgKIN5MJP/5EkfVC0+KSRwndDb/ztw/2G/vJ/YpwxM3cR06Gqud
X-Gm-Gg: ASbGncsmLCpxkMBFFQZszQt21XTXjdggpB5eSACYjxJ8sBwk1Vs0X8wcIWfYCT+IQLf
	gBfl7xIsG0faGQBEW1Ftrxtye2zwJrH9hO08oLV1Nr8xmBbmQ+CibX7IMAPPHdn/GPlooIoSaZQ
	fqK1svJ8wBHsUrnB082a6Ep8MrrMnB9tKJFD09nwhSEmMCaAeQw2amIAIvjdNHAaLPAriwadYTG
	jm/NFWFK50wJDJDJWyeN1Jfgwj4TzufkktlTpmFjZIjQiM5awdePgwpJ739UVfWTH+7WenhpFLL
	Y+G0j3evZg2Qn6jVt/qIufibGPWmepsTOa9EkI15HtBp3UeFTcvm0FtgO+gallPstaQ+N73VMBN
	DYGacVg6odiVsHKJ6yNHTHhxod75Y4vu3cT1iKA+XTOtN8sCt9fjzUSpKbR1IzB0rHF76E7FeCR
	z08j0S/80=
X-Google-Smtp-Source: AGHT+IENrsvklw3VMayWb2/SzhwdX4veJ0+2ZwpShwijlf0i60yg9zXIjqKms1bHJUjYdDjkBYD4JQ==
X-Received: by 2002:a05:600c:6095:b0:46f:b32e:52d9 with SMTP id 5b1f17b1804b1-46fb3cbc5f8mr146733575e9.13.1760536415649;
        Wed, 15 Oct 2025 06:53:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710049cba2sm35932135e9.0.2025.10.15.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:53:35 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:53:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland
 <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
Message-ID: <20251015145332.260eebe6@pumpkin>
In-Reply-To: <f5f939ae-f966-37ba-369d-be147c0642a3@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
	<76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
	<20251014112359.451d8058@pumpkin>
	<f5f939ae-f966-37ba-369d-be147c0642a3@linux-m68k.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 18:40:39 +1100 (AEDT)
Finn Thain <fthain@linux-m68k.org> wrote:

> On Tue, 14 Oct 2025, David Laight wrote:
> 
> > On Wed, 08 Oct 2025 09:19:20 +1100
> > Finn Thain <fthain@linux-m68k.org> wrote:
> >   
> > > Discourage assumptions that simply don't hold for all Linux ABIs.
> > > Exceptions to the natural alignment rule for scalar types include
> > > long long on i386 and sh.
> > > ---
> > >  Documentation/core-api/unaligned-memory-access.rst | 7 -------
> > >  1 file changed, 7 deletions(-)
> > > 
> > > diff --git a/Documentation/core-api/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
> > > index 5ceeb80eb539..1390ce2b7291 100644
> > > --- a/Documentation/core-api/unaligned-memory-access.rst
> > > +++ b/Documentation/core-api/unaligned-memory-access.rst
> > > @@ -40,9 +40,6 @@ The rule mentioned above forms what we refer to as natural alignment:
> > >  When accessing N bytes of memory, the base memory address must be evenly
> > >  divisible by N, i.e. addr % N == 0.
> > >  
> > > -When writing code, assume the target architecture has natural alignment
> > > -requirements.  
> > 
> > I think I'd be more explicit, perhaps:
> > Note that not all architectures align 64bit items on 8 byte boundaries or
> > even 32bit items on 4 byte boundaries.
> >   
> 
> That's what the next para is alluding to...
> 
> > > In reality, only a few architectures require natural alignment on all sizes
> > > of memory access. However, we must consider ALL supported architectures; 
> > > writing code that satisfies natural alignment requirements is the easiest way 
> > > to achieve full portability.  
> 
> How about this?
> 
> "In reality, only a few architectures require natural alignment for all 
> sizes of memory access. That is, not all architectures need 64-bit values 
> to be aligned on 8-byte boundaries and 32-bit values on 4-byte boundaries. 
> However, when writing code intended to achieve full portability, we must 
> consider all supported architectures."

There are several separate alignments:
- The alignment the cpu needs, for most x86 instructions this is 1 byte [1].
  Many RISC cpu require 'word' alignment (for some definition of 'word').
  A problematic case is data that crosses page boundaries.
- The alignment the compiler uses for structure members; returned by _Alignof().
  m68k only 16bit aligns 32bit values.
- The 'preferred' alignment returned by __alignof__().
  32bit x86 returns 8 for 64bit types even though the ABI only 4-byte aligns them.
- The 'natural' alignment based on the size of the item.
  I'd guess that 'complex double' (if supported) may only be 8 byte aligned.

What normally matters is the ABI alignment for structure members.
If you mark anything 'packed' the compiler will generate shifts and masks (etc)
to get working code.
Taking the address of an item in a packed structure generates a warning
for very good reason. 

[1] I've fallen foul of gcc deciding to 'vectorise' a loop and then having
it crash because the buffer address was misaligned.
Nasty because the code worked in initial testing and I expected the loop
(32bit adds of a buffer) to work fine even when misaligned.

	David

> 
> > > @@ -103,10 +100,6 @@ Therefore, for standard structure types you can always rely on the compiler
> > >  to pad structures so that accesses to fields are suitably aligned (assuming
> > >  you do not cast the field to a type of different length).
> > >  
> > > -Similarly, you can also rely on the compiler to align variables and function
> > > -parameters to a naturally aligned scheme, based on the size of the type of
> > > -the variable.
> > > -
> > >  At this point, it should be clear that accessing a single byte (u8 or char)
> > >  will never cause an unaligned access, because all memory addresses are evenly
> > >  divisible by one.  
> > 
> >   


