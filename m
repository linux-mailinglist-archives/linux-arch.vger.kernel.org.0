Return-Path: <linux-arch+bounces-14372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0DC13951
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514D64E28B6
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE222D8DC8;
	Tue, 28 Oct 2025 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xq7ERVrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eodsjk9g"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D12C17A8;
	Tue, 28 Oct 2025 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640996; cv=none; b=p72MLnObd41MrcZ2luyYKXTE34Nmj0j7tobsGwL6VUKd9+xUUTZqmQOJ2tHaxLdwzytDfsQ8iv++gUYG7j7knCoI575cYQHobu+Cw0nS73ElHKrhkb4No7NhqmJ4NWfypOSfKgefWDFYI4JVJX4n1AJDWL/khDrBUSC93ERKRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640996; c=relaxed/simple;
	bh=24piICuL1TFvQkkPUpBURn6MSOHQmPj30SRS3p89FRg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FJ/5obfr1rUlKrMI/pgZKuVbC65p4JNb2d1yFeztGVDgQS2Krs9SEWLc1QiTubyn5YUee6Y1cMdOzmTbNPiN8MTRAIOjaPAqaN0IzxSCmFPaT/rR+HYVnS2hYR2eVZ4UVomRmT9wtz0w2bp8JKxZ/zoReEmhvsDnmI40eNx2uP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Xq7ERVrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eodsjk9g; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C646EC049C;
	Tue, 28 Oct 2025 04:43:12 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 04:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761640992;
	 x=1761727392; bh=0JJIkDhabFeQu41OWvb1I0C49bKjs5BXbI+33V7E/DI=; b=
	Xq7ERVrJvCMn7KM+GJIjGJU6l/nnqobgi2ttOFMlQ3gzVppaypAMXeNoGpJG6J7w
	iU4q6IJEeMYQ7SAACfECkIOrlyiKMWDfdYWzsl73R1f+8KzfecXegG25oGI0xMCz
	dOXuwLiI63yhQNuGnf8bko+4nJXq0rGCKPHCxoBak7JxJD3/+Av6Ryjk2j4u+cJZ
	Ghdgf2CQxAh1RnArZ3j10fmuwkMad8qPZQOTiyNvrDTBwYyIgzX0AFwRJ91gA2L5
	VqaOwLG/kMSmJHyy7ZbAedUj3lonwWXmGHmDYJ4fcvy0FPXe8iNwfeXFKNLtQedX
	o2ywp7YtllGKuWrJLW0GOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761640992; x=
	1761727392; bh=0JJIkDhabFeQu41OWvb1I0C49bKjs5BXbI+33V7E/DI=; b=E
	odsjk9gmyhy5abk7WI2miFV+T87z564P1AYR2TvLZGQpqArDmPokF/t722n3I4Tj
	EpyVxm/uAn+B/CYsExrbwg/Ym1wj4JcV+ZXs+foGaPgnXUpESUdCszPEwxut/zFX
	xcV3bSxllP3wL3eb7VK35iE0S+g0Bv1b2tN/3WjNv7KFE9KeHHvMBwmfVdHU5bLN
	2i+DFfnEauC8R0f4aLHDvo4s2qkQGmvwPl5ODYfWEEVxmNgQbRCu/9+UrtQDsAp2
	McBvjLHmuFvxcH7KzrGNlPW/+MzCC0ohSNNRNr0BzoIAq5V1sil47l8i1m6Ne+yD
	gj+ehDon30hPc80oq9r8Q==
X-ME-Sender: <xms:HoIAaUtaYFqBbJcPsIwH_N9aBY3VmmgjKJsuzycGO5yhkf5od7uupQ>
    <xme:HoIAacSn2C6gyejJUVK9jxPnsznK09RRPtkVN6ix7AeSkMwhE7L64Q7_h61Ot49T4
    DU0HE5d1ja8ZDWj0zMtyVbwIxkocyj4fqybNYAX81eNbgbEp7ckiN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehhrghrihhsohhknhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegtlhesghgvnhhtfihord
    horhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    iihhvghnghhlihhfvghnghdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehpvghtvg
    hriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HoIAaRK98uVZXggexNZJxfpOi2NhgCDBpdBortjF4YEFlnX-7575tg>
    <xmx:HoIAaYtT4qxWDTg6TXCMRVb6I7jai_a5cVtV7XatpNk52wWObCtxyw>
    <xmx:HoIAaZsQi0-T0s8zmmp7YXxMdSo49olveWp-cJiaKFFMl0_-8Q_RPQ>
    <xmx:HoIAaXVHVooVmeleiM97lpwcJ8DxjnGIMcPMdIXgwf_9CIvgOPFLpw>
    <xmx:IIIAaR6OVmbqtFe8haMko2FXa-g9Vh851x94veFTolgXUIvEFDoTVRSF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B93ADC40054; Tue, 28 Oct 2025 04:43:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ab2ZwGVH8-qs
Date: Tue, 28 Oct 2025 09:42:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ankur Arora" <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Haris Okanovic" <harisokn@amazon.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, "Joao Martins" <joao.m.martins@oracle.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Message-Id: <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
In-Reply-To: <20251028053136.692462-3-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
> Support waiting in smp_cond_load_relaxed_timeout() via
> __cmpwait_relaxed(). Limit this to when the event-stream is enabled,
> to ensure that we wake from WFE periodically and don't block forever
> if there are no stores to the cacheline.
>
> In the unlikely event that the event-stream is unavailable, fallback
> to spin-waiting.
>
> Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check for each
> iteration in smp_cond_load_relaxed_timeout().

After I looked at the entire series again, this one feels like
a missed opportunity. Especially on low-power systems but possibly
on any ARMv9.2+ implementation including Cortex-A320, it would
be nice to be able to both turn off the event stream and also
make this function take fewer wakeups:

> +/* Re-declared here to avoid include dependency. */
> +extern bool arch_timer_evtstrm_available(void);
> +
> +#define cpu_poll_relax(ptr, val)					\
> +do {									\
> +	if (arch_timer_evtstrm_available())				\
> +		__cmpwait_relaxed(ptr, val);				\
> +	else								\
> +		cpu_relax();						\
> +} while (0)
> +

Since the caller knows exactly how long it wants to wait for,
we should be able to fit a 'wfet' based primitive in here and
pass the timeout as another argument.

    Arnd

