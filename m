Return-Path: <linux-arch+bounces-2807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E306F871E34
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 12:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2122F1C2380C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2A5812B;
	Tue,  5 Mar 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gT9ny6Ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r7l5RfFf"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8E5786E;
	Tue,  5 Mar 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639157; cv=none; b=HIaKZaJFGjsTtNA2vVJ5EC6qNAkAy6XpuqgRbgyLN71CWPrByyvAcVn2Imo/zUYGzKmxbRLDyqZ5QgPmqA4bP9llECOVY9a/TS4d5Wu6u6/LBbMisPyv2CicvAyfs5fNAj4a4FbEQe0+aqXoMCS4xGbP3pScCqZB6pQH3FQRgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639157; c=relaxed/simple;
	bh=cvxuucTIk3cPB6Sfmo73Zpg57jG48hokZ+K6J7a310Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bA43VIZWInlOjMBu9HiWbre9Hiz6JtjctMm6G7MEetmAbp7XpZ/UU4pJk9+LprBzXNclJE8zlo2UOsXxOjnHcZAtDQrDA6qRMNPieiryg0S/7sOjm72Wqf7meKMYpaI6OXBOsbILLuFpj+YS71NTje9DjK3oaBlSpwKv2eXIK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gT9ny6Ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r7l5RfFf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5C811140119;
	Tue,  5 Mar 2024 06:45:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 06:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709639153; x=1709725553; bh=L0V6fINBaj
	l5FUIjF3rvm+rXcNcFq8LiVT+eqTz8+4Q=; b=gT9ny6OxXnueQI9xdCBEag7HKO
	FdCh+erTgJFfAkSJGEeHo3o/CQSkSpNTCQIWB3qHthoZAuHpFNa3Yt2mufh5t8XM
	RkZPoq58i8sQm7QM6k/0UeVnLtSyrqcTvMNlirly12svIohTJGyBpswiVN+4f2nu
	a4Gdmra+RLecfGkvMKV1PStNwiBGeT1YCi3G7T9x+UOhkojR3Vckx7QDUlsLBJrh
	GnA4Jml2c6SDIleCfF0MobGJNkiwYtCpUmXixR4ndlOM77jGOYejxIbDMc9wczNn
	iZ7DAHPx1RtIdjt2UZe+LmMGAeDQIrSxYAiCxR8NGAxvx6HNwGSgGbrfamsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709639153; x=1709725553; bh=L0V6fINBajl5FUIjF3rvm+rXcNcF
	q8LiVT+eqTz8+4Q=; b=r7l5RfFfQCs0KXaQISa21e3Vj0J8W2dG2BZKhtyZbzoa
	xnJHRqLWqDsctD2yeVkohp91MvN0iM/utH2nrY3ZXVonoCPFgkGl4+xB8OrZ+b9C
	XEUEZLCDl8qUJgEzjwQ9t/ozI5aWIhxa1B1Z/Q9Nji3FmFm3ig0Sr9uwe/RVW8Jv
	iI2wHoYdoea+0rd3PPTAyAp9r8DEXTgv5b8fHO8rKJT0zYadppNqGkTzDOJXWjVE
	X673GgaMTas3U54//gV44g6bOwkC0Ldk4+1cJ+vMpiLh2x1Ox0qVnLMvqDHdeNjm
	wpzwqM+OQeVf29lpC0ShM8xvAcsSMVMTFeeWazTa9A==
X-ME-Sender: <xms:8QXnZY1TKoSsgzkFqjvFm4sCKvIM8vRTCf2iLFpBW_rz77-zVucHtw>
    <xme:8QXnZTFdCOHvudbmAbFG1q2XtwcQz8m7HePqTFkmydfa6aMZvb8xbwiMcPkBa9OSh
    QI3wVL_IgjyfAy3WtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8QXnZQ4M1rLZ00uUutjr9FMXuklVvsc3rxj9vS5XqKuTDeV_HGHlpw>
    <xmx:8QXnZR0iw_m4FxVYsfGb7IBGYE9BtOm6uxR54nz4R68d3WFtuHybbQ>
    <xmx:8QXnZbFYu30BCPH0Qo2KVS5wDMPAdKmgxzoHpEp3zyOQucxb2wTb6A>
    <xmx:8QXnZebooVWsndEZ83Gw-Ut3TBDL0rhPgLrtWUsZkkACk0Pz3WkTrQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7A6EEB6008D; Tue,  5 Mar 2024 06:45:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b28dfaba-a5d3-4c33-a07c-9d991c0235a2@app.fastmail.com>
In-Reply-To: <20231208005250.2910004-5-almasrymina@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-5-almasrymina@google.com>
Date: Tue, 05 Mar 2024 12:45:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mina Almasry" <almasrymina@google.com>,
 "Shailend Chand" <shailend@google.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Jeroen de Borst" <jeroendb@google.com>,
 "Praveen Kaligineedi" <pkaligineedi@google.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 shuah <shuah@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Harshitha Ramamurthy" <hramamurthy@google.com>,
 "Shakeel Butt" <shakeelb@google.com>
Subject: Re: [net-next v1 04/16] gve: implement queue api
Content-Type: text/plain

On Fri, Dec 8, 2023, at 01:52, Mina Almasry wrote:
> +static void *gve_rx_queue_mem_alloc(struct net_device *dev, int idx)
> +{
> +	struct gve_per_rx_queue_mem_dqo *gve_q_mem;
...
> +
> +	gve_q_mem = kvcalloc(1, sizeof(*gve_q_mem), GFP_KERNEL);
> +	if (!gve_q_mem)
> +		goto err;

[minor comment]

The structure does not seem overly large, even if you have
an array here, I don't see why you would need the vmalloc
type allocation for struct gve_per_rx_queue_mem_dqo.

   Arnd

