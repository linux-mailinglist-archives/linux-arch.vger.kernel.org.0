Return-Path: <linux-arch+bounces-5354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D32C92D6D8
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 18:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FAD2815EC
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99559194C96;
	Wed, 10 Jul 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeE9psM3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F49194C73;
	Wed, 10 Jul 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630143; cv=none; b=YD3lAAgDBKpuSJh4FPdaUHZeUP8bMn34H6FQmmmHWuKiCg3QYTC3qbcpRHHO2KV69AWXvoAp5yVoBJWCIv2l37pCwdMthDRUCsShZFEtKggyz7vjm4Kp3TyL3+yd5VidK1ry//W3DsPZ+fc8518dSKJ5JyLJDC1vUf2V5R3SXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630143; c=relaxed/simple;
	bh=eS/RMGP4VxRIFbhmXWkCrFvxioDBvmLiKkBEAODdwGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCQ/7SSA2jPsUE9Nfax8t0rFtnFMzk6fWwhRqHFXxXe80js3uuqxMmIx7qjPIBXJvi1KybvFljiZsftFo/KWB5XYWPMWFnZwzrK6VEY0S709HDCs//wv87SQAKEbZtYt0L5QIam5uBo4tW70RAFEh1rPiNYyvrW7tJH9hIQSvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeE9psM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C51C32781;
	Wed, 10 Jul 2024 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720630142;
	bh=eS/RMGP4VxRIFbhmXWkCrFvxioDBvmLiKkBEAODdwGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GeE9psM35dHGvAUo79TtOnu4kq5cY9EUrGF2ghylZhRExsJfxInrnrbzIGYTRdEyP
	 JuNUksWFVoX99WDJK0OYBlsaXy6q6YA4gtH9ruZmomvqVAnZKrQ5V0cyaDEK1nrfmj
	 TYzIOxglnzs0uEzQL7xFLg0IgYd2T3xSZ3m9tEEYvl2XCdOAvnosGa5j4fJc/Yy95m
	 Fc5KKtoP2fmuVTazyDqaAh0RTuL+2gSo3Q0QXNcq8mXWHgnju0cDM5kOaxJGJVc4MU
	 IX9XFPAHEsGhG08l+UfVEIDuPwq1AH3mfKgmvCy5HzZT6Og5qbJjr0Ohj8oZTpGXx8
	 z5HtdpFuugVEQ==
Date: Wed, 10 Jul 2024 09:49:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
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
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, linux-mm@kvack.org, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH net-next v16 05/13] page_pool: devmem support
Message-ID: <20240710094900.0f808684@kernel.org>
In-Reply-To: <20240710001749.1388631-6-almasrymina@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 00:17:38 +0000 Mina Almasry wrote:
> @@ -68,17 +107,103 @@ static inline netmem_ref page_to_netmem(struct page *page)
>  
>  static inline int netmem_ref_count(netmem_ref netmem)
>  {
> +	/* The non-pp refcount of net_iov is always 1. On net_iov, we only
> +	 * support pp refcounting which uses the pp_ref_count field.
> +	 */
> +	if (netmem_is_net_iov(netmem))
> +		return 1;
> +
>  	return page_ref_count(netmem_to_page(netmem));
>  }

How can this work if we had to revert the patch which made all of
the networking stack take pp-aware refs? Maybe we should add the
refcount, and let it be bumped, but WARN() if the net_iov is released
with refcount other than 1? Or we need a very solid explanation why
the conversion had to be reverted and this is fine.

>  static inline unsigned long netmem_to_pfn(netmem_ref netmem)
>  {
> +	if (netmem_is_net_iov(netmem))
> +		return 0;
> +
>  	return page_to_pfn(netmem_to_page(netmem));
>  }

Can we move this out and rename it to netmem_pfn_trace() ?
Silently returning 0 is not generally okay, but since it's only 
for tracing we don't care.

> +static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> +{
> +	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> +}
> +
> +static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> +{
> +	return __netmem_clear_lsb(netmem)->pp_magic;
> +}
> +
> +static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> +{
> +	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> +}
> +
> +static inline void netmem_clear_pp_magic(netmem_ref netmem)
> +{
> +	__netmem_clear_lsb(netmem)->pp_magic = 0;
> +}
> +
> +static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
> +{
> +	return __netmem_clear_lsb(netmem)->pp;
> +}
> +
> +static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> +{
> +	__netmem_clear_lsb(netmem)->pp = pool;
> +}

Why is all this stuff in the main header? It's really low level.
Please put helpers which are only used by the core in a header
under net/core/, like net/core/dev.h

