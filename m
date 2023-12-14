Return-Path: <linux-arch+bounces-1055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2E813AEC
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF54F1F21A63
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6878D6979D;
	Thu, 14 Dec 2023 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T5cRHmky"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F00697A2
	for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so11132448a12.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702583114; x=1703187914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MpUjOoTdCqNzayaiwbixMLyZUnTZjhFDCaA6n5v3lDM=;
        b=T5cRHmkyC1XeP1ByTEbxUxOR7s6Iy7cYdIniNLwsjt7ikJ3h5wWxdHeXZTFssUASur
         FWgTX9GPLeeaLHOpsnNjVBqqOQsZLLAqAyOHn3RjBFr/+mMTC+Wl7ltvmIE0swwofVRe
         0gdUzC7arOg7g/Z8a2y3OuKMlk0wNmlIYCX9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583114; x=1703187914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpUjOoTdCqNzayaiwbixMLyZUnTZjhFDCaA6n5v3lDM=;
        b=ZiNVIR9lu1rHnVt3imXIsPWwLeYDBx86r2LEeH5WLjMXRlObJuutBAJl3tHvhyGPM+
         uI0Klq0fyy7GV4eovw2e4m94iWFk3B0WpDA96PGDiggQle5gJzu6TuQj39qHbZ+CSWKG
         smw+M/f4s4qyoyrB21FJHzPnGql+HZmZbcMofisHSBTf0zqSWuBv/X+RO2ZgpT6XZLtM
         CrLSTltg4EqeyecJbeGvNx/S5EWunnwQWCI+/itkcywC76mF8NBawybLX3eCbYZDcqFF
         pWq23JwGHJcFvrJiTcPsUO30EhPN3JqdzU2p8lsj5KJWsyZiNsuACdTyUwT5YhfUETHv
         4v1A==
X-Gm-Message-State: AOJu0Ywe84m7C9Nl5yN0opaPYbmBzd6oq3gN8XtZZlJVxNVcMg9PIFWv
	XTRDQUkHGoQdI3AjGzhmx96jSlgEy8p722U4unUSuQ==
X-Google-Smtp-Source: AGHT+IFdeepiamORK8+rHYde+APC7Y5omw30EX1l/TXEjBEpxghdv6hUL165EQ9cl43SYxRczn07NA==
X-Received: by 2002:a50:cdd7:0:b0:551:e2a7:8895 with SMTP id h23-20020a50cdd7000000b00551e2a78895mr1028511edj.158.1702583113842;
        Thu, 14 Dec 2023 11:45:13 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id c27-20020a50d65b000000b0054c9bbd07e7sm7337265edj.54.2023.12.14.11.45.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:45:12 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso956093666b.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 11:45:12 -0800 (PST)
X-Received: by 2002:a17:907:3ac2:b0:a19:d40a:d21f with SMTP id
 fi2-20020a1709073ac200b00a19d40ad21fmr2222801ejc.235.1702583112429; Thu, 14
 Dec 2023 11:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
 <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com> <20231214115614.2cf5a40e@gandalf.local.home>
In-Reply-To: <20231214115614.2cf5a40e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 11:44:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
Message-ID: <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 08:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> And yes, this does get called in NMI context.

Not on an i486-class machine they won't. You don't have a local apic
on those, and they won't have any NMI sources under our control (ie
NMI does exist, but we're talking purely legacy NMI for "motherboard
problems" like RAM parity errors etc)

> I had a patch that added:
>
> +       /* ring buffer does cmpxchg, make sure it is safe in NMI context */
> +       if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
> +           (unlikely(in_nmi()))) {
> +               return NULL;
> +       }

CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG doesn't work on x86 in this context,
because the issue is that yes, there's a safe 'cmpxchg', but that's
not what you want.

You want the save cmpxchg64, which is an entirely different beast.

And honestly, I don't think that NMI_SAFE_CMPXCHG covers the
double-word case anywhere else either, except purely by luck.

In mm/slab.c, we also use a double-wide cmpxchg, and there the rule
has literally been that it's conditional on

 (a) system_has_cmpxchg64() existing as a macro

 (b) using that macro to then gate - at runtime - whether it actually
works or not

I think - but didn't check - that we essentially only enable the
two-word case on x86 as a result, and fall back to the slow case on
all other architectures - and on the i486 case.

That said, other architectures *do* have a working double-word
cmpxchg, but I wouldn't guarantee it. For example, 32-bit arm does
have one using ldrexd/strexd, but that only exists on arm v6+.

And guess what? You'll silently get a "disable interrupts, do it as a
non-atomic load-store" on arm too for that case. And again, pre-v6 arm
is about as relevant as i486 is, but my point is, that double-word
cmpxchg you rely on simply DOES NOT EXIST on 32-bit platforms except
under special circumstances.

So this isn't a "x86 is the odd man out". This is literally generic.

> Now back to my original question. Are you OK with me sending this to you
> now, or should I send you just the subtle fixes to the 32-bit rb_time_*
> code and keep this patch for the merge window?

I'm absolutely not taking some untested random "let's do 64-bit
cmpxchg that we know is broken on 32-bit using broken conditionals"
shit.

What *would* work is that slab approach, which is essentially

  #ifndef system_has_cmpxchg64
      #define system_has_cmpxchg64() false
  #endif

        ...
        if (!system_has_cmpxchg64())
                return error or slow case

        do_64bit_cmpxchg_case();

(although the slub case is much more indirect, and uses a
__CMPXCHG_DOUBLE flag that only gets set when that define exists etc).

But that would literally cut off support for all non-x86 32-bit architectures.

So no. You need to forget about the whole "do a 64-bit cmpxchg on
32-bit architectures" as being some kind of solution in the short
term.

               Linus

