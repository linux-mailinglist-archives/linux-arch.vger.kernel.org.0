Return-Path: <linux-arch+bounces-4-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D97E3195
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06B41C209ED
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545E2EB1F;
	Mon,  6 Nov 2023 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s53NL0fU"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6B2FE2E
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 23:44:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1AE8F;
	Mon,  6 Nov 2023 15:44:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9A3C433C7;
	Mon,  6 Nov 2023 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699314286;
	bh=t0BwAmAb144cG2eL0TnYT2JWy9BOS2OIlHQw4E5qN9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s53NL0fUZ9FBNFCipYjRnFb3FG746CBTXqochlWbarCvEwzcoPCcYJ2NLfA4wdIki
	 E2onJ2+3Cat4oLe552PHcA0d/oghgDT6US1+1ZbqNtHDkCIk/vCQ7t4MUFs3vwUmyW
	 GcqQu1qbBd/O2KS+fus8SxOzrPruj0rVCt+jAFArPK/tZLUGb7SkPNnRW6sk+Eains
	 esV82j+7jylgEynsJGVUcmnLlSgYnDEvo+cbue1jD8SPe0/Qa6ngdKOy889KT/cxx7
	 pfSfv4Qsoko6kf4Bo6MWJmfBUaQdUibdsazVbyUz/uOT8YXHCELcsmcTx4ukNRCa0d
	 6fzgAAIDOTpGQ==
Message-ID: <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
Date: Mon, 6 Nov 2023 16:44:44 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
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
 <20231106024413.2801438-6-almasrymina@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/23 7:44 PM, Mina Almasry wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index eeeda849115c..1c351c138a5b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>  };
>  
>  #ifdef CONFIG_DMA_SHARED_BUFFER
> +struct page_pool_iov *
> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
> +void netdev_free_devmem(struct page_pool_iov *ppiov);

netdev_{alloc,free}_dmabuf?

I say that because a dmabuf can be host memory, at least I am not aware
of a restriction that a dmabuf is device memory.


