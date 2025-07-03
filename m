Return-Path: <linux-arch+bounces-12562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D8AF8260
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 22:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EA7A3237
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02F2BE7B5;
	Thu,  3 Jul 2025 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IyCeoJk4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976D29C327
	for <linux-arch@vger.kernel.org>; Thu,  3 Jul 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751576322; cv=none; b=fJijM3KFkhQtzs32DOV6OgHZIZ1/qK5pQlFe0Jf0e/G7vU1AEhb9WdkoJpfIjaKsZ8Bsr5gyp8Ahgv2cqV39se5/i8KFQnLi7ie4MDCrwfxAxXDtJUWObPnXkYOqEsiC1dYuoMJ+eKlJXte7ZZmkiZ0fgqVu/5/vDxd7xZSMUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751576322; c=relaxed/simple;
	bh=DiJjAsxd3NLx6OvlELv3sKg3BSU/dtVOQuiuh5Nz4Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XropNRVUZk/sFes9id4wFjPv7MRFPEfN8LpvaeN5/jDLTVjzFduK+xiJUHG5PTruKrbgDEAJrL54FBffsoSJAWtIU9svO7FngR0pLeulEFI0VFr8sgoBvmAFMQoQ1jlJ35RCsE4VFen+72/Xdy444wxO0Rw2nzpXBKuu8QesqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IyCeoJk4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so442635a12.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Jul 2025 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751576316; x=1752181116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XpibsVHxYqxJwhE/Mgkya5GxIWQIBQtSRQMl/dLvVIY=;
        b=IyCeoJk4RZ7ZFRwYoMeTQW/zLt6ucMXdxNddFuRSEqsJMxDZzbwpXabyz3slZ5s33j
         QGezxINlIaPST69MEUOA3fJJPSm9Z1jkTKpZWe141vYiqJOpLOBQrJNJuskQfng0pQG3
         YxQSBqyFQ/7zBH6sSiVUgbs/dZpVFrxwNbBuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751576316; x=1752181116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpibsVHxYqxJwhE/Mgkya5GxIWQIBQtSRQMl/dLvVIY=;
        b=Ep1Mz/0igjuqX5/+PRYEIn8GxtWG1jSFhlH0MDI6CEc3Qm65ApgiAfJMTrBIrGVGKT
         2aInMVN3JsZTmlNTdkz/qs1V8y3UZDB3YQt4YzOoHdf9wRwzBeOP0GK5kClkZiHDnkcH
         QCqonFQf9N908JmypYIM5JC0pS1F2YORVo+aZNIMz+PMVcG/o0iltn9bSErHJFj5G2G+
         8Q7Aj7hkGKO0fy7T7j4e3jBe1+v0l29nqUpOHXO7vP8HaRlSYohvwrBgr6nUOV3bebO9
         SOQEEKwnAzODVcPYI1s2ynJVXVkvdk+wLyhZOV02cDNc2jevBg2xDBAPpIy+An3X55UM
         B6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/w4U+sf7Y3DNgpxifxSP/VhjVquV94qYgWJ4aiVv1zRDvomZ8CZTb4/sgUvQ7FiwvButgwK1wA0Vo@vger.kernel.org
X-Gm-Message-State: AOJu0YyjD7EKsQtMs+gRAojQT4ja/yF49LnWznMzWs6lGaUzFhQU3YdL
	Br3XfdZd7arXag61le2UScFe5jPgz85/zdIverp/5pdBZW7u5DVsMkPrxmOKYnPU7xqsYJJksUc
	kOVFb4Kc=
X-Gm-Gg: ASbGncsaS9Lf9/2PKlk7tjxc2VbJAuxAx9JTyMISamBEl5YhPq8yXKIImWo4syfLDc1
	lK9O/AkyV1TtbhYX3OHRnLVMgqDzaEcfyn5BJo8/Ees3fSKW/tdY8ryqP6657R9AWEQ3Qz8oBD+
	zhXX+eUJgyIMw070/a7oCVj1/9Bw1bXIuuY863dekxnnPayv7SmZ0vcFWIpNNy88eSyHaBC49T0
	mUA4klsomEtAEz+PKDbSRQE1VzebDb80IjE5PPDnB+q/JevI11YWt25rVNhKKs8YCMkWIZe+Z7H
	Dy+Swqxqv4fe02NDFbNnulfh4h2nf5w7M/MXC1aVMAh9HKP5Rkj2DIpgw+/C79nsjy/gyg/Uu+c
	brjUJ/VUD4WvG7bAGxbgHBnbvsyqxo7NtZNBI
X-Google-Smtp-Source: AGHT+IEjLMd5TofG7udzjrU+ZOvFtCPidYn7n3rkUgTIJ7IL9P5MEzQLemo1nLQhZqsAlSs8PHQnHg==
X-Received: by 2002:a05:6402:26c4:b0:606:eb8e:d975 with SMTP id 4fb4d7f45d1cf-60fd1f94dfbmr82074a12.0.1751576316344;
        Thu, 03 Jul 2025 13:58:36 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c80c4sm271173a12.75.2025.07.03.13.58.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 13:58:35 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so526854a12.0
        for <linux-arch@vger.kernel.org>; Thu, 03 Jul 2025 13:58:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6lEHyKs8shQn2JifFcl+oYjvoz/uCBYdkj5CQgPKF9+zuzzR7XVkaLt+2KrEQx9P6r11ukN4l60YQ@vger.kernel.org
X-Received: by 2002:a05:6402:d0b:b0:607:f257:ad1e with SMTP id
 4fb4d7f45d1cf-60fd33621b5mr42848a12.22.1751576313551; Thu, 03 Jul 2025
 13:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703115222.2d7c8cd5@batman.local.home> <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
 <20250703152643.0a4a45fe@gandalf.local.home>
In-Reply-To: <20250703152643.0a4a45fe@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Jul 2025 13:58:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdM_A1iWs6=y__nDcVq9pZRynd1mO8F9XnAeZuHumHtA@mail.gmail.com>
X-Gm-Features: Ac12FXwYVzSrl3kui7aMRaxe8iQweZ7A051wIMsfyQxmbAoaWneINGskzeXmSE4
Message-ID: <CAHk-=wgdM_A1iWs6=y__nDcVq9pZRynd1mO8F9XnAeZuHumHtA@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

" part

On Thu, 3 Jul 2025 at 12:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I always thought the "HAVE_" configs was a way for architectures to state
> that it supports something but doesn't necessarily enable it. Whereas the
> not "HAVE_" configs are user selectable.

I don't actually think we have those kinds of rules in practice.

We have very random Kconfig things. A lot of things are "architecture
just selects the feature directly", and the naming is a random
collection of ARCH_HAS_abc, ARCH_USE_abc, ARCH_WANT_abc, HAVE_ARCH_abc
and HAVE_abc.

And those are the patterns that _try_ to be some kind of pattern, and
ignores all the "architecture just selects the feature directly".

Honestly, when we have *five* different syntaxes for "this
architecture supports feature 'abc'", I'd argue that not only isn't
there a standard way, all those different syntax forms are just
confusing.

I get the strong feeling that the reason people have those different
prefixes is literally to just group things together alphabetically -
ie some people use "ARCH_HAS_xyz" just because that way they can put
the "select" statement next to another ARCH_HAS_xyz that they also
maintain.

And then in addition to those various "arch has", we have the
"GENERIC_xyz" Kconfig entries that architectures also select.

I think those GENERIC_xyz Kconfig options may actually have more of a
pattern: that _tends_ to be about "I'm not implementing my own
version, please just pick the generic version". That one is one of our
better patterns, I think.

So the reason I dislike the HAVE_xyz pattern is exactly that there
_isn't_ a pattern. When there are fifteen different patterns, it's not
a pattern at all.

That said, maybe it's better to have one place that has that "if
FUNCTION_TRACER, even if I despise the nonsensical "helper
indirection" just because of the random naming.

              Linus

