Return-Path: <linux-arch+bounces-119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADAF7E8643
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42B9280E74
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FB3A278;
	Fri, 10 Nov 2023 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urs+N/fb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E93D381;
	Fri, 10 Nov 2023 23:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CFC433C8;
	Fri, 10 Nov 2023 23:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658017;
	bh=3kEmglIzeVKeC89qJz186In/g6MnNvWn/X0kBCEAmR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=urs+N/fb0zYrePTt7BfGxDX3SlOzERDJqx1nVlvFB0bjm20DEIOtlngKpII5c8iUC
	 JA+a/PQoHqi7fbtMcF6+72fNv57rXF0fFdo9uGu4Ib4h2e/rh0hXSVpgxVOwgyaE18
	 ZOl47igkAtH6rUtgZzs1JZI9ZKl+tQln3SdK3zFqeuuKQSad1G2Qof0r6YqS5f+K/m
	 avCl0oRY/UckS2XaoWsLJL6GjlHYaQMA8DZIW6fJPMh3vDNg2oHIlMUpsvzmjp/Qf8
	 KlRCpaECHCkbwoKHIiku1cErTYNEclyDVpCghn5fmL2ME3UUxI7uHtCDyIvZ2t9Hq/
	 OtoukLeU9AnSw==
Date: Fri, 10 Nov 2023 15:13:35 -0800
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
 Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
Message-ID: <20231110151335.38a1c6ec@kernel.org>
In-Reply-To: <20231106024413.2801438-13-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-13-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

My brain is slightly fried after trying to catch up on the thread 
for close to 2h. So forgive me if I'm missing something.
This applies to all emails I'm about to send :)

On Sun,  5 Nov 2023 18:44:11 -0800 Mina Almasry wrote:
> +	trigger_device_reset();

The user space must not be responsible for the reset.
We can add some temporary "recreate page pools" ndo
until the queue API is ready. 

But it should not be visible to the user in any way.

And then the kernel can issue the same reset when the netlink 
socket dies to flush device free lists.

Maybe we should also add a "allow device/all-queues reload" flag 
to the netlink API to differentiate drivers which can't implement 
full queue API later on. We want to make sure the defaults work well 
in our "target design", rather than at the first stage. And target
design will reload queues one by one.

