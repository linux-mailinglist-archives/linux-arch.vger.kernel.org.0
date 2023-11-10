Return-Path: <linux-arch+bounces-126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE57E8679
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93ED281389
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DD3D3B9;
	Fri, 10 Nov 2023 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O87Imx2q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C83D963;
	Fri, 10 Nov 2023 23:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79674C433C8;
	Fri, 10 Nov 2023 23:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658361;
	bh=1I7t6Ai+hRiLbbZt727Rjf2UhRX77+78thKzDhoeWNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O87Imx2q0q+m9Txp/BMMtKPySHNAC/fXEp5NddB1B31ZjSiC47SpaEs6eJBarHKXm
	 +Erk7Qmwa9yVFKKwvAYiGm5AWGK5QVV9b33ahB3sp2SIc6T2CW+FOMDLZq8nL5UCqL
	 TtRaBspceqey9QIfFnaplznB+rFQXDfxqixws23mVhSOk/JejjtM/hFqCymVDQ52n7
	 tkXcanIIYj9S5W1AQ0IR8GD/uNZMowbqeS9hpF9JS8WIJR9L0qjPwiVrM+/FWRCsTz
	 LWLgjQbjT2MJdhifaDNGqktUUGdKgMvYBKr3eMlvijg9am5zIQ3eX6QWTgNboVneoe
	 5FQBROhSnrQRw==
Date: Fri, 10 Nov 2023 15:19:19 -0800
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
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Message-ID: <20231110151919.4789d54b@kernel.org>
In-Reply-To: <20231106024413.2801438-11-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-11-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Nov 2023 18:44:09 -0800 Mina Almasry wrote:
> +		if (!skb_frags_not_readable(skb)) {

nit: maybe call the helper skb_frags_readable() and flip
     the polarity, avoid double negatives.

