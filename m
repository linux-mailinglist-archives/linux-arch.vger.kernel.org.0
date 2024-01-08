Return-Path: <linux-arch+bounces-1299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51452826C35
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D764FB21C24
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F114263;
	Mon,  8 Jan 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ak7pHqML";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESWjcGtI"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381A25757;
	Mon,  8 Jan 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704712141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBr54UrbDBqBWO0Zs3pXK4ySEoD4xvWP17nI7TgZkWs=;
	b=ak7pHqML8qBLZvhs66sx1miPuG8E/Vc45gFM5rts0SeNmjy/TrVg2TZRsuWxspA9FdJYpi
	2z01rYJyCNj+xhB7CNSEDqTPv7p/PLcrRAKOVnl9MAI0bBZNoB4LvUZ5x5eVQcrhBVlj4L
	lWtPd4MWz74du1uf920GgapC3KQogwcwDXlugy58fE/pZt47CUqL/uF4p270H3cVwdjaW1
	MLisYv6TaIkxzCdSf39pS7rpQXqDdDLOkwvs51x+Vqd0YpmQD0g5Rl72BZJvEip5ubO/Xu
	UBh6vKy2niM34+L+sLK5IP+hDbNqGjKQaiHRoEJ1c5EXWqfRqdo4OiSdOzSpKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704712141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBr54UrbDBqBWO0Zs3pXK4ySEoD4xvWP17nI7TgZkWs=;
	b=ESWjcGtI3EVArg1SWAS/o+XnPp8w9CzXgk8/SmWZK+qRnT6dsWhQ6UszStMiCEMnAsMeX8
	GvPxy5pAzYjppACg==
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 luto@kernel.org, datglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 geert@linux-m68k.org, peterz@infradead.org, hannes@cmpxchg.org,
 sohil.mehta@intel.com, rick.p.edgecombe@intel.com, nphamcs@gmail.com,
 palmer@sifive.com, maimon.sagi@gmail.com, keescook@chromium.org,
 legion@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5] posix-timers: add multi_clock_gettime system call
In-Reply-To: <20240102091855.70418-1-maimon.sagi@gmail.com>
References: <20240102091855.70418-1-maimon.sagi@gmail.com>
Date: Mon, 08 Jan 2024 12:09:00 +0100
Message-ID: <875y04kroz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 02 2024 at 11:18, Sagi Maimon wrote:
> Some user space applications need to read some clocks.
> Each read requires moving from user space to kernel space.
> The syscall overhead causes unpredictable delay between N clocks reads
> Removing this delay causes better synchronization between N clocks.

As I explained to you before: This is wishful thinking.

There is absolutely no guarantee that the syscall will yield better
results. It might on average, but that's a useless measure.

You also still fail to explain what this is going to solve and how it's
used.

> Some user space applications need to read some clocks.

Is just not an explanation at all.

Thanks,

        tglx

