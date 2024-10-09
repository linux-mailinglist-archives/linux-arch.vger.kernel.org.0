Return-Path: <linux-arch+bounces-7909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C2996D3D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2382835F8
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3016F0E8;
	Wed,  9 Oct 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oQOs8kCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMeceCAt"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F819ABAB;
	Wed,  9 Oct 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482813; cv=none; b=UXJnP/ArO8YLgHcMM3lcz3SLhcK2p1OWKbKO+Rp4+015wbr6x7OhrAekq9YEtnRpgYXHpJYeVklj7WKQSV55PJZ/z0ceY47ygB0HmzgqmX0Av1Mjevdj8jZ282/Qth5vBZBYS01hMal0TuchO9LrnMxJQOx4ApVAZhUr7tzW+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482813; c=relaxed/simple;
	bh=El3JqQRpLCkxhPsPMxKfjev55jeNH5mnmmxjPHwk2Ig=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hr5QiaPj9Z9tXkl0CTFcp1JHdgbF93duUGkbekYnOxkhC+tqSPjFUE/UK26Onqu8r44xPe9Ex83OirfngW+b2ra01gVaPdHQaoXHn68VbTY61ec9bpVrusnQzYIV4dznT7kfyHizIzxMMGb8MIeO5k2HmzGe0cF0rqmBO0UkQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oQOs8kCK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oMeceCAt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EEAA61380261;
	Wed,  9 Oct 2024 10:06:48 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 10:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728482808;
	 x=1728569208; bh=7AEiig9c/7wiIG97Hr2tulDdk8lJo3CwPWgfvG3cqr0=; b=
	oQOs8kCK/NnoDFbeh8NYIFgnU7EWDJq210AZ17pgPcVr0s8t4Vq4QjsRC0QOkm8Q
	jU6UCfS39M7vux56KrOng2F6Y0yrmrZzpWAKeXdUH11BGy73irTZQZopAtPBoIkT
	1qC9nbDwA8/QYmCZINeI38PZMF52GH342I+9Xx4uF8HHCQoNYhw+Gl6pC0Fq/eRT
	sKFmEByr3o62fi0DvAiYokJQUdQeXxzYLELzNb+wrIAU5eDcakrfFxQHKQxdH1O9
	SfHAqBhlAMLApF0BxQP2CZcSwupwtvb+I4PNSyMIrfCHzthssd5U3WwMYy/6epDW
	rVBtFbK/Zt7gxM1+EguZpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728482808; x=
	1728569208; bh=7AEiig9c/7wiIG97Hr2tulDdk8lJo3CwPWgfvG3cqr0=; b=o
	MeceCAtz/bmQ10Z5D2RfVpXPfnSZkZguqJBx9lKa+IB8SFlwBCPlk5eEgsedk1Ie
	lXF69pWqnMlOmP8/el8nzFs+N+NKzBsmp91Bivm/h9eXpymcH4Zmlqw+RhggqN5v
	usMX3ePPR7QMH2UIKTSUK5NKiCsVomo/cryyyOEe4cHwZWQ8kdXYlrry93U9sDmP
	SfRh7XW/SZAqG14pXP1hy4afWVVe8+b+b1MEnAvf/sRjrbTolgC7ZYkemBMpUUMw
	AKYoXUl+0OsZy23/NtcODfuTUpj4FP4ZVjVxsYouXmnW5e1V615fvPw2n3qtF3rL
	qCd2RQ66eCJAJaUhMoWfw==
X-ME-Sender: <xms:-I0GZwkgABMbFhbjz5TAOeVpoKCpcWalQaX4IdSNB_nP5VmiOxElgw>
    <xme:-I0GZ_3VF9LLk4LXZvZCIUX45tmeF4wKrKwW8xtPlyIdYcfa4bEIMHpaaENRKTmSm
    4hUYMbpzfQANV3Cbyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnh
    gvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshhnphhsqdgrrhgtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtoheplhhinhhugidquhhmsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdr
    ohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdr
    ohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlihhnuhigqd
    grlhhphhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-I0GZ-rCA4Fl-YeMz1EBuIcKDdpCuuOpo3T0vD4P-oZf1RDDpjgaqQ>
    <xmx:-I0GZ8mlUzBY8q2JinIfwPVZi9LXVI32mxMdmVvdp7L9Ai9Y55jtVA>
    <xmx:-I0GZ-3wHxqRWliSbYlqcPrqe2D1EgoLFl-IXjLV57dSVwzcK3wCfg>
    <xmx:-I0GZzsfcfMxXvtiXOnA8c6Djn-ORiK0A1lBW73Gqi1mdoezKwNZiQ>
    <xmx:-I0GZ1v-G53-56c9PHxvQsMFLRDeTrW4Vm6CR0BrqtzB4K1yF0i2ERan>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D3232220071; Wed,  9 Oct 2024 10:06:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Oct 2024 14:06:27 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com>
In-Reply-To: <20241009114334.558004-2-hch@lst.de>
References: <20241009114334.558004-1-hch@lst.de>
 <20241009114334.558004-2-hch@lst.de>
Subject: Re: [PATCH] asm-generic: provide generic page_to_phys and phys_to_page
 implementations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 9, 2024, at 11:43, Christoph Hellwig wrote:
> page_to_phys is duplicated by all architectures, and from some strange
> reason placed in <asm/io.h> where it doesn't fit at all.
>
> phys_to_page is only provided by a few architectures despite having a lot
> of open coded users.
>
> Provide generic versions in <asm-generic/memory_model.h> to make these
> helpers more easily usable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is clearly a good idea, and I'm happy to take that through
the asm-generic tree if there are no complaints.

Do you have any other patches that depend on it?

> -/*
> - * Change "struct page" to physical address.
> - */
> -static inline phys_addr_t page_to_phys(struct page *page)
> -{
> -	unsigned long pfn = page_to_pfn(page);
> -
> -	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !pfn_valid(pfn));
> -
> -	return PFN_PHYS(pfn);
> -}

This part is technically a change in behavior, not sure how
much anyone cares.

> diff --git a/include/asm-generic/memory_model.h 
> b/include/asm-generic/memory_model.h
> index 6796abe1900e30..3d51066f88f819 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -64,6 +64,9 @@ static inline int pfn_valid(unsigned long pfn)
>  #define page_to_pfn __page_to_pfn
>  #define pfn_to_page __pfn_to_page
> 
> +#define page_to_phys(page)	__pfn_to_phys(page_to_pfn(page))
> +#define phys_to_page(phys)	pfn_to_page(__phys_to_pfn(phys))

I think we should try to have a little fewer nested macros
to evaluate here, right now this ends up expanding
__pfn_to_phys, PFN_PHYS, PAGE_SHIFT, CONFIG_PAGE_SHIFT,
page_to_pfn and __page_to_pfn. While the behavior is fine,
modern gcc versions list all of those in an warning message
if someone passes the wrong arguments.

Changing the two macros above into inline functions
would help as well, but may cause other problems.

On a related note, it would be even better if we could come
up with a generic definition for either __pa/__va or
virt_to_phys/phys_to_virt. Most architectures define one
of the two pairs in terms of the other, which leads to
confusion with header include order.

      Arnd

