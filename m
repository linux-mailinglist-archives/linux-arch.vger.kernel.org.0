Return-Path: <linux-arch+bounces-13451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57265B4FAC3
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E245716BA85
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CE1E0DE3;
	Tue,  9 Sep 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MglQcGbV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bg11J8AJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38B322A;
	Tue,  9 Sep 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420196; cv=none; b=jTCI1p60n6peFdL9fnDrlcgMBaf9vIkGDPSWZ+9ux7HXrhuzy1IO5t6Zua9iHSoNztnRaWv6ZCksL/vFbbNn/ym1pLY/35JU/rrhzRmLmVRN3bIpZU3W5V34fbk2lpnJ/uROLbDmeSzxldu5Gk+Rdbf0VK0cyYQ5IJmasWjrK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420196; c=relaxed/simple;
	bh=r5suooBlzrJ3QIuuA26TOQV5CForM3MBZbFtPBYxAWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrAXmmjTw5wQYbcOfH6OMdSZGiLLhl1as9i/3LBM1fhmIJ+RmaQ9XKkeU+JlpIn8N0A6bGmmeX2TV7+fSAYO0acrd2i566Tc8qNT/188U6NMuIMEq3UmKuwH/aosB39zvTJStyJASN234KxUxWpFTI6XxdEJlvhTjHp/QIjL4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MglQcGbV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bg11J8AJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757420192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywHzOzkreYp/9yLru3tVx2YAkh0o+irEJGSqdqemY6o=;
	b=MglQcGbVyGRBGwDWiFKIU2UY4M1w7hV6WSZ8m5v95HYkhvePIlOa98DJ4BVZfX+d3+vTB1
	EJ6NoXQN7hb5Bf765Hwfr93XTtTfC8+oV94s/yvv3vTJfCF3HEQzy2shwNJWc5UP60LpnE
	53JP1uYhEWeipLABSMiCmKAkc/KZpRet0XWCWSTSm5lZvQItKJ900SiyQvFnkpzbs95/ol
	Fh1MR3WhH3ZfeS/vlI9L5AtIfbigcXS9/AN16WJAAclqccrLcPWVWElVr8Yv5FiL1glgQp
	LhyKWEeswRJf3kt8nHgf2eihyYkiDitwxezC1H9Z1EegCDkcRyzvFl4JK95OHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757420192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywHzOzkreYp/9yLru3tVx2YAkh0o+irEJGSqdqemY6o=;
	b=bg11J8AJM0v7y7rthREEIYhYroPZSyESvYb+AGm/t7UZG6E7XutxFQ3wO14z/Aks73B+Zp
	0wWQ0a1SWRK9NUAg==
To: K Prateek Nayak <kprateek.nayak@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch 10/12] rseq: Implement rseq_grant_slice_extension()
In-Reply-To: <18383aa8-5774-4805-ba98-46b292f3a2a1@amd.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225753.205700259@linutronix.de>
 <18383aa8-5774-4805-ba98-46b292f3a2a1@amd.com>
Date: Tue, 09 Sep 2025 14:16:31 +0200
Message-ID: <87segvvn1c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09 2025 at 13:44, K. Prateek Nayak wrote:

> Hello Thomas,
>
> On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
>>  #else /* CONFIG_RSEQ_SLICE_EXTENSION */
>>  static inline bool rseq_slice_extension_enabled(void) { return false; }
>>  static inline bool rseq_arm_slice_extension_timer(void) { return false;=
 }
>>  static inline void rseq_slice_clear_grant(struct task_struct *t) { }
>> +static inline bool rseq_grant_slice_extension(bool work_pending) { retu=
rn false; }
>
> This is still under the CONFIG_RSEQ block and when building with
> CONFIG_RSEQ disabled gives the following error with changes from
> Patch 11:
>
>     kernel/entry/common.c:40:30: error: implicit declaration of function =
=E2=80=98rseq_grant_slice_extension=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>        40 |                         if (!rseq_grant_slice_extension(ti_wo=
rk & TIF_SLICE_EXT_DENY))
>
> Putting the rseq_grant_slice_extension() definition from above in
> a separate "ifndef CONFIG_RSEQ_SLICE_EXTENSION" block at the end
> keeps the build happy.

Duh, yes.

