Return-Path: <linux-arch+bounces-11118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D5A70785
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0343188C8F5
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22125E476;
	Tue, 25 Mar 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cas0BCBQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvfwj1bg"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B301547C3;
	Tue, 25 Mar 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921979; cv=none; b=WgrBXQZTJfQDCZGKgk3FPLFP28eTxfZAT6YeYVoCPUVayrKncYdHZQTZL8ownQIkH6sLlxOKipBONdXo7IzXxzt7FZ08FN2cXlvGZxSJOiVpzwc9YDcWd68sbMu1Irb4OZ6j9nQCIqtNPy/ea2mgtHo2Mj8QsBCFqoyjfhBrHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921979; c=relaxed/simple;
	bh=4W3BIyRaHFe7PrPpyfwCQpUYd2ckXMij+VhkaR9rlRg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bhEylzo2yb4uMkSavKE22T6TSmOGZOOAbyNkKq51nUFDl7Mm5zRoX9ngNYYDJOfHn+ASlv+QGpWmKOu7wuMX3nneAcfbG9kJJXWEyRSpC/YmIpGRoNzB/2I2cRx7k4Oev66bjYQ7XW6Vgr9+NQui5JCsncPOk00lVN6nN66dNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cas0BCBQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvfwj1bg; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 40FF111401BA;
	Tue, 25 Mar 2025 12:59:36 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 25 Mar 2025 12:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742921976;
	 x=1743008376; bh=1kZo2dIkUctXPOLQlyuKriYib5RXb/4Fue46r1qeads=; b=
	cas0BCBQftI1df3SZtZgrE0YSKFUoiJyXMQOZvaybeuvTrAn5y0BQdOii8p8E5Lo
	Wy5wBLqr2saZP0030woUFSD1unTwp0GIwLS+gZ3LUiX+wzg1hloTmoTEy5NQKBrt
	TLO5cvQh1XEOMZVWFkDbE0udFUT2AtDf2/m8OYtF0uuj6Huj20IwBagVLIPvRrcy
	Z02qCi9bgS0s969pxMrXdpOr0ItgzsL+cch0ZQ4bR2Lv837ZKYxzuJiKc6Wh5kvN
	yik/O/ciR6CKkpfyuBhVhYnHKsYnSySSvKtyhjAiZ+OXt+k8AV4Gn47IVrFSA3tv
	DCyb8CSiQOMvyo+ZxlaxmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742921976; x=
	1743008376; bh=1kZo2dIkUctXPOLQlyuKriYib5RXb/4Fue46r1qeads=; b=g
	vfwj1bgtD3IXFawdKt9BBjcBjjtWJYms8t2QHBDDqLYUMAfzg1W8pwXNfc3jTXTh
	RN76OFW3TqT6JTBwOPyijrPF2cTAZ61zQmRA4tycyAh6fxupY1jx5juG+TdS/k0Y
	XY3Pki1aukDuffzt/yXm8sQa+/4byAii8Ut2YThF3EiZ9MSXdzAxxd64h3DLJl7u
	FplSAPUWx+xkqyO06TlSSfDsipc1FLAn+mIfYLSplT/NWqNjLmiDRKiWn4Tun3kE
	VMJV3FlU1uyWX8e/GOw1ULhDcJ3F0ZMzU5gRgA26AhFANYlEXiU/ngs7XEsqgFI+
	EfvE1kpYpUNgAXK9sCLcw==
X-ME-Sender: <xms:9-DiZxg08AyG8NQJG_o8Xk3DBrrx3Pw16TSkR8-tc1XrxE30DhysZA>
    <xme:9-DiZ2DaKW-U94kxMtFazEIvd6UgUYctMBmcXRiaHOmJxIv-8_CaLVtXJ-wp5kQrA
    xC3cuEJw5bgdEEZktc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedv
    vdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughvhihukhhovhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepvghlvhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgrshgrnhdquggvvh
    esghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9-DiZxGT5HYiuXiurSrrYEElDS_5tE8daS5nTZe49bbPi4HvVLsePQ>
    <xmx:9-DiZ2RQA5Lw5HAPc-QXlWJC5cLJfg920U1ceCsi5scu-fqOlefSRQ>
    <xmx:9-DiZ-zWFjamXMMJ6ZN1uRs0CufpBX1dXFiiibdgfHzQl7Oiu7PjXw>
    <xmx:9-DiZ84mSNf77RxbnO4xkODeSzNv2MOseFCKbeGE3YwKfWoZCFT71g>
    <xmx:-ODiZ1oUaxOfKSLrcy47mz1kvH3WB-AvHtxfzNnliw2F8e4BWFi7cM5o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C90822220072; Tue, 25 Mar 2025 12:59:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T022a60d36d02d9f7
Date: Tue, 25 Mar 2025 17:59:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jann Horn" <jannh@google.com>, "Marco Elver" <elver@google.com>
Cc: "Dmitry Vyukov" <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <fbd8d426-e45f-4f2e-b201-20b8396b20f9@app.fastmail.com>
In-Reply-To: 
 <CAG48ez2eECk+iU759BhPLrDJrGcBPT2dkAZg_O_c1fdD+HsifQ@mail.gmail.com>
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
 <26df580c-b2cc-4bb0-b15b-4e9b74897ff0@app.fastmail.com>
 <CANpmjNMGr8-r_uPRMhwBGX42hbV+pavL7n1+zyBK167ZT7=nmA@mail.gmail.com>
 <CAG48ez2eECk+iU759BhPLrDJrGcBPT2dkAZg_O_c1fdD+HsifQ@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025, at 17:36, Jann Horn wrote:
> On Tue, Mar 25, 2025 at 5:31=E2=80=AFPM Marco Elver <elver@google.com>=
 wrote:
>> On Tue, 25 Mar 2025 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tue, Mar 25, 2025, at 17:01, Jann Horn wrote:
>> > > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer inf=
rastructure")
>> > > Signed-off-by: Jann Horn <jannh@google.com>
> [...]
>> I have nothing pending yet. Unless you're very certain there'll be
>> more KCSAN patches,
>
> No, I don't know yet whether I'll have more KCSAN patches for 6.15.
>
>> I'd suggest that Arnd can take it. I'm fine with
>> KCSAN-related patches that aren't strongly dependent on each other
>> outside kernel/kcsan to go through whichever tree is closest.
>
> Sounds good to me.

Applied, should be able send the PR tomorrow with the rest of
my asm-generic changes.

     Arnd

