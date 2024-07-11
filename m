Return-Path: <linux-arch+bounces-5365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616092DDDE
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 03:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B5B2820BE
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551B2F5A;
	Thu, 11 Jul 2024 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu7j9vqd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0006321D;
	Thu, 11 Jul 2024 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660926; cv=none; b=OoB2JSqr0fMkK+OsRZGsYqFJrhQh3XNFOOOzqnKdSxHm1P4ldTF7T/FRwVmoZpj0N8I1nUpinDOHaT+pFbvkGqw1A+aovtohyifTLoJjM1Ltvz/LYO5k16uaDJNfkVAEn2hDxZC/0anyhX29OK+XNr+oNO2lrAohhqyK4djcd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660926; c=relaxed/simple;
	bh=QjOULS8b+CZJ29PyHWRuJmie+Hn55IcoVG3HP/3LohE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnLLlJrh8akdwLMbZgs6JyUadYlISBRD8TKjtAK0oRxNmJsBE4UHUK+CaoBHXWev/sMdN+uNmXaSy98TkuseZ9dbLyMGkdIwQ1UHDi6b5GP4U2+RbFNtsJ4m0J4TdBYOVW+eLRZhesxjMkORYNlidiT1d3CLO/iDP0omG8gj5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu7j9vqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA79C32781;
	Thu, 11 Jul 2024 01:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720660925;
	bh=QjOULS8b+CZJ29PyHWRuJmie+Hn55IcoVG3HP/3LohE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nu7j9vqdXFB65PlvnMG07kLL4ivK1FfVmXPHqTj2KJK596Mc9VqYs9lJeZEnKP7ON
	 zXThKeg9bymdodZ2PIefG7emFD2gdT5qBsgTLm+H20XqJqPqzN0EFhC0m76b69HAKY
	 IYbR340PfQzawxYhWyFufDRPBQHIiiklguQ7ygzJqm+l2Li6ovHnuc9HjM2IhUp6DQ
	 /pG5oYdKyNVQMInWszt3EtEL8K4E758yZUnsbrn5XLQuIRBzGAmZ53YVSi6XiVF6Hp
	 w6+ekApzB8N7QHyw3aeV+j7GzkIcFhh/EmmQxXvlulGRFFFtOWh1wCj2EME4SmvAhb
	 q7RK7aphR1DUQ==
Date: Wed, 10 Jul 2024 18:22:02 -0700
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
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
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
Message-ID: <20240710182202.0324279f@kernel.org>
In-Reply-To: <CAHS8izPnFxeEMEQkxq=A9Rp7T8ADJ__3eWfeQmC2hEBYQVzcvw@mail.gmail.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-6-almasrymina@google.com>
	<20240710094900.0f808684@kernel.org>
	<CAHS8izPnFxeEMEQkxq=A9Rp7T8ADJ__3eWfeQmC2hEBYQVzcvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 13:29:03 -0700 Mina Almasry wrote:
> If we want to add __skb_frag_ref() support for net_iov I suggest something like:
> 
> diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
> index 0f3c58007488a..02f7f4c7d4821 100644
> --- a/include/linux/skbuff_ref.h
> +++ b/include/linux/skbuff_ref.h
> @@ -17,7 +17,13 @@
>   */
>  static inline void __skb_frag_ref(skb_frag_t *frag)
>  {
> -       get_page(skb_frag_page(frag));
> +       netmem_ref netmem = skb_frag_netmem(frag);
> +
> +       /* netmem always uses pp-refs for refcounting. Never non-pp refs. */
> +       if (!netmem_is_net_iov(netmem))
> +               get_page(netmem_to_page(netmem));
> +       else
> +               page_pool_ref_netmem(netmem);
>  }

Probably not much better since freeing still looks at the recycle bit.
Eric and Willem acked patch 8, maybe it works, and if it doesn't we
know who to call :) I can't point out any case that won't work so if 
y'all think this is fine, let's leave it.

