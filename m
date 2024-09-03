Return-Path: <linux-arch+bounces-6975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85596AA97
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F1D282B7B
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A81A265F;
	Tue,  3 Sep 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLZNXCj0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11150B647;
	Tue,  3 Sep 2024 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400314; cv=none; b=pGZQdNjxDtGE6dYWjNbpSE9ARcFQh/KwZGLDqZpK/l7o4EZ64MZjaMsFFyLGxqCkQKlT4wD3qkyWIZkQgGkslIFNinSv/CkCCfOtc4oY5I0Wq+yGiv1ZSJICS9UuoqlA0sbnjIEiEzG4UTZUv111oBqchwasFkQ7vEJz9wl2g5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400314; c=relaxed/simple;
	bh=tN5vqlCKPar7XP4sqfMn5SllXz0g+GvMXAGcorIVqYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6cxjg39/RKDfQYxxe+OFBE7/Xs5sUqg/aXRZIPveKrsdrsAVsX92+Yhs7ew5OmAQ8duHQp+NLZOzIanhAUL/BzkYDm5DwfEI0DPgF8qq6j7WorltBlA2F6FeTPhZg49v4FCqaDqnFshKlDLuG57VC/7wAbOxWbiSmVclEl5pD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLZNXCj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42686C4CEC4;
	Tue,  3 Sep 2024 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400313;
	bh=tN5vqlCKPar7XP4sqfMn5SllXz0g+GvMXAGcorIVqYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pLZNXCj0UEyKhvBJH5OnAGowSygKD8coz1erfWLAmf25HQz7h56PVHW0XMx2E/+w7
	 xIjmR/ODgmkQ6EkT6qbdOkd5+85QO1VKRGcUIdp6j2mkLuyJOvw/tsogx2g6M2wzva
	 plaXBbA4zNqKIrFF1xpYvfxDeNxXAy01Gmo8YJ+WZVfKF+cf6OJiYtW+gQBUW93FAy
	 xIbMwFjMhxNIKZyJ57an/ZH5OFRWVdtyWrTv6ylNleOf2fa0XbMtEJRZe8/7ngefo1
	 qikCcPNCOUF1XR5udOGdG6WVHyWR9fGyOzvTd3fowwLf6pKYqM5v5MJzgqDs6Hj2YM
	 mtSUblomNCqHQ==
Date: Tue, 3 Sep 2024 14:51:50 -0700
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
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, "=?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?B?bA==?=" <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net-next v24 11/13] net: add devmem TCP documentation
Message-ID: <20240903145150.4ffee51b@kernel.org>
In-Reply-To: <20240831004313.3713467-12-almasrymina@google.com>
References: <20240831004313.3713467-1-almasrymina@google.com>
	<20240831004313.3713467-12-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 00:43:11 +0000 Mina Almasry wrote:
> +The socket must be flow steered to the dmabuf bound RX queue::
> +
> +	ethtool -N eth1 flow-type tcp4 ... queue 15,

nit: tailing comma here

> +Devmem payloads are inaccessible to the kernel processing the packets. This
> +results in a few quirks for payloads of devmem skbs:
> +
> +- Loopback is not functional. Loopback relies on copying the payload, which is
> +  not possible with devmem skbs.
> +
> +- Software checksum calculation fails.

Speaking of which, I think we need to add readability check to 
skb_checksum_help(). Shouldn't the check in __skb_checksum() 
have a WARN_ON_ONCE() around it? It's impossible to return 
an error from there.

> +- TCP Dump and bpf can't access devmem packet payloads.
> +
> +
> +Testing
> +=======
> +
> +More realistic example code can be found in the kernel source under
> +tools/testing/selftests/net/ncdevmem.c

looks like HTML output wraps the file path, maybe quote it as
``tools/testing/selftests/net/ncdevmem.c`` ?

