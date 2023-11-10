Return-Path: <linux-arch+bounces-128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE87E8682
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D71C20AD0
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A103D963;
	Fri, 10 Nov 2023 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1fE9DxA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4483D3AE;
	Fri, 10 Nov 2023 23:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C55C433C9;
	Fri, 10 Nov 2023 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658377;
	bh=luJNmLAVg0NvFE4vMKzZIgSGc1vreIiFo+6ll6uU50g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1fE9DxAmngdEnLFVm0IGl0MMxV8bmBLE0Ae9DA9ep5/htSzaSPrZ06BwKpbu8Awv
	 QQkFJyOpbK1xhaj0LojSLeZ6qxU+20U73LLDIwR8j0EbdT2o90JDNif00PNGcZjgQX
	 R+z1UqQYhwDMVhxvxSxemLWgLvTkTyTjtXhnMqvI7zRUOwypHo4TEp0IkYZQUrVHW/
	 hgFXKLSR/BOf7nYeVqQ30PWCnefMPg90ivl3acdKti9EBwizBYD4TTbUSk/87mr5p0
	 VkzMPc0fv3Vdsxw8bT+iI8746rthCtklXgTSra4ki3boHAj2e4s8JAKvzp/9+hlwSH
	 /4kbehSUkS9kQ==
Date: Fri, 10 Nov 2023 15:19:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
 <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
Message-ID: <20231110151935.0859fd7a@kernel.org>
In-Reply-To: <20231106024413.2801438-9-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-9-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Nov 2023 18:44:07 -0800 Mina Almasry wrote:
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
> +#include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>

>  /**
>   * DOC: skb checksums
> @@ -3402,15 +3404,38 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
>  	fragto->bv_offset = fragfrom->bv_offset;
>  }
>  
> +/* Returns true if the skb_frag contains a page_pool_iov. */
> +static inline bool skb_frag_is_page_pool_iov(const skb_frag_t *frag)
> +{
> +	return page_is_page_pool_iov(frag->bv_page);
> +}

Maybe we can create a new header? For skb + page pool.

skbuff.h is included by 1/4th of the kernel objects, we should not
be adding dependencies to this header, it really slows down incremental
builds.


