Return-Path: <linux-arch+bounces-6176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A919507EE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F9A280DBA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95F19EEA0;
	Tue, 13 Aug 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJUMvPwY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F219E802;
	Tue, 13 Aug 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559961; cv=none; b=TuO4QbzTBMr5oFp40Y3QwOdSkxiSrFmymYJTRg/kz6oOiIGej2LGcl4MkTzz30Rf6j/cB7bswh88YTXOC102dc7Uvn4mZ6qLdvZ3AZ9e0eETFVhqf9idpBiCSd1GZnsbu8BviXxO6EMXW36ZdKeo2/9D6AICqmn8XhX4DKRpd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559961; c=relaxed/simple;
	bh=BkMT1oZs8wsRPi0UzxeExZ+sMn6QcdSVOxPluJLt7fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgIG9oAS7o+mmdqIhPmDoFD+K0YJXKsnfVrUNrYrhr2IO4g3m0dLptqSzRekY1aC5SfBjsfrRM7DIlXn8V22YX3b00NjZztyFO9tGVLkUtdXGBMWbpf8ctgEXLrXHjJ2kzaDVp/EF0O5XJ4UQupZR1+huJtVr6VKdRSHHue/Q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJUMvPwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C51EC4AF09;
	Tue, 13 Aug 2024 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559960;
	bh=BkMT1oZs8wsRPi0UzxeExZ+sMn6QcdSVOxPluJLt7fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJUMvPwYEz4twWJkX2/DBO6lgBCLmry7xNwcj7mHVF1Wu2r8anDxNlilhF+jy27aG
	 Jx4dgTgc0s0HDaUublN5PoN+H2skcCgaLvJGlu/2GxlZwYI7trTSQQXdb74w8R7tRn
	 kCAPwm2Cvvz4ybkwcPKvuy2ErXaxmTGR863mS4+qtva0pxa/f44xuE8jHSz/3UVCmz
	 lVJkV9Q5J5+Req3XUGUlQgEEwM+nqyKtfAcw+m/7oLQ42wuYXHvL56R/79oq9hyP1W
	 bTxxyYQPhwO7iNiUaDaMkCYKVsACtIKK6NbL+EWpR45m+gJVBf9pcDvFLplWXr/S3t
	 BGr028oZ7DLMQ==
Date: Tue, 13 Aug 2024 07:39:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240813073917.690ac1cc@kernel.org>
In-Reply-To: <5a51b11d-9c35-42a5-879b-08dc7ca2ca18@gmail.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-8-almasrymina@google.com>
	<20240806135924.5bb65ec7@kernel.org>
	<CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
	<20240808192410.37a49724@kernel.org>
	<CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
	<fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
	<20240809205236.77c959b0@kernel.org>
	<CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
	<48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com>
	<20240812105732.5d2845e4@kernel.org>
	<CAHS8izPb51gvEHGHeQwWTs4YmimLLamau1c4j=Z4KGM8ZJrx5g@mail.gmail.com>
	<a6747b29-ed79-49d4-9ffe-b62074db1e09@gmail.com>
	<20240812165708.33234ed6@kernel.org>
	<5a51b11d-9c35-42a5-879b-08dc7ca2ca18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 03:31:13 +0100 Pavel Begunkov wrote:
> I'm getting lost, so repeating myself a bit. What I think
> would be a good approach is if we get an error back from
> the driver if it doesn't support netiov / providers.
> 
> netdev_rx_queue_restart() {
> 	...
> 	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc();
> 	if (err == -EOPNOTSUPP) // the driver doesn't support netiov
> 		return -EOPNOTSUPP;
> 	...
> }
> 
> That can be done if drivers opt in to support providers,
> e.g. via a page pool flag.
> 
> What I think wouldn't be a great option is getting back a
> "success" from the driver even though it ignored

page pool params are not the right place for a supported flag.
Sooner or later we'll want to expose this flag to user space.

