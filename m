Return-Path: <linux-arch+bounces-210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA027EA5BA
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C333280EB1
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2C2D631;
	Mon, 13 Nov 2023 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh8VLAlu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B532D62C;
	Mon, 13 Nov 2023 22:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73772C433C8;
	Mon, 13 Nov 2023 22:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699913462;
	bh=y8SvI32OK2xraWnJ4KYO59jDyKCSgMJ4BUaSyMs0sXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sh8VLAlu2TmvxYxt3GN/26B09B8wkV2+1djcwE8Do3NvbevLDLFLmcF4YsP/sCiHD
	 NW4TAVN2626qYqQZ9gcvgaKIoHkfVe+s2AWqXNrsu8Xl0AfBnF1Vd8JWmlqeVdBKOM
	 h2ru3fjERW2LWok5RGV9gkJxm2hnRvqjsTxAfYZyMO9A2PhTDH5PN+1t8UAu1SEGIZ
	 NOIR0ex6iou1GQEd1NFF2ucKqLJjr9mKhphshDQXzoqdPKJhBHReb0wsywTUyCOztx
	 tLE5Vxef0IOTcXVEzGS5tfTu8GIR8oCdjW0zUkV3ILeho4XhBy1idGuC8LO3I8aBdJ
	 yzLBad+6UuGBg==
Date: Mon, 13 Nov 2023 17:10:58 -0500
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
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom
 page providers
Message-ID: <20231113171058.68973860@kernel.org>
In-Reply-To: <CAHS8izPKRh7ukRytXaweKcY_76sE7F_3s1sYVgsUXYGrypK93Q@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-3-almasrymina@google.com>
	<20231110151907.023c61cd@kernel.org>
	<CAHS8izPKRh7ukRytXaweKcY_76sE7F_3s1sYVgsUXYGrypK93Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Nov 2023 19:28:52 -0800 Mina Almasry wrote:
> My issue with this is that if the driver doesn't support dmabuf then
> the driver will accidentally use the pp backed by the dmabuf, allocate
> a page from it, then call page_address() on it or something, and
> crash.
> 
> Currently I avoid that by having the driver be responsible for picking
> up the dmabuf from the netdev_rx_queue and giving it to the page pool.
> What would be the appropriate way to check for driver support in the
> netlink API? Perhaps adding something to ndo_features_check?

We need some form of capabilities. I was expecting to add that as part
of the queue API. Either a new field in struct net_device or in ndos.
I tend to put static driver caps of this nature into ops.
See for instance .supported_ring_params in ethtool ops.

