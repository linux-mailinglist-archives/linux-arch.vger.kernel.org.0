Return-Path: <linux-arch+bounces-13453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C312B4FAB2
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 14:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D2C44199C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E832CF83;
	Tue,  9 Sep 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VnKWONyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LhaPqjvE"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238A285C9F;
	Tue,  9 Sep 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420622; cv=none; b=f0/XBmWWoCzbsLKkL0NET2cJaL5cumo6xvYlenmk2bup3VFzliyTHC9gbt9CtLQ+ltYyQ4oYo6+C/icMTStMdQuouzWXiHD/fKKg/+mr31JHIhcG3yfY9jeXHT/q9JSjW2+w/Veq+FsJr3bP7vQHPKyPu4MZD44vzYHKIc/PC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420622; c=relaxed/simple;
	bh=H7f7YThXxHIvtHcKZb4kQxNNWQLDj+hl/EKdv3iWoys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oD1x+iteES9AiK4WuFZwbdEZa3o+rJBOyrgI/LYxLQOXQQCBbN8FN2fEB2fJH1pMhnfPAR0/GaMlSD34sJp/gqrvzY1HMagbjipEBR4WBKemYV8li5UcwQOX0BTNqo8o1EIVcuKye6qeXFuze2qdXq+mkSCYpS+PnSCo4W2d+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VnKWONyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LhaPqjvE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757420618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL8qAuVyYy5N/WJ7uobjj3AQJ1cLb7LBf6oZJwltW8E=;
	b=VnKWONyCZYdYzJJHGQJSpkZq1XJOVbTJFQS2L5/BzLYxvu2940wdfjE9+Njoev56/0mGSj
	Y51ss5l7RZ380qhe8HpyQK1yOpSFmGBdMDSGe71OPhqDYVn8dsf0iC5aXquWpqaBHarUVb
	ZuijJyrg6OAtTIYP/8GhU/Nv3KwlrZzYLhMk1bseJE1tXGCKpNCkxDA1fG4z5BLXzXK7yr
	JdXFbsv1wVHkWXmI+xlFfizc6k2cayoTM5ZpsIdPQxKbziJLKD4k3WzEQeP/MfhEFT8y7W
	J4LJgctbSz80h/eTUwYyFouxJ/IXzipEqxw2EG0nvQaJ8uICD43P0FTLrRNBuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757420618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL8qAuVyYy5N/WJ7uobjj3AQJ1cLb7LBf6oZJwltW8E=;
	b=LhaPqjvE7KNL8ueVFFqwSPFiFi+m57J90Vc/BWeW7x6SIZ76FVP0/sTO9ERKg5otIza5Bi
	q0isSQokbSwq92Cg==
To: K Prateek Nayak <kprateek.nayak@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Peter Zilstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 06/12] rseq: Implement sys_rseq_slice_yield()
In-Reply-To: <47499513-7bf0-4393-ba89-5efd9c115c43@amd.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.936257349@linutronix.de>
 <47499513-7bf0-4393-ba89-5efd9c115c43@amd.com>
Date: Tue, 09 Sep 2025 14:23:38 +0200
Message-ID: <87plbzvmph.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 15:22, K. Prateek Nayak wrote:
> On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
>>  /* restartable sequence */
>>  COND_SYSCALL(rseq);
>> +COND_SYSCALL(rseq_sched_yield);
>
> I'm not sure if it is my toolchain but when I try to build a version
> with CONFIG_RSEQ_SLICE_EXTENSION disabled, I see:
>
>     ld: vmlinux.o: in function `x64_sys_call':
>     arch/x86/include/generated/asm/syscalls_64.h:471: undefined reference to `__x64_sys_rseq_slice_yield'
>     ld: vmlinux.o: in function `ia32_sys_call':
>     arch/x86/include/generated/asm/syscalls_32.h:471: undefined reference to `__ia32_sys_rseq_slice_yield'
>     ld: vmlinux.o:(.rodata+0x12d0): undefined reference to `__x64_sys_rseq_slice_yield'
>
> I would have assumed the COND_SYSCALL() above would have stubbed this
> but that doesn't seem to be the case. Am I missing something?

Yes.

>> +COND_SYSCALL(rseq_sched_yield);

does not create a stub for rseq_slice_yield() obviously :)

/me looks for a brown paperbag.


