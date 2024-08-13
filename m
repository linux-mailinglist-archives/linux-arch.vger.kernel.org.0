Return-Path: <linux-arch+bounces-6178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A7950909
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9393B25D87
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C11A0712;
	Tue, 13 Aug 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz/8AFXr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F81A0702;
	Tue, 13 Aug 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562778; cv=none; b=FiFRPKjgBIMtckf0FQGy2769Llk6uE8x0JdewxQ8sAjTksN1TW9RAjdhOR4PhiGpwY1cmNgTivEtr3lJwhuwtxODVN9mJDSsqLNCKPWgXnW0WcBFZI5WlJItFTQ6IfzOQ3qbi7jMa/t7HXqwl1VnFuztrziuByw2HKFhebwNT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562778; c=relaxed/simple;
	bh=IUkzPMLKL9hxrVCRse+Tn29r759bkrevm8jISz7/NVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbsOmQQdGWMDbcfV/jpIGkSGX0p1u501CI9Yu9agfQy4Qxq04hiin40huzffZRJu7XUMLTcF3C2jxa2Q0SN7QfDrt86kDa5aBOLX2SMZcJKixc3NE5BXCQ7C9D9rEjLFqiUFseTcz8/xhvG37IrsLVGpnF/DZK98HCmld2TnxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz/8AFXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8B9C4AF09;
	Tue, 13 Aug 2024 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562778;
	bh=IUkzPMLKL9hxrVCRse+Tn29r759bkrevm8jISz7/NVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lz/8AFXrJT9670zCrN4KWrpS/qHfbJzVH2SwYK+34AfLrA0BJHSl1PU5fdFq+JWZF
	 w9W7Lypd8K0zGJCHv5Z/sowDvHbYIfbBp7Qrv+uZy7QgzSdkZdmwtxEfMb3IxqQSoB
	 Re677vy+gy/FDsDswIsBN++DRbLYmQgLIZBpwC/UbUBIqKIl9qfbd4QQOOynyku23w
	 2ExdG33d3W2Y0Ga5N8uD/ONPmABMxCL57CGjbBP/gVYxH6EyTFuoBnFWbjoDlc5fQO
	 FYeFxXWOZWcjtZi+psvbkL8E5jSTK+NUzEh6Wp+GLlYhD96vdQ4pN9L3CGpgMeVw2Q
	 PVEWD+5jh8ZgA==
Date: Tue, 13 Aug 2024 08:26:15 -0700
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
Message-ID: <20240813082615.53693b97@kernel.org>
In-Reply-To: <6a779dbb-ad3a-47cf-bb8e-1a50732a9694@gmail.com>
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
	<20240813073917.690ac1cc@kernel.org>
	<6a779dbb-ad3a-47cf-bb8e-1a50732a9694@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 16:11:15 +0100 Pavel Begunkov wrote:
> On 8/13/24 15:39, Jakub Kicinski wrote:
> > On Tue, 13 Aug 2024 03:31:13 +0100 Pavel Begunkov wrote:  
> >> I'm getting lost, so repeating myself a bit. What I think
> >> would be a good approach is if we get an error back from
> >> the driver if it doesn't support netiov / providers.
> >>
> >> netdev_rx_queue_restart() {
> >> 	...
> >> 	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc();
> >> 	if (err == -EOPNOTSUPP) // the driver doesn't support netiov
> >> 		return -EOPNOTSUPP;
> >> 	...
> >> }
> >>
> >> That can be done if drivers opt in to support providers,
> >> e.g. via a page pool flag.
> >>
> >> What I think wouldn't be a great option is getting back a
> >> "success" from the driver even though it ignored  
> > 
> > page pool params are not the right place for a supported flag.
> > Sooner or later we'll want to expose this flag to user space.  
> 
> Fair enough, it appeared to me that's what you was suggesting
> 
> "What comes to mind is adding an "I can gobble up net_iovs from this
> pool" flag in page pool params (the struct that comes from the driver),
> and then on the installation path we can check ..."

Yes, we still need one flag in page pool params -- functioning like 
the inverse of PP_IGNORE_PROVIDERS, I'd call it something like
PP_CAP_NET(MEM|IOV). To distinguish the header and data pools.

> We can also move it from pp flags to queue API callbacks, however if we
> want to expose it to the userspace, I'd imagine we need a queue flag set
> by the driver, which then can be queried by netlink or whichever
> interface is appropriate. And it can be used can be used to fail
> netdev_rx_queue_restart() for queues/drivers that don't support mp.
> 
> netdev_rx_queue_restart() {
> 	if (rxq->mp_params && !rxq->netiov_supported)
> 		fail;
> }

Yup!

