Return-Path: <linux-arch+bounces-4824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBF9037AD
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 11:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4764FB22329
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB45176AD9;
	Tue, 11 Jun 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Din4qqCL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2D175550
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097548; cv=none; b=MnvoG0Xu1cGjZr9m6qw6iu76YGGaaZdeNSJvqpFdyTCru6cqvAf5MJI2xj7sDE/NeExUCuAeJKEW/79X0Rh1IiGHxN5l6cUU56DyJ6v2eohKQN3LLo73Gj8ng21VYmfGd8IOg+bypBzqkLIFdn6q7MOYGZ7KHyqtQnp2XyZ+MmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097548; c=relaxed/simple;
	bh=h9mB6JOkfiuYUHIoFddpH6zwD+eYp90mVVEYcj5srVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3RnpDqr0iC2luK+oJZ7iw0uhOSjsgYlQnl+vlLkSgcTUrmx1PJsJljuoVBpbxElyOZ+6hzOucn+AGqwzrM9Oe7qoHYmvSZXNdBizbfMIvF92JwJxDK7MVpYb5jeCsaW9902E6sAGm3HScCeCG66WRVAQMCT0QD3oKB6/ydfHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Din4qqCL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1c490c13so2844523f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718097544; x=1718702344; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps2N1Am+eO68AysV/PVFcrJRz34VjfFRtWBoGRzfhpw=;
        b=Din4qqCL5ROnGRtf1skv93gsYajaq93yOEJdxyWZ+hTRokCYa2MFffzhqaTBT15rG7
         HeDC07/EUYZLFY1c+8RsED6giKl3xg9rQJKqBYWh9eNtKC7hZxV8DTq29hbqxjxzSWQt
         qVNaXBNDWDYGD2vvc+ZZJDWjMphlOXJy1xh0wT6wE61fCjqY4phszswwC1r3PnZ5F6Id
         xTiEcoAAMZoBteAtLZQh/E5If08EDfRQhUbhjiatrQ8mytk22T+0mxrVQS3DfmGa2JAZ
         9m0y2w5lkfZHaF1dPfaCnxjqD95s23hEjQ3W45VsHmtnnnqJjfdJ59LFFXG1N7uO45aJ
         XgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097544; x=1718702344;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps2N1Am+eO68AysV/PVFcrJRz34VjfFRtWBoGRzfhpw=;
        b=HJByZ71FZ/LQGM55XdUxfJ0cU/ke9BNnVpO4/ULmHyXQplPdYJ7XmxubP7HEamCuN+
         9ZQGLxfPlnl1xpAHrYMdmvue/uv5930gTnoFzc578T3iGfzvIWLGaGjNea4XDuwPzcT8
         PyuBYcevhN0/rV/bPh6W6Xx3kLjrSZwNeiISIzPKEMVY74fH+rFJZjg69B0X3UMYVDQU
         gJ/n10lKDduwbKRbu6xYHoAfbx5s7+upMxhyV/NCoYYcSItjqi2GyfMOzH/DyqResEL7
         nabW6zphGTi+he1Z952Vm74UxHW4v/zsF/hP9p4RiXOKh2LGZM6cLm2BHXzsLJcYo+2q
         mDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ITY1UFtHtTUISZWRZrNXXvERQOZ3B+0XhWPO3v3dN98M83StblFD1+X45wEUr0LoXMQM2FAp43xH6HvYo1HCebIZdYloofUenA==
X-Gm-Message-State: AOJu0Yx7WU35Wd2ZD9lWaMR4v0Yh1EoMjmSJwcnjjBHDkDxWpG3ftBMC
	AqCfTIRUdu1xQGr9z07DOa0YkPVBa6KpAHJKuRsy6+DYiGljmQgOObZLcE/QGw==
X-Google-Smtp-Source: AGHT+IFvw9AoMpMLtxSAEwVADz1EUNN8lzkMo5ne0b71vkTSoYSsb3umTlTGDpHAaueebUmL9Y86JA==
X-Received: by 2002:a5d:634d:0:b0:35f:1d3b:4f7e with SMTP id ffacd0b85a97d-35f1d3b5004mr5003652f8f.26.1718097543845;
        Tue, 11 Jun 2024 02:19:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:7a2:184:b13b:60d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1e20664esm6703606f8f.52.2024.06.11.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:19:03 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:18:57 +0200
From: Marco Elver <elver@google.com>
To: Marco Elver <elver@google.com>
Cc: peterz@infradead.org, alexander.shishkin@linux.intel.com,
	acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
	mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de,
	glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	christian@brauner.io, dvyukov@google.com, jannh@google.com,
	axboe@kernel.dk, mascasa@google.com, pcc@google.com,
	irogers@google.com, oleg@redhat.com, kasan-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add support for synchronous signals on perf
 events
Message-ID: <ZmgWgcf3x-vQYCon@elver.google.com>
References: <20210408103605.1676875-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Apr 08, 2021 at 12:35PM +0200, Marco Elver wrote:
[...]
> Motivation and Example Uses
> ---------------------------
> 
> 1. 	Our immediate motivation is low-overhead sampling-based race
> 	detection for user space [1]. By using perf_event_open() at
> 	process initialization, we can create hardware
> 	breakpoint/watchpoint events that are propagated automatically
> 	to all threads in a process. As far as we are aware, today no
> 	existing kernel facility (such as ptrace) allows us to set up
> 	process-wide watchpoints with minimal overheads (that are
> 	comparable to mprotect() of whole pages).
> 
> 2.	Other low-overhead error detectors that rely on detecting
> 	accesses to certain memory locations or code, process-wide and
> 	also only in a specific set of subtasks or threads.
> 
> [1] https://llvm.org/devmtg/2020-09/slides/Morehouse-GWP-Tsan.pdf
> 
> Other ideas for use-cases we found interesting, but should only
> illustrate the range of potential to further motivate the utility (we're
> sure there are more):
> 
> 3.	Code hot patching without full stop-the-world. Specifically, by
> 	setting a code breakpoint to entry to the patched routine, then
> 	send signals to threads and check that they are not in the
> 	routine, but without stopping them further. If any of the
> 	threads will enter the routine, it will receive SIGTRAP and
> 	pause.
> 
> 4.	Safepoints without mprotect(). Some Java implementations use
> 	"load from a known memory location" as a safepoint. When threads
> 	need to be stopped, the page containing the location is
> 	mprotect()ed and threads get a signal. This could be replaced with
> 	a watchpoint, which does not require a whole page nor DTLB
> 	shootdowns.
> 
> 5.	Threads receiving signals on performance events to
> 	throttle/unthrottle themselves.
> 
> 6.	Tracking data flow globally.

For future reference:

I often wonder what happened to some new kernel feature, and how people
are using it. I'm guessing there must be other users of "synchronous
signals on perf events" somewhere by now (?), but the reason the whole
thing started was because points #1 and #2 above.

Now 3 years later we were able to open source a framework that does #1
and #2 and more: https://github.com/google/gwpsan - "A framework for
low-overhead sampling-based dynamic binary instrumentation, designed for
implementing various bug detectors (also called "sanitizers") suitable
for production uses. GWPSan does not modify the executed code, but
instead performs dynamic analysis from signal handlers."

Documentation is sparse, it's still in development, and probably has
numerous sharp corners right now...

That being said, the code demonstrates how low-overhead "process-wide
synchronous event handling" thanks to perf events can be used to
implement crazier things outside the realm of performance profiling.

Thanks!

-- Marco

