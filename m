Return-Path: <linux-arch+bounces-14732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8FC57F9D
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 15:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAF9935083C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4272C1598;
	Thu, 13 Nov 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T29kqcDA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxJGGLdu"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7126E71F;
	Thu, 13 Nov 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044716; cv=none; b=Ze+qeO1+7dNVRvBE09eoba3xl68LwWWLnho2coaJzuzzLQ2Ur6891SlCW0S4kwMmTVYAxxEWizmJ6ZuRqO01ekbXtZUeqaP4ArHUqf+uowuXW6UlekPOvyV+SWFLeZxS3pyjoGp/OEA1RERKzn56ZwntTitFcrMa81mfu+PN8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044716; c=relaxed/simple;
	bh=ckRaPpYysGTgWDsSatqWgYvgTnxwIinmoe1ULzFEXho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1q/QimfGF9N6qrw2BUfwU5KqqNWL3b6l+3BKMFRWp1U/lRxH0+FS9uOrkCLM70kPmaucKovu63bISgELcJpSerHsthUK+4QM3wEZMLNjpHOKBxJtXClcs6X9isnv9nWIDiB17FeUtIPJNd4lntcEQavekme7K8+YLMsJbJr7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T29kqcDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UxJGGLdu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763044713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEyYa8J+jraXJi4/0H/z8EoFzpp20Pv+f07pd+P/QNY=;
	b=T29kqcDA9yUIrUcV8oHPqrRWfCRQ8FPjZbeVe6i5j6YCMpHXyjXANr9cp96Cuqvw5ILX/q
	+NAV4JDvYZZZhFO4N/wejRqUB51SEAsqkOKIzFR5mdgZ59qzc4Y0jpz5GrFVpgsI594r6h
	Jq7YSUkhRjwK8ChqlnOSfx6rvfRmGYWDsMs4xi6W+l4K5t0zXXy6kZx5qN3h6l3eeJ9aFe
	CW6KY7rIacuzNhYZz9luc/JwyM9L2bYTtCpkwKm+/VUkV6qMrwUMNYd8Fs/tJ03//BU0ZZ
	xalzep+uXN9H6ScWYPziiHfrQO+1h4eAkU6/Vi1odsTVCM4J3yvK7YjD7gfTDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763044713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEyYa8J+jraXJi4/0H/z8EoFzpp20Pv+f07pd+P/QNY=;
	b=UxJGGLduCZP+M4nn2ojD0iA9wL/P5AArwLfgqTZRdh95O6VmRiKZjJrpDcZVDydGHtgp1W
	HGxUdwR9JoVFa4BA==
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "Paul
 E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <5DFB2CA1-8751-409F-BBEA-CB753E717821@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
 <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com> <87cy5mewxk.ffs@tglx>
 <368CA4A7-3640-45F7-810F-2E2A073FE27C@oracle.com>
 <5DFB2CA1-8751-409F-BBEA-CB753E717821@oracle.com>
Date: Thu, 13 Nov 2025 15:38:32 +0100
Message-ID: <878qgac80n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13 2025 at 02:34, Prakash Sangappa wrote:
>> On Nov 12, 2025, at 3:17=E2=80=AFPM, Prakash Sangappa <prakash.sangappa@=
oracle.com> wrote:
>>> On Nov 12, 2025, at 1:57=E2=80=AFPM, Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>> Can you verify that the top most commit of the rseq/slice branch is:
>>>=20
>>>   d2eb5c9c0693 ("selftests/rseq: Implement time slice extension test")
>>=20
>> No it is
>>=20
>> c46f12a1166058764da8e84a215a6b66cae2fe0a
>>    selftests/rseq: Implement time slice extension test
>>=20
>
> Tested the latest from rseq/slice with the top most commit you mentioned =
above and the=20
> watchdog panic does not reproduce anymore.

Thanks for checking. I'll post a V4 soonish.

Thanks,

        tglx

