Return-Path: <linux-arch+bounces-14996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B53C78285
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4B6AC2D464
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776D2FD1CF;
	Fri, 21 Nov 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="fRgUO6Zb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658E2FDC5B;
	Fri, 21 Nov 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717370; cv=none; b=ENzAviyN3yh9THUwmCiAE/e61baTGzZ9yKrz37Z0oeIHpZViBjHPJD5lHBn7fE/wVofhmeMD0o3cKU93fRXJ5SIcQKSUja9MjUEjH41XG0zQAGpMy8kWC/zKsIZhwEUEqc0P8mRN0WGJzvfkgg0VWpLCKqYRJWdpsn4aeN04rEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717370; c=relaxed/simple;
	bh=xvPsyMsP9xjAIh96rxpOZ8EoDVs59hG4uUid+e9SLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHEV0dGXWm3zXGm8lw38V2wSo61c6P+IuvFaig4FtAtIsfmQNLZPswhhJZ4wdu9hGc+UzrLoDz9y7C542DYFOGYpg9FkA2bOti4g0TbJaPUL3TNRZOp/nvxsGP74gvFqhiOLpR6eylecGCsyy3C6vRQYTKZngFDFeQYWk6IszCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=fRgUO6Zb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vMNRq-00BGWa-8w; Fri, 21 Nov 2025 10:28:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=HC7LH3PmHsE+Tdv/b/p/UBtp7UDvrGoAbJSRk79aHB4=; b=fRgUO6ZbYXPqBRK9dTZQwruxWY
	xo28jjaRrO8Wq2DiXsJGUlt3PUCuWustFZz/U7VGHj8HMCfL4+jcy5m/QF5BJs0Jk0r4gYmzhG65A
	WXoSOX6p5nmMqnbrLyZk/3sVIAY719Ab7McWdcHkXpXzYnHBN+X6gHaXjhxPzf7iVeUfQVq1D30eh
	9Zd+uhlfkdEzjRqb4AS5h9yfIurAJYf58qi/5ea+GMZqK+Fv3VOWrR95LZ8n7pFwujpDxte2w0Cxv
	ih2rByQ0j4VFZepzOJCjh6a0JTuzVuug++W6O4BC2cu+ZUxOQoLaBKwPKTxGM7Xr0tAg0Sjl5o8gS
	45oKuD6w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vMNRo-0000xH-LM; Fri, 21 Nov 2025 10:28:56 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vMNRb-001a9m-UL; Fri, 21 Nov 2025 10:28:44 +0100
Date: Fri, 21 Nov 2025 09:28:41 +0000
From: david laight <david.laight@runbox.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
Message-ID: <20251121092841.4a2e0cf0@pumpkin>
In-Reply-To: <874iqpkkid.ffs@tglx>
References: <20251029125514.496134233@linutronix.de>
	<20251029130403.860155882@linutronix.de>
	<261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com>
	<874iqqm4dr.ffs@tglx>
	<C9D3DC1A-CBF5-4AB3-B500-C932A6868B13@oracle.com>
	<874iqpkkid.ffs@tglx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 12:31:54 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

...
> > =E2=80=A2 Due to the contentious nature of the workload these tests pro=
duce
> >   highly erratic results, but the optimization is showing improved
> >   performance across 3x tests with/without use of time slice extension.
> >
> > =E2=80=A2 Swingbench throughput with use of time slice optimization
> > 	=E2=80=A2 Run 1: 50,008.10
> > 	=E2=80=A2 Run 2: 59,160.60
> > 	=E2=80=A2 Run 3: 67,342.70
> > =E2=80=A2 Swingbench throughput without use of time slice optimization
> > 	=E2=80=A2 Run 1: 36,422.80
> > 	=E2=80=A2 Run 2: 33,186.00
> > 	=E2=80=A2 Run 3: 44,309.80
> > =E2=80=A2 The application performs 55% better on average with the optim=
ization. =20
>=20
> 55% is insane.
>=20
> Could you please ask your performance guys to provide numbers for the
> below configurations to see how the different parts of this work are
> affecting the overall result:
>=20
>  1) Linux 6.17 (no rseq rework, no slice)
>=20
>  2) Linux 6.17 + your initial attempt to enable slice extension
>=20
> We already have the numbers for the full new stack above (with and
> without slice), so that should give us the full picture.

If is also worth checking that you don't have a single (or limited)
thread test where the busy thread is being bounced between cpu.

While busy the cpu frequency is increased, when moved to an idle
cpu it will initially run at the low frequency and then speed up.

This effect doubled the execution time of a (mostly) single threaded
fpga compile from 10 minutes to 20 minutes - all caused by one of
the mitigations that slowed down syscall entry/exit enough that a
load of basically idle processes that woke every 10ms to all be
active at once.

You've also got the underlying problem that you can't disable
interrupts in userspace.
If an ISR happens in your 'critical region' you just lose 'big time'.
Any threads that contend pretty much have to wait for the ISR
(and any non-threaded softints) to complete.
With heavy network traffic that can easily exceed 1ms.
Nothing you can to to the scheduler will change it.

	David

