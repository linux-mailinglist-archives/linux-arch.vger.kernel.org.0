Return-Path: <linux-arch+bounces-4944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC80090B34A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18E61C23831
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD67140E37;
	Mon, 17 Jun 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jurD3cZV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4514038E;
	Mon, 17 Jun 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633819; cv=none; b=Bm6pyB+DZgSqwdYASmRPWlwKqvI03d6PquEUw9w/d7tSlW//8s3z+/nbYnP8nRXKOYvaKDe/nI+imZBPH9ShTu9SxzN0nBFVW0OgbDLCn9hTE//qjzqwML7biusLLF6M5sIP28e1EVQgy9q0n9m7DMS7zHDEp6KbH4kBHgLz/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633819; c=relaxed/simple;
	bh=EKHULvpqNZT7k8Un31/LE5FzemNbHyJHUksXDrB0rig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ha0IV6U+r4X1IUmXXZzcEHSN7kG8FbEnDRdmlzjMkF0XnDcZhLjtkQx02Xej/HdeIfnAU93+yU9hM6FRaAK9MGAn6CmmZUvNO427C/f2wfZ7gqVe+hKBkFQr0/LHzqWD5nwXh4q7z0zzgnc+6EaN9xT5BoJmnPGrk5xsRPVLCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jurD3cZV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso582622066b.2;
        Mon, 17 Jun 2024 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718633816; x=1719238616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Drz0c1Oa4e/cLUt8BmnU83fUjCzoD8CgDqb9N07B3fI=;
        b=jurD3cZVbyeVSUSW0vE0zigkqAldLoJaWsm4EEm1IUoET8bixTZ3KpialR/4nH+fMw
         lGRtc6WIZB4Z0DfOuBIVwyvWABC++D1yM4CdX42ATFJOK0tkos/OpKSv8SNMHgTEVgnh
         qZ67k37pLSsbi+oWHV1ll6EXGlXoehxpnLAfbhOwq+splzedn/UkVcj99iAoXujg9xLa
         pirYVcdtk4h9vx8xOqJd5Efvb7/WdpOa5H/ypgt/0W9bsejcYR5UmrTpUZSxfvA8tGjE
         m42+xLADEW/TNiiU2gE4BRIIX50JkD5ZyQA9r736hgw3wdbNXczaV+3e95HF5O0TeDlr
         fEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633816; x=1719238616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Drz0c1Oa4e/cLUt8BmnU83fUjCzoD8CgDqb9N07B3fI=;
        b=HspPGse7fPPKiybvhm6spN9qoindqD0/GibrFXCOfGJcsqtCLn43LRtjv2YZFMZT8T
         PjSlRUpjvmK6bGHVmThW6xOqSM3Agy2zkBXxbHrAaxlisRqx43wv3rZhHB0K71kB8pup
         iJpuKtCiRrbUWvbfas4TySvj52iBegOte7fhNE5skEd0nNwutBX30DaNU46mi3hxxPxF
         cTZGQjbDcLK7rJcs4fDCrkIFo+S5muKKtM4IdUhPjoQnqIGlCsGdwgjeRidkFKCFl4fr
         KwCBKVK4/DH3iZtVRx1DMlXeB9NEnxzgMvRGAfwT4zpySYA1ARIDNQBWjghVH/yZTGRC
         73Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV1f46RY4Bni/WI51yixEXGyh/a9r5Czw11jSwmKfK7p/6GJawsoSA02/IGHqoKankdPbmbYTKWM+M5fkKt181H04+uccIYj8oAvfKlyqBXmufowEIzxJ0BM3LsW0xGHhxNcWsSsvX6iA7/vYZURbSzkSEqqELkPWmu2k4MvU6wSavoC+PweXZ15AgV+2/7FCYJ+IN/s/GrC5oaZ/Fk3QlpVp/pGD+sE4eqmhuDZ5yBaylN5+dPemTUQcL9+3+L5htxGvDNUjABTXAlQcUjrAims4Fx0B0k26ox0IExCektVqTrLYpP263aa0Fv3OMNjkWk0tTG3nOgCDCvP+lryCiPaMvPK+IL5QZoRpmn21uoLr+Ktd3OijqGOnvVXdKklZe85VPHe4YOPkOZvw98kyav5lSYHQNVf4Q5VZAYdkCfgi8GbWdeC337O8SZ8k/6n1SRLFntC74BYCuKxA74Jbzkw5xcIuIGV+XJ09rUJMM/l4/c2eBzLJtOIZd9wbhYHVMeZnmCSVHLfdyy8/pUTPLxub4O/niz27yHZgKiLQVztmf8xcXTehTG
X-Gm-Message-State: AOJu0YxA7a7eB670T9JrOQo6BcYWAM7bo6MtQlGxQ0yQUOnFsU4XTyp4
	1RI8ndUEAJJ0oHydOhPK5/zx208/9I/JarKKUltYJxzhAGahUX4H
X-Google-Smtp-Source: AGHT+IFokiO39Qki+IyFQ+TRRzsTCRMTNhTNMlfnFWf73BlGYeWH1z0yP3M3M0hW8ADbaYfa4+g3mQ==
X-Received: by 2002:a17:906:4555:b0:a6f:523a:8e93 with SMTP id a640c23a62f3a-a6f60de2129mr643249766b.71.1718633815552;
        Mon, 17 Jun 2024 07:16:55 -0700 (PDT)
Received: from [192.168.42.82] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db67e5sm518501066b.66.2024.06.17.07.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 07:16:55 -0700 (PDT)
Message-ID: <439590d4-0f05-4f5e-80ec-e7fdf214e307@gmail.com>
Date: Mon, 17 Jun 2024 15:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/13] page_pool: devmem support
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
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-7-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
> Convert netmem to be a union of struct page and struct netmem. Overload
> the LSB of struct netmem* to indicate that it's a net_iov, otherwise
> it's a page.
> 
> Currently these entries in struct page are rented by the page_pool and
> used exclusively by the net stack:
> 
> struct {
> 	unsigned long pp_magic;
> 	struct page_pool *pp;
> 	unsigned long _pp_mapping_pad;
> 	unsigned long dma_addr;
> 	atomic_long_t pp_ref_count;
> };
> 
> Mirror these (and only these) entries into struct net_iov and implement
> netmem helpers that can access these common fields regardless of
> whether the underlying type is page or net_iov.
> 
> Implement checks for net_iov in netmem helpers which delegate to mm
> APIs, to ensure net_iov are never passed to the mm stack.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Apart from small comments below

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


> ---
>   include/net/netmem.h            | 137 ++++++++++++++++++++++++++++++--
>   include/net/page_pool/helpers.h |  25 +++---
>   net/core/devmem.c               |   3 +
>   net/core/page_pool.c            |  26 +++---
>   net/core/skbuff.c               |  22 +++--
>   5 files changed, 168 insertions(+), 45 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 664df8325ece5..35ad237fdf29e 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
...
> -/* Converting from page to netmem is always safe, because a page can always be
> - * a netmem.
> - */
>   static inline netmem_ref page_to_netmem(struct page *page)
>   {
>   	return (__force netmem_ref)page;
> @@ -68,17 +107,103 @@ static inline netmem_ref page_to_netmem(struct page *page)
>   
>   static inline int netmem_ref_count(netmem_ref netmem)
>   {
> +	/* The non-pp refcount of net_iov is always 1. On net_iov, we only
> +	 * support pp refcounting which uses the pp_ref_count field.
> +	 */
> +	if (netmem_is_net_iov(netmem))
> +		return 1;
> +
>   	return page_ref_count(netmem_to_page(netmem));
>   }
>   
>   static inline unsigned long netmem_to_pfn(netmem_ref netmem)
>   {
> +	if (netmem_is_net_iov(netmem))
> +		return 0;

IIRC 0 is a valid pfn. Not much of a concern since it's
used only for tracing, but might make sense to pass some
invalid pfn if there is one

> +
>   	return page_to_pfn(netmem_to_page(netmem));
>   }
>   
...
>   static inline netmem_ref netmem_compound_head(netmem_ref netmem)
>   {
> +	/* niov are never compounded */
> +	if (netmem_is_net_iov(netmem))
> +		return netmem;
> +
>   	return page_to_netmem(compound_head(netmem_to_page(netmem)));
>   }
>   
> +static inline void *netmem_address(netmem_ref netmem)

I don't think it's used anywhere, do I miss it?

> +{
> +	if (netmem_is_net_iov(netmem))
> +		return NULL;
> +
> +	return page_address(netmem_to_page(netmem));
> +}
> +
...
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a5957d3359762..1152e3547795a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -26,6 +26,8 @@
...
>   
>   /* If the page refcnt == 1, this will try to recycle the page.
> @@ -714,7 +713,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>   	 * refcnt == 1 means page_pool owns page, and can recycle it.
>   	 *
>   	 * page is NOT reusable when allocated when system is under
> -	 * some pressure. (page_is_pfmemalloc)
> +	 * some pressure. (page_pool_page_is_pfmemalloc)

There is no page_pool_page_is_pfmemalloc()

>   	 */
>   	if (likely(__page_pool_page_can_be_recycled(netmem))) {
>   		/* Read barrier done in page_ref_count / READ_ONCE */
> @@ -727,6 +726,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>   		/* Page found as candidate for recycling */
>   		return netmem;
>   	}

-- 
Pavel Begunkov

