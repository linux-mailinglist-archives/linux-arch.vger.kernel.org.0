Return-Path: <linux-arch+bounces-2825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B9872995
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AEA1F26A78
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BB12D201;
	Tue,  5 Mar 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XZ2oMdA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYV1xzR9"
X-Original-To: linux-arch@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4512D1F3;
	Tue,  5 Mar 2024 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674956; cv=none; b=ByzcLOlPUmfwycSFdl/Bow7WLkoak3LoC5nKMz2CvSPMz5c/LdsTorCeL6ab+klgUStUolh/eXHoe6DbiCZa+kwjD72VwwZIrPMj3rSBwNlkdn+8+SqwzBi6U+9sKdOfytdRqgQyl9pzhxLNcm+OBpy3ejm0U2PGOvsBke4LeyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674956; c=relaxed/simple;
	bh=wZkSkX9694x6IaB7S0oYpjmKV7DkKNY9dxbFCcaTTio=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rfhY05yYiKV1G6z8A9BYi2h0u1iVmdQbRAuBQNEZbvcsTPFlz5YjRnqY/xCbPQvmmSpGNyHxrP0IQvjpLnygDn8fcegMb8kmtzANtQejrWDhqtBg02XPq0KOo8hCbquEe90ql1RVi8dXYdcq0PdWADflSQrGi7QyU2PQwMMVs40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XZ2oMdA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYV1xzR9; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 115652CC01D1;
	Tue,  5 Mar 2024 16:42:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 16:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709674949;
	 x=1709682149; bh=Hz9n4ApIEoOa8ewx4aHPiFWUsa7oc5PoCFR5tHWnstc=; b=
	XZ2oMdA07S+7hmypj5QmtD0nNybpY6WbMrxw6JgYsyydLHTkYM1bxw1KTdED4WUn
	fwIaV2zXznYPrYc5LYEAV+VuJz2KX1qm0gcumhFs23mh4qpWQtLA2lc691Q/Uk4/
	FUemAMA/9zkuLIZz/DK7HVQVeQgtHF2lFoHxNfTrbNvUxe6gVD1VlAXYtAPCqvEZ
	noa71qckqnyqHn/nRxMFCx2+2jCqXOSLw5Sv+scjTsM/yGQpSaLHuKHv/1VsdaLs
	3mwDUdsdZEwijrbkaZGXhGpow2MlMaqZb1ZEbWNttk7KrY9eqfkOJIEXR5yoM82P
	NrKLnSQBBHwHnc78L800pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709674949; x=
	1709682149; bh=Hz9n4ApIEoOa8ewx4aHPiFWUsa7oc5PoCFR5tHWnstc=; b=m
	YV1xzR9VwNyMdvd2XxXxlJbHbTZ0OvC3pZn34wUhHPTlEO7UfqSvQyCb1RILFRLI
	B+81/OXji3z8G1HZDalct/dCiJFD316qld+uwRlKBjxSQjuwt/3wEWl4jU3oCEGo
	o6uafFR9no+xodPAC1rtnQh4dfnqoYjcRBP217iRnGy4A267tYOMotFHfey2l7Gj
	zqzW5nBLMcmOHOP+XgZdptdsRY1SAtQkz9TH7YfGn4r1VEbS9bWUV2ahYQJ9gKnm
	tCHegqOl0Fwrmj5Yqi4r9STaoj7Ldcy2mSqkCKVGL/CT3LtVFe/fvF8Fb0/9xZbA
	oQxpwmFtV2ONVC+oUAN+g==
X-ME-Sender: <xms:xJHnZXh6_Ll67eXxQ5IzrwKb7JXNcfHOjxWeF-PNY5GTihlf4JwMaQ>
    <xme:xJHnZUARHkU-tew3b4nqSUUOqwaqwVt-03sRKHJCbOgFt-tuJeQdDnZ0UngQ39xqw
    E5u2wmzDqpwqX8ZFuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xJHnZXEwrc_6UC-oU7zTOsd4x7vgSjvx6z-qUsrI4jZi8oxPsNNvxA>
    <xmx:xJHnZUSSUvHtOP8idKYag43S_3FuAJ09uenNeen5kNu3HgR6tX0xMQ>
    <xmx:xJHnZUwjhfoRh0qlfaZkMhUZF7kFZoBb1bs4TCFhBbV5ih_eY6EXrA>
    <xmx:xZHnZYUomTIt-IeObDeUChktO6Gx2l2mAGwspc1JBF7-3JHixliqgJ-IsxrdhuDf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 02874B6008D; Tue,  5 Mar 2024 16:42:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <037496c9-f06a-4946-b903-95d87d577b89@app.fastmail.com>
In-Reply-To: 
 <CAHS8izPhvRDPVHr8mY2FffPCLYjKqaazjy5NFcnJSnLK+CdyCA@mail.gmail.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com>
 <5e2f9342-4ee9-4b30-9dcf-393e57e0f7c6@app.fastmail.com>
 <CAHS8izPhvRDPVHr8mY2FffPCLYjKqaazjy5NFcnJSnLK+CdyCA@mail.gmail.com>
Date: Tue, 05 Mar 2024 22:42:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mina Almasry" <almasrymina@google.com>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Andreas Larsson" <andreas@gaisler.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 shuah <shuah@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pavel Begunkov" <asml.silence@gmail.com>, "David Wei" <dw@davidwei.uk>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Shailend Chand" <shailend@google.com>,
 "Harshitha Ramamurthy" <hramamurthy@google.com>,
 "Shakeel Butt" <shakeelb@google.com>,
 "Jeroen de Borst" <jeroendb@google.com>,
 "Praveen Kaligineedi" <pkaligineedi@google.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Kaiyuan Zhang" <kaiyuanz@google.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 21:00, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 1:05=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:
>
> A key goal of this patch series is that the kernel does not try to
> parse the skb frags that reside in the dma-buf for that precise
> reason. This is achieved using patch "net: add support for skbs with
> unreadable frags" which disables the kernel touching the payload in
> these skbs, and "tcp: RX path for devmem TCP" which implements a uapi
> where the kernel hands the data in the dmabuf to the userspace via a
> cmsg that gives the user a pointer to the data in the dmabuf (offset +
> size).
>
> So really AFACT the only restriction here is that the NIC should be
> able to DMA into the dmabuf that we're attaching, and dma_buf_attach()
> fails in this scenario so we're covered there.

Ok, makes sense. Thanks for the clarification.

     Arnd

