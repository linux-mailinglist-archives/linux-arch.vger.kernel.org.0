Return-Path: <linux-arch+bounces-14354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BDC0D164
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81C0A4EFB5D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48C2F8BF3;
	Mon, 27 Oct 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jiKtU/t8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oyunfvfG"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD82F6922;
	Mon, 27 Oct 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563625; cv=none; b=Wdv3YW5s6bPCVBJ9mBqqAcEiyCQhqUyiE8hQ9h15k4kDVN8+K20BwC+DSuGes1cNdxxlE5Hctm59/GkHWLf4TvHRTAQcz+noZUmfF2pEtXi2D+EpEuJm3AAgiWG0BlYOisN3YU1zStjMdBmkaznLU1p4nOHJ10CaAOQTt+kkNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563625; c=relaxed/simple;
	bh=FhhQPvunzfcAyhud3BpIQ309f7xmsZV9cvG1cStKtLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHGn4IbCMs/TayR8U6MGTfxaeSrooTfkmqZuhYhjau7umVv0I1px6nxehzOGtP4LRhOsomB/k3vkHhL1r5oHWWxoEOBQrcvdv6cuqV1c/fCwASH6l5iPGYzDWYBsFhoJpD63i7jbHDhIb3s910dUxb07PUgBCAJDWpLYxsRs42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jiKtU/t8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oyunfvfG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761563622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF5pR6mAV2eKqF+f57TFnDHZIaIt2BA9q6wphVxl95k=;
	b=jiKtU/t8uxjSazvE0LebnlpDYwQA3zzEa/zc7XSwYxC3rLCxjCYi1LzqusW5+mLIiKMGWS
	yJffPO5Xe8XuvuKwHbq90kRTOMJ/JAXNOMC/cNirvOjrCykHZK4VJ67hClhDow3CsXRQTb
	cD+qP1COvbSilmAlniKO9Ohg6389s4YQ2BkOl1yCsKR1NPczrtvLwVV/JSY4Z6ABvtQrZ8
	qMav+qsZmGBR9ZKqPcelCDI6ilpVS2eM0NzqTxGb4TkWMcnRaoUo8ZgPhVLqxzRcZb07AR
	FE7ZNOIj1gEF9FF0LPJ9+EYT58N6X16zRGRP3i10Dbnv6CtcCd40vcUU9H/J3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761563622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF5pR6mAV2eKqF+f57TFnDHZIaIt2BA9q6wphVxl95k=;
	b=oyunfvfGwNTU7k3Tw4WoGeY8KJ7ZpzQ9FjMPFUltyF/nu3HXLRofIlfh0Zxo5JsBqLI5DT
	N++qvzkdEdfsm8Cw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zilstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V2 01/12] sched: Provide and use set_need_resched_current()
In-Reply-To: <20251027085910.zpFdjX8e@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121426.964563578@linutronix.de>
 <20251027085910.zpFdjX8e@linutronix.de>
Date: Mon, 27 Oct 2025 12:13:41 +0100
Message-ID: <87frb4wqai.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 27 2025 at 09:59, Sebastian Andrzej Siewior wrote:
> On 2025-10-22 14:57:29 [+0200], Thomas Gleixner wrote:
>> set_tsk_need_resched(current) requires set_preempt_need_resched(current) to
>> work correctly outside of the scheduler.
>> 
>> Provide set_need_resched_current() which wraps this correctly and replace
>> all the open coded instances.
>> 
>> Signed-off-by: Peter Zilstra <peterz@infradead.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Peter's SOB comes first be he is not the author. Is this meant to be
> Co-developed-by or is his authorship lost?

Bah. I dropped the From: line accidentally

