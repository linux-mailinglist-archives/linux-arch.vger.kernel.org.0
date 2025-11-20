Return-Path: <linux-arch+bounces-14989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76274C73BDE
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 35E9F303B0
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8731ED89;
	Thu, 20 Nov 2025 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6VdTrHm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7uHKcKC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380D2F60A1;
	Thu, 20 Nov 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638318; cv=none; b=SWtJyfMO3YkK/0jVBawntkrA6vl5oUWhcvwdanF54aRtjWIIUOuSkDEJe3hXM9I7IMrpCFrjagZoLCYu9vgMK7hE4KJ7D/Pvo7/kZ+8Qaax3tgcJErfgoBPC4F2/lUDb/76vkmhQQCAFBXN+CbY+zI64tKBBTM2nhPa2fjzHkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638318; c=relaxed/simple;
	bh=PeIQpskFOZFmQuo5SFxYpSkiWfgwGhPROs1dmExTBhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MvjuWc3kB3QEOIVi1vjcPXfOOuOUYIHASUp6u+Hw4m6TlG+4/Fi3up67onLPwwiZRfldQ+ABQgLZeJf0ZMXVua2ni3+AAB8DzKbl/1VkVlGxE9oAiWxPwkOYXqdk4M5KeRas6YYf+VvbxeClOiVJrH1erwnQn3l+SRYV/hPRQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6VdTrHm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7uHKcKC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763638315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6p41dAesVOIVU+GBWhMIXO9dH9yVLIF4rvzn044K02w=;
	b=G6VdTrHmc47c3H6nRRQ+Raakfenh0a92d7UoUC1gOYEYzaRhSQy1e/JEgYYVMT/5/U6CBF
	zGRvaNe+1cK5uwObln0UK66eyA0C1BJ9w+YY8hpPAnzqBR4kuS/3KYR0ZSVhdiNKlmt5tC
	Pl7crnXp+dlxiaTjYIigArmEhm19/4ZBlgO1XzfqkZaBt+DFDPmIX4+fHTc3V/D0w6iAcw
	d8BpEnibMq/3YJsebjZH9gZ56gu2k4tnwdPr/6RpHK1XWhIVBZ9w3IrG7hOGibDiN9KM1D
	WO+eY2+m184mF36U2giw4iQXJVnI9TheelIByKDKe9Ef1hJrLgqPTPL7jKKYTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763638315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6p41dAesVOIVU+GBWhMIXO9dH9yVLIF4rvzn044K02w=;
	b=S7uHKcKCwASuxgAPm59MxcS31h5uQq++09QUstcSXwQBV0WxlpHrHBzpHircw02ECqRYvp
	NxyxWc6gFqXPSDDw==
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
In-Reply-To: <C9D3DC1A-CBF5-4AB3-B500-C932A6868B13@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.860155882@linutronix.de>
 <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com> <874iqqm4dr.ffs@tglx>
 <C9D3DC1A-CBF5-4AB3-B500-C932A6868B13@oracle.com>
Date: Thu, 20 Nov 2025 12:31:54 +0100
Message-ID: <874iqpkkid.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20 2025 at 07:37, Prakash Sangappa wrote:
>> On Nov 19, 2025, at 7:25=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
>> Something like the uncompiled and untested below should work. Though I
>> hate it with a passion.
>
> That works. It addresses DB issue.
>
> With this change, here are the =E2=80=99swingbench=E2=80=99 performance r=
esults I received from our Database team.
> https://www.dominicgiles.com/swingbench/
>
> Kernel based on rseq/slice v3 + above change.
> System: 2 socket AMD.
> Cached DB config - i.e DB files cached on tmpfs.
>
> Response from Database performance engineer:-
>
> Overall the results are very positive and consistent with the earlier
> findings, we see a clear benefit from the optimization running the
> same tests as earlier.
>
> =E2=80=A2 The sgrant figure in /sys/kernel/debug/rseq/stats increases wit=
h the
>   DB side optimization enabled, while it stays flat when disabled.  I
>   believe this indicates that both the kernel-side code & the DB side
>   triggers are working as expected.

Correct.

> =E2=80=A2 Due to the contentious nature of the workload these tests produ=
ce
>   highly erratic results, but the optimization is showing improved
>   performance across 3x tests with/without use of time slice extension.
>
> =E2=80=A2 Swingbench throughput with use of time slice optimization
> 	=E2=80=A2 Run 1: 50,008.10
> 	=E2=80=A2 Run 2: 59,160.60
> 	=E2=80=A2 Run 3: 67,342.70
> =E2=80=A2 Swingbench throughput without use of time slice optimization
> 	=E2=80=A2 Run 1: 36,422.80
> 	=E2=80=A2 Run 2: 33,186.00
> 	=E2=80=A2 Run 3: 44,309.80
> =E2=80=A2 The application performs 55% better on average with the optimiz=
ation.

55% is insane.

Could you please ask your performance guys to provide numbers for the
below configurations to see how the different parts of this work are
affecting the overall result:

 1) Linux 6.17 (no rseq rework, no slice)

 2) Linux 6.17 + your initial attempt to enable slice extension

We already have the numbers for the full new stack above (with and
without slice), so that should give us the full picture.

Thanks,

        tglx

