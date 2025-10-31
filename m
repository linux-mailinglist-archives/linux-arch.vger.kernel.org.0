Return-Path: <linux-arch+bounces-14453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D154C26FAF
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 22:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51BB74E5A69
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2FA2D2499;
	Fri, 31 Oct 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMtE9hKA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cjp7At5o"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBA26ED24;
	Fri, 31 Oct 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944833; cv=none; b=M63rCZmUyekRMcgjjvavYtEK4rrQkt21/ZSDDEcxy9Xgr08uGDakwKV7sSW8faJ2tOnzYBmXxo56/trnNwcPZ2AWyUZJ7ld+/FzU5EwbqJ4RsAnFxZbIjbOUhWtx/OWJ4sgLPLQoAocSIa3B7m2z7enyfbDqOmMTLAhhZgfl4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944833; c=relaxed/simple;
	bh=5g/L1qN3bh2ex8VXFb4fFTDm3l77Aoo4+YMoUWK7oSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7sb4OEX+unhht3SF1bc95LFD4LNgnNkGA+uic5IfaKKjsPm4fZZZkXR8QH5IvKgesBcR7Uaiz4Zo0VFqQOOsqbC4QWYWyc0Be939qDHcZOKpRY131Lhq8IbW3kUknslO4Zt49PWVhSgrhZa/+xBIRZYggXNwagmcBS8QWL9T88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMtE9hKA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cjp7At5o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761944830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NtKPVcZj0/iGQjULUWhrWJM75fipiStRDs9WxNmLM40=;
	b=YMtE9hKA0utWp9rW+uGGmzah7uqX5zmd0TgVbwbGdrLC2CsgDorCW8oRzge3Tjis2AnRM4
	77Lql8Grpl+242GxiOMel2lmKtOZwLPv/EVDQQOrbk1SVI06BqE3wuxQiJBx8yooNQAkv6
	YkQHn+vCwc8n6gawfrBpxC4U9Fa/rTqdjYoDb7Jghtw/T+TdN7Ydu6RPDditis4pHwIeVE
	Fs/RCObL2Aqar9nyv8S5O/TYcOmTvEPHniU8P6UjArLlwK6FUEbQYQjpxHE+nOLswTjia4
	z5V/ZQSJTWQXe3GjnmZhHZni1ENFAMypC3qhrbMG1cOsQtIDUqNMhy+ghj5lCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761944830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NtKPVcZj0/iGQjULUWhrWJM75fipiStRDs9WxNmLM40=;
	b=Cjp7At5oeOzJy/u8Zk7uNFOj+ys8lRmZxBDuWvhgZuqsVhbH2xcF1h+rWHr3tJCI2AaEmm
	y7F8WaKWkG0z2oDA==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [patch V3 06/12] rseq: Implement sys_rseq_slice_yield()
In-Reply-To: <8a06928e-7bdc-4b46-a4be-63032843ea6e@efficios.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.796935865@linutronix.de>
 <8a06928e-7bdc-4b46-a4be-63032843ea6e@efficios.com>
Date: Fri, 31 Oct 2025 22:07:09 +0100
Message-ID: <875xbusruq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 31 2025 at 15:46, Mathieu Desnoyers wrote:

> On 2025-10-29 09:22, Thomas Gleixner wrote:
>>   
>> +/**
>> + * sys_rseq_slice_yield - yield the current processor if a task granted
>> + *			  with a time slice extension is done with the
>> + *			  critical work before being forced out.
>> + *
>> + * On entry from user space, syscall_entry_work() ensures that NEED_RESCHED is
>> + * set if the task was granted a slice extension before arriving here.
>> + *
>> + * Return: 1 if the task successfully yielded the CPU within the granted slice.
>> + *         0 if the slice extension was either never granted or was revoked by
>> + *	     going over the granted extension or being scheduled out earlier
>
> I notice the presence of tabs in those comments. You will likely want
> to convert those to spaces.

And why so? It's perfectly formatted and there is ZERO reason to use
spaces in comments when you want to have aligned formatting.

Thanks,

        tglx

