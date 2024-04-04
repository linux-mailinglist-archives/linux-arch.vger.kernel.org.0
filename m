Return-Path: <linux-arch+bounces-3439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD40898CEA
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014C41F29C4C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1512BF06;
	Thu,  4 Apr 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjUt7RDL"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F224125B9;
	Thu,  4 Apr 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250288; cv=none; b=KJ9ngcfMs6fP6JTJj2q0mei+aSZUs61g8aFyP9A7Lxe+yf0Itpqk5IenM0sXg4xurU/DzokxLVIjzSSqsip4M0rqIO3Np4EYnsXxcqMA8KiInOwdzVZPRRQjLCEqwbHL0/7Tgh0KOL5j9s/fKX+5T2Jhv6/e7dJJwmt2E4PqgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250288; c=relaxed/simple;
	bh=x/9ry9wlBV0rCnnySuGdNSMlfXrPzK2YD/HWEbR4zhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TThYY0bX5PI71WWdBAqvAdrwwuX370DNNUoSr6ZpLnAkszBribZ1RQSNfj3uG7PUK2YMxdpb+pXSHGru8DMWU+6JEOogHLDDDYpkWHVPfbDcOKgS9DPiYYoaObd033FIAy7u+kI2uYtMIWfthmtBGRkbI6qu7MTVkNrkUgjsCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SjUt7RDL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4CFp86wmxp1/JViVh6kBybDsWXnT4XZ0nWmOLk8Oyj0=; b=SjUt7RDLy8Dplm6P/4WcYLCDto
	JdMhwnM8Tzfwk5oJXKCWGBJAd6uhu57bpnCvXTmEXcMrnoqK4t0aD5o1x6FcPoeHZcEwrqQ3FPctY
	0c+WEzZJ5fshBqiGEcv3yjtTXOEw5ewWZlAsh9VVpawJuENkQYvgtFXn9rIqLzHRUEv/B4yd9T+NI
	CKTrHVJsbB0s1mNNR0fevMlZMbCoTmBq3NE6HUw+kdV3qVOaJBosFJH6nZle7fAO04gBwW0zz6Xhl
	SrnK0b5GjDAXJGIixt3dWRZpcvikm3SkrvW/C/zeVmzHQuuyBVXoYOVj/ba/GG0FEGfYCQOUfddO7
	XGjtmthg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQVm-00000008UpK-45BQ;
	Thu, 04 Apr 2024 17:04:27 +0000
Date: Thu, 4 Apr 2024 18:04:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, joro@8bytes.org, will@kernel.org,
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de,
	herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org,
	benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com,
	jakub@cloudflare.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	kent.overstreet@linux.dev
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <Zg7dmp5VJkm1nLRM@casper.infradead.org>
References: <20240404165404.3805498-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404165404.3805498-1-surenb@google.com>

On Thu, Apr 04, 2024 at 09:54:04AM -0700, Suren Baghdasaryan wrote:
> +++ b/include/linux/dma-fence-chain.h
> @@ -86,10 +86,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
>   *
>   * Returns a new struct dma_fence_chain object or NULL on failure.
>   */
> -static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> -{
> -	return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> -};
> +#define dma_fence_chain_alloc()	kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL)

You've removed some typesafety here.  Before, if I wrote:

	struct page *page = dma_fence_chain_alloc();

the compiler would warn me that I've done something stupid.  Now it
can't tell.  Suggest perhaps:

#define dma_fence_chain_alloc()						  \
	(struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain), \
						GFP_KERNEL)

but maybe there's a better way of doing that.  There are a few other
occurrences of the same problem in this monster patch.

> +++ b/include/linux/hid_bpf.h
> @@ -149,10 +149,7 @@ static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
>  static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
>  static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
>  static inline void hid_bpf_device_init(struct hid_device *hid) {}
> -static inline u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
> -{
> -	return kmemdup(rdesc, *size, GFP_KERNEL);
> -}
> +#define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size) kmemdup(_rdesc, *(_size), GFP_KERNEL)

here

> -static inline handle_t *jbd2_alloc_handle(gfp_t gfp_flags)
> -{
> -	return kmem_cache_zalloc(jbd2_handle_cache, gfp_flags);
> -}
> +#define jbd2_alloc_handle(_gfp_flags)	kmem_cache_zalloc(jbd2_handle_cache, _gfp_flags)

here

> +++ b/include/linux/skmsg.h
> @@ -410,11 +410,8 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock);
>  int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
>  			 struct sk_msg *msg);
>  
> -static inline struct sk_psock_link *sk_psock_init_link(void)
> -{
> -	return kzalloc(sizeof(struct sk_psock_link),
> -		       GFP_ATOMIC | __GFP_NOWARN);
> -}
> +#define sk_psock_init_link()	\
> +		kzalloc(sizeof(struct sk_psock_link), GFP_ATOMIC | __GFP_NOWARN)

here

... I kind of gave up at this point.  You'll want to audit for yourself
anyway ;-)

