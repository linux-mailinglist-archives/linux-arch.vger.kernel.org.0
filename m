Return-Path: <linux-arch+bounces-123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467B7E8669
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3F0B20B56
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB813D3AF;
	Fri, 10 Nov 2023 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgPe1WP3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B681945B;
	Fri, 10 Nov 2023 23:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B48C433C7;
	Fri, 10 Nov 2023 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658232;
	bh=DgVOmmZyh3PXIlWFtVjMUaKArXLuCBtm1eqxE6u0RQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IgPe1WP3NH7aJqiPGbFf01nnZ3S9WWaPDdxWlqeYzs9iaDXsoDvv2dqwKir3GxS/8
	 ovIfqe7IwZnmwI9MvJbsCTwHRj4470U3s09zOeVzdZc/YZ2sZAar9hq9ndnbCwoiF8
	 KPicEYVkTbWf2SWOfHTrvLpJWh7+lddI4LXveik/S0m5YQEgD8OwusdxvhMnijrwp3
	 QbeMiiInT7XxDlesibExVQDmqs0ZhzwtrM7mq3HcqWj+OtiNDqLoDWk/RiwPdsfMrP
	 +fEJD6tHAp1grxD54ay+pE7B6chuXtshliijsxPD1JgQiX16WMoSN6FtvZ78OGNuwC
	 //C01sLxUSBsQ==
Date: Fri, 10 Nov 2023 15:17:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Mina Almasry
 <almasrymina@google.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Message-ID: <20231110151710.2ceded75@kernel.org>
In-Reply-To: <ZUq42Po1Pn-9QxrM@google.com>
References: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
	<ZUlvzm24SA3YjirV@google.com>
	<CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
	<CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
	<CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
	<CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
	<ZUmNk98LyO_Ntcy7@google.com>
	<CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
	<ZUqms8QzQpfPQWyy@google.com>
	<CANn89iJNR8bYYBO92=f5_2hFoTK8+giH11o-7NHURoahwvV11w@mail.gmail.com>
	<ZUq42Po1Pn-9QxrM@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 14:23:20 -0800 Stanislav Fomichev wrote:
> Can we mark a socket as devmem-only? Do we have any use-case for those
> hybrid setups? Or, let me put it that way: do we expect API callers
> to handle both linear and non-linear cases correctly?
> As a consumer of the previous versions of these apis internally,
> I find all those corner cases confusing :-( Hence trying to understand
> whether we can make it a bit more rigid and properly defined upstream.

FWIW I'd also prefer to allow mixing. "Some NICs" can decide HDS
very flexibly, incl. landing full jumbo frames into the "headers".

There's no sender API today to signal how to mark the data for
selective landing,  but if Mina already has the rx side written 
to allow that...

