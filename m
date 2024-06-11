Return-Path: <linux-arch+bounces-4829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1E2904205
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A39B26D76
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F124CDF9;
	Tue, 11 Jun 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BqBzoNLr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A94D131
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124999; cv=none; b=D9+2Nr2dk8TQ/Gd+mw21IWpDU7/7/ocFmb4tlnlpFsvtucIG2y4wwF402HtpMA8c5QpTl2M9AYKW8VrTFzTBYxGwFMTWgYDL87b+d2mjcukLyJXAeImRFDbfF+blBL4DvONArn8dKbqNizP76sm+dS/gQRPZ2DJkotz5m4QrMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124999; c=relaxed/simple;
	bh=o29lQlHY6pBB5D1miRHhOsA44JWXgR9MvIZMXmk7GOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJCwEkM4eI1SKRbaGbPIo0V8w8gaCeG4cf/D6XrV81PZ+POnl80SuCkS2shYAXeimWaC8sYY8JGS86p34nq7acXEVR/vH+41d0RL0pxbwb+3RLKlugM0+cyoB46lwQJAZnSkBcbJ0jCmNcasWqmoPo1T+/ckrRKn2y0dOS2NzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BqBzoNLr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so1567785a12.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718124996; x=1718729796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9fd3UL80BMA34VQCo8tmKRzc+M7L8fT8pwxngoicvPg=;
        b=BqBzoNLrYCnhI25iIN7djrY1+QjJQpR0FilTB4qA01g8nbNpLBgGEkZzTSfrajbTZw
         jLmcj+P5tgx7yq+wr5nLlN64sHeJhAa6yujkfX3uXirwOo3XRtGO/TasLi2EMtZozr/8
         PsEgAEZ/UMaZoVl/5I7ErUJSa4ENmWsGDs9n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124996; x=1718729796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fd3UL80BMA34VQCo8tmKRzc+M7L8fT8pwxngoicvPg=;
        b=X3WuyLvzyHMEtKea6DRReqHQzx5MseiZZ2DUZWKWGlepeD8GCHQilXas3Rc5dIoI9J
         aqtcAnvOwpaL92dn5WRccve4R+EabLsD3qIXFc2nKal0YeHh351Il079jIOivBCVQloU
         +M+7nH3epDjQGAtTtHYQwtO9DTmpB1EoGnrSuwkXfkS09GVMPXA6keLFuvjP9osC7eU/
         Vs7diPWEh41k87aa5mdjEG9TbeJlu1r++USOt61a60SSk+NDwvJhHCXd8HRK2/cRnN1B
         2sqanqZZx4tGtDtdQAOdu+CjSsRxRNcey6OydGvHZKHjd+zLGR3hraOBe5nEG4ZzFQKv
         hPLw==
X-Forwarded-Encrypted: i=1; AJvYcCXN/5cA7ewYmbset4+PqeTyFUvjSb2Lo+KLWB+rolXq4436kasHEnPbl8waHwyqjuD4Egx+7VBW0Fb+OrgvxPCUHJVvJlfXSB7hYQ==
X-Gm-Message-State: AOJu0Yx77kxISaB/cPfEZSo18Wtpy1R3rAJLh3lkahVTj22w1VKGRiJq
	sXfSPRRobvmrMe82AU72m1Mpzjq2bG3ucb2Q08WUpAB6yiCqARj6OHeVvR3JOdwGzycvuBMhL56
	nCgM=
X-Google-Smtp-Source: AGHT+IHIqTMzxXnSkzc2gf3zghDyKTbJ1H3ZJTJbdhJUagrCe3z+/7CFhYRytJkrF2Y8xCGveE+4Mw==
X-Received: by 2002:a50:9eef:0:b0:578:56e1:7ba3 with SMTP id 4fb4d7f45d1cf-57c509a5fb8mr7787214a12.38.1718124996166;
        Tue, 11 Jun 2024 09:56:36 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7fcfc67fsm4515924a12.31.2024.06.11.09.56.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 09:56:34 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d48ec3so137660266b.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 09:56:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfw1ct86G3Prvb2BphFARhj9m8Hz7OALWAq9llBFFkvER1qjU5905RzeWI9i+SzAhpn4pARiAXpI5CM1JIYBHTHLIS/VSnJ4eCSg==
X-Received: by 2002:a17:907:72d3:b0:a6f:1f4a:dfba with SMTP id
 a640c23a62f3a-a6f1f4ae1eamr427237266b.43.1718124993806; Tue, 11 Jun 2024
 09:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
In-Reply-To: <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 09:56:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
Message-ID: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 07:29, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Do we expect to use this more widely? If this only really matters for
> d_hash() it might be better to handle this via the alternatives
> framework with callbacks and avoid the need for new infrastructure.

Hmm. The notion of a callback for alternatives is intriguing and would
be very generic, but we don't have anything like that right now.

Is anybody willing to implement something like that? Because while I
like the idea, it sounds like a much bigger change.

> As-is this will break BE kernels [...]

I had forgotten about that horror. BE in this day and age is insane,
but it's easy enough to fix as per your comments. Will do.

> We have some helpers for instruction manipulation, and we can use
> aarch64_insn_encode_immediate() here, e.g.
>
> #include <asm/insn.h>
>
> static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
> {
>         u32 insn = le32_to_cpu(*p);
>         insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, val);
>         *p = cpu_to_le32(insn);
> }

Ugh. I did that, and then noticed that it makes the generated code
about ten times bigger.

That interface looks positively broken.

There is absolutely nobody who actually wants a dynamic argument, so
it would have made both the callers and the implementation *much*
simpler had the "AARCH64_INSN_IMM_16" been encoded in the function
name the way I did it for my instruction rewriting.

It would have made the use of it simpler, it would have avoided all
the "switch (type)" garbage, and it would have made it all generate
much better code.

So I did that change you suggested, and then undid it again.

Because that whole aarch64_insn_encode_immediate() thing is an
abomination, and should be burned at the stake.  It's misdesigned in
the *worst* possible way.

And no, this code isn't performance-critical, but I have some taste,
and the code I write will not be using that garbage.

> This is missing the necessary cache maintenance and context
> synchronization event.

Will do.

                 Linus

