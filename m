Return-Path: <linux-arch+bounces-836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9880B06E
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 00:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07A5281B3D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A65AB95;
	Fri,  8 Dec 2023 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iciff3s5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DB290;
	Fri,  8 Dec 2023 15:13:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33350fcb2c7so1875238f8f.2;
        Fri, 08 Dec 2023 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702077206; x=1702682006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdvT6mOf5g65CEarA8B1SO8V/fqN2dA07OWm6nPK8JQ=;
        b=Iciff3s57iWo3gbYznNcUJOihqjfopVbGB8/Eu+g+tGhLUECb0udcZd5vjumWbAckd
         HFLzNCzu8upvQHdt7sS7fpqr3LmVr86qLW9gbr5dwYLUb67cgRLUWR8bkZfAg/pIYv8F
         rVdTZIkNxJcQHxYJ/5i3tVyADeWce15OEleb4yj+J5ebSM3YbyEiOsvkf7FC+66tV0vH
         jt+6fYXYlIEtnhSqfxO69LF3jaKwehfqCZEwgbNHCF4Qyf6vCyrDdfDXRcUkxPNmFC7S
         6OcX4fVOMsdJwmH/QbRiPrirORnEtQjJHHK464dABiQ6qiwtg1d6fnHD8Jlxz0LiLCd1
         EuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702077206; x=1702682006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdvT6mOf5g65CEarA8B1SO8V/fqN2dA07OWm6nPK8JQ=;
        b=I68ZjREOWkJe9yebTRIgX7ZMrt3c6elKdZbMMbkBRhg9uf6vdhZm9e+ds7I6Lk87vc
         7XTXd346kvaR1Pu7DAaqP7wBoZNkLvCmtDB7Sw+C4Y0tcgQPC/+U227fymznSKT55AX/
         X+R52QLo/7li8zR1BZ8+pGsxZJA0Bo7FiO/rHf66LrG0sbBvN4lm995Q7o+4qyEFr7pQ
         TV37AzhV+fbS5tpBh6TIp2cKmxc1J+g4CnfiTtC+Rk/LdaVts4BQgc1YQs1AfSHnUvBu
         C7VuKQpslAuTrhn69bIHqRITMKukv0sNH9/AeMe7wGdkip4roIqENA9gU8T+5/Vv4cDZ
         Q5nw==
X-Gm-Message-State: AOJu0YwCJUbYbDbCP8dXS9UMtZCTUc7ZZTCyb2rDoXwI9YyRxpkqa2Iq
	M4+Tw2N0PcQoB7dig2eb3aY=
X-Google-Smtp-Source: AGHT+IEBHi/D2vKjO2h2A/tT7jCBjGoOCfZq8DH8NQxvNJdBherB8vnCQiq7VQs7WHEKIMjIAwZ5UA==
X-Received: by 2002:adf:f74e:0:b0:333:546b:bcda with SMTP id z14-20020adff74e000000b00333546bbcdamr358457wrp.137.1702077205923;
        Fri, 08 Dec 2023 15:13:25 -0800 (PST)
Received: from [192.168.8.100] ([85.255.236.117])
        by smtp.gmail.com with ESMTPSA id e33-20020a5d5961000000b0033346fe9b9bsm2923952wri.83.2023.12.08.15.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 15:13:25 -0800 (PST)
Message-ID: <d17e203c-ee9f-44fc-8b03-bb34e80701e7@gmail.com>
Date: Fri, 8 Dec 2023 23:05:49 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory
 provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20231208005250.2910004-9-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 00:52, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem page_pool_iovs.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the page_pool_params.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
> the page_pool can provide the driver with the dma-addrs of the devmem.
> 
> Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
[...]
> +void __page_pool_iov_free(struct page_pool_iov *ppiov);
> +
> +static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	if (!refcount_sub_and_test(count, &ppiov->refcount))
> +		return;
> +
> +	__page_pool_iov_free(ppiov);
> +}
> +
> +/* page pool mm helpers */
> +
> +DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +static inline bool page_is_page_pool_iov(const struct page *page)
> +{
> +	return static_branch_unlikely(&page_pool_mem_providers) &&
> +	       (unsigned long)page & PP_IOV;

Are there any recommendations of not using static keys in widely
used inline functions? I'm not familiar with static key code
generation, but I think the compiler will bloat users with fat chunks
of code in unlikely paths. And I'd assume it creates an array of all
uses, which it'll be walked on enabling/disabling the branch.

> +}
> +
> +static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return (struct page_pool_iov *)((unsigned long)page & ~PP_IOV);
> +
> +	DEBUG_NET_WARN_ON_ONCE(true);
> +	return NULL;
> +}
> +
>   /**
>    * page_pool_dev_alloc_pages() - allocate a page.
>    * @pool:	pool from which to allocate
-- 
Pavel Begunkov

