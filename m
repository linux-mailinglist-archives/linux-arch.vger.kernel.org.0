Return-Path: <linux-arch+bounces-129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47097E868A
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8789B2812F5
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460C3D963;
	Fri, 10 Nov 2023 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBPJ+8HO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F23B79E;
	Fri, 10 Nov 2023 23:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA104C433C8;
	Fri, 10 Nov 2023 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658395;
	bh=WhEv7XhK+t86jf2iy5v/8j4Xu6HVlv6Bu7i7eHf+DcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lBPJ+8HOTH+QZNkBBNnj3QzSJF+Y0eeL633p3vyJ/AvYHNIDs0ZyxBh1HUUxvu9ww
	 Kdu7kCnZfMUZoATzyYeJ8lNCkvs07MFihtPxdJEhv45ubQ6Sg12r35L3sD7WJFaVC5
	 FnCdIKAN5XL16RbE2J6mU4B3ESUlTgRMADYoBsRUdmUdqK1cbk5xhmoYrtZkOB5Vmx
	 urqguJR3yAIfYDyKO0uuN4NC0w4Ec54bVQQya+ceeb9+iRPVuWbuxKTtVtNOrDCW1M
	 gMq1zXrVv6VEbQv/zkG0wJQD4dnri/rEc5t6BPhuLd5CyaLW/Q9gizTFwrQT37mB4S
	 FGagW5ESHEB4Q==
Date: Fri, 10 Nov 2023 15:19:53 -0800
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
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to
 netdevice
Message-ID: <20231110151953.75c03297@kernel.org>
In-Reply-To: <20231106024413.2801438-5-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  5 Nov 2023 18:44:03 -0800 Mina Almasry wrote:
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -52,6 +52,8 @@
>  #include <net/net_trackers.h>
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
> +#include <linux/xarray.h>
> +#include <linux/refcount.h>
> =20
>  struct netpoll_info;
>  struct device;
> @@ -808,6 +810,84 @@ bool rps_may_expire_flow(struct net_device *dev, u16=
 rxq_index, u32 flow_id,
>  #endif
>  #endif /* CONFIG_RPS */
> =20
> +struct netdev_dmabuf_binding {

Similar nitpick to the skbuff.h comment. Take this somewhere else,
please, it doesn't need to be included in netdevice.h

> +	struct netdev_dmabuf_binding *rbinding;

the 'r' in rbinding stands for rx? =F0=9F=A4=94=EF=B8=8F



