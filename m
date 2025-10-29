Return-Path: <linux-arch+bounces-14411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F5CC1BC37
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 16:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 882DE5837AF
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1102E1EE1;
	Wed, 29 Oct 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXlPihwQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="195qSjd7"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD92E0901;
	Wed, 29 Oct 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750660; cv=none; b=B7Iw217KUxfTO72UVLqwujMQF2TWzcFbXzWjEtuwPCekFwVgGWxnl61dD9b0E4UsPacS1VnZ85+UcwQ8t2ySh1c0oDYySF+pophfgTYQCABt0QgD7K4VpbNh3msJeWh4cc6gOcSOJ/FnbSKt/2mEKBjvdnTYYOzTAA8dYQ4SOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750660; c=relaxed/simple;
	bh=sAv1z1FgZI5xEbZMpuf1SeLtdIlGbwOrSChKTjqrO4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWetpCp4ATUrf4mpkQ7UM/kmPpbA/OtpAz4eUMUZOy8EQ0UbvM5EMm+/Em1pcLVTS7cWae3OLz/vp/MO5rfG8tWZWqEy4mMMzaFn8XjMITa6V/v7UKVAebKG1z3A6JghWkGMe+6XvfXW52loixUAWMPcWxO6j9UfQez0bZi7mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXlPihwQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=195qSjd7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 16:10:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761750656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lc3orl+6C4wXnR7bqU7PuJ/5Qcp1MmFzz8u4/5D8yFQ=;
	b=iXlPihwQwKdKVlWTaeY1e9XWLmIzLWoVB4Cu8lRBZkWrv57wnynUT7O/IRYuYkgguJIWFe
	B3dErPgcZcoV+NOgUnu/ZEGyFvJXkMyWSNGFQUj10+akh+8S36Vvf+HdtbhOmXBDjV5dGF
	IIjKq/AVdjy2iIOv5EUXiPic86GuxWjVsgYAFhJz7DfH2Z6AVSKoVYbVZe8+Q7JTE+AnfI
	h3HiO1AZBkno6buUFVUJhYZHyDJZ/UZPw2x0MoBisSY/BCErCNnorY79GB/O7FoLqNRVUq
	kIrlsP7R8p5oqfcBkYc/rv1PcR+DJetLkYXBQE8xIyktE7uCweAlUG4u1UWe9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761750656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lc3orl+6C4wXnR7bqU7PuJ/5Qcp1MmFzz8u4/5D8yFQ=;
	b=195qSjd7J0TZl5Ns3PzXRbF5K8Z3NLL/WPo5wQY2oKV96hWiTkETaujqR2f9yIE6mK9iD1
	1de1cmk6Huz9FxAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
Message-ID: <20251029151055.SA-WMUQ_@linutronix.de>
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251029125514.496134233@linutronix.de>

On 2025-10-29 14:22:11 [+0100], Thomas Gleixner wrote:
> Changes vs. V2:
>=20
>    - Rebase on the newest RSEQ and uaccess changes
=E2=80=A6
> and in git:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid
>=20
> For your convenience all of it is also available as a conglomerate from
> git:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/sli=
ce

rseq/slice is older than rseq/cid. rseq/slice has the
__put_kernel_nofault typo. rseq/cid looks correct.

> Thanks,
>=20
> 	tglx

Sebastian

