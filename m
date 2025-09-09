Return-Path: <linux-arch+bounces-13452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491FB4FA85
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EFE1C26855
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351D5321F40;
	Tue,  9 Sep 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5yzCWuk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SP6bx5Cm"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC93314AD;
	Tue,  9 Sep 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420338; cv=none; b=i0t1Tml4zUIrXpLWZkzeH6l7roR+ilXdqPl4JGRJ5KYQKskbaklwzhUH9vFZkp0n2e9Ia/MOquVYqv0A0eSSUcg4XtI7X02Nf5xNr2P3FuApm16kkkbu4yiiGtZgbkn2J05/7AMjr0+wHBuXBxo62Pa9t4pCOQssvU0WN93rago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420338; c=relaxed/simple;
	bh=HTqvjQ/oVYKvz6ilnyLZHRCvRZIkG9HmG1PJYU5Umfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0p1fo5ne5bqc/TPxMAnQeDzbWdw0K2Sn1BRgyUCUCsyTjhivfvzgRxN7M41PXaV6USk+jeQB0SqH6heW9eLtnR8+2SerzGsuD93tfBKdazqYiwIMwPOFOTtkE7h67sWNsInL5l3POJxJ5alpwTRxha0Y1ek8kVm+/T3dsEfMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5yzCWuk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SP6bx5Cm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757420334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ev+FVEcj3joLVHvg0emrOdxTz+Twd4BERFs1IwE/SmU=;
	b=B5yzCWukx1PMJpi3tQVwAq1pV9tsx+4OT75yWgEwGYv1jyfgJOCHX8VpMYzLq3CyUZMqun
	G8Clo0nRPTJGDtwR1f/yv2/qSoIh3uinFMjHufGc+uvMD+76VpN51z73uQqd0yZMbcAIov
	2SXxZbSFpuJBLS1Je9G2pLnoYIXOezmHtG+EaGAiGBvn4fAFhBO9F9VmMjTIYoba5Jv/9N
	nS4YPMlbCHP1L9MT/stlYS89gQ0B4hjyuYe5e9ynkvlZmQnYrP1sjNWKawxB4j0y89g1mw
	TCFXjunPsQj5T0GTT+Od+nQbV9tiY4B4VQovxtu7hskJVjVLmLJY43j679wpew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757420334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ev+FVEcj3joLVHvg0emrOdxTz+Twd4BERFs1IwE/SmU=;
	b=SP6bx5CmUDfNfbsVS6hMc0+ZM8WVMbw8iZCCjrdg22Nc+eCxACnxpQHJLLo7VWinTPghwt
	11urCJ6vFt1kvKBw==
To: Randy Dunlap <rdunlap@infradead.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch 03/12] rseq: Provide static branch for time slice
 extensions
In-Reply-To: <94f08403-31f5-43ee-871d-5e0ebcfd3b6c@infradead.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.744169647@linutronix.de>
 <0f28cc54-1f84-4f28-bd61-ee9e0b9d0d0c@amd.com>
 <94f08403-31f5-43ee-871d-5e0ebcfd3b6c@infradead.org>
Date: Tue, 09 Sep 2025 14:12:29 +0200
Message-ID: <87v7lrvn82.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 21:11, Randy Dunlap wrote:
> On 9/8/25 8:10 PM, K Prateek Nayak wrote:
>> Hello Thomas,
>> 
>> On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
>>> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
>>> +DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
>>> +
>>> +static int __init rseq_slice_cmdline(char *str)
>>> +{
>>> +	bool on;
>>> +
>>> +	if (kstrtobool(str, &on))
>>> +		return -EINVAL;
>>> +
>>> +	if (!on)
>>> +		static_branch_disable(&rseq_slice_extension_key);
>>> +	return 0;
>> 
>> I believe this should return "1" signalling that the cmdline was handled
>> correctly to avoid an "Unknown kernel command line parameters" message.
>
> Good catch. I agree.
> Thanks.

It seems I can't get that right ever ....

