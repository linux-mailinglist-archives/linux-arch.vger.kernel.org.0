Return-Path: <linux-arch+bounces-127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF377E867E
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC29D281229
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA433D963;
	Fri, 10 Nov 2023 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDjbKuev"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F63C061;
	Fri, 10 Nov 2023 23:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331F2C433C7;
	Fri, 10 Nov 2023 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658367;
	bh=D+rgNwHZFpDs1LpaDcMUKJtp1XBDNR7Hu4FLz0bimv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDjbKuevYwRFaN7WqJiDyPcrz38e5pVS+0laeL9DKurWGRDRdfSwpTZs/VzXEjvKO
	 9tBIBivJzS/HT/aBBhOs1Eitx1ROi33polSHKhPdUhfXJs/KRZBwVj38e+ep4XOxRc
	 0MY4+VmQ01GV/DaAsRYQFTwUugAbj2jHi2457+QDbQM02Zc20AXSQOQinEwKfxR7wD
	 lq5PFgwJ5LlrBPb0cSVOokIG4tjQU+pvM4d6y44IukpqmQmWY5nct39+Pd6EmdMQqU
	 aYe/awKfSX6/oU3Ie9we+MqqDOmhixxE+tYE0fSupvBzkl8TP9R1/inb/7IzviezsQ
	 nLt7uJqnJfupQ==
Date: Fri, 10 Nov 2023 15:19:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@google.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn
 <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Message-ID: <20231110151925.13d946d0@kernel.org>
In-Reply-To: <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
References: <ZUk03DhWxV-bOFJL@google.com>
	<19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
	<CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
	<ZUlhu4hlTaqR3CTh@google.com>
	<CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
	<ZUlvzm24SA3YjirV@google.com>
	<CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
	<CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
	<CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
	<CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
	<ZUmNk98LyO_Ntcy7@google.com>
	<CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 11:53:22 -0800 Mina Almasry wrote:
> My bad on not including some docs about this. The next version should
> have the commit message beefed up to explain all this, or a docs
> patch.

Yes, please. Would be great to have the user facing interface well
explained under Documentation/

