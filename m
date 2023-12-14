Return-Path: <linux-arch+bounces-1035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25581289A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 07:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05ADEB210C9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569EC79E2F;
	Thu, 14 Dec 2023 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JuyBWAu8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07471E8
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 22:53:40 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so895780866b.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 22:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702536818; x=1703141618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NiI/O/Kwj2hTfnkTjsVyBrnrMlgdhxR75QC+suIDMTA=;
        b=JuyBWAu8XDqIvkbPyykWZeiETanDax3fQLjEG8ZS8xvjLWmd2aIkQg3mDI+EaFFxBA
         qXcaEDmyU6bbDHy+l8/jgEjSO44OyDxI1fmqPOa7Id0DMO2axssU3H9+S9HO4Rp1+J7s
         rbdWbcdpPidBcQ/F4oul/p3Vd+3JWywyhHe8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536818; x=1703141618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiI/O/Kwj2hTfnkTjsVyBrnrMlgdhxR75QC+suIDMTA=;
        b=IREvFOMsMqus/pXJ0hkwgufk89X5A55HToQZ390C/Z8TOq2HKjpOGukZvgyCdeHR7q
         eIeMQOKMj+Y2R4zzi3M+2F+gsXjeYBiu1Fj2m0C4QpWZR9Mep40FIVfaiFSPqBoDsSC1
         bl5yBwUGO+Uit3Q3ssdFdTTe57yR6GfNJ+uY2qzG2stBxfJJ2XB1DYFBcbo9c1CsFV6O
         qriXwBkeECQ2d9kp2yfSafcJb4KSrTwvscJytpfClJI+fEP2cmPSXuaZD9fMOmunwHn0
         jMudqnnSAgDWOpim8suT21g8x9AzkMJ3lPOwUbe94H25aGTxh8pVNrJKdnR7WVmkij6R
         gRGg==
X-Gm-Message-State: AOJu0YweikWA4j8CYzaLoJbdW2D5sJZBDCLGv1XSb3elLuhNHzD8faGa
	afVzxr8EZYL9cQZNsFgsW6SgfVT6DppzrmKAB5zG647n
X-Google-Smtp-Source: AGHT+IESIYXSOgIhUTFlrnvCgVUUocFCW+3mticP6osRD4xoJlGq0+yv/zdLb1iwI4GX/NAv1S5d7w==
X-Received: by 2002:a17:907:cb12:b0:a18:b427:c4ba with SMTP id um18-20020a170907cb1200b00a18b427c4bamr3852455ejc.54.1702536818289;
        Wed, 13 Dec 2023 22:53:38 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id d11-20020a170907272b00b00a1e2aa3d094sm9054305ejl.173.2023.12.13.22.53.36
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 22:53:36 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so895779166b.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 22:53:36 -0800 (PST)
X-Received: by 2002:a17:907:6d1d:b0:a1e:eecd:6f88 with SMTP id
 sa29-20020a1709076d1d00b00a1eeecd6f88mr5810857ejc.77.1702536816499; Wed, 13
 Dec 2023 22:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
In-Reply-To: <20231213214632.15047c40@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Dec 2023 22:53:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
Message-ID: <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 18:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tl;dr;  The ring-buffer timestamp requires a 64-bit cmpxchg to keep the
> timestamps in sync (only in the slow paths). I was told that 64-bit cmpxchg
> can be extremely slow on 32-bit architectures. So I created a rb_time_t
> that on 64-bit was a normal local64_t type, and on 32-bit it's represented
> by 3 32-bit words and a counter for synchronization. But this now requires
> three 32-bit cmpxchgs for where one simple 64-bit cmpxchg would do.

It's not that a 64-bit cmpxchg is even slow. It doesn't EXIST AT ALL
on older 32-bit x86 machines.

Which is why we have

    arch/x86/lib/cmpxchg8b_emu.S

which emulates it on machines that don't have the CX8 capability
("CX8" being the x86 capability flag name for the cmpxchg8b
instruction, aka 64-bit cmpxchg).

Which only works because those older 32-bit cpu's also don't do SMP,
so there are no SMP cache coherency issues, only interrupt atomicity
issues.

IOW, the way to do an atomic 64-bit cmpxchg on the affected hardware
is to simply disable interrupts.

In other words - it's not just slow.  It's *really* slow. As in 10x
slower, not "slightly slower".

> We started discussing how much time this is actually saving to be worth the
> complexity, and actually found some hardware to test. One Atom processor.

That atom processor won't actually show the issue. It's much too
recent. So your "test" is actually worthless.

And you probably did this all with a kernel config that had
CONFIG_X86_CMPXCHG64 set anyway, which wouldn't even boot on a i486
machine.

So in fact your test was probably doubly broken, in that not only
didn't you test the slow case, you tested something that wouldn't even
have worked in the environment where the slow case happened.

Now, the real question is if anybody cares about CPUs that don't have
cmpxchg8b support.

IBecause in practice, it's really just old 486-class machines (and a
couple of clone manufacturers who _claimed_ to be Pentium class, but
weren't - there was also some odd thing with Windows breaking if you
had CPUID claiming to support CX8

We dropped support for the original 80386 some time ago. I'd actually
be willing to drop support for ll pre-cmpxchg8b machines, and get rid
of the emulation.

I also suspect that from a perf angle, none of this matters. The
emulation being slow probably is a non-issue, simply because even if
you run on an old i486 machine, you probably won't be doing perf or
tracing on it.

             Linus

