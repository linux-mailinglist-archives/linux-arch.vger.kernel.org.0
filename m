Return-Path: <linux-arch+bounces-6828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47496518B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 23:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A251F22DC7
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740018C015;
	Thu, 29 Aug 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us1i7LvN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BA4D108;
	Thu, 29 Aug 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965937; cv=none; b=CHGykNS7pH2GeSdxYZ7xjUANtoIlQETgDLA9jj40gvJwtA9U5X/iSqAwc3dtNwjadYYiGFseyi9sXbsVaUJ0VQP4W4rSycgnhtuVdN0ByHIpKpTuK5Hj34uyDAIRk2EUg91ojDq+rzatoL4GG6x5yolxObnjXslUss2wVMjSg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965937; c=relaxed/simple;
	bh=SdFDbc/FKfVCaHZ3R/u6SOjH9IobabUDvHC41qgaXUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVnWnAsdkkJ1bgmhE+sWnNqzDjs19lsbylscvm3vLViMP6ecwu353kwhboNh1ZdMfL/I3pHgWVLUJCh5FX2gMOAPiV15pwagvp2HPGElH8eIiJjuGrPWsIGiKIUfOuZ3b5HFrO9ZgmOXn08X0ASeLY/TGIyEhSnAehiZ7MFRXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us1i7LvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD0C4CEC1;
	Thu, 29 Aug 2024 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724965936;
	bh=SdFDbc/FKfVCaHZ3R/u6SOjH9IobabUDvHC41qgaXUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=us1i7LvNVt8Qyg0Ds3Qzx74/wqCdnCowJCXYSfINx9H2q6n5Kit1aO8FDlGGeTMaf
	 vHRHoicpP5fkO3U2+B+81byJTxSyg+s/JKaYfAXXXdaGZWJ8id+HmCmmuUmWdaElQn
	 gv+atJ2B0Ww51vx9gFkQVsIDp8BIu4oIA7f7e5Fp9659+RAYm3nte+AWc4etT9Sc/o
	 /HVToybUJrWVLFvJ3z5lls1n69Cce9t5gwg1hA83miP9iDl4xOg9yZp2+Rj04tO4em
	 wlA6UgNFKwOVnSaAgjOChfdDXWkt/q9nVjfwSzRkZxy01PXMkIQpvgBVgXQ7kosnUy
	 Ykx86deotI6gw==
Date: Thu, 29 Aug 2024 14:12:12 -0700
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
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v23 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240829141212.1d146a16@kernel.org>
In-Reply-To: <20240829060126.2792671-4-almasrymina@google.com>
References: <20240829060126.2792671-1-almasrymina@google.com>
	<20240829060126.2792671-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 06:01:16 +0000 Mina Almasry wrote:
> +		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
> +		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE) ||
> +		    nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {

I keep going back and forth if I should complain.. so nit:

The first two conditions can be together, but for the third one
you want to NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]));
so separate if() is needed. I think I suggested the combining
but I meant just the NL_REQ_ATTR.. ones.

