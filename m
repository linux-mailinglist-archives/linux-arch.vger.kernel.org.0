Return-Path: <linux-arch+bounces-1064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF7813C0A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DAAB21CFE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E56A35A;
	Thu, 14 Dec 2023 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FfoMFynM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48E2BCF6
	for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso2111434a12.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702587047; x=1703191847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70Y7o3IdU9xF6jWzjwutAl8ZEw5YbkckBXgTZi3FBa0=;
        b=FfoMFynMFOxD2ydWLHwg2k1Vn5PZ898lYI5PZoP+z020RE1SNUzT2jwNvaAYIjYpnd
         hdGSfSgrIST54KTK1rCQkphZHpqHL9nTq9eIjW/6Q/T/ySagqKXX5dXMp2bKl1aFpSO8
         YblI4YcHcxpx0A2t9ioMk71y+T7KKeKo19aHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587047; x=1703191847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70Y7o3IdU9xF6jWzjwutAl8ZEw5YbkckBXgTZi3FBa0=;
        b=obCW0a4CPwxkVapGkurA885+eIbULzrSD6MqeW84I7SuBupejFieWlDiIA2x3fNMqA
         NU4y/xIM2O/VUahAy05nEOmtdBbQQuhnRONxL82OnSdi5qmNdK7rWXToZuMC5CeozO08
         FVcTcuhgtcXSqpP3MOsxwCkJW6ZToQlUKM5uRq82Ane3w1n1KYvG8VyZA2zkHnJZNtEe
         HYkxhGshArx6v1f5n+Vet/vVBhH7UVL0hPnYaGOf17jf+MkxukZMfeUBXgZq1Tn8cZwR
         vC8tlQTJtwlQ7jApc0lpMu2E112b46VcPXMvd+tOynGSdktLyCVtJDTcqRVq+Wg/pP2b
         8WqQ==
X-Gm-Message-State: AOJu0Yy2Ws2FtP9Yuyt+SbkqHgbDAmVFr3hbEMiLEHziCCFrfgTRP2Yz
	uuGlgJ2ePqUnFSnXxWCCX7mYpt34OyxW5I6R2o1uwNHB
X-Google-Smtp-Source: AGHT+IFbv7ucBRLXIIPuJbiCV/co07OW6rxrskzvU6X4sEfCq3tdPU8jVEWJfcmXxC4kJvAO2+oxhw==
X-Received: by 2002:a50:d798:0:b0:552:3358:f637 with SMTP id w24-20020a50d798000000b005523358f637mr3011669edi.37.1702587047446;
        Thu, 14 Dec 2023 12:50:47 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b0054cb316499dsm7035314edi.10.2023.12.14.12.50.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:50:47 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so2085824a12.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 12:50:47 -0800 (PST)
X-Received: by 2002:a17:906:608e:b0:a04:e1e7:d14c with SMTP id
 t14-20020a170906608e00b00a04e1e7d14cmr11442076ejj.32.1702587046729; Thu, 14
 Dec 2023 12:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
 <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
 <20231214115614.2cf5a40e@gandalf.local.home> <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
 <20231214153636.655e18ce@gandalf.local.home>
In-Reply-To: <20231214153636.655e18ce@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:50:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Message-ID: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 14 Dec 2023 11:44:55 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Thu, 14 Dec 2023 at 08:55, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > And yes, this does get called in NMI context.
> >
> > Not on an i486-class machine they won't. You don't have a local apic
> > on those, and they won't have any NMI sources under our control (ie
> > NMI does exist, but we're talking purely legacy NMI for "motherboard
> > problems" like RAM parity errors etc)
>
> Ah, so we should not worry about being in NMI context without a 64bit cmpxchg?

.. on x86.

Elsewhere, who knows?

It is *probably* true in most situations. '32-bit' => 'legacy' =>
'less likely to have fancy profiling / irq setups'.

But I really don't know.

> > So no. You need to forget about the whole "do a 64-bit cmpxchg on
> > 32-bit architectures" as being some kind of solution in the short
> > term.
>
> But do all archs have an implementation of cmpxchg64, even if it requires
> disabling interrupts? If not, then I definitely cannot remove this code.

We have a generic header file, so anybody who uses that would get the
fallback version, ie

arch_cmpxchg64 -> generic_cmpxchg64_local -> __generic_cmpxchg64_local

which does that irq disabling thing.

But no, not everybody is guaranteed to use that fallback. From a quick
look, ARC, hexagon and CSky don't do this, for example.

And then I got bored and stopped looking.

My guess is that *most* 32-bit architectures do not have a 64-bit
cmpxchg - not even the irq-safe one.

For the UP case you can do your own, of course.

            Linus

