Return-Path: <linux-arch+bounces-124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78C7E866D
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D82C1C20A0C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979C3D3B1;
	Fri, 10 Nov 2023 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R181imvs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230753D968;
	Fri, 10 Nov 2023 23:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E505C433C8;
	Fri, 10 Nov 2023 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658240;
	bh=FcD/HWbd4EsU6HwpXVqt2njpk4bjOQ41rYghofjuGtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R181imvsgeKraRpbX9LkEIoxIiXfD6RhL6ZMTrJ5qPQ4EWf2gQhl/rnePu/vqnEmq
	 rF+PDNN0NgZelMtS+uZyDu3jn8OSEtb9Ob03BXtf7JZO9682gNg+jtzHkdXfTpt/Sh
	 qPTLdIvKuBRcahsXUkYUepEY1uC36Y6RYoTBR3YzcsPgJNjjrCpyqAfEyqeLwUoJ//
	 7coMFzfantRo2Zk4eHk5iun30IzxMou3p8lYb0H0R0SRsUIo+RyaysSGcRXCP4i517
	 cpABJ1jfppUbUcxAFgOhCJKHTHlelNaMdEuDf3mqDkMfYtUKuGF+bQdRcTiljdUJBF
	 4j7erT8zDOuKw==
Date: Fri, 10 Nov 2023 15:17:18 -0800
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
Message-ID: <20231110151718.3460e59e@kernel.org>
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

On Sun,  5 Nov 2023 18:44:11 -0800 Mina Almasry wrote:
> +	if (ynl_subscribe(*ys, "mgmt"))
> +		goto err_close;

Why? :)

