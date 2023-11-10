Return-Path: <linux-arch+bounces-125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5277E8675
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE55EB20B25
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E003D3B6;
	Fri, 10 Nov 2023 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9fRqmR1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64F3B2A3;
	Fri, 10 Nov 2023 23:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F09C433C7;
	Fri, 10 Nov 2023 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658349;
	bh=Dd3jebo4AS2ZWH3RN1miW12tLJYVseY43ijk1beJi20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9fRqmR1U2biaQbf9D263gpWDTf7YUhWXczhracH0Gqee0CmKA+qgzlo4rVot0AT4
	 VvRnNAMYi7xL/S717i4c4IPxlDQ27Xxz57zXWvgzpQbfb74hpSm4wp2JFMaRxkOJzB
	 fj+czz+E8Oyt4aBl87v8bnmzxlr/c0CbeoIEEYUAueWdb4mk+2NjoQkZEjcjQBwozh
	 9LfL+qJ3dyIPJ7NWqMHfS+YwblGi8nruc0OQAmVHTOTE14qsTB3BQT468KtuRrzLAb
	 UoScOA5QJtOXbeetxc/ztCQwsddpviKocGz4LIRvi4ARQsbMSMxQImFnyt701L9Nqf
	 m1tE/OsABgSxA==
Date: Fri, 10 Nov 2023 15:19:07 -0800
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
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom
 page providers
Message-ID: <20231110151907.023c61cd@kernel.org>
In-Reply-To: <20231106024413.2801438-3-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Nov 2023 18:44:01 -0800 Mina Almasry wrote:
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 6fc5134095ed..d4bea053bb7e 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -60,6 +60,8 @@ struct page_pool_params {
>  	int		nid;
>  	struct device	*dev;
>  	struct napi_struct *napi;
> +	u8		memory_provider;
> +	void            *mp_priv;
>  	enum dma_data_direction dma_dir;
>  	unsigned int	max_len;
>  	unsigned int	offset;

you should rebase on top of net-next

More importantly I was expecting those fields to be gone from params.
The fact that the page pool is configured to a specific provider
should be fully transparent to the driver, driver should just tell
the core what queue its creating the pool from and if there's a dmabuf
bound for that queue - out pops a pp backed by the dmabuf.

My RFC had the page pool params fields here as a hack.

