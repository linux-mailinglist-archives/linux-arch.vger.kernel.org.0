Return-Path: <linux-arch+bounces-6383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8C958AF4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231541C20E86
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E561922D3;
	Tue, 20 Aug 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhV8y6cZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563F43AB2;
	Tue, 20 Aug 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167164; cv=none; b=GAgZ1fcQJjyce0xijztQpkh11TlYhyUfjFMI613gfr9YGwU24fHcRDqKKZcYRUc/AvGrG4qcb2JTnafUMqlurvBUrEUMeFV33t+HZ0mqcNtH/hw4EQ20d0GThF5Z8zpsdyIjSIr0JmF8bwoTPeokG31VTGhWoJoKrkzzpb+lq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167164; c=relaxed/simple;
	bh=/OXYNA076GPRELh0pHtb1LqJyPMWNb0FBe4CzjTGaQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rARUwhGbhgokb/StUb2LFnp/qnlFJVzcsT3458/D9g+/I7+QdgLTYnNHR0AEBZINYC4dN/8+7NQSoN6tlVmIwFQ/M1WNV4lxGYwbJ/mhHhaQSYO2Hfq2zEOEBGx7OfWWcb1F4SA3pJh4jb5TdGQpRIZPlNjek8rC6GFvo6Rv7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhV8y6cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899F1C4AF0B;
	Tue, 20 Aug 2024 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167164;
	bh=/OXYNA076GPRELh0pHtb1LqJyPMWNb0FBe4CzjTGaQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhV8y6cZBCxHcRXtyBXg5fkxQ0emSjT4auJjQk+246Tw8eD3OUCE057w6/vUhGK+Q
	 RBjicnT8mi2sKTBuq0JANhVJTDhMvdUqDUjecxktxoY+vMrnz4MGVdsNOpaqcNAw9I
	 8huEtnENFiJFKoN9IcbUvsltqlewOPHIwnN9eFpsuawwCJvXkDlHhiXl7L7Wur0fpu
	 tpAX/YFnzoaY+ZA/9o5gRvZTPhKxlmy+9Auiz50bY1SO6+EAmVeqJQ3ehrBxhx64mc
	 3Inbdd0jxjd2cxDx/Af/1fV60ySoP0m+sl/9zoj0NBHNWDP6FteTyA3BOpW4xPB0UC
	 8Lpljm3h/QgEQ==
Date: Tue, 20 Aug 2024 08:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
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
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240820081920.6630a73f@kernel.org>
In-Reply-To: <CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
References: <20240813211317.3381180-4-almasrymina@google.com>
	<CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
	<20240819155257.1148e869@kernel.org>
	<CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 00:01:02 -0400 Mina Almasry wrote:
> Took a bit of a look here. Forgive me, I'm not that familiar with XDP
> and virtual interfaces, so I'm a bit unsure what to do here.
> 
> For veth, it seems, the device behind the veth is stored in
> veth_priv->peer, so it seems maybe a dev_get_max_mp_channel() check on
> veth_priv->peer is the way to go to disable this for veth? I think we
> need to do this check on creation of the veth and on the ndo_bpf of
> veth.

veth is a SW device pair, it can't reasonably support netmem.
Given all the unreasonable features it grew over time we can't
rule out that someone will try, but that's not our problem now.

> For bonding, it seems we need to add mp channel check in bond_xdp_set,
> and bond_enslave?

Sort of, I'd factor out that logic into the core first, as some
sort of "xdp propagate" helper. Then we can add that check once.
I don't see anything bond specific in the logic.

> There are a few other drivers that define ndo_add_slave, seems a check
> in br_add_slave is needed as well.

I don't think it's that broad. Not many drivers propagate XDP:

$ git grep -C 200 '\.ndo_add_slave' | grep '\.ndo_bpf'
drivers/net/bonding/bond_main.c-	.ndo_bpf		= bond_xdp,

$ git grep --files-with-matches  'ops->ndo_bpf' -- drivers/
drivers/net/bonding/bond_main.c
drivers/net/hyperv/netvsc_bpf.c

> This seems like a potentially deep rabbit hole with a few checks to
> add all of the place. Is this blocking the series?

Protecting the stack from unreadable memory is *the* challenge
in this series. The rest is a fairly straightforward.

