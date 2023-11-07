Return-Path: <linux-arch+bounces-13-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A97E3224
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A79280DE2
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B553818;
	Tue,  7 Nov 2023 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHFJpRRp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF27FD;
	Tue,  7 Nov 2023 00:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EF7C433C8;
	Tue,  7 Nov 2023 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699316181;
	bh=rdCTl+4hQmLubYiMS/p2QV8xEsJXv+ZSM2pgQqPjLVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LHFJpRRpE9spIepJHWhKG3x06BG5ePCOBuH4QJZkUidEwERp/tNEcGEPDfwoYcMsD
	 LwQ+LDowdMk/nRme8Pe/2PP8U5mpI2/vbQhTfrjDmoqRK0P0GMn3klxMiSbaEGAvQx
	 TxXq8Y5RvYtNAFTBQmRE6GfauJ63a/UJka/kDzDprGDEt16iWZR1vfQi3/2DP/Asai
	 fs3QZ5heBo/8vttlafXTbhlXmNU5RDgI6S3oS67JNxncI/lQdczhxSDJGJZhgR1QIC
	 kDsR5rXhwiQHG8PesuHnV3MhFJjuLD1YVEoyKFwdec07E1shE+t0tHzE2NG0moUC11
	 E/fd2myN6ldFA==
Message-ID: <fa44c3d1-92b9-4686-ab3b-4fcda257aafd@kernel.org>
Date: Mon, 6 Nov 2023 17:16:20 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
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
 <20231106024413.2801438-10-almasrymina@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-10-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/23 7:44 PM, Mina Almasry wrote:
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 176eb5834746..cdd4fb129968 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -425,6 +425,9 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
>  			return 0;
>  	}
>  
> +	if (skb_frags_not_readable(skb))
> +		goto short_copy;
> +
>  	/* Copy paged appendix. Hmm... why does this look so complicated? */
>  	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>  		int end;
> @@ -616,6 +619,9 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  {
>  	int frag;
>  
> +	if (skb_frags_not_readable(skb))
> +		return -EFAULT;

This check ....
> +
>  	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>  		return msg->sg_from_iter(sk, skb, from, length);


... should go here. That allows custome sg_from_iter to have access to
the skb. What matters is not expecting struct page (e.g., refcounting);
if the custom iter does not do that then all is well. io_uring's iter
does not look at the pages, so all good.

>  
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 42d7f6755f32..56046d65386a 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -390,6 +390,9 @@ static void gro_pull_from_frag0(struct sk_buff *skb, int grow)
>  {
>  	struct skb_shared_info *pinfo = skb_shinfo(skb);
>  
> +	if (WARN_ON_ONCE(skb_frags_not_readable(skb)))
> +		return;
> +
>  	BUG_ON(skb->end - skb->tail < grow);
>  
>  	memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
> @@ -411,7 +414,7 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
>  {
>  	int grow = skb_gro_offset(skb) - skb_headlen(skb);
>  
> -	if (grow > 0)
> +	if (grow > 0 && !skb_frags_not_readable(skb))
>  		gro_pull_from_frag0(skb, grow);
>  }
>  
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 13eca4fd25e1..f01673ed2eff 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1230,6 +1230,14 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
>  		struct page *p;
>  		u8 *vaddr;
>  
> +		if (skb_frag_is_page_pool_iov(frag)) {

Why skb_frag_is_page_pool_iov here vs skb_frags_not_readable?

