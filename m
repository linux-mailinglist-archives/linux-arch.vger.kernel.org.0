Return-Path: <linux-arch+bounces-5-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA807E31A2
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C851C20A0E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DAC2747F;
	Mon,  6 Nov 2023 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFosqqH0"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516622FE31
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 23:49:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F392;
	Mon,  6 Nov 2023 15:49:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E181EC433C8;
	Mon,  6 Nov 2023 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699314562;
	bh=vxZh7uQV/qwyCfhEVz7KfEgklD4PUHvJkzFT4Xt+7Io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TFosqqH0vuGDxkFCsh+y8Th4LUHgwk30AfF75ljEHSTXLtMUk2YpH/GAXfDeG1cB3
	 EzzTqqwD10r+HNVDCDGMl/N9V+DlnnlaMlnsdhCSKRXW7kiDd6ZX/CfRV6Cct4HtiQ
	 wzhiUJixHByChVm0W6BzlMoNriYyTYKbS8P7oxUmWSqfycy8waSYkgLZ8G7l6DcUb9
	 yRu6v2+nPnJJ/LEhXXMhAppXHfuR2Ot211vqmVt2x0dQ0FQD/LjomoseKxhd4IkmfI
	 nO3xKT4vKQZHAedO3bH2w68OluwUQn9mgzPzFUjOGKBQBQdEfJLpsI+oxYPSbYpJ42
	 d4M9M97iHVSYw==
Message-ID: <583db67b-96c6-4e17-bea0-b5a14799db4a@kernel.org>
Date: Mon, 6 Nov 2023 16:49:20 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory
 provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-7-almasrymina@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/23 7:44 PM, Mina Almasry wrote:
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 78cbb040af94..b93243c2a640 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -111,6 +112,45 @@ page_pool_iov_binding(const struct page_pool_iov *ppiov)
>  	return page_pool_iov_owner(ppiov)->binding;
>  }
>  
> +static inline int page_pool_iov_refcount(const struct page_pool_iov *ppiov)
> +{
> +	return refcount_read(&ppiov->refcount);
> +}
> +
> +static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	refcount_add(count, &ppiov->refcount);
> +}
> +
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
> +static inline bool page_is_page_pool_iov(const struct page *page)
> +{
> +	return (unsigned long)page & PP_DEVMEM;

This is another one where the code can be more generic to not force a
lot changes later.  e.g., PP_CUSTOM or PP_NO_PAGE. Then io_uring use
case with host memory can leverage the iov pool in a similar manner.

That does mean skb->devmem needs to be a flag on the page pool and not
just assume iov == device memory.



