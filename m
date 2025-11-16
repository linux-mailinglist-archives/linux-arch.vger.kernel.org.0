Return-Path: <linux-arch+bounces-14825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36167C61DE7
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98D2A34BA5B
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995626F29C;
	Sun, 16 Nov 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CXC/stQe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="URDgpC4g"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FF1F0E34;
	Sun, 16 Nov 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329979; cv=none; b=rFfFj2JgMqBwxSc6n5VeIyAVQcOhONiPyc3QEHTA/GSKfAfFd+NIpy6Csqux0BpW0f+9PFNDx5VM9itfyXN826XmvUpJaPSYJPypgTtieTrSitSEH8mQBJRNZDWu6gQSkiHE3ILJd4pVPL3N/II5lldRE0nuB81E6Z+p/dtTRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329979; c=relaxed/simple;
	bh=LeYOPprC6n/JMJQOTSv7kwVntIKcNwShoLrpBBYK2WM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iLSEGfNpWBoLs/05RFJhayPpwPM+ceEIG8phj0Je1ZJTbQ+xWbX//VsxMTGFBUJu0fWlUP0hKwNNdGT7azd/a5ISej0B16wi6/3qHOfUURvgC8Mmcl0cghdlg6FJG5b2t6WiY6MRt7oLzdLeYAHxiHFBeTH+5bT6EnZr1HaAXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CXC/stQe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=URDgpC4g; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 25F6C1D0010A;
	Sun, 16 Nov 2025 16:52:56 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 16 Nov 2025 16:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763329976;
	 x=1763416376; bh=xDr4EYeVJZoVxP3NOGfEC9a0Qsl8cilM5d9Y2CeRdCA=; b=
	CXC/stQeFwDfstl6z12FJRZUbSLRYKKVnI7GRbchnS47zzXcHNVzy7e6OdFBB9oh
	XL0rZjXK9E1SZAhDgKX0c9SbuZbZ5879iy5mJVZldcw5KvxdhsWxVGJJv5pKhcZ1
	oKNxApsutQAac3JV7ZQP6w7KERW7drTF1nQEj5n3L4QKzUKlUl0jHusiJV2SHx4i
	hy9Y1AuBYgVOI9AGqot3l0HpkjgpHoQy7DMRZlRFtwGkGZ52IEs6Duq5nkcv9mxv
	qGI3PPvgUkltlTm2ysZFT9L87hiygl3/ITnD7TsnSdKBWCxTyKKfxk01mVAdvQXo
	imnAz5SAE2s80Cgdj0E/rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763329976; x=
	1763416376; bh=xDr4EYeVJZoVxP3NOGfEC9a0Qsl8cilM5d9Y2CeRdCA=; b=U
	RDgpC4g1Mi4wUF/OO26kEBGr9uSPuDKX+fvxpfKVN2sKDa6680aSXb8vonTu/8Zg
	sVDgpwTdWukKgeucjeFz0bbIxFSlulLQ9g1ya+1hsdN+mRBECm4aL1zeEKyVFTyH
	hdeFH/+qFNZouxI6zT7uq8VleLMeFRSxRQFFmDyCec7EAhlRpvbd9wHSx37qoJtI
	UZVXJrc5X0mMGVo/nN9bYFbUTbApQq1A4NKSaNZFsGieua4HvnjFH5aOLGjiv/5A
	afiWLlInPEEOAhHwyg+G+dVEflJO50rBX99O4bPeiCa5d9jlWtCAEsbV3t3v4gbV
	vZ6O6CBIJ+UEiw1Su3E4A==
X-ME-Sender: <xms:tkcaaYFXFPF9WTgo3ZWo19qv6PX5juOlsqs9y3fiZ_C7td12JFNiSA>
    <xme:tkcaacL7wVDh5O3Q6VdczFN_VymdYLVytPI9gWwnwUjKA1aJEOj2ey363SIg0D2W9
    S8U3P8C0ZLfpNZq77-nA2f739UxSEFsB1Zq2Ilf22uKWgBVjTsW32s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeijeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkphhrrghtvggvkhdrnhgrhigrkhesrghmugdrtghomhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    hrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhgvg
    grshihsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:tkcaaQpW24GS0VyYcVFVX3332guGkcjON9PuLklIQ6X5Mo78HMVIjQ>
    <xmx:tkcaaXERk4o8MTgcOg216KjiQEFRULrj2E33JVxYFYvIq_tA5KZd6w>
    <xmx:tkcaaU9jWZWmEBx1f-JK8qSJytvvvTSIrslspbZNE-cqWxHcveHawg>
    <xmx:tkcaaUQSrkvPrrmtmvxKLJyzo72L-A6ujoHx4hi4iaw7mW5ObuFkTQ>
    <xmx:t0caaT46jN-8oV2e-e04lKicHSJnjGQWPtlIFkriU1YL6EaM1y6q_QO_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9EAE5700054; Sun, 16 Nov 2025 16:52:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag6Jzdul079s
Date: Sun, 16 Nov 2025 22:51:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Prakash Sangappa" <prakash.sangappa@oracle.com>,
 "Madadi Vineeth Reddy" <vineethr@linux.ibm.com>,
 "K Prateek Nayak" <kprateek.nayak@amd.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>
Message-Id: <3bc50dd8-d115-4516-8a21-8313a57f1b40@app.fastmail.com>
In-Reply-To: <20251116174750.984829834@linutronix.de>
References: <20251116173423.031443519@linutronix.de>
 <20251116174750.984829834@linutronix.de>
Subject: Re: [patch V4 06/12] rseq: Implement sys_rseq_slice_yield()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 16, 2025, at 21:51, Thomas Gleixner wrote:
> Provide a new syscall which has the only purpose to yield the CPU after the
> kernel granted a time slice extension.
>
> sched_yield() is not suitable for that because it unconditionally
> schedules, but the end of the time slice extension is not required to
> schedule when the task was already preempted. This also allows to have a
> strict check for termination to catch user space invoking random syscalls
> including sched_yield() from a time slice extension region.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> ---
> V2: Use the proper name in sys_ni.c and add comment - Prateek

I checked that the syscalls are well-formed across
all architectures, which is easy here, since there
are no arguments.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two minor comments:

- Number 470 is also used in Christian Brauner's listns
  series. Obviously only one of you can claim that number.

> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -408,3 +408,4 @@
>  467	n32	open_tree_attr			sys_open_tree_attr
>  468	n32	file_getattr			sys_file_getattr
>  469	n32	file_setattr			sys_file_setattr
> +470	common	rseq_slice_yield		sys_rseq_slice_yield
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -384,3 +384,4 @@
>  467	n64	open_tree_attr			sys_open_tree_attr
>  468	n64	file_getattr			sys_file_getattr
>  469	n64	file_setattr			sys_file_setattr
> +470	common	rseq_slice_yield		sys_rseq_slice_yield
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -457,3 +457,4 @@
>  467	o32	open_tree_attr			sys_open_tree_attr
>  468	o32	file_getattr			sys_file_getattr
>  469	o32	file_setattr			sys_file_setattr
> +470	common	rseq_slice_yield		sys_rseq_slice_yield

- These should probably all become 'common' eventually, especially
  now that the s390 compat syscalls are out of the way, I would like
  to revisit my series that unifies the tables for syscalls over
  402 into a single source file. Until then, it's probably less
  confusing to keep the format and use n32/n64/o32 here.

     Arnd

