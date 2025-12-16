Return-Path: <linux-arch+bounces-15457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EACC14DE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 08:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DDF83006DB4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36486338F5D;
	Tue, 16 Dec 2025 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AYPQrNpc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJSez4Ov"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA19338580;
	Tue, 16 Dec 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869868; cv=none; b=i0HBPSmuUsVK595p4P9HeWLKSRyLVpetTCeyrrcEWQpBCAqMWDq9r+96Y0COhFxhICTuvc1QU/GvyF5EcJ6qVMkrjc/pr2U+KOFfQr6mYq2RTjdeMgjK0lc1KOK4zgiHtQnfo+mVQucCw0R8hIL+ZnwLph7NL8wRebnEAe30x08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869868; c=relaxed/simple;
	bh=5MIBFvwLE3WsuDYqY5Sp6ySSGvydu0UZ6fxNAobuTl8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HgfZKIHGNkwoMHnE7aqihwHyJQF8PekDKv+MdqWPx9MF6TxD2lEzyzsM0XkopLZcznuvWjB0bomtNNUsrv2ofHLdN7KJyAaegTXuZKvouvKk8/w0TAjsrpHk/BoB8wzuLNIoH372OCZvDR3uLIGuuWc2tMoOidtJpazAELjZQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AYPQrNpc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJSez4Ov; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF4A71D0014F;
	Tue, 16 Dec 2025 02:24:24 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Tue, 16 Dec 2025 02:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765869864;
	 x=1765956264; bh=5MIBFvwLE3WsuDYqY5Sp6ySSGvydu0UZ6fxNAobuTl8=; b=
	AYPQrNpckR/1BLO/jWOmSrEjaGk5VWp4K6buNvphEOgxYwCWXIS/7ttKSEHkB4Q9
	DmY3LUrFRmki3mbm/TH5W/pJT7t8ulSNIisB23dkQVJrOS3jk45UyM4k4355NhoU
	2f8KZgjeKm+GQh+FDSAC8a8aNaiEUU5geJk4xkPaAKCXYaMIxHd1Xi+50ElXP0mC
	EPE2Hk8uJ8InUp8FV6USc44zsTKehBvQmh2jjT2bYr/w44UqB1sjutJjQLsAj9se
	SV9xzYmOeePy8wxjhkImgnS1oU/RZKL9+dya/UzQw5QBs3A3GfLrWrS7V4q97n8T
	OeTxmgZoqAdfmYtl2/bChw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765869864; x=
	1765956264; bh=5MIBFvwLE3WsuDYqY5Sp6ySSGvydu0UZ6fxNAobuTl8=; b=A
	JSez4Ovbu87uY7s0h6B9zO7W8+4KAeaJT7GaosQucw9Wmx1KXQbNrInHLNu+TNOS
	RwrfVDGA8GdIXbl7dd/kXM1Fb+MJtLSD3UmmVYPOKsB5I/cqjeiYbJMHt5TZa5/V
	WowfDi6MjoOqkVWjLbWMbnsFD1ig+rDjVSZ/BCR8Pprv0euLDXzr7mp3lw39xc3o
	MrruafO765Hu4i+vkyfdGJLDVrIG4RWfBrSn0elXX4u5InBhbRauW0uF9FDSSx0X
	PMb2FLPouoNOw0kXBUIxa7rgAFmSnwT7jPvATgEYPvLjKxNe7cb4Pmgkg61RdPj9
	FjjlK/duiRrusRVXAv41w==
X-ME-Sender: <xms:JwlBaSn5dsy1zVwBSa-XnS18LFhNsccQreHpQ1mGTtu_C3NQJ2pXsw>
    <xme:JwlBaUrA3Q3VA4QD9R8RGo7_bpVrmQjw22f_4wT6VZSGCwVOVrh48mtOfiv8VtmtC
    8hELE2iQIr1DCAIkLB1ziLKkwo8mCVpF9iulHMiUkSZOdHozlqpJd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehgrghrhiesghgrrhihghhu
    ohdrnhgvthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprh
    gtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhn
    rdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhose
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-ME-Proxy: <xmx:JwlBaYh5f_qVfePiB3g9pN-n371fvMO6olt36QO_IPGQoL4r_siq9g>
    <xmx:JwlBacD_sprqLwjw3gXupck_wlxpig8A7tUqJV2as9l1P1nn-0rk6w>
    <xmx:JwlBaWu3xcNlW2uXbWhDBh1bGghgsJE2JCucC6CPOpO3hKr1-xX9rA>
    <xmx:JwlBaW5M5t1QHZATiEwpLWz23E0-oHjjK2Jmb_-fyocAg7ZBfMSJng>
    <xmx:KAlBaWfGctzHKoVjcQ5EI7s0fdu-aOHp_VEdyQx3LUx9RwXUIEavZ9Ii>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CCA27C40071; Tue, 16 Dec 2025 02:24:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwemBkxk8zs-
Date: Tue, 16 Dec 2025 08:24:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "Mark Rutland" <mark.rutland@arm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 bpf@vger.kernel.org
Message-Id: <be416313-1f49-4275-80a2-3cb0826a67e9@app.fastmail.com>
In-Reply-To: 
 <4ff540deaf87eb24ba11bbac95bdbea68d22a129.1765866665.git.fthain@linux-m68k.org>
References: <cover.1765866665.git.fthain@linux-m68k.org>
 <4ff540deaf87eb24ba11bbac95bdbea68d22a129.1765866665.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v5 1/4] bpf: Explicitly align bpf_res_spin_lock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 16, 2025, at 07:31, Finn Thain wrote:
> Align bpf_res_spin_lock to avoid a BUILD_BUG_ON() when the alignment
> changes, as it will do on m68k when, in a subsequent patch, the minimum
> alignment of the atomic_t member of struct rqspinlock gets increased
> from 2 to 4. Drop the BUILD_BUG_ON() as it becomes redundant.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

