Return-Path: <linux-arch+bounces-4723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41088FDC4D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2248E285325
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 01:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179079F6;
	Thu,  6 Jun 2024 01:48:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CE4C97;
	Thu,  6 Jun 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638522; cv=none; b=uTQk2Uhs3KcNbD52VU6kbiP2bgZFbMzngOlDp3Ed/PE3CKunWz7akb8xBK6vAHIjYBJZvc+pFBnoL+xBozXX3nza99tG9zJSU4W0iymdrnKViOeolg18CO1xYKFc/GK/FH8XbSToGcsLdGXM68gr7aMe/jkBtF+/FbC5P3k0WPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638522; c=relaxed/simple;
	bh=JLj70tGrmcNhj18kACZpvaoJfW48fvOe3MQyZNPDPeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cllq2OdNeW3Ym6PnXmzSH1VjqRO6l4E7G3UqFPCDh3w3DyVYEE/EYK4sDmOgjZfnxp6bLinMME5Dxth3zPo9/5sKf6egcjwqHrUuA4cuT57AlPzlWHp70cml1TLnMRB/MuIXbubRug7u+E+xKSBcgdMyFistNM+7MQlwp0JzJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8074FC32786;
	Thu,  6 Jun 2024 01:48:34 +0000 (UTC)
Date: Wed, 5 Jun 2024 21:48:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, "Christian
 =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Pavel Begunkov
 <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe
 <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand
 <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH net-next v10 06/14] page_pool: convert to use netmem
Message-ID: <20240605214837.44efcc6f@gandalf.local.home>
In-Reply-To: <20240530201616.1316526-7-almasrymina@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
	<20240530201616.1316526-7-almasrymina@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 20:16:05 +0000
Mina Almasry <almasrymina@google.com> wrote:

> @@ -42,51 +42,52 @@ TRACE_EVENT(page_pool_release,
>  TRACE_EVENT(page_pool_state_release,
>  
>  	TP_PROTO(const struct page_pool *pool,
> -		 const struct page *page, u32 release),
> +		 netmem_ref netmem, u32 release),
>  
> -	TP_ARGS(pool, page, release),
> +	TP_ARGS(pool, netmem, release),
>  
>  	TP_STRUCT__entry(
>  		__field(const struct page_pool *,	pool)
> -		__field(const struct page *,		page)
> +		__field(netmem_ref,			netmem)

Why make this of type "netmem_ref" and not just "unsigned long"?

>  		__field(u32,				release)
>  		__field(unsigned long,			pfn)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->pool		= pool;
> -		__entry->page		= page;
> +		__entry->netmem		= netmem;

You could have this be:

		__entry->netmem		= (__force unsigned long)netmem;

>  		__entry->release	= release;
> -		__entry->pfn		= page_to_pfn(page);
> +		__entry->pfn		= netmem_to_pfn(netmem);
>  	),
>  
> -	TP_printk("page_pool=%p page=%p pfn=0x%lx release=%u",
> -		  __entry->pool, __entry->page, __entry->pfn, __entry->release)
> +	TP_printk("page_pool=%p netmem=%lu pfn=0x%lx release=%u",
> +		  __entry->pool, (__force unsigned long)__entry->netmem,

And not have to expose the above text to user space (look at the format
file it produces).

It being of type "netmem_ref" in the ring buffer is useless.

-- Steve


> +		  __entry->pfn, __entry->release)
>  );
>  

