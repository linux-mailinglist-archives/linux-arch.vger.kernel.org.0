Return-Path: <linux-arch+bounces-11115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52842A70604
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C1E1649D0
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D221D3F4;
	Tue, 25 Mar 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="esKtqLEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBJCjyD8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55C13D8A0;
	Tue, 25 Mar 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918780; cv=none; b=ee9FtrbrI6O/krMFCKtuoqw8uKwufbKSiuZZ6vSZn3CatKmY2FvZ+3mjAlqvhRduUlxpx25VVipMcaqKysI8Z4lcTx3KczrLxzwgYFNv+tV6VBvL3nJGrqKtiVnOYjBj4MXWkwlPoDMu2iwIbrye6qfzI+h1THx7GUm6PzYWgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918780; c=relaxed/simple;
	bh=wni3V1/bvtXy3LA3Xm4VzfKB0NyrZZt/omgbUesO1Q4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u82HrK2A7pcfx8zoQjh63WuJFzJrvBwODv0QhtUPs7eTdxluCkh+qRFuMse1DkTlSCxl8R17ldNMB+MuTsBpFATJb5avQpxGsfAmRF543d42g4VY2wqK2tNxjrpIIR1DSY9Yu/KK/8wx/Nhn4khqJYY6LLHFQbhRTR1PzL+BwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=esKtqLEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBJCjyD8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDF3B2540092;
	Tue, 25 Mar 2025 12:06:16 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 25 Mar 2025 12:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742918776;
	 x=1743005176; bh=i5gIEhSWhDc/CD1KGDEUUBNtkR8QlRiEolUuUnkGdoo=; b=
	esKtqLECGr8TnPL6JwLrbJMgFt9hAUdzWjtnA1hBjI7LokNiM1mzUpl4lmq1IBrA
	LJOjm0W/xiAXT83nARr3cfy3Q2a4MvS/trAgesz2F09GJhWw3dNBStLevaETknjb
	iU9xtTHQL3k3/28ZWAkT1TVPsd1/CyTI1OxtUra4Mz6AVj1d/yxkOu+cTZbZaptB
	96qG1xIsLja+IX8lLTK+Ly8IeAd9Io+MziiKSz0obPJiLWlpgqn8c9zNDNg5Pc19
	Dl3SNSgKjJwYJhViGL+CiICkbag2Pq3ahdFQM1AvZBrfaKEXeuMMAXqvcbTZXlO7
	o0sxoD30kRjiA/VcUfVcKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742918776; x=
	1743005176; bh=i5gIEhSWhDc/CD1KGDEUUBNtkR8QlRiEolUuUnkGdoo=; b=m
	BJCjyD8cynsrLMJbTNALq1x9FuqAyfDCCxxqTW2tnG5K+Pkxr0gSBNcfs8xLOmFo
	TiK0wZlWzkjl1OiTk1DxCewKkq/lPfotYFsVusKCNtsXlxGde9vvbLGUTw0DRc8W
	sdzxFcAtlCYJbW9aeupmTAJSU7h7SdJ8BvpnvoRnKKqrNTaRyozQqHYCXWLAaDYX
	2MNIB62+sDMypBkhAXp18sH+dnMoIDR6BJTfYJ1mT4jyvlmGkUq/Ef7W1Uvqvlcv
	oHzWu5EiuhXnoxyCyshQRipCJtNWPfX4QIWS6N9oC07Us81ayEO+SynOxDsoT5ip
	+25mIyqgQgDU6dWPgn3TQ==
X-ME-Sender: <xms:eNTiZwQlPft4XSGRBXtVoJhgFD-vKRjCjv4oPdAhBskETnzprfZGtw>
    <xme:eNTiZ9x28MeQ3cTw5PO5lrE7uhedBL9lD7oIfOxTU8hc6L2AUwszexsSBF4-LT1Y9
    AxkH4qVgslJrAbGEv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughvhihukhhovhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepvghlvhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgrshgrnhdquggvvh
    esghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eNTiZ92bXH6QFbxQO7HBGMa0g4GARgz_nwJE28LhKcPrr6RmFCwNAw>
    <xmx:eNTiZ0BXFpzb0QGtoIFoaLaggqk1VxeUOnLPOsKLZn4NPKnEZxM-Aw>
    <xmx:eNTiZ5hqKrPp0M7VQwCUhrF7Pxau2BZKq4SuyuPhjyxp0dwGmUgcCw>
    <xmx:eNTiZwqP2vlLz9nuyx9gTFNWMhpW2MI75QxDR3nefI3irdpX1BxA7g>
    <xmx:eNTiZ3YkwhbNrX_V5IcNwWphY-Fxw97ZuQL3WccceM9V_GtiEYOel2E2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 61E852220072; Tue, 25 Mar 2025 12:06:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T022a60d36d02d9f7
Date: Tue, 25 Mar 2025 17:05:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jann Horn" <jannh@google.com>, "Marco Elver" <elver@google.com>,
 "Dmitry Vyukov" <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <26df580c-b2cc-4bb0-b15b-4e9b74897ff0@app.fastmail.com>
In-Reply-To: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 25, 2025, at 17:01, Jann Horn wrote:
> Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
> This is a low-priority fix. I've never actually hit this issue with
> upstream KCSAN.
> (I only noticed it because I... err... hooked up KASAN to the KCSAN
> hooks. Long story.)
>
> I'm not sure if this should go through Arnd's tree (because it's in
> rwonce.h) or Marco's (because it's a KCSAN thing).
> Going through Marco's tree (after getting an Ack from Arnd) might
> work a little better for me, I may or may not have more KCSAN patches
> in the future.

I agree it's easier if Marco takes it through his tree, as this
is something I rarely touch.

If Marco has nothing else pending for 6.15, I can take it though.

       Arnd

