Return-Path: <linux-arch+bounces-90-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5633C7E6610
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506B3B20C45
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31A10A01;
	Thu,  9 Nov 2023 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPjU0k6R"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BC10A0A
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 09:01:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82566359E
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 01:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699520511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GdRtcKnHBIooBz8CRQ9n177xrjS4UMT2Wxo71oaBJg=;
	b=bPjU0k6RI/CYpKKflPCz5VYaMl9jOtCBsV1zqRn1O25tyhWBtohmiXhAB8bfGx+689/0Xm
	dFYWre8Vj1gffoISzV4b5Aid2zaiT83xpwTqQNhrM+ylOdDwM/jA5RziqzegQoxeptX+s0
	i9XUgredcnpwPa81XZ4Tf0kTCwMoqSs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-YOggoHR8PBe1MWCZYiIcow-1; Thu, 09 Nov 2023 04:01:50 -0500
X-MC-Unique: YOggoHR8PBe1MWCZYiIcow-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5435b614a0cso60500a12.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 01:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520509; x=1700125309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GdRtcKnHBIooBz8CRQ9n177xrjS4UMT2Wxo71oaBJg=;
        b=MasZgzAEWmcKvLH+03Jt5ilSlipTDlCtMFwi9sNxj9cfXdN4u4XG9IwdYLk0QZLFgi
         Cw/QnZS9dpO3NAb0k04+c95qhKHDlO7/Grt/053X7HFf2xf7wQ7ieYkHXA8+YniXw91j
         uy1YCE4KQP9OL+5CP2eHTGNtC4CWTRH/3yuoIySGnRaI4WyO4iQGVw1jkZ1FwKlExBhq
         lJgxQwYH66F/3+7ZwsGauejnxA1EHO3M1D4MHkma8KtBjHYylPaBcJPpIYVZm+U1qCGp
         yq+AXwS0aEQEn3dM+ssuxvqu1Zt56fcUQgu7ve0TuEjwuoc3yq3QTbpj6vM3N1LQj7PX
         6MUw==
X-Gm-Message-State: AOJu0YwCW4ApXCPCJqNTpPfZ5MHab0uDMo0DEaYqkVMTsPBhoW/Y/9aN
	ZBIs0EMzQZuTCGlUxUiuiXkV55itdCqSnh9rTxumiX6hpai8q9YVvYdQ4j7GecVGc7sigGFthmW
	G3THUJ5TI1a7B4As7YkUa6g==
X-Received: by 2002:a05:6402:f17:b0:540:a181:f40b with SMTP id i23-20020a0564020f1700b00540a181f40bmr4095000eda.4.1699520509311;
        Thu, 09 Nov 2023 01:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs4kFQwDr2GcSp3GTsPB4RRvWzreFUbMHSJElDo2cAX0GNGwqbEAhl7Xc8OlUx2EJqQdsHHw==
X-Received: by 2002:a05:6402:f17:b0:540:a181:f40b with SMTP id i23-20020a0564020f1700b00540a181f40bmr4094979eda.4.1699520508954;
        Thu, 09 Nov 2023 01:01:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id y93-20020a50bb66000000b0053e6e40cc1asm8068217ede.86.2023.11.09.01.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:01:47 -0800 (PST)
Message-ID: <429f6303c9c61d50ba6c5fdddec30c22dc0b2c09.camel@redhat.com>
Subject: Re: [RFC PATCH v3 07/12] page-pool: device memory support
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 09 Nov 2023 10:01:45 +0100
In-Reply-To: <20231106024413.2801438-8-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-8-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
> Overload the LSB of struct page* to indicate that it's a page_pool_iov.
>=20
> Refactor mm calls on struct page* into helpers, and add page_pool_iov
> handling on those helpers. Modify callers of these mm APIs with calls to
> these helpers instead.
>=20
> In areas where struct page* is dereferenced, add a check for special
> handling of page_pool_iov.
>=20
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>=20
> ---
>  include/net/page_pool/helpers.h | 74 ++++++++++++++++++++++++++++++++-
>  net/core/page_pool.c            | 63 ++++++++++++++++++++--------
>  2 files changed, 118 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index b93243c2a640..08f1a2cc70d2 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page_poo=
l_iov(struct page *page)
>  	return NULL;
>  }
> =20
> +static inline int page_pool_page_ref_count(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return page_pool_iov_refcount(page_to_page_pool_iov(page));
> +
> +	return page_ref_count(page);
> +}
> +
> +static inline void page_pool_page_get_many(struct page *page,
> +					   unsigned int count)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return page_pool_iov_get_many(page_to_page_pool_iov(page),
> +					      count);
> +
> +	return page_ref_add(page, count);
> +}
> +
> +static inline void page_pool_page_put_many(struct page *page,
> +					   unsigned int count)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return page_pool_iov_put_many(page_to_page_pool_iov(page),
> +					      count);
> +
> +	if (count > 1)
> +		page_ref_sub(page, count - 1);
> +
> +	put_page(page);
> +}
> +
> +static inline bool page_pool_page_is_pfmemalloc(struct page *page)
> +{
> +	if (page_is_page_pool_iov(page))
> +		return false;
> +
> +	return page_is_pfmemalloc(page);
> +}
> +
> +static inline bool page_pool_page_is_pref_nid(struct page *page, int pre=
f_nid)
> +{
> +	/* Assume page_pool_iov are on the preferred node without actually
> +	 * checking...
> +	 *
> +	 * This check is only used to check for recycling memory in the page
> +	 * pool's fast paths. Currently the only implementation of page_pool_io=
v
> +	 * is dmabuf device memory. It's a deliberate decision by the user to
> +	 * bind a certain dmabuf to a certain netdev, and the netdev rx queue
> +	 * would not be able to reallocate memory from another dmabuf that
> +	 * exists on the preferred node, so, this check doesn't make much sense
> +	 * in this case. Assume all page_pool_iovs can be recycled for now.
> +	 */
> +	if (page_is_page_pool_iov(page))
> +		return true;
> +
> +	return page_to_nid(page) =3D=3D pref_nid;
> +}
> +
>  /**
>   * page_pool_dev_alloc_pages() - allocate a page.
>   * @pool:	pool from which to allocate
> @@ -301,6 +359,9 @@ static inline long page_pool_defrag_page(struct page =
*page, long nr)
>  {
>  	long ret;
> =20
> +	if (page_is_page_pool_iov(page))
> +		return -EINVAL;
> +
>  	/* If nr =3D=3D pp_frag_count then we have cleared all remaining
>  	 * references to the page:
>  	 * 1. 'n =3D=3D 1': no need to actually overwrite it.
> @@ -431,7 +492,12 @@ static inline void page_pool_free_va(struct page_poo=
l *pool, void *va,
>   */
>  static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>  {
> -	dma_addr_t ret =3D page->dma_addr;
> +	dma_addr_t ret;
> +
> +	if (page_is_page_pool_iov(page))
> +		return page_pool_iov_dma_addr(page_to_page_pool_iov(page));

Should the above conditional be guarded by the page_pool_mem_providers
static key? this looks like fast-path. Same question for the refcount
helper above.

Minor nit: possibly cache 'page_is_page_pool_iov(page)' to make the
code more readable.

> +
> +	ret =3D page->dma_addr;
> =20
>  	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
>  		ret <<=3D PAGE_SHIFT;
> @@ -441,6 +507,12 @@ static inline dma_addr_t page_pool_get_dma_addr(stru=
ct page *page)
> =20
>  static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t =
addr)
>  {
> +	/* page_pool_iovs are mapped and their dma-addr can't be modified. */
> +	if (page_is_page_pool_iov(page)) {
> +		DEBUG_NET_WARN_ON_ONCE(true);
> +		return false;
> +	}

Quickly skimming over the page_pool_code it looks like
page_pool_set_dma_addr() usage is guarded by the PP_FLAG_DMA_MAP page
pool flag. Could the device mem provider enforce such flag being
cleared on the page pool?

> +
>  	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
>  		page->dma_addr =3D addr >> PAGE_SHIFT;
> =20
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 138ddea0b28f..d211996d423b 100644
> --- a/net/core/page_pool.cnn
> +++ b/net/core/page_pool.c
> @@ -317,7 +317,7 @@ static struct page *page_pool_refill_alloc_cache(stru=
ct page_pool *pool)
>  		if (unlikely(!page))
>  			break;
> =20
> -		if (likely(page_to_nid(page) =3D=3D pref_nid)) {
> +		if (likely(page_pool_page_is_pref_nid(page, pref_nid))) {
>  			pool->alloc.cache[pool->alloc.count++] =3D page;
>  		} else {
>  			/* NUMA mismatch;
> @@ -362,7 +362,15 @@ static void page_pool_dma_sync_for_device(struct pag=
e_pool *pool,
>  					  struct page *page,
>  					  unsigned int dma_sync_size)
>  {
> -	dma_addr_t dma_addr =3D page_pool_get_dma_addr(page);
> +	dma_addr_t dma_addr;
> +
> +	/* page_pool_iov memory provider do not support PP_FLAG_DMA_SYNC_DEV */
> +	if (page_is_page_pool_iov(page)) {
> +		DEBUG_NET_WARN_ON_ONCE(true);
> +		return;
> +	}

Similar to the above point, mutatis mutandis.

> +
> +	dma_addr =3D page_pool_get_dma_addr(page);
> =20
>  	dma_sync_size =3D min(dma_sync_size, pool->p.max_len);
>  	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
> @@ -374,6 +382,12 @@ static bool page_pool_dma_map(struct page_pool *pool=
, struct page *page)
>  {
>  	dma_addr_t dma;
> =20
> +	if (page_is_page_pool_iov(page)) {
> +		/* page_pool_iovs are already mapped */
> +		DEBUG_NET_WARN_ON_ONCE(true);
> +		return true;
> +	}

Ditto.

Cheers,

Paolo


