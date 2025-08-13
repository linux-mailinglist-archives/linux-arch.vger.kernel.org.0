Return-Path: <linux-arch+bounces-13160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E90B25008
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D803B44F3
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F0289348;
	Wed, 13 Aug 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aJCV0ycE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jf2QT+uw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D24288CBA;
	Wed, 13 Aug 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102623; cv=none; b=hrZFnSObxEnxOMbTyKg+r0/Nk/I1PLLu/V+Pnhf9umiouufkikmEXZMdlqmo1Wq0Cb/7170MykDFayKf1lHRbzc0AJLCPSJdylSQfobDSZwFXjiyHOHTmgm6nfBSIW/4KfsAb2yzAqXIUfM7QmE2vHW704pRSRYHMfGLxRF0K7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102623; c=relaxed/simple;
	bh=rIVetnmj5BGlUvq1abB6LKm1vAzyyAHS0GNloMbbwI8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bQmT2lze5zzlc6kFWofg/UQ0fmV2HXShHg7shuFj8DZ0TVyGwL/mvmQx/z6yyrsoESX2XZpkmDp2pNuBoh3PsjQhoeeCwL5yi9TR2hXNwqbxeRwHehBQmKbUmb/i697FBGe+il/mg+/bTztZukRWUpoqdYUJa8AIQ5GIKJvkFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aJCV0ycE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jf2QT+uw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13EE314000F9;
	Wed, 13 Aug 2025 12:30:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 13 Aug 2025 12:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755102619;
	 x=1755189019; bh=vjAX2/LhHjkP4rTS8b1FppYeRZTcGybCFtXL4zZ0x3E=; b=
	aJCV0ycEe4E/b3iJZLFGdEdPwf9zKYu5wPBV6/lYmnmHnXLqkzURwWDhQqhcar+k
	0up0qu66Lq0ssSgF4qdUDzmGyBkOIboI7dzaxYwKXscSRnTS/DHQE+HCTjX6RC/2
	w8dWciQKLWngikuOpwYzn6i5UOytqREebA5WW8z2t/a0zlCvQ60pbWtni6j2MPCY
	9r9mtAPBIEhhlS5H7LkD21mluvvlKNym6++s/hlVA5Tn70haUKgGIg5XzscvRdNL
	UA5a8rW8BoK0QGpzQ/d1gZqPp1dVR0ZX0mIBwhB0W86CngPdcwW+jLIuLKdME/L+
	X3TI8/69BPwGpN1c/0xtag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755102619; x=
	1755189019; bh=vjAX2/LhHjkP4rTS8b1FppYeRZTcGybCFtXL4zZ0x3E=; b=j
	f2QT+uwbg4ma5rRkOjbVDAMjhL3GNTO/HJLRKmT27dDW46cYweMgIAkn3x/uYxKX
	uV5QOhuU5f6a/k3j1MzMehMcl+kfPvyw7xBOos94SbYsvsvXZ0idy/2wAudsbXI+
	0GjgoIoN7XgUn3kHENC3Lr2jncSPkc9T1XXm1iETAVHmUksAedJkvBNTvFxRVcEW
	1OxNga5lvIpJVk6a6zgmQW7mxeJubgs/rZkgOAovSkQY3PxH+AeomqHKzmejC9eS
	qOtGguMzoAtXjbTymQFXuDULLrau9gHwyANF8YJHq7cORrVdOZPntEJ6jShzZwMT
	YtgdPmfFAfApGy06gZL/g==
X-ME-Sender: <xms:mb2caFvCbGaTtUkUQE7kJ9XzlyfC0jQl2wjl22xJk3l1Fs-tf287gA>
    <xme:mb2caOeexrCh9D_2r5I5S3EXCmwpQBd6wyy4b9Je0IupWt2z00to3iYFq4RLseR92
    r2l9_KN68w_2bkrZuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehhrghrihhsohhknhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegtlhesghgvnhhtfihord
    horhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    iihhvghnghhlihhfvghnghdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehpvghtvg
    hriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mb2caPqPzvcl5q4h1-36ODgbpQZ_uLkeb7SMfQ40uYxH1Jcjtqa6Hg>
    <xmx:mb2caKGwMrqbZvjZpMGOqrjzw3XCehG5617fvvVFWBmA3se_3nyZ5g>
    <xmx:mb2caBoecBnN6iAjMGu80iWahRWxyQt1TGHMMhiNUKuGy9LsCXnwmA>
    <xmx:mb2caA2E-PFvuHi_ugtJ1Up5bnSy-_UrWFsmoMTg-WwJpU6coxWOmA>
    <xmx:m72caGyCugxt8xU_oZbvTtN6yTgbZBFZo1n6I8P7cKKy0CEGgapGRhf6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67320700068; Wed, 13 Aug 2025 12:30:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf2626a88c2a27380
Date: Wed, 13 Aug 2025 18:29:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Mark Rutland" <mark.rutland@arm.com>, harisokn@amazon.com, cl@gentwo.org,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, "Joao Martins" <joao.m.martins@oracle.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>
Message-Id: <67b6b738-0f1c-4dd4-817d-95f55ec9272b@app.fastmail.com>
In-Reply-To: <aJy414YufthzC1nv@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com> <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com> <aJy414YufthzC1nv@arm.com>
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 13, 2025, at 18:09, Catalin Marinas wrote:
> On Mon, Aug 11, 2025 at 02:15:56PM -0700, Ankur Arora wrote:
>
>> This also gives the WFET a clear end time (though it would still need
>> to be converted to timer cycles) but the WFE path could stay simple
>> by allowing an overshoot instead of falling back to polling.
>
> For arm64, both WFE and WFET would be woken up by the event stream
> (which is enabled on all production systems). The only reason to use
> WFET is if you need smaller granularity than the event stream period
> (100us). In this case, we should probably also add a fallback from WFE
> to a busy loop.

I think there is a reasonable chance that in the future we may want
to turn the event stream off on systems that support WFET, since that
is better for both low-power systems and virtual machines with CPU
overcommit.

    Arnd

