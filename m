Return-Path: <linux-arch+bounces-1032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782E8127DC
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 07:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4065F2824F1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B6D26E;
	Thu, 14 Dec 2023 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCwoc/9W"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B7CA57;
	Thu, 14 Dec 2023 06:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B1EC433CC;
	Thu, 14 Dec 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702534828;
	bh=+vkxHeCGMNypV4HTfFOZ2Yy/60cFLbQw3F9hivio95U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XCwoc/9WTOKFFdAICIMqPHMjv6oeO4Pp+v7+7n/BcwEpfIUwCaQGC1TyO90tc3s+F
	 4iMuFSonb7td1SNtF1ARcta6HO3szQxo/eTWA3PWgh1n9ndKRu3EGh+nxdxwJCDwEF
	 C5wbcDdHDR9kDvws7qfFo2ZK3IFMZukwcHNhYfnGRauUxTzKDGsAZUwkEJjVzYYniB
	 rd8UTiTCDeYkElN+6hTQ17XC95nHuKkDorHWKjNxvgot4aPi0xBRyLLQeDnMf+uifL
	 xSTQdlfLVS9vWPcdZDdUGFtsUGZzqb7Z5spstpB1oT9YsbKWHGPQUAatOOPdI3jqXx
	 PsahGbgOBc0ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D40E9DD4EFB;
	Thu, 14 Dec 2023 06:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v1 00/16] Device Memory TCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 06:20:27 +0000
References: <20231208005250.2910004-1-almasrymina@google.com>
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: shailend@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, jeroendb@google.com, pkaligineedi@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, arnd@arndb.de,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, linyunsheng@huawei.com,
 hramamurthy@google.com, shakeelb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 16:52:31 -0800 you wrote:
> Major changes in v1:
> --------------
> 
> 1. Implemented MVP queue API ndos to remove the userspace-visible
>    driver reset.
> 
> 2. Fixed issues in the napi_pp_put_page() devmem frag unref path.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,01/16] net: page_pool: factor out releasing DMA from releasing the page
    https://git.kernel.org/netdev/net-next/c/c3f687d8dfeb
  - [net-next,v1,02/16] net: page_pool: create hooks for custom page providers
    (no matching commit)
  - [net-next,v1,03/16] queue_api: define queue api
    (no matching commit)
  - [net-next,v1,04/16] gve: implement queue api
    (no matching commit)
  - [net-next,v1,05/16] net: netdev netlink api to bind dma-buf to a net device
    (no matching commit)
  - [net-next,v1,06/16] netdev: support binding dma-buf to netdevice
    (no matching commit)
  - [net-next,v1,07/16] netdev: netdevice devmem allocator
    (no matching commit)
  - [net-next,v1,08/16] memory-provider: dmabuf devmem memory provider
    (no matching commit)
  - [net-next,v1,09/16] page_pool: device memory support
    (no matching commit)
  - [net-next,v1,10/16] page_pool: don't release iov on elevanted refcount
    (no matching commit)
  - [net-next,v1,11/16] net: support non paged skb frags
    (no matching commit)
  - [net-next,v1,12/16] net: add support for skbs with unreadable frags
    (no matching commit)
  - [net-next,v1,13/16] tcp: RX path for devmem TCP
    (no matching commit)
  - [net-next,v1,14/16] net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
    (no matching commit)
  - [net-next,v1,15/16] net: add devmem TCP documentation
    (no matching commit)
  - [net-next,v1,16/16] selftests: add ncdevmem, netcat for devmem TCP
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



