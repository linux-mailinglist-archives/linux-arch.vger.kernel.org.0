Return-Path: <linux-arch+bounces-6240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF44953EDB
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 03:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD60B24141
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 01:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559417BA1;
	Fri, 16 Aug 2024 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcPBNpDC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37ED2BCFF;
	Fri, 16 Aug 2024 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771370; cv=none; b=HHliaLykvjS5QHln6rT75b1KHsOpJJP2q8e6aqOrydJoQ/vNHZCS9x+9GSiJi6et39DAB/zouVTGGuU3NKzJ2cfpfxPtliwdOviG54D4kgoRQv2Rqx0ldcATxsU6nYmf1fAXNWYIgT0BbO7Jjf3C8PTyJFoaIqQdK2lZ3B57+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771370; c=relaxed/simple;
	bh=IkxgNU5lZE6GtoPPMNJU9i4n15FLyHYKT67mAHsJDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjXxlA+OcErznBVhV1xxC/pcFs0oBTNVMuFhQQVR89PC29oO7Tm6didaOPDcV/wikNf2pxWyrk/0wkZwXbWNfzcwWO8vluFEGbPsX1MlI1b2sLE/rkTDuFi163eWPHdeEbq1WCEDRpVZlJs4X8mawfGF/5hY2muFK7BFmzdef0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcPBNpDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B2C4AF09;
	Fri, 16 Aug 2024 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723771369;
	bh=IkxgNU5lZE6GtoPPMNJU9i4n15FLyHYKT67mAHsJDsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcPBNpDCRFXY8kGxpg2OnRKk1wK1Dnq5Nh134fk9HH+HXrxS9P35iW+jorPaKYS1N
	 xAMygGZ/o8VttaAfDJ73kbiQunXv00m488MEt5zFzKx0LmQ+yM91SMEj/TOTfvHriW
	 5gsmMzKyX4hCr0NdhJXl+6EFrUUTMZlDnL9mk+hbDY69YRrM4P0eypdGanoGEqyjwW
	 VnKH4FrMCPyOazttbwCRLeHANRE3uJJckxjidvB49sZn2byX+9sHs42dntssCrTNqq
	 kbYFHxD1BHqZoc/Cao/daL6ihfXWV1GKXL7xuhyFlGg+FRagNIGfP4rt1DbGZ2ks8D
	 3C5SoToFZwuJg==
Date: Thu, 15 Aug 2024 18:22:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
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
Message-ID: <20240815182245.2b5e3f44@kernel.org>
In-Reply-To: <31640ff4-25a6-4115-85e6-82092ce57393@gmail.com>
References: <20240813211317.3381180-7-almasrymina@google.com>
	<de7daf80-a2e4-4451-b666-2a67ccc3649e@gmail.com>
	<CAHS8izPMC+XhXKbJOQ3ymizyKuARSOv_cO_xO+q1EG4zoy6Gig@mail.gmail.com>
	<31640ff4-25a6-4115-85e6-82092ce57393@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 17:32:53 +0100 Pavel Begunkov wrote:
> > This is where I get a bit confused. Jakub did mention that it is
> > desirable for core to verify that the driver did the right thing,
> > instead of trusting that a driver did the right thing without
> > verifying. Relying on a flag from the driver opens the door for the
> > driver to say "I support this" but actually not create the mp
> > page_pool. In my mind the explicit check is superior to getting
> > feedback from the driver.  
> 
> You can apply the same argument to anything, but not like
> after each for example ->ndo_start_xmit we dig into the
> interface's pending queue to make sure it was actually queued.
> 
> And even if you check that there is a page pool, the driver
> can just create an empty pool that it'll never use. There
> are always ways to make it wrong.
> 
> Yes, there is a difference, and I'm not against it as a
> WARN_ON_ONCE after failing it in a more explicit way.
> 
> Jakub might have a different opinion on how it should look
> like, and we can clarify on that, but I do believe it's a
> confusing interface that can be easily made better.

My queue API RFC patches had configuration arguments, not sure if this
is the right version but you'll get the idea:
https://github.com/kuba-moo/linux/blob/qcfg/include/net/netdev_cfg.h#L43-L50
This way we can _tell_ the driver what the config should be. That part
got lost somewhere along the way, because perhaps in its embryonic form
it doesn't make sense.

We can bring it back, add HDS with threshold of 0, to it, and a bit for
non-readable memory. On top of that "capability bits" in struct
netdev_queue_mgmt_ops to mark that the driver pays attention to particular
fields of the config.

Not sure if it should block the series, but that'd be the way I'd do it
(for now?)

I'd keep the current check with a WARN_ON_ONCE(), tho.
Given the absence of tests driver developers can use.
Especially those who _aren't_ supporting the feature.

> > and cons to each approach; I don't see a showstopping reason to go
> > with one over the other.
> >   
> >> And page_pool_check_memory_provider() is not that straightforward,
> >> it doesn't walk through pools of a queue.  
> > 
> > Right, we don't save the pp of a queue, only a netdev. The outer loop
> > checks all the pps of the netdev to find one with the correct binding,
> > and the inner loop checks that this binding is attached to the correct
> > queue.  
> 
> That's the thing, I doubt about the second part.
> 
> net_devmem_bind_dmabuf_to_queue() {
> 	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq);
> 	if (err)
> 		return err;
> 
> 	netdev_rx_queue_restart();
> 
> 	// page_pool_check_memory_provider
> 	...
> 	xa_for_each(&binding->bound_rxqs, xa_idx, binding_rxq) {
> 		if (rxq == binding_rxq)
> 			return success;
> }
> 
> Can't b4 the patches for some reason, but that's the highlight
> from the patchset, correct me if I'm wrong. That xa_for_each
> check is always true because you put the queue in there right
> before it, and I don't that anyone could've erased it.
> 
> The problem here is that it seems the ->bound_rxqs state doesn't
> depend on what page pools were actually created and with what mp.

FWIW I don't understand the point of walking the xa either.
Just check the queue number of the pp you found matches,
page pool params are saved in the page pool. No?


