Return-Path: <linux-arch+bounces-2936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C48792D3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D4E284A60
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FC379B69;
	Tue, 12 Mar 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VPapf6gr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAcRHzfP"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B269D0C;
	Tue, 12 Mar 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242389; cv=none; b=SzJFJVQWnU6YnP3XaCQqp7cnx3AfxKQ0fNnnOqk0q+PiORAojvb24Qxq+TJEZ053lT4sWVBVkBSJrqI6FQC2rY85f4DGFUJovKwIZr6yS87IXb55ZN925J5iEvlgQLd6qU+D0/amwNpaqYc1v7emXFpr0mNPKk/B64yMtdX0T6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242389; c=relaxed/simple;
	bh=CQCphKWr4o25jDk8CXK4sQL5dE4RRsnaO39JGnEXsBk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZhaXLCUb9XEE9AD3tuKJIsNY+YuK0GJJP7ycET2b3x1YPF5b2TyCwBugWYi6ZfbdSH3spCq0oLK82tulcDNwfGGEIynyt5V73qWRgXdu+rFtmoGNBbyn/+w8pofbW8kohyKQ8QwYhOfOmI02/40yeK5NlmeXa06tWXl1365BuIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VPapf6gr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAcRHzfP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1BFFF1140150;
	Tue, 12 Mar 2024 07:19:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 07:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710242386;
	 x=1710328786; bh=YRT9uyaC97F1MKGGv+BnROns3fVOkRDmiWjZt3YyyvI=; b=
	VPapf6grS6pV/lcvu1jh2cuW2/02JzQH/gsZg7thaJNEQKsB/fJt4j4CiKRWuA3Y
	+mFt/as935gZ1F87Im5BvWXLCMnah9IFoFGE9w9uqYZo7xV4rwY5AdDJgZDptT01
	BgZT4gIk3Jwxepo2a2NN30D5mNaVSdLTgxIP4pxq0g3vBgNX9+Xevylh4UzYOPol
	JjykPX8l+faKq/7njBEIPZH70EAHNna2DGNraQvbWj3RArWrGl7wL3W+GGoqCx2/
	3/pAUNSdwW2DXw/Q6cs0LIPMTxWlrml80/+rDT1EugBK9YWQSVXdQhlcPZtuDrIp
	acBshciDKglR82Vw+IHBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710242386; x=
	1710328786; bh=YRT9uyaC97F1MKGGv+BnROns3fVOkRDmiWjZt3YyyvI=; b=S
	AcRHzfPnfr2lqcel970ZOU51cSCBWkUybtxt23FZu+6uYWz1VWCZFTffztgeSheV
	jD/LkkPwpxaTe5WKpqM132dTokJx1zWhqWAGT9mDTexzbABvmlEuXZs8pVPSnLoI
	+b0sO2JLiD6WK9ThyyAtUUuFVj0wtvDDcQJrCMIcBBBuFyn2HEP+Ec6j2gKNco38
	VXyrG09P2eVJXxh7v0Qa3dyt/tQU/56Bqs6FP+6wIdnoyRYwpVh307lAAI9QMOno
	ZwSvzYK2gIYlqrbq7br5C7viNb2fes/tF/vp39VOwJqX5T1labGM/dyK+ElZ1jFa
	uc+fzowxyEZ9N3ZG+lNlg==
X-ME-Sender: <xms:UTrwZRJbFYezQJqKbvrcdR-V-qowY5mlPFmIySt5uRq46_PZJ22Y4w>
    <xme:UTrwZdIOeIzklaevJaIM8S2Cxo2rh3lJucbhMuwc-A07oocKt-5visU-8Vqs2mAt2
    UKksDGV31shFM6Xw_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UTrwZZtTZ2lBXV9FfpNpUzSKlOOIgb6OYzeULw5Jyz6vRQm0mtaZdA>
    <xmx:UTrwZSZH43ddw2MmcbQ_s_QQdZISnNexDVlRSubNYHDQpKlaTtpdZQ>
    <xmx:UTrwZYYz_QTbXskec5eswQE-UoPP2tzh93IS9tuBQrd7MwFnU_2cOA>
    <xmx:UTrwZWDwh9B2of9OJvn6Kd3fNw6KYpjCiakv8FIpHBHppFYkd0k7Tg>
    <xmx:UjrwZZG-VTJnpoD0o2Kw_MTpuQPsNthd0hL1DzA6VqCvj2JdeAQ-0w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47B8FB6008D; Tue, 12 Mar 2024 07:19:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7bf7d444-4a08-4df4-9aa1-9cd28609d166@app.fastmail.com>
In-Reply-To: <20240312095005.8909-1-maimon.sagi@gmail.com>
References: <20240312095005.8909-1-maimon.sagi@gmail.com>
Date: Tue, 12 Mar 2024 12:17:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sagi Maimon" <maimon.sagi@gmail.com>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Andy Lutomirski" <luto@kernel.org>, datglx@linutronix.de,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Nhat Pham" <nphamcs@gmail.com>, "Palmer Dabbelt" <palmer@sifive.com>,
 "Kees Cook" <keescook@chromium.org>, "Alexey Gladkov" <legion@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Miklos Szeredi" <mszeredi@redhat.com>,
 "Casey Schaufler" <casey@schaufler-ca.com>, reibax@gmail.com,
 "David S . Miller" <davem@davemloft.net>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v6] posix-timers: add clock_compare system call
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024, at 10:50, Sagi Maimon wrote:
> Some user space applications need to read a couple of different clocks.
> Each read requires moving from user space to kernel space.
> Reading each clock separately (syscall) introduces extra
> unpredictable/unmeasurable delay. Minimizing this delay contributes to=
 user
> space actions on these clocks (e.g. synchronization etc).
>
> Introduce a new system call clock_compare, which can be used to measure
> the offset between two clocks, from variety of types: PHC, virtual PHC
> and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> The system call returns the clocks timestamps.
>
> When possible, use crosstimespec to sync read values.
> Else, read clock A twice (before, and after reading clock B) and avera=
ge these
> times =E2=80=93 to be as close as possible to the time we read clock B.
>
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

I like this a lot better than the previous versions I looked at,
so just a few ideas here how this might be improved further.

> +/**
> + * clock_compare - Get couple of clocks time stamps
> + * @clock_a:	clock a ID
> + * @clock_b:	clock b ID
> + * @tp_a:		Pointer to a user space timespec64 for clock a storage
> + * @tp_b:		Pointer to a user space timespec64 for clock b storage
> + *
> + * clock_compare gets time sample of two clocks.
> + * Supported clocks IDs: PHC, virtual PHC and various system clocks.
> + *
> + * In case of PHC that supports crosstimespec and the other clock is=20
> Monotonic raw
> + * or system time, crosstimespec will be used to synchronously capture
> + * system/device time stamp.
> + *
> + * In other cases: Read clock_a twice (before, and after reading=20
> clock_b) and
> + * average these times =E2=80=93 to be as close as possible to the ti=
me we=20
> read clock_b.
> + *
> + * Returns:
> + *	0		Success. @tp_a and @tp_b contains the time stamps
> + *	-EINVAL		@clock a or b ID is not a valid clock ID
> + *	-EFAULT		Copying the time stamp to @tp_a or @tp_b faulted
> + *	-EOPNOTSUPP	Dynamic POSIX clock does not support crosstimespec()
> + **/
> +SYSCALL_DEFINE5(clock_compare, const clockid_t, clock_a, const=20
> clockid_t, clock_b,
> +		struct __kernel_timespec __user *, tp_a, struct __kernel_timespec=20
> __user *,
> +		tp_b, int64_t __user *, offs_err)

The system call is well-formed in the way that the ABI is the
same across all supported architectures, good.

A minor issue is the use of int64_t, which in user interfaces
can cause namespace problems. Please change that to the kernel
side __s64 type.

> +	kc_a =3D clockid_to_kclock(clock_a);
> +	if (!kc_a) {
> +		error =3D -EINVAL;
> +		return error;
> +	}
> +
> +	kc_b =3D clockid_to_kclock(clock_b);
> +	if (!kc_b) {
> +		error =3D -EINVAL;
> +		return error;
> +	}

I'm not sure if we really need to have it generic enough to
support any combination of clocks here. It complicates the
implementation a bit but it also generalizes the user space
side of it.

Can you think of cases where you want to compare against
something other than CLOCK_MONOTONIC_RAW or CLOCK_REALTIME,
or are these going to be the ones that you expect to
be used anyway?

> +	if (crosstime_support_a) {
> +		ktime_a1 =3D xtstamp_a1.device;
> +		ktime_a2 =3D xtstamp_a2.device;
> +	} else {
> +		ktime_a1 =3D timespec64_to_ktime(ts_a1);
> +		ktime_a2 =3D timespec64_to_ktime(ts_a2);
> +	}
> +
> +	ktime_a =3D ktime_add(ktime_a1, ktime_a2);
> +
> +	ts_offs =3D ktime_divns(ktime_a, 2);
> +
> +	ts_a1 =3D ns_to_timespec64(ts_offs);

Converting nanoseconds to timespec64 is rather expensive,
so I wonder if this could be changed to something cheaper,
either by returning nanoseconds in the end and consistently
working on those, or by doing the calculation on the
timespec64 itself.

     Arnd

