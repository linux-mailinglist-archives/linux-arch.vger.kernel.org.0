Return-Path: <linux-arch+bounces-14438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A133DC25974
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 15:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111154EB4CE
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740D31A555;
	Fri, 31 Oct 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+fKj/3+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPkfZ9K5"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61502EBBAF;
	Fri, 31 Oct 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921180; cv=none; b=iUMyES5G8dIgGlLZpDRogSB6O7ik1vmzYUqPPwVRTJ+MFFped7q41xdqOA8u9zN4lTvjZPFnlNNBGLNRRS7DQPiprXlWvvirqvzE7tpPJ+D90PVzsYBaZvRE0yXINVdtcrMr1eB5YlRZIrDjt0TmshnOztoeWF6sNjXOhskbPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921180; c=relaxed/simple;
	bh=Pql8y+9KVqO2oYJxK+ekz1JwkNsR08SbyFlMz5p4NO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q4HRzDwwiwDTVC2GyQGEVizePtEUDj63/+mjQXhQ1wuT8Gp49YwPKtymoCu7vsu8qrcCmvrk/DSnS69UlNIfVFcCLwh3xZmdHGCHuQy9sV9UiwruCOHPyc9utgl/q8kP11FnSJwSWQtAV/F1z1AVcGygUnf8/kTS2nyrxts3NUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+fKj/3+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPkfZ9K5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761921177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWjiQGeCH8V9Weyht1eZQ9p8KytDBMq+frDo4cdg/2Y=;
	b=f+fKj/3+x9Yoob0D8C9xpBzd8QrYbV7HeNBDGK2vU54YY1d6HsRiBY13isO8n6Ro0L/d7u
	0BCJqfzce1iNcqXFi90ojNruS+so/F1jLi5C4TDIss0AE+5aMdEUO5sR+rCR3hWcorVSJA
	lBBVJqg7MJd6Yju98/7MCi9e1aqumkogMLIS2pgA9aDCsHcM2WBVoj18iJnUdfi/BY5eka
	O2kzHQQdICBlLYF7sA4VK8GXxPMud4XMfZFTrvh+zzD5IWT3Vh0JmhLlBsQzcDlpaQo5jz
	c6El6I87dkkBReSCHv9Zw1tWj/wjN2KrDZuCmPtZ+kiIyxlh/iReqXmHjT7vPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761921177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWjiQGeCH8V9Weyht1eZQ9p8KytDBMq+frDo4cdg/2Y=;
	b=JPkfZ9K5WhL9d8W6v8tP3csJHQ4WV0vpBAuMM9yw01vvgszR9JYqMW5oH4rmqP7QZ8nmoe
	YAe41+yAf+euCZDw==
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
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <999E136D-49BE-4AEE-8392-C09D0511351C@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.542731428@linutronix.de>
 <999E136D-49BE-4AEE-8392-C09D0511351C@oracle.com>
Date: Fri, 31 Oct 2025 15:32:55 +0100
Message-ID: <875xbvta3s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30 2025 at 22:01, Prakash Sangappa wrote:

>> On Oct 29, 2025, at 6:22=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
>>=20
>> Aside of a Kconfig knob add the following items:
>>=20
>>   - Two flag bits for the rseq user space ABI, which allow user space to
>>     query the availability and enablement without a syscall.
>>=20
>>   - A new member to the user space ABI struct rseq, which is going to be
>>     used to communicate request and grant between kernel and user space.
>>=20
>>   - A rseq state struct to hold the kernel state of this
>>=20
>>   - Documentation of the new mechanism
>>=20
> [=E2=80=A6]
>> +
>> +If both the request bit and the granted bit are false when leaving the
>> +critical section, then this indicates that a grant was revoked and no
>> +further action is required by userspace.
>> +
>> +The required code flow is as follows::
>> +
>> +    rseq->slice_ctrl.request =3D 1;
>> +    critical_section();
>> +    if (rseq->slice_ctrl.granted)
>> +         rseq_slice_yield();
>> +
>> +As all of this is strictly CPU local, there are no atomicity requiremen=
ts.
>> +Checking the granted state is racy, but that cannot be avoided at all::
>> +
>> +    if (rseq->slice_ctrl & GRANTED)
> Could this be?
> 	if (rseq->slice_ctrl.granted)

Yes.

