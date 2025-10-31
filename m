Return-Path: <linux-arch+bounces-14452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1032AC26FA0
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 22:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3DD1B27552
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FBB26ED21;
	Fri, 31 Oct 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KQLbYetU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJe9F7Si"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC628153BD9;
	Fri, 31 Oct 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944752; cv=none; b=Vn4Q576ZanwR9pHv+c6pURoWZfOtd32MRUwm3V6/nIxDI/4ChsWv7H8nZ1EXHxOxpZMhD6QyVwTMLBNZPCbJ2V6NVoMjaWYVj1Mdeiwo7y3ENHAfUdCmtjfJjfxkx4gMr8YweKrhWbym0z3uqV8UC91WimFUvV8H0oWyXv4idQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944752; c=relaxed/simple;
	bh=YVa/07OiDwNknDZnMRb8DgV1/Zr3ZxlUq6WMmDqGUV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ec8LsffuSp7j0RGEF6eyjP5pPHuvW65QUPxYdzIGD0jZY/fLA/z9Qg7tAaXyzgStE7ho4dzHA4fz/1Yurj4fJZQ3ZCh/UjNecH4TqMUEuESmYpAYLfgVhUjwa0T/dAX2pYLTIMkM3W0rmUNQQAoE61wTFsLH3EfDcrn3nud6vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KQLbYetU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJe9F7Si; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761944749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/PyQym1ATzFyvhReACvStanm/M2Bg5/h6iuwJUTLfg=;
	b=KQLbYetUqH0gMyNy7/940wCkbqzJlqiRMcDBxUkknYDWkF0K5quxERLB2+k44tTZBBeBNb
	ClbVcJO2HyHIve2yJtt2WR8O5cYYfZDl1fyAM+EEw0z2E70GNU+Wgt1jcpv7m7HCx5gyB0
	w6N3XKG/Vxlf2DdK1Pu3R3op241IvOp1xsSX47yHb9Isz9X0/sPxv3JqgLTO4NeN2FnMj2
	oBAsGPcsMERoDpzBGFT3lFGG6ZLajXXRY1zBXnLITSfG8BIWzaDnVTeBX84cUwGmNFHvzb
	TWcxmpt5bnXayvHk3I6pYp6uRiCgR0iaj6Vvd9A1DokrOyZUYAfDBmXpBzmGTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761944749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/PyQym1ATzFyvhReACvStanm/M2Bg5/h6iuwJUTLfg=;
	b=oJe9F7SixmP/XNJtPY9gS+ndUGL5JsFX+duY+L4940TowBDIPAz29Nwus0WxKXhULpHp62
	NEBg2sbA14pMavDA==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V3 05/12] rseq: Add prctl() to enable time slice extensions
In-Reply-To: <68bafe10-23db-4885-b4d7-7d8126da76d7@efficios.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.733465222@linutronix.de>
 <68bafe10-23db-4885-b4d7-7d8126da76d7@efficios.com>
Date: Fri, 31 Oct 2025 22:05:48 +0100
Message-ID: <878qgqsrwz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 31 2025 at 15:43, Mathieu Desnoyers wrote:
> On 2025-10-29 09:22, Thomas Gleixner wrote:
>> +	case PR_RSEQ_SLICE_EXTENSION_SET: {
>> +		u32 rflags, valid = RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
>> +		bool enable = !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
>> +
>> +		if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
>> +			return -EINVAL;
>> +		if (!rseq_slice_extension_enabled())
>> +			return -ENOTSUPP;
>> +		if (!current->rseq.usrptr)
>> +			return -ENXIO;
>> +
>
> So what happens if we have an (unlikely) scenario of:
>
> - thread startup
> - thread registration to rseq
> - prctl PR_RSEQ_SLICE_EXTENSION_SET
> - rseq unregistration
> - rseq registration
> --> What's the status of slice extension here ?

On unregister it's cleared and you have to re-register it when you
register a new rseq. It's part of the rseq state so obviously it's all
set back to zero.

