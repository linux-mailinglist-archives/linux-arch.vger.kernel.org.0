Return-Path: <linux-arch+bounces-211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE54A7EA5E2
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 23:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645981F2297B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FFF2E621;
	Mon, 13 Nov 2023 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfTtVlCf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDE2D616;
	Mon, 13 Nov 2023 22:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACAAC433C8;
	Mon, 13 Nov 2023 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699913845;
	bh=CxWQpMYa8YFxdmrO7alx+fTpOfQbmSEl3BDYj4zQHDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfTtVlCfr2biHw2W2q09MzqRYOXyxULA1cvXKH7lJgKmOoBelavwg2NXMOeLV7RUo
	 hrZuG3PHE0z5OMU4LNRcYJVjk0cH2848YM8SF61BQovVnipqwkNu8pDfRo54FL/qed
	 /K+B+kMd4vlsDHBN45H7bcB4/VHCJY4WQK9LS2T0cMlbtHGDade5u1H98jC04pTWwN
	 KPdxdN8TpGk98s6qR3UTMZL77bOJSTg3QVyGaeJlKZR8wMv/V50rWPbz2j2fb7M3J8
	 gAhCxBNq7Y1mkkatFEdAbqH0WbqHrEMgjNWtPrunbYike0UbTQowc3cHZ7MmbWmELA
	 naKo5qrdJEm0Q==
Date: Mon, 13 Nov 2023 17:17:21 -0500
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
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
Message-ID: <20231113171721.1a6731e6@kernel.org>
In-Reply-To: <CAHS8izN7MydkJPaHfj7Pw0V+xoDBkCmEVTc1TH24=hjXm98xnQ@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-9-almasrymina@google.com>
	<20231110151935.0859fd7a@kernel.org>
	<CAHS8izN7MydkJPaHfj7Pw0V+xoDBkCmEVTc1TH24=hjXm98xnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Nov 2023 22:05:30 -0800 Mina Almasry wrote:
> My issue here is that all these skb helpers call each other so I end
> up having to move a lot of the unrelated skb helpers to this new
> header (maybe that is acceptable but it feels weird).

Splitting pp headers again is not an option, we already split it into
types and helpers.

The series doesn't apply and it's a bit hard for me to, in between LPC
talks, figure out how to extract your patches from the GH UI to take a
proper look :(
We can defer this for now, and hopefully v4 will apply to net-next.
But it will need to get solved.

