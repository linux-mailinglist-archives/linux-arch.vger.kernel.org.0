Return-Path: <linux-arch+bounces-121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC87E8651
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D461928121B
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D03D3A1;
	Fri, 10 Nov 2023 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTADZZ/9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53283B2A3;
	Fri, 10 Nov 2023 23:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF495C433C7;
	Fri, 10 Nov 2023 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658184;
	bh=Uzz0ofUN0GdWH6BIrAshYk7RdH6xgZcN3EjqeZ+1zb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTADZZ/90F/7qwZfq6DctzfUcvXxWTAoVgPB4JcKl+BMyH4buYHADpYZMdAzpAtq6
	 ZkpHYO/gp4t8yqM3oNbMpeyWBT8vky55ihaponMI0vdm/liYjSt1GC4uyn0V9FVaOt
	 Ci5+/YA/uVcx09vVsyYQ+9mkDz0IhRweb9Vvn0hs12m85umwqMGYXjdIZAPzcvHR87
	 dipszU5QLy7d/fMOLKUiMqv3+0GQX18SNrmWTTOFuVqonSUFbv2X5QLZ0jGlVpsiRR
	 /3/6wSoEMflLvU+dcVnsOv05+hwfMLIhOinjtDs49Ql7PYstp/ifr08J9Rtd/e0jlc
	 jJoJdqMU03YUQ==
Date: Fri, 10 Nov 2023 15:16:22 -0800
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
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn
 <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory
 provider
Message-ID: <20231110151622.2f45f618@kernel.org>
In-Reply-To: <20231106024413.2801438-7-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Nov 2023 18:44:05 -0800 Mina Almasry wrote:
> +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +
> +	if (!binding)
> +		return -EINVAL;
> +
> +	if (pool->p.flags & PP_FLAG_DMA_MAP ||
> +	    pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> +		return -EOPNOTSUPP;

This looks backwards, we should _force_ the driver to use the dma
mapping built into the page pool APIs, to isolate the driver from
how the DMA addr actually gets obtained. Right?

Maybe seeing driver patches would illuminate.

