Return-Path: <linux-arch+bounces-132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300787E885A
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A2F1F20F26
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C75234;
	Sat, 11 Nov 2023 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht9uExB8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683D5226;
	Sat, 11 Nov 2023 02:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F08C433C7;
	Sat, 11 Nov 2023 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699670158;
	bh=gY+gv6FuH7IyPZd+GcBbaxMFJ8nyFzbRgSyvPpB8WHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ht9uExB8i5dnk2CmKBU1mVcjqsdrsD2ZgLZevr8N30eX0ZSAYboFGGKykaf+sSld7
	 CGIVo25CwHPZiytr+teiiIPuigIDo+JPIkQyvN5n3iPDUMIc9jsF0NZEo7e+fDs8hI
	 ztRuR71feWJhW6c3gOy9FbB8al83VwWsa2jI6RDs8vnryE62nP6YASRYhTa1kayr6w
	 Da1EO6WGh1FXrOMerj2O/J/S46xnJ+wZhJFsdyYR1y51fhNB5Bz4l+uQ9vxyzm9yki
	 rXMDshUoip7ZzimtjecJgZVPpXDWmdS8vodHd4gqw3Sf3ZLjfhV8IAAtpr5Xj5Edg8
	 N5/Cmof6uQUjA==
Date: Fri, 10 Nov 2023 18:35:56 -0800
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
 Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
Message-ID: <20231110183556.2b7b7502@kernel.org>
In-Reply-To: <CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-13-almasrymina@google.com>
	<20231110151335.38a1c6ec@kernel.org>
	<CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 18:27:08 -0800 Mina Almasry wrote:
> Thanks for the clear requirement. I clearly had something different in mind.
> 
> Might be dumb suggestions, but instead of creating a new ndo that we
> maybe end up wanting to deprecate once the queue API is ready, how
> about we use either of those existing APIs?
> 
> +void netdev_reset(struct net_device *dev)
> +{
> +       int flags = ETH_RESET_ALL;
> +       int err;
> +
> +#if 1
> +       __dev_close(dev);
> +       err = __dev_open(dev, NULL);
> +#else
> +       err = dev->ethtool_ops->reset(dev, &flags);
> +#endif
> +}
> +
> 
> I've tested both of these to work with GVE on both bind via the
> netlink API and unbind via the netlink socket close, but I'm not
> enough of an expert to tell if there is some bad side effect that can
> happen or something.

We generally don't accept drivers doing device reconfiguration with
full close() + open() because if the open() fails your machine 
may be cut off.

There are drivers which do it, but they are either old... or weren't
reviewed hard enough.

The driver should allocate memory and whether else it can without
stopping the queues first. Once it has all those, stop the queues,
reconfigure with already allocated resources, start queues, free old.

Even without the queue API in place, good drivers do full device
reconfig this way. Hence my mind goes towards a new (temporary?)
ndo. It will be replaced by the queue API, but whoever implements
it for now has to follow this careful reconfig strategy...

