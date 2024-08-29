Return-Path: <linux-arch+bounces-6832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714B9651E9
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72122B21142
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060451B653D;
	Thu, 29 Aug 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/aH4yCw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7A18A92E;
	Thu, 29 Aug 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966807; cv=none; b=o/vFMUoeLHEBkFn1rE6MjgiYGlTxdEuuD1C7JY0jH0/EI8zgo0dsFAca6J2GqsoJ0eiJAz0On5ynEyO3Z/iXWiW2WjLt6M/VbYGoN0rpMqhDX9w1gPaZ4/dSX+C21CqiOG2qvwFKINV6WGFYgFvYkstH64AlQQQOEGKHefBMNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966807; c=relaxed/simple;
	bh=qv1w3i8ppp9WEatmXOTIDaygnDc4b+KopM2kue4iUXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXB6G1x4TdbB7KF2x07obGUAoWS3v11WckNv2bDPfI0L1etIn7E3BO0UFeufUs3++g73wHj7QYUOvS1QY8yxK9oSFriIxYaLBh1TCEpE9b5AmAe1D8zNqjm98H0LFus46JuXMcXHUMYB/gaelTiABL8Ti1Y4x3OAw3PiS2gzFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/aH4yCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5BBC4CEC1;
	Thu, 29 Aug 2024 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724966807;
	bh=qv1w3i8ppp9WEatmXOTIDaygnDc4b+KopM2kue4iUXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q/aH4yCwlgAE0YdZkEXc5ZWzCRJpVizL7u3qOFqjdHTLBh/GACVu7V+LYtSu7k99i
	 fuCsKpIG7Ycih3jx7Nea0jL7wfVPoPaH1K7VToVloVY9GnEbAh3blFw6mIfvwkfi8P
	 v86W/H6gdGgrjLiTOcnC8zC7buNYkwMeca7w7pi0Q4Fy5cqWuRd9dFXOCmrZIEh0OG
	 +egu64hiZCWHl0GbAoGuKWN2aH034agEq7Cezds5QwuoX+mPfEdjmTihMkJMsnin7J
	 6kRj6oJBykEyxE6SnnmmUTf7JH4YP5PCAIPbElrGwvuwvXryYVm9axq9Kg8g+IWpFZ
	 IMeHpXeFot+4w==
Date: Thu, 29 Aug 2024 14:26:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
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
Subject: Re: [PATCH net-next v23 13/13] netdev: add dmabuf introspection
Message-ID: <20240829142643.4aa5c52a@kernel.org>
In-Reply-To: <20240829060126.2792671-14-almasrymina@google.com>
References: <20240829060126.2792671-1-almasrymina@google.com>
	<20240829060126.2792671-14-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 06:01:26 +0000 Mina Almasry wrote:
> +		binding = (struct net_devmem_dmabuf_binding *)
> +				  rxq->mp_params.mp_priv;
> +		if (binding) {
> +			if (nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF,
> +					binding->id))
> +				goto nla_put_failure;
> +		}


> +	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;

> +	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
> +		goto err_cancel;

nit: this is better than the put in queue_fill_one()
no need to cast void pointer there, and you can use a single 

		if (binding &&
		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id)))
			goto nla_put_failure;

