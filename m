Return-Path: <linux-arch+bounces-6674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB8961126
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D011F2447D
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8CF1C6F40;
	Tue, 27 Aug 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mpljrPsr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD91BC9FC;
	Tue, 27 Aug 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771795; cv=none; b=mvpoaZPxx1qkcpXbV4nXf4Xeg3t858fDklJuDTV2EXPve7C/TjfftYSMuvaId+2Q618ACKi0p/B9Y6VjjuUbEX/Pue/rOPhkEzkany3f2YKUvUd2ohYolGyy8TTaYd8oTZy0nKdnOW3BG2wK7T7A8yu77zUKuk19UQfm09kZGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771795; c=relaxed/simple;
	bh=4CERzyJPApKe9b8waHvyPgcYFDtkKGL2bOp9eM0x8OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQ7l4TxrYiwEIqNjXBRvlPHrpNFv2FAcJFZ3xCBiFb2TPN+MDASY0BN++wqg5573iIgJ9UdwiXfh12fv/MEnwOmGF9iEMGr+ad8UTOpjxanERxYzoPaKBazPwTk/h9t/D9Gb1yOquY6zyZWNCdLnwrRRoFWmJc6USCi2ZU5mkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mpljrPsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB70C4DE10;
	Tue, 27 Aug 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mpljrPsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724771791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMqVM/w+phqj82xsm2b1jf2JRlYeXm3YIM84EG1EwNA=;
	b=mpljrPsrXw6rZuijJSW5LPwgN9NOJDOnsPITJxvPEONsjfuVdhgLT7xLmpNkYXhNO/307k
	x9dcn/2jy7xEx75301wmZcJH3MVsjPU/81+A8EUilB/sHTURp7TEGWQgcmh3Ax7K9f6Bi4
	jfLfF134AgkjgATwcO9dQ9ohh4YpVnU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 42417ec2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 15:16:31 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-270420e231aso3718488fac.2;
        Tue, 27 Aug 2024 08:16:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNfnc7mofgYt6mF7eUWrwi3cIMmnO1cXcmbDVvZRtvEnvk5mWfKtiveA8kYD1cgULzGrmgmxeU6lc01RFx@vger.kernel.org, AJvYcCWdGfz5V0+I0vafPxj7DdD+zF7F08gNpkmRzTq9y102ykGmrn0Kp992rKmRHqZ+NXXiIKZNWN9oAjeo08L3@vger.kernel.org, AJvYcCX0fWNoP1ubnyM5oWLz0kVxB662U8VnjBFK8ZALHy2l7u9U6d64fQv+0ZI6iib82Y+oksixl8+hRKVv@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIVPQlr2zVRwmISJ9tXy0w2oBIXne7eFjHcVHjJ5Y41iM5px8
	BSInnwwwI2s1jC0OpFCSpOKRBhPKiROJq55iPpiDRUYdAitdVH8HkZ9yR1sIlEdPxJ5pPN6XBVs
	2KmptKSNdrQqJLKJAu7Yd34m4A8M=
X-Google-Smtp-Source: AGHT+IF/nLZQ5Ljyy7TUacWXpsdnydDu+GGulnItz3FJFKRIJogkvULfxf6RkPyzDRIY4rgZi7DYLIWg7RRZ8G7H2Yc=
X-Received: by 2002:a05:6870:3920:b0:25e:de4:9621 with SMTP id
 586e51a60fabf-27759da2e37mr3635566fac.24.1724771790136; Tue, 27 Aug 2024
 08:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <397f9865-c4ad-44be-91ab-9764fe3aeb89@csgroup.eu> <Zs2UGH6xjJmis5XD@zx2c4.com>
In-Reply-To: <Zs2UGH6xjJmis5XD@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 27 Aug 2024 17:16:16 +0200
X-Gmail-Original-Message-ID: <CAHmME9o35OwD574x2TyAfp=iRfWD95pvi561+Q=2aAWRORofKg@mail.gmail.com>
Message-ID: <CAHmME9o35OwD574x2TyAfp=iRfWD95pvi561+Q=2aAWRORofKg@mail.gmail.com>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:02=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.co=
m> wrote:
>
> On Tue, Aug 27, 2024 at 10:46:21AM +0200, Christophe Leroy wrote:
> > > +/**
> > > + * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without=
 using the stack.
> > > + * @dst_bytes:     Destination buffer to hold @nblocks * 64 bytes of=
 output.
> > > + * @key:   32-byte input key.
> > > + * @counter:       8-byte counter, read on input and updated on retu=
rn.
> > > + * @nblocks:       Number of blocks to generate.
> > > + *
> > > + * Generates a given positive number of blocks of ChaCha20 output wi=
th nonce=3D0, and does not write
> > > + * to any stack or memory outside of the parameters passed to it, in=
 order to mitigate stack data
> > > + * leaking into forked child processes.
> > > + */
> > > +extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 =
*key, u32 *counter, size_t nblocks);
> >
> > For Jason: We all redefine this prototype, should we have it in a
> > central place, or do you expect some architecture to provide some stati=
c
> > inline for it ?
>
> Given the doc comment and such, that would be nice. But I didn't see a
> straight forward way of doing that when I tried before. If you want to
> try and send another fixup commit, that'd be welcomed.

I'll give it a shot.

