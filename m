Return-Path: <linux-arch+bounces-4948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F690B87D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2400B1F238D5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE618EFFC;
	Mon, 17 Jun 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJvI+Jbl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8343165;
	Mon, 17 Jun 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646777; cv=none; b=FUrOZCmUNjwSlHb13tz7fZ+djJc5O99SH78kfJ6q70FQCAYfnP8Ll+lwAK0yJKBajjp6ugg7KbV8WEhNMlznvl1Gj98A8HqdJE1dilr44rv+3YbIkkDA7WN+aOTGkQPMDpNPkghyrTw9FxF27YkrilcOlyVa7pAyvkP/eI2QiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646777; c=relaxed/simple;
	bh=4gsJQl6qIuVWg7RhN46VmapVAsYSwUdCY7u3dkVR+gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqYtZ/zRxVmlUjtsDeLgqJfU/ZE9OrN6nRW296lYXdplr72SO1kLbEW6sxTDcJfjef2V0Vf9o61vmvkfMOK36sjRwnqMOpM//8nA26sx8aTwPRhOuY8nX8ZsL4svMwWNbEd//i+XzHDc8p4g50pqceomdpkebEK+scYpr4oLS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJvI+Jbl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f22d3abf1so4200228f8f.1;
        Mon, 17 Jun 2024 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718646774; x=1719251574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpAELCdjsBD+JrbERWD7mTd4OMlGherBa7u+JgUwCuU=;
        b=OJvI+JblguvKGVK+cKS5/Y1J+iPdmCU6EpTZkh1BJcQvrf4hencWnze+98rj0W+5EE
         qGX4gcd8av+qUlxqfVvmzsNb0XSWNEycXVYsVAY4M6LuViV0jK1EYRaaYmEm7GwlYxLd
         a1EGKm9hqQ+pZ6Vit4jwiDVdbkCbmsK8EmMXCsY1WiFBAAFp8273ciC7TCogfcwKghVS
         y/mpn6AkrEi/sJuPtXfkAkI8vvO2MBWq61H/JgfJv2x52bZymVhg7DwGZAIowjKIIVjy
         LkxDpB2WDlFl6SjGTTrylP/X8O/HTE4h0vrF3cS5rNwTh/HAjkjwGr51BBnpLvWQoZ/F
         diYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718646774; x=1719251574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpAELCdjsBD+JrbERWD7mTd4OMlGherBa7u+JgUwCuU=;
        b=F6ih09aXGXTy7yoMigH3gvPEBfTp3yqOj+F1D4PKIL3JLpo81n2YdG62xnEx+c9Ncm
         tp7N82jf95NmoJtFVqfn6wRtUr603E2+L90Bdh1kcaSdcJfbRmLClwZvWBJqgiZTRXCo
         6UFqqVGddzKbzrH7qGOQz+fFf6Znki26drKBXLMLSThmhILMDBWytkke3W5YKO74qd65
         APCwF5mTRTXjdEEGsExScVAqG83lmXUPhMsdiA/6BPqFG3O+3VM4Bof5+3LCVHkNS47X
         5lw/TH1VIHJNi9Wi4MyfzwTPF6uV9hVzCT4YWJ6kiCE4oTd19W+vy/JBRmwxmk1cMhy+
         QUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8yw/wfKSJRj4jH9Ifto4+AA5apFJgxD7BANjXfKGfH57fCUy1Dm0aU+L0mchmVGn/hCX5uVSS30NSygzzmLoggDJ99T7QCUklYWOXxR6GavhmmHnSpnIBWOaVnhAqQ4RBOh0yLIp/QN6TBLWBGrsDwqX4bX+eEBxT9hFaxHJqwy0zGPYEdXqYD0a3Y8TeTAuEIhEBk0ou98Hw//2g5Ky6Z3qqfL0eMpHQwt5VMwUIwvkhoaS07xFGrBNoixIoy9YnqQ8xil0SHSb253Q+O5H5cgohsT/pxqpxFYDI8Ks2VOAm0g9CXsQyPiwh+81eg276FiBiMLqHZ3z/9n/HtAnyclUjt712Zq8fnFNvLviGQ0TjbohHNkNGoCYdIyrQh7p8/CUXGYptegbLI8SiHYeKGrjbyVyer7oa77HVGttP6cZOuAOvvHn2TR4c6y5a7sfZUUMVbfFu3+0kAoCKGyM2B9AOAUP7LyHVw+wvrwzgc5UzQ6DR9KDJtUDkCBG56vYnA2R7uOFwiHYibatwIRE5cej2kSp+h9KKvitnQlAbToLyDbU2iWjf
X-Gm-Message-State: AOJu0YyKeXhR7A9hqsPVjUq989Kx9dNfyHtCYgr67TOAlaOoqnNpOoi6
	Dejxd+7677Vhm3vnqBQIqie1pfBRs1SRjR4aWgAv9Lw64y3RwIMR
X-Google-Smtp-Source: AGHT+IGl45hl8z5GTV7cP0mMya2j77Ernk+fngMh6lTe4ik8n3cM/4R8lGNxKRhI8iXovlNIXIeAXQ==
X-Received: by 2002:adf:efc9:0:b0:35f:219d:e529 with SMTP id ffacd0b85a97d-3607a78338cmr10492439f8f.47.1718646774132;
        Mon, 17 Jun 2024 10:52:54 -0700 (PDT)
Received: from [192.168.42.223] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdce5sm531595666b.108.2024.06.17.10.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:52:53 -0700 (PDT)
Message-ID: <fa9f8d25-9f68-4f63-a070-639e23917827@gmail.com>
Date: Mon, 17 Jun 2024 18:52:54 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/13] page_pool: convert to use netmem
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
 <20240613013557.1169171-6-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
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

nits below,

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


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
>   #endif /* _NET_NETMEM_H */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 873631c79ab16..5e129d5304f53 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -55,6 +55,8 @@
>   #include <linux/dma-mapping.h>
>   
>   #include <net/page_pool/types.h>
> +#include <net/net_debug.h>
> +#include <net/netmem.h>
>   
>   #ifdef CONFIG_PAGE_POOL_STATS
>   /* Deprecated driver-facing API, use netlink instead */
> @@ -103,7 +105,7 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
>    * Get a page fragment from the page allocator or page_pool caches.
>    *
>    * Return:
> - * Return allocated page fragment, otherwise return NULL.
> + * Return allocated page fragment, otherwise return 0.

It's a page_pool_dev_alloc_frag()'s comment, and the function
still returns a pointer.

...
>   static inline void *page_pool_alloc_va(struct page_pool *pool,
> @@ -172,7 +174,8 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
>   	struct page *page;
>   
>   	/* Mask off __GFP_HIGHMEM to ensure we can use page_address() */
> -	page = page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM);
> +	page = netmem_to_page(
> +		page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM));
>   	if (unlikely(!page))
>   		return NULL;
>   
> @@ -189,7 +192,7 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
>    * it returns va of the allocated page or page fragment.
>    *
>    * Return:
> - * Return the va for the allocated page or page fragment, otherwise return NULL.
> + * Return the va for the allocated page or page fragment, otherwise return 0.

ditto

>    */
>   static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
>   					   unsigned int *size)
> @@ -212,6 +215,11 @@ page_pool_get_dma_dir(const struct page_pool *pool)
>   	return pool->p.dma_dir;
>   }
>   
> +static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
> +{
> +	atomic_long_set(&netmem_to_page(netmem)->pp_ref_count, nr);
> +}
...

-- 
Pavel Begunkov

