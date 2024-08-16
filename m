Return-Path: <linux-arch+bounces-6274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512C8954DDF
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E361F2555D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A61BDAA6;
	Fri, 16 Aug 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKSTGrm8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CA1BDA94;
	Fri, 16 Aug 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822514; cv=none; b=q8vdHNDbEtIVp/Jle4ZR6+Qb0Q2g4qgWqA1nO4BCiOQUoiu3YE5CiN/NvmxC+l19eHqfkNLfS68Wyz9ROfQo4DzeyRACsH72BHFtT/z1uUsxNW6pVdEYh29cOUq+gwpxW4G5FApEprUi1lSiw6iAMo0nPyjk1i7jTRrePYT1TO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822514; c=relaxed/simple;
	bh=Q18cNSCViMkznglQB7U8THt2jlE6uRjEx/JSrUARwzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfDIvowUn708IFttF9aIWWLZhB9jvsVT9fLhFMcle1MI9fav49grmqhGIY13TsYQQUXajDVB8SCq4Nc9KOIPTPoNt26ucXVjL+EQNFzQT1k+iFGvUeaLAz3s+DGK9P3YCe54ZAB1SKCrBv5pM/aJz7JRsXRJ3TR81a04RtUVp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKSTGrm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C32C32782;
	Fri, 16 Aug 2024 15:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822513;
	bh=Q18cNSCViMkznglQB7U8THt2jlE6uRjEx/JSrUARwzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bKSTGrm8LaF2gwztx+/6SinSoy24s5gR4CldYRBEkiNOSwgcpm7hLvrrK2gtq0Pvx
	 hMOv7Np2xjcElkjbz06G6kxT1paCcuIl6tgDnhA1FReWgEk0VrJIV5VnmY28VW+uM3
	 rZACO8v+MYhjqas3sNB0o4umHsNfCDqpROl01Mt/tH5odX/nLSTCmpnMqAFo9lHFii
	 7gaHt6gXGlFMnEUaVC739Sgm/hKhGjvNlG4yZPxcjScZu7DwFyzYVs8aZxgV2ToxjC
	 MflEhOxEm/9blSXnL7eNEt3U0O1uRbAir3rluhSYsWuh/JjkeQLFqL1D7S/NCKi2I7
	 8SQyYhQ0iAcDw==
Date: Fri, 16 Aug 2024 08:35:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v19 06/13] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240816083510.3386fb10@kernel.org>
In-Reply-To: <CAHS8izO9LDM9rLVnJPgp6QXb4YLW5+3ziGOHTqScy-SKOLejYA@mail.gmail.com>
References: <20240813211317.3381180-7-almasrymina@google.com>
	<de7daf80-a2e4-4451-b666-2a67ccc3649e@gmail.com>
	<CAHS8izPMC+XhXKbJOQ3ymizyKuARSOv_cO_xO+q1EG4zoy6Gig@mail.gmail.com>
	<31640ff4-25a6-4115-85e6-82092ce57393@gmail.com>
	<20240815182245.2b5e3f44@kernel.org>
	<CAHS8izO9LDM9rLVnJPgp6QXb4YLW5+3ziGOHTqScy-SKOLejYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 08:20:44 -0400 Mina Almasry wrote:
> > I'd keep the current check with a WARN_ON_ONCE(), tho.
> > Given the absence of tests driver developers can use.
> > Especially those who _aren't_ supporting the feature.
> 
> Yes what I have locally is the driver setting
> netdev_rx_queue->unreadable_netmem_supported when header split is
> turned on, and additionally a WARN_ON_ONCE around the check in core. I
> was about to send that when I read your email. I'm hoping we don't
> have to go through the scope creep of adding configuration via the
> queue API, which I think is a very significant undertaking.

I don't like adding more and more transient stuff to netdev_rx_queue.
It's one thing if we create a temporary solution in the core, which
we can easily redo later. It's another altogether when we expect drivers
to keep some bit up to date across all the reconfiguration paths they
have. Just to then got an replace that with another API.

If the post-check works let's go with that for now.

