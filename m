Return-Path: <linux-arch+bounces-5768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF26942DCA
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 14:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072A21C232A2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC91AED2E;
	Wed, 31 Jul 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FZOD2poL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uthfwm23"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE11AED22;
	Wed, 31 Jul 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427712; cv=none; b=uPpASoX9yAGlPfoEwlMzKlXbzJie7M7FVUjgljhHLa7HbsvTjIxgjY3t6VoX6JoR71zVstqzdxjNS9sjn0FuJhNMSULe9ZHSSxHShZ+PmuCqohTGSj5gS8lzU3vAsm0yxMciJmSVNxGgY3vKtbfZxqNLHAu/PVggxeIoUuwkBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427712; c=relaxed/simple;
	bh=X+N/8wDI+2G8ihgNutvu+cqVca5VfoL36s1iWUu+E5A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m/MOtI8VnNvToshAord+FWfLnVGjBtIrp4n3cRVIOEGPPS7Bxzk5Eh9di9IwEkZdJHze2QrXAHKvpPc15RnYC7pDO+k7j5tiHy83yzgEbnDYnXFdXqYBriUaKXcWTOw3KsJzPGMXnhzd6qNfHkeAAetf/Hp/AN8eKlXKKyx+hCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FZOD2poL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uthfwm23; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C58231146C90;
	Wed, 31 Jul 2024 08:08:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 08:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722427709;
	 x=1722514109; bh=nsi034J3FNIc62+1DZ1jxTLfxGL9bYqPqg9goj1LTos=; b=
	FZOD2poL3w9hagQM+2vBrnmmVRE4grXdd0qLHQUBCMKj/iASuef03udPYjUJCDaa
	lwSbyd+CWrf8AXehGNu2foUvuy9uVLCWaHxDVQSNQVZ0cJRIyYAWpCWWXij6KxJe
	iWk0b7zRETQ3kTLrceMn0/m35W9N+9O45+tOlRbLV1BWNpIRLbwkHdePbBXphmL6
	asnbj2Lex4cbPj8KW3HLnhmWGxqkpoENuIxFi/dZGBJYFZs17bI3FQhz6ltMrb6a
	bniMgCBRFb8KaAecMNbZ0zwWhp5ngEtsF3KPkcKjHbE0qrhbBXGjQSzXWRkYY89a
	yktmI0B6bYCqN72jKv56qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722427709; x=
	1722514109; bh=nsi034J3FNIc62+1DZ1jxTLfxGL9bYqPqg9goj1LTos=; b=u
	thfwm23GhzSO5u1a4GVgOtrvEj60ovv6DG+K8+t0tbTPU/nJU4m3NE/BAFAwFdWI
	cZf3nBt7fhqticbl/sG14hpduPKlz+57NzH1EG08hFaTnddQoaq5shbLCUJMI4Dg
	JhTxy9I3AAN0iylJwNIVob9ggzfO3clgHxDHe7NfJrXtjNhTtULEF9PDZgL5Oik+
	2fLQy7A3ughWm9hDhjyA31knD3hmsZCqeTXLsGCdHvdbqr6rJkONWUjQvr/oWcP7
	mdB9ugUVvQB7S6qWvnfkljE7cgeHdrvHkzRmGsGeL+cRY26UvjCxKmjbxYE0+lel
	SuaNqfzCJRQu3DGzU8U1Q==
X-ME-Sender: <xms:PSmqZmaTTnEFDti-g-Se4RztNfctW2YwgUtyKxt_o82S-v5zsWAskw>
    <xme:PSmqZpaC4HRH-P1jxDPnGVPkoOk0njIH1XGhnOb-pN3y3IDlHZ0aOKJE4DqKyhHtM
    CKAkSUcUBSkqjlaacw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:PSmqZg-2kuau7MwYIY05NKwGFZvjDx6PQ1gjHlPLitfJmZhLX00BFw>
    <xmx:PSmqZopqwBg9DAldg2FPUT1l7zO9XWasx_gpizxp9QSQIgzYXrvVWw>
    <xmx:PSmqZhodIYmgGstrQdIRMHvyJ6Zs_IWzIG6tJMsw2ZfC7_umqMbPqA>
    <xmx:PSmqZmRcHQTCUOni_XTihe62oDh0n3cSf9vB7AKcb9M1pj2ngQu2PQ>
    <xmx:PSmqZna-PgQDtm17-JBbdeF9UeR096Ex1yIiEspxA79GkdGlfQ1IwfsC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5D25DB6008D; Wed, 31 Jul 2024 08:08:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 Jul 2024 14:08:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhiguo Jiang" <justinjiang@vivo.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>,
 "Roman Gushchin" <roman.gushchin@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>, cgroups@vger.kernel.org,
 "Barry Song" <21cnbao@gmail.com>
Cc: opensource.kernel@vivo.com
Message-Id: <b8fad35b-ba72-44ef-b89b-5333dd457ca7@app.fastmail.com>
In-Reply-To: <20240730114426.511-3-justinjiang@vivo.com>
References: <20240730114426.511-1-justinjiang@vivo.com>
 <20240730114426.511-3-justinjiang@vivo.com>
Subject: Re: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 13:44, Zhiguo Jiang wrote:

> +
> +
> +extern bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> +		swp_entry_t entry, int nr);
> +#else
> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> +		swp_entry_t entry, int nr)
> +{
> +	return false;
> +}
> +#endif

To address the reported build regression, that function must
be annotated as 'static inline'.

     Arnd

