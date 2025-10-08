Return-Path: <linux-arch+bounces-13953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE8BC3768
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 08:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCD93B2905
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D52D9EE6;
	Wed,  8 Oct 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e343gnqj"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FB29B8D0;
	Wed,  8 Oct 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904659; cv=none; b=jgRWFf12WxPv0pM8Y5xk1kdJ+5CpwQoDw4rrejmuCBBK0d+Zaue0bM5GHIPTNprjflgW41WyAo/1WwmGgjcjUzgxy6AJw1GpsyL0M6o5yfRBXMaVmTXV10sESFuLSrPfOFwTA2AAdSDbnQksg+18n7qqnJ5FCJPObI+LjdnJAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904659; c=relaxed/simple;
	bh=S7+jHto0uyDlubN6nNelCH1snqkJhKvmTzZHBlkWxTo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YPWWCcddPTIeAuBLsozj7aHg1bEoBV7kERThm4mKf9k89Y1ReJmFLBIHyrH3Mvu4KbCJmjBmH+2Ja96jO/OTFKZqwpdKQ/7XmS23L/fXn5jPGPdx1Nlutx5AJMGE9jWfsk/Sj5MeaUk/XG38XrRkCn1I+TSL6oXseulsBkNg4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e343gnqj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA7237A01A3;
	Wed,  8 Oct 2025 02:24:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 02:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759904656; x=1759991056; bh=of/Zk3NoJ60SOfxlEHlLZ01daHGhpIzTjyp
	dolQThQU=; b=e343gnqjFy1PppZY6uJWRoFww340axIIW38FzpYcbN7JFjIecxM
	grKONPF4Dgw42i2E1UC0eZRmETN60ynrf2mzWJVGNrCLajA+rgC3Gwvb8E6RvvMc
	ayB+CanQth/Lr/PwnXQaG4b/Tk05sKZwIGqbM2I0/zdA1X7Md8+gFIl4QT+NxMpF
	yg9IAGj0y1CVWemZOvhxfHMGEsvk/BTssTmDRRuuAJ5ryVjQiY+0y/zUQ/0v5+NI
	9ZHpMsJBFHW9TxgvQOeELO4Xiy1FcpdwG4+s8clzaVdslUrBamMXSvScsNRI+1zZ
	0VRXU9h2nZsJKLgvssp25Q+850cHyD91bMA==
X-ME-Sender: <xms:kAPmaHVdBDzzPaw1Lj9b1DhCcxAVu6aE3pUWBYR3Kz4b8RQEDf1x9g>
    <xme:kAPmaLe7kw6iVouRMfyk6ZL0qUrDIwEF8Ocoh0VqNXOm1Ho-_ZzDN_iqx6NwV6c3N
    woKPYZhtHu1OF5yw_efhAJyQTihDjIrcGFZle56SGNzvW6ke_yfJE8x>
X-ME-Received: <xmr:kAPmaAZyDH5LNo-v358EcZkQJ9Vw1yimYihJsaH_heedAVIBbHq9pbX8Fca-XJv00PYWLk8p6TKAivI5R5rfsTbrCghbW_61gzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdekvedv
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehg
    vggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrh
    gthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieek
    khesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusg
    druggvpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhm
X-ME-Proxy: <xmx:kAPmaHNbd-jlESmo_2aFmWEfHA20QqC529OOxm7GGAddWroafqG_eQ>
    <xmx:kAPmaGV7UAeThoR0OdoUmhpZDAaZopiWvBhTYI_n3u0TGEAxOzOx4Q>
    <xmx:kAPmaEKF6_WhGI5exe5jIpz1kntf9sCNwjCfRViPUHfq_UWAVjghPA>
    <xmx:kAPmaJqfY6qtdz9Rlx60yTZOjiv0YkFTF_YoOa-DtVAreKRxVn4JCA>
    <xmx:kAPmaIsLOPvMqH6rdlbp9yeS2SJMEjtZrFn8hCpnlFa5EtX0WU0L0KUy>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:24:14 -0400 (EDT)
Date: Wed, 8 Oct 2025 17:24:04 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@kernel.org>
cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Boqun Feng <boqun.feng@gmail.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
    Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: skip alignment check for try_cmpxchg() old arg
In-Reply-To: <20251006110740.468309-1-arnd@kernel.org>
Message-ID: <7061992e-e8bd-e5e5-9e63-3fb131e0fdde@linux-m68k.org>
References: <20251006110740.468309-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 6 Oct 2025, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'old' argument in atomic_try_cmpxchg() and related functions is a
> pointer to a normal non-atomic integer number, which does not require
> to be naturally aligned, unlike the atomic_t/atomic64_t types themselves.
> 
> In order to add an alignment check with CONFIG_DEBUG_ATOMIC into the
> normal instrument_atomic_read_write() helper, change this check to use
> the non-atomic instrument_read_write(), the same way that was done
> earlier for try_cmpxchg() in commit ec570320b09f ("locking/atomic:
> Correct (cmp)xchg() instrumentation").
> 
> This prevents warnings on m68k calling the 32-bit atomic_try_cmpxchg()
> with 16-bit aligned arguments as well as several more architectures
> including x86-32 when calling atomic64_try_cmpxchg() with 32-bit
> aligned u64 arguments.
> 
> Reported-by: Finn Thain <fthain@linux-m68k.org>

Tested-by: Finn Thain <fthain@linux-m68k.org>

> Link: https://lore.kernel.org/all/cover.1757810729.git.fthain@linux-m68k.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/atomic/atomic-instrumented.h | 26 +++++++++++-----------
>  scripts/atomic/gen-atomic-instrumented.sh  | 11 +++++----
>  2 files changed, 20 insertions(+), 17 deletions(-)
> 

