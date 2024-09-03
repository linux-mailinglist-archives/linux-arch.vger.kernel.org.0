Return-Path: <linux-arch+bounces-6973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201996AA2D
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48691C21343
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33EC126BEA;
	Tue,  3 Sep 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZOZSvlT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7D1EBFEE;
	Tue,  3 Sep 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399096; cv=none; b=NZl9GJFZ0Y3g9WUuKemp6zzc5wLIPzsC2CHBwWxK+7eOlfjKEIw98PZi+nLYEkfQmXdGG9yaV6FdOTkk84sAxCiKA1nB5pD1mJ1YT/DhZFJhx6U8UMvZWAvCbVGm5rISsHQCzoHOfY5gzB1aATwYg0WGhFJZKoXvmLVKrqIghp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399096; c=relaxed/simple;
	bh=QXi/ll4uuI2edg5BwxfzCEhzkKn1Hj/er7+RJFOMUlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2u4+rXmV7WNcUw7M+MTy0So9itRow3CuYGe9IFcO3DbWWw4BYL5mRWM5e7r+p9h18AP4e/bu9Y3c4BYW8pA0ZKQV0Syn91QgS/+qkcs6x3qjUm+qvGwdvnXc7hJtCrDaoWrj9D4wv1TF0bwzj/SV2dD3WZ7i4hYtv6+42zZIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZOZSvlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC2C4CEC4;
	Tue,  3 Sep 2024 21:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725399095;
	bh=QXi/ll4uuI2edg5BwxfzCEhzkKn1Hj/er7+RJFOMUlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZOZSvlToUkAOVqd0UgmlzLGJUkWpA5komnwhd3xww+g6jIGmcTpmsJKJAZ/u9WpK
	 GU77r0k/GGoy7CrDGc/aZonl6bEJwK6ypjnhspjZlwsPAkcmt4XviAs8GBY95CbGPm
	 3Li7cKsQ+n/qMSCfHXM0Nb15U/xuM8eAAB8+LAgyAlWiLZvN4LqnH1pnYNNkVjsq6e
	 MZ4RSVtCqFI6Btqrs4A0Rre3i3WYij+2y21/8CPBajl1zRcFJaR6qc7SOQ/Ot2QVKE
	 beXe5GAu7dxHaeUXEb9LFKdDm4bkIOgT8TB1ospVQcxsozRXdmxvHyIG4LSGdWRaFu
	 OMdwFEomkGRGw==
Date: Tue, 3 Sep 2024 14:31:32 -0700
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
Subject: Re: [PATCH net-next v24 07/13] net: support non paged skb frags
Message-ID: <20240903143132.424c08e5@kernel.org>
In-Reply-To: <20240831004313.3713467-8-almasrymina@google.com>
References: <20240831004313.3713467-1-almasrymina@google.com>
	<20240831004313.3713467-8-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 00:43:07 +0000 Mina Almasry wrote:
> Make skb_frag_page() fail in the case where the frag is not backed
> by a page, and fix its relevant callers to handle this case.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

