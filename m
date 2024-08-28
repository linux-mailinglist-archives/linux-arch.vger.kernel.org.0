Return-Path: <linux-arch+bounces-6730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B078963051
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 20:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9B1282941
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47111AAE28;
	Wed, 28 Aug 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROtLpkCE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54D1D696;
	Wed, 28 Aug 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870616; cv=none; b=uJZwamkrjh5oRjpH6SBD4rh3eC2qJJ6li8bOxd5aUabP5asyfwAiyQQA7r8VU6YltEMBEq+S6n9QP8Dlx4h+rbIj5vevFLwfXMyBxp6V75zSS4V8oRmmBnAY/TOGSN9fiuLocENf5HO10aJBI6GJisdLzQ84IBuSHLgi6aEDWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870616; c=relaxed/simple;
	bh=bWjjtD9ux0QAGG3fGYObh74lsPxgFpjHa3YWm0m0vIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg8NLAiN1pUYg/CZyuIe3v/9AOKfJ3kdjm5n9ZUcJWOqRE17Iih5BlNWvRTbUydOrtYLKo/GvtwNdO9eC4UuAeS2ybdlpWXDVR7yAc0xB1IA6dKqW3Bccz1evVcTEc5V2SZTYQ6YzZwJWwYLE+78WGN6UYT7cyU0DtjrZPKn/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROtLpkCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72659C4CEC0;
	Wed, 28 Aug 2024 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724870616;
	bh=bWjjtD9ux0QAGG3fGYObh74lsPxgFpjHa3YWm0m0vIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROtLpkCEGD8Ucdbs7a1iRfvuc32G3qJBY6quO3vEkfgfTtRxHiuhmUPG4800e2RsG
	 /Lm2aGh9ZM5echC/qr/x2EXrVQ45i6g+DGFDj3b4IL1+1nBBMKPOO7F2EVPH21SXWt
	 D3wyLlY3wzUG+pAwc9PiOyoANcpRLYBPjrk80WBsoM0sK/mk/Y/+Np3wR59Dnj9tMd
	 zCiuTrI/cV8v34a6M0pTb4HTETCCVIQdFJzGlV39b2ciDrjitNDYPxuwRZojB40abg
	 4ctkvmZU35i1iPs5RMsbgdrXOvldO8psyPOoy6iI6yqUNNrEivtWT76jv46HwMkF1o
	 46/gB0lOrWDFQ==
Date: Wed, 28 Aug 2024 11:43:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?B?bA==?= <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v22 04/13] netdev: netdevice devmem allocator
Message-ID: <20240828114333.560895f0@kernel.org>
In-Reply-To: <CAHS8izP8T5Xj97M7efecBmCrG9z8E0PYTxWCYZ0ym0hv13-DKg@mail.gmail.com>
References: <20240825041511.324452-1-almasrymina@google.com>
	<20240825041511.324452-5-almasrymina@google.com>
	<20240827191519.5464a0b2@kernel.org>
	<CAHS8izP8T5Xj97M7efecBmCrG9z8E0PYTxWCYZ0ym0hv13-DKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 00:20:23 -0700 Mina Almasry wrote:
> > On Sun, 25 Aug 2024 04:15:02 +0000 Mina Almasry wrote:  
> > > +void net_devmem_free_dmabuf(struct net_iov *niov)
> > > +{
> > > +     struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
> > > +     unsigned long dma_addr = net_devmem_get_dma_addr(niov);
> > > +
> > > +     if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
> > > +             gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);  
> >
> > Is the check necessary for correctness? Should it perhaps be a WARN
> > under DEBUG_NET instead? The rest LGTM:
> >  
> 
> Not really necessary for correctness per se, but if we try to free a
> dma_addr that is not in a gen_pool (due to some other bug in the
> code), then gen_pool_free ends up BUG_ON, crashing the kernel.
> 
> Arguably gen_pool_free should not BUG_ON, but I think that's an old
> API, and existing call sites have worked around the BUG_ON by doing a
> gen_pool_has_addr check like I do here, for example kernel/dma/pool.c.
> So I did not seek to change this established behavior.
> 
> I think WARN seems fine to me, but maybe not under DEBUG_NET. I don't
> want production code crashing due to this error, if it's OK with you.
> 
> Unless I hear otherwise I'll add a WARN without debug here.

WARN makes sense, I didn't know about the BUG_ON() hiding inside
gen_pool :(

