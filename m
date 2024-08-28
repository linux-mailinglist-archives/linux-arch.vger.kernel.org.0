Return-Path: <linux-arch+bounces-6683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B16961BF2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 04:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301311C23310
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 02:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14E3EA71;
	Wed, 28 Aug 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qErgpU0R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B411CBD;
	Wed, 28 Aug 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811323; cv=none; b=dHLsB8/Q4Qy+xtSvbOTrbtn4wRAT/lh6OYoxANo6DyFscgDeyfOXq2ktHCruLam/1VI5fTLYuSAATCKxA3sJBWG8eOzsTUw+JUnLxPVyq36A5PKNkueAJ39di4AzLaUB/NygI34nWZ3JK3cvklx5hEaxgI6h2KC2a0iXequnFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811323; c=relaxed/simple;
	bh=BjF/SI+Clg9VwmD1YDiNY5kSZ6b/7YEV1Coee82xshg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K221If8Tjue/+pKxgZX5jI50OOVysYSM94VdqON/2rGAQ4LUlacB0BxLx5nIJ9UuxHeGrB05ERM65Nz+7WC3bcvWegla/5wcM78Q4pqYNuLo04kWh4E/df4VAxixtYG5CyARpvbCXp0B6nsTZC6KGjMsmYXdwIw7lGsiPklB3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qErgpU0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CF9C4AF60;
	Wed, 28 Aug 2024 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724811322;
	bh=BjF/SI+Clg9VwmD1YDiNY5kSZ6b/7YEV1Coee82xshg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qErgpU0RhYH5WDJJXkws/HENWDPAZrNV4DIAGhLruIvnrdv3ETwsMJaqlJwbsGqBG
	 sOXE0rshTwA67CfrMAyRLqfniN21SQvvoGipcCdy5EFJuKE8jvV4G2PfqPNFgiS8It
	 4dPunWamEUGMRhzS5KC8Ts7cFkyW+7TDVf2RUUn9JS/FAj+cUaBIPIwdP72q7mflEV
	 HS/9jaDHMHisZPyMz7+Cl+J5EU7axirOz22wZxDO+Neit95DQIA2Zn57ERIMVACRxP
	 VyV6iPqNF2tEA75Czk7faOlTESzI0kcVa7iIp8ySMs9wv6/gdVM6qZQWlKav9fit6N
	 KOxTNe3Rdac3Q==
Date: Tue, 27 Aug 2024 19:15:19 -0700
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
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v22 04/13] netdev: netdevice devmem allocator
Message-ID: <20240827191519.5464a0b2@kernel.org>
In-Reply-To: <20240825041511.324452-5-almasrymina@google.com>
References: <20240825041511.324452-1-almasrymina@google.com>
	<20240825041511.324452-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 04:15:02 +0000 Mina Almasry wrote:
> +void net_devmem_free_dmabuf(struct net_iov *niov)
> +{
> +	struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
> +	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
> +
> +	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
> +		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);

Is the check necessary for correctness? Should it perhaps be a WARN
under DEBUG_NET instead? The rest LGTM:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

