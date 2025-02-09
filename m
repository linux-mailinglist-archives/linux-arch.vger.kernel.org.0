Return-Path: <linux-arch+bounces-10067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A9AA2E0E3
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 22:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B267A2942
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30A1E283C;
	Sun,  9 Feb 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7x9TxFY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD31DF25E;
	Sun,  9 Feb 2025 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739137253; cv=none; b=ngw6kcWZaeIB2P2+iDgq6HfGepN9EbDeDeulKMyY+PZKUkDMk6LLcdkswpymybxzajLPwwAoaV4qKZEUAS2v50y/NBwCOZZI4aj3CAkiMcA7zR3diTEq5YC1VcZRz0HvBmOs4yBE8l37iVA1d0U7lkTYOk1CAdKDYKEuo0vCtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739137253; c=relaxed/simple;
	bh=Ziv+M3+50z5eMM14eZX0Oixu3FyWuNm2XqHRVSZ5PAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmYH3eTo6QyKOmqFQuFt7CNKdQqfV0RwgBIh4d4PQ7lVg3BFIu6713XZjbGXuI0CzBkGxk963xCCKPGXNFvcce1e/HJGDw6/UAi8LMBDJCv3EqOtV6BSj5bTP/eveznD5CBELb17Nz04CEtJVcQbmoHJ1JNH58A7xzEcvdbXlrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7x9TxFY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394036c0efso2714785e9.2;
        Sun, 09 Feb 2025 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739137250; x=1739742050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vHmVTfsnRz1JF9lpJrmG696etUTSYNASGKo7x++LBE=;
        b=c7x9TxFY/YtdPTUK6K7gXgSxyh46EgD/eL63m0S/9rFiR2oDKKYLlRPs3lmXHe0wEU
         rwLAKosIw8YLIRXZiUGWiydg+ueW8WnFaLk0f9PvOq8olNc/CrmmCCeAgG2YoMWH2X4I
         adcpxU3EXAl6JTV/57/K6QjWanl3Ly6J7D5dfISaQ6dMyrMqv2d8YKtEKmCNfdJceQEM
         J+sT0dZwVeL5nSxqpKE9QqB71ZY/Hws5njlx0YPk4iytSe649g2pfZ6l+IxW0sr45ors
         3dOPg3OQpx6ySqha3dpxNN3T/5e/HgFq44Uc1sfQ9tT51RNwrKdBbEgN7uYGJKbNOwen
         eEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739137250; x=1739742050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vHmVTfsnRz1JF9lpJrmG696etUTSYNASGKo7x++LBE=;
        b=FOa3p67V+mgadTb+GRYq9fHv0IiLUTD+BbPdhn3UVVg/23wZX//uEoBYtCwP1AxFoj
         Xtt6tFcT+uzmNTBFDUGqZ71647u03Mo1586WHe5jJQg9/3fkDgywBzwyVGM7bRPfryu0
         lmIe1kG5DPGsON0faMVyKnzklPQSWhYb+HyZIL5IGiXksEizM8TExHhG1tcLMjeQT2Ba
         JIyevy32gmD3dXOVWE8HrU8ffV8OG9Erm8jWdjLM5ZEl9/OPcJBLSo8mzlAPQzen1T1G
         AY5zFBJYg5LfCVqvQMHVGgjw/m9LArr79UdDk6PAWUx0ZLVk0Q+LGq94Bh16OLa7FRBo
         Rlhw==
X-Forwarded-Encrypted: i=1; AJvYcCVRs7OiNhmxrAOTblEGVIHzLZENqXctoux0+XJHkRV6WH24jv2DiPiJDASqnuSMN7ynr+225365TDlJ@vger.kernel.org, AJvYcCW+lKuonkcRBVjIJaHw58Jb9efWw0BgiUhwzM9NfSF7tTCZ28v11wGFV/3h2mh69FGzStzw4sEQS0XaUUtp@vger.kernel.org
X-Gm-Message-State: AOJu0YzPS683saBjufxHsjQ7X/jDlXoE9i/LuGgYgZnxr9KmuUeU22kK
	ZRYNX26hua6hby0qHz/ZluAL0Nx52SbAamoezRou7v8TsKTeQG+2
X-Gm-Gg: ASbGncvqz7pIFuK57CxqxRsU1wljY5UaOC8I8qe81kZv87LSEuZQ7xIWM8DOjQcFGlr
	1mLRLFqk2I2v9YfZ6ET/B5eCeUZvOjngImzNbRg7S2K1Xhm4IcuZ1qXdfAXvfghhitJW+yrYE7k
	NXVEnCNxKSuuW4cRFCq3WLez4gMkJUL+elGAOkqwnbx4+3xPwW88Fj15d7ZmZqjJrB//5eI6p5D
	YAOABUC/uUpHCpPFJRyl8nyNfvViUU6JA6AvoAy3/8qDiFTlMl9dV91/hg/1DlURizDZdcBBbXS
	Vau69hhTKjNp0V+W/IXpLhIgnctRZXD+Jr+0rxE4bzLMNnP2L1ZNbg==
X-Google-Smtp-Source: AGHT+IFSxBwa9KnAS8L9/EAz8cLmuKb/l0d8yDFFaz3zOamCgdFD5cNHDH4gBGKhfk0z5d3IqpoPdw==
X-Received: by 2002:a05:600c:34c2:b0:439:3ba0:d564 with SMTP id 5b1f17b1804b1-4393ba0d6f4mr32217185e9.6.1739137249560;
        Sun, 09 Feb 2025 13:40:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db10b2fsm158834885e9.33.2025.02.09.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 13:40:48 -0800 (PST)
Date: Sun, 9 Feb 2025 21:40:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Andi Kleen <ak@linux.intel.com>, Dan Williams
 <dan.j.williams@intel.com>, linux-arch@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/1] x86: In x86-64 barrier_nospec can always be lfence
Message-ID: <20250209214047.4552e806@pumpkin>
In-Reply-To: <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com>
References: <20250209191008.142153-1-david.laight.linux@gmail.com>
	<CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 11:32:32 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 9 Feb 2025 at 11:10, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > +#define barrier_nospec() __rmb()  
> 
> This is one of those "it happens to work, but it's wrong" things.
> 
> Just make it explicit that it's "lfence" in the current implementation.

Easily done.

Any idea what the one used to synchronise rdtsc should be?
'lfence' is the right instruction (give or take), but it isn't
a speculation issue.
It really is 'wait for all memory accesses to finish' to give
a sensible(ish) answer for cycle timing.
And on old cpu you want nothing - not a locked memory access.

> 
> Is __rmb() also an lfence? Yes. And that's actually very confusing too
> too. Because on x86, a regular read barrier is a no-op, and the "main"
> rmb definition is actually this:
> 
>   #define __dma_rmb()     barrier()
>   #define __smp_rmb()     dma_rmb()
> 
> so that it's only a compiler barrier.

I couldn't work out why __smp_mb() is so much stronger than the rmb()
and wmb() forms - I presume the is history there I wasn't looking for.

> And yes, __rmb() exists as the architecture-specific helper for "I
> need to synchronize with unordered IO accesses" and is purely about
> driver IO.

I'd missed the history of it being IO related.

...
> And some day in the future, maybe even that implementation equivalence
> ends up going away again, and we end up with new barrier instructions
> that depend on new CPU capabilities (or fake software capabilities:
> kernel bootup flags that say "don't bother with the nospec
> barriers").

Actually there is already the cpu flag to treat addresses with the top
bit set as 'supervisor' in the initial address decode - rather that
checking the page table in parallel with the d-cache accesses.
When that hits real silicon then patching out the barrier_nospec()
lfence would make sense.
There is also your kernel build machine where you don't care.
So compiling them out or boot patching them out is a real option.

This does make it more clear that the rdtsc code has the wrong barrier.

> So please keep the __rmb() and the barrier_nospec() separate, don't
> tie them together. They just have *soo* many differences, both
> conceptual and practical.

A simple V2 :-)

	David

> 
>              Linus


