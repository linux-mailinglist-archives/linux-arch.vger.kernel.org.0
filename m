Return-Path: <linux-arch+bounces-4945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193E90B509
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7EB31318
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CA15FA86;
	Mon, 17 Jun 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJEj4efi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981415FA77;
	Mon, 17 Jun 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635545; cv=none; b=jkJOWrPrBzepku6NixjfW69+c5bMUXchY7knpRZDAPJCiyOEWnjtUmE/eDn/afq6lEhIULtdyS1HFBCLGvDgjsDSnDMmop/iI7cxUudRVQeTEIGWseCUAY3NAPDJSeDjM66zWAgalgZW7zhemEwxTe5MN3nwK2FkU6avvIlai1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635545; c=relaxed/simple;
	bh=rFVsoK865UN32ZC+/dEHN/mQE5ZBn9kkvYV25JTrEHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLuQUsJM0TXVxgkoXehzcFpvK+Q7I6Oi93o1Lmivxz5+6yb+YkvJuQGXjlQ4v3XCHQyPt34yj7w4fAClKWjdzEt5xeMe15RKivI1Z9GRpDW3scbsdADU3zvrAff0XPk54QKlZ3NEHv+KyU8aOxpm+fdy8FEcJhnOLsG0EqQW+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJEj4efi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f09eaf420so519264266b.3;
        Mon, 17 Jun 2024 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718635542; x=1719240342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ah3rcgKtsiLLs9s7Ep0iHOREj7mRgLBYmdEE8sYGz64=;
        b=jJEj4efijRqlYzaiwfpV62eIpDfDx9+5ZsV9vDy7gteF6E2KsKun5uGC5Rbaqb4iOo
         nnRzGttnsVzlwJv7UeAgPaqFaFreqMV5+Rx2VZ9gQmHS2nR5/7jVfcjDQx0REz82YrPd
         W9JmaY3hM2TVjwduqN+PTnXWQVXnv766EQpAYyU1vkhES1iVZauDFUvL2ftMDGd9ip5k
         MMP6NTad1SEYIebq9+hBMt2I+4eaD+YqV3iaNagwCsKnWP4AUAKI9rEgywii1oS1SxQQ
         2bTknUjBsGJtXlq0W8ye/1Kl6DV4s4nUa7Dbfla8hy36NB8uuQiVnezjjgKRdwckdMUi
         qV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635542; x=1719240342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ah3rcgKtsiLLs9s7Ep0iHOREj7mRgLBYmdEE8sYGz64=;
        b=PEfqkyX+UAA2ipiTczPNSmADI4cHJYUO+8MMeDfHFX9EfqXk5CFrRvYMPd5q5LBPvk
         b/zLmfB4Re1dQuKm1hpL+2bvdM2PiAP/j6g2fFnhM2u3ZIplTANuVziBW7GImLFcEBhB
         ZdbPfQUN5UJ2md2yXKJMYTAmYwoBu2nglQxqSjabKyqDQcA0PcEyDZRe93PnpGiOIW0s
         FjO2c+lt/Jgip+0nFdVLzOgm0dniIWgaTdOQGhP8iYgTS6WNDyF/Vps5dMe691gPEW+R
         5aYiXACZQbCwvmuecD7csMpZJD5/wEzwTvKSnyobI9h+ZzX2yx+Sg82+8md3PNMlJMgJ
         vaxw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Qu1hNTIXDGWBjaLOdKPabPsn5blNBf22rLfwGHedUQNV7elp4hSubn5+B97gR6ie9QIR5mWSiOL3y7LayFVllJNJArOY9mdldK4rPndYOvN+P/SKzXSuHcJWlxh6teRoymxCGTrrjGaVRqDC57Fn/Iv0YuXWNc8SubWJ5K6sd6k8UjtfLaQXPKy2GnoDKzQ9W89FS4aI2REdIclq9Eli9xDywKt2g6UN1ZBhmN9geXUvek9lm4JTya41rMoA6X01p7Tg8xFJEnIB+6uOWpNpJEseHwENoejH/EgS2HSl8hGoAE/vt/3SBMGhNSMjDfcstn76Cu2RcMf5ZCktByTW9yLbeNGUi7xoSeqJrWtAiLF7nwMwz4e0vqCzHSCcZt0c4iJZEHJQU1125DwkZQhICVYIfRso3eZ6+/NdJJSNn049GlXzRC9H/GY6ypTsZhmO6QByuWh7fVCL7TQ5b+Re5Hfmx/IdvZls9bWf9LUxn5PR1yv72J1JfvEk9qhxfRNQCMsDlfCwjze4sNKZQNqY2RQcLet+X/+6Jk8KvwMCuQqOy7V81doa
X-Gm-Message-State: AOJu0YwL+fsaQIYP3BYBAKUsYYbEpvj8VW+jZpvFqPf8kjyzZkuVOwnU
	31ck+TZz+IeM0Z4DMHEs67LUmByaAQBQkQgotvglOIwNqRZ1Xcxq
X-Google-Smtp-Source: AGHT+IGy29Bog/6x0frVCqVR0gtIWSVZ7NmfaBwvNVXbu4bGaKBQqObsvBBOakN7w58CXi9kwdrLlg==
X-Received: by 2002:a17:906:aacb:b0:a5a:6bde:c3fb with SMTP id a640c23a62f3a-a6f60d29568mr573906666b.28.1718635541341;
        Mon, 17 Jun 2024 07:45:41 -0700 (PDT)
Received: from [192.168.42.82] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa41cbsm522762466b.225.2024.06.17.07.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 07:45:40 -0700 (PDT)
Message-ID: <14b7af66-04fe-4b49-94d6-bea5d554252e@gmail.com>
Date: Mon, 17 Jun 2024 15:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/13] memory-provider: dmabuf devmem memory
 provider
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-8-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-8-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem in the form of
> net_iov.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the net_iov.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
> the page_pool can provide the driver with the dma-addrs of the devmem.
> 
> Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity & p.order !=
> 0.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Comments below, apart from them

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4fd9b9dbb675..d3843eade5fc2 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -17,6 +17,7 @@
...
> +
> +bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
> +{
> +	WARN_ON_ONCE(!netmem_is_net_iov(netmem));
> +	WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem)) !=
> +		     1);

If you're adding it anyway, maybe
"if (warn) return" ?

> +
> +	page_pool_clear_pp_info(netmem);
> +
> +	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
> +
> +	/* We don't want the page pool put_page()ing our net_iovs. */
> +	return false;
> +}
> +
>   #endif
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1152e3547795a..22e3c58648d42 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -13,6 +13,7 @@
...
> @@ -269,7 +275,25 @@ static int page_pool_init(struct page_pool *pool,
>   	if (pool->dma_map)
>   		get_device(pool->p.dev);
>   
> +	if (pool->p.queue)
> +		pool->mp_priv = READ_ONCE(pool->p.queue->mp_params.mp_priv);
> +
> +	if (pool->mp_priv) {
> +		err = mp_dmabuf_devmem_init(pool);
> +		if (err) {
> +			pr_warn("%s() mem-provider init failed %d\n", __func__,
> +				err);
> +			goto free_ptr_ring;

Should also free stats, look up

free_percpu(pool->recycle_stats);

-- 
Pavel Begunkov

