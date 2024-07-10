Return-Path: <linux-arch+bounces-5350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C195792D511
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E43D1F234FF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A434192469;
	Wed, 10 Jul 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfbpzxdf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71910A09;
	Wed, 10 Jul 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625751; cv=none; b=cpVDIJOw9hBt/cjHMCfFmB/28MlAZcsb9fMoZBIpyrZTgphtdNMX62DFhqzKCDhpU2lETKqMaP+4recl3LfsuHwC5NJfFUsdji6EloT6rCexuEox2gMA8EIiRteN0iF2ihBFX8VCmPEK9tppYzUbHG4FF2WGLZZiHyWOsNcUVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625751; c=relaxed/simple;
	bh=7nXaOQ2Y21REg/4hAQAvgB2v44nvBiwZIAy1N2EwgCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjcEVsu79zWT/hf0wnL45AAPB4i2gj3zARouZJEg7JUFMi6FYvWODg2i2FX8FO9r7LUba59XqGt2EUi6LdUnWzSTLlVkkS36OYTeKVeT/aBZwnVVFvG8w+Bx+45lPWtaFPi0PzD1JxB0/UzUp+0YTKqQEUkQSlNYV+MIfFL8fXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfbpzxdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EF9C4AF0F;
	Wed, 10 Jul 2024 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720625750;
	bh=7nXaOQ2Y21REg/4hAQAvgB2v44nvBiwZIAy1N2EwgCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kfbpzxdfM08YiMA9CnN1Ds8V/6cfkbBcUBSyJUyyszqmvYhChL4AE5DcSgHpHQIYk
	 uK6ddvllWwmNjBDlk3YUhq9pHqSdF5gfYxmE2VWuRJ24IMML35Yn06oLI7IZlAIQyu
	 e6KTtc0qNrFVdrEHQO4OpHLx928c8B5RM0yZfDSyHHGyN8gHHr0wE6R/0HM9//M+dF
	 WOS/N61/Bw/aAKSPINmAQeel29qmosvlZBX5HDEDRV/WOCgFhRB43qP/dsRIiCfz9e
	 iA0zOurNkwSguAGh8kpj73E0ZgtzvHfuDJS1HaVwMLIIvDDkUTbyuNZPVPHOiytyeH
	 99nf/1JFxtdpw==
Date: Wed, 10 Jul 2024 08:35:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v16 01/13] netdev: add
 netdev_rx_queue_restart()
Message-ID: <20240710083548.351e51e5@kernel.org>
In-Reply-To: <20240710001749.1388631-2-almasrymina@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 00:17:34 +0000 Mina Almasry wrote:
> +	DEBUG_NET_WARN_ON_ONCE(!rtnl_is_locked());

ASSERT_RTNL() ?

