Return-Path: <linux-arch+bounces-3397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CC89774B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C3528FEFC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BE154C1E;
	Wed,  3 Apr 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJpsqN23"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF49154C12;
	Wed,  3 Apr 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165287; cv=none; b=TFOsEpHPHvMpsXSVOrzdJ3xGTcagVMBNbbDwbmjf+qVtNIX0VuATQVq3fneF066Qom8Xs5LS2t4j+H9tYTDnf8IotFc28fiFCSiiPEGQOg+qRqzm/2YA9t5d2gVpxJlGToWYeXoivbOjEGcAVkFxtmS2i0mp2UY4NwbU6EIEgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165287; c=relaxed/simple;
	bh=ev9qwjumkVBT21OJLnRxmj6j+tcZWLWc9gYIuhQP4YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia2opbuoxHt0lFkgWDWQ6GW72TwXxCw0yfeQSJ/LhG7sn01WZkrj8WZRUJRsE4888fMYzSyz3Ech/P1f6Gxg8GCCmQni6+lw8lB91KappKy7elE43A1OQAfDim+Rx3i92Q5ooTwIdQtz8KoPEYKbLRt0tvnVMBkb7I6ZXCcHAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJpsqN23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25477C433F1;
	Wed,  3 Apr 2024 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712165286;
	bh=ev9qwjumkVBT21OJLnRxmj6j+tcZWLWc9gYIuhQP4YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJpsqN23a/bTPCDYI46/mddJ60857N8gxl0704dxwCHxM5gKzPHc731EgK6XTky8d
	 UTSvCE/t886wLCwR1UtYWv7Xweb+uKowOagxSx/lUTLkXov7Dsf3h7EJVqcumDwZqs
	 tOZb0mWrfqCf+8IONESe5080Pxu9nMjALf/FMnCDXF9xhUlL3R67eN2rH1I5mN6bzF
	 1n8OJA3VkfjnGjVp4Z+o4CVz2zIgJ7Dmv0gNexlQEtkyGLrPexZxzjQpZtQ6ml5ppR
	 mZhUqv9H4p4rGkxe60L9FXP3YjGI6r2+YWhPDeKU2GGU7vXAeDQM5+N6jWyDCaqmEM
	 CqEUGy0nok9lw==
Date: Wed, 3 Apr 2024 18:27:49 +0100
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH net-next v8 06/14] page_pool: convert to use netmem
Message-ID: <20240403172749.GP26556@kernel.org>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403002053.2376017-7-almasrymina@google.com>

On Tue, Apr 02, 2024 at 05:20:43PM -0700, Mina Almasry wrote:
> Abstrace the memory type from the page_pool so we can later add support
> for new memory types. Convert the page_pool to use the new netmem type
> abstraction, rather than use struct page directly.
> 
> As of this patch the netmem type is a no-op abstraction: it's always a
> struct page underneath. All the page pool internals are converted to
> use struct netmem instead of struct page, and the page pool now exports
> 2 APIs:
> 
> 1. The existing struct page API.
> 2. The new struct netmem API.
> 
> Keeping the existing API is transitional; we do not want to refactor all
> the current drivers using the page pool at once.
> 
> The netmem abstraction is currently a no-op. The page_pool uses
> page_to_netmem() to convert allocated pages to netmem, and uses
> netmem_to_page() to convert the netmem back to pages to pass to mm APIs,
> 
> Follow up patches to this series add non-paged netmem support to the
> page_pool. This change is factored out on its own to limit the code
> churn to this 1 patch, for ease of code review.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

...

> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h

...

> @@ -170,9 +172,10 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
>  	struct page *page;
>  
>  	/* Mask off __GFP_HIGHMEM to ensure we can use page_address() */
> -	page = page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM);
> +	page = netmem_to_page(
> +		page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM));
>  	if (unlikely(!page))
> -		return NULL;
> +		return 0;

Hi Mina,

This doesn't seem right, as the return type is a pointer rather than an
integer.

Flagged by Sparse.

>  
>  	return page_address(page) + offset;
>  }

