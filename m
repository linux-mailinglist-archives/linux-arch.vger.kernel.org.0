Return-Path: <linux-arch+bounces-1999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90678847462
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C828293C96
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073E1487DC;
	Fri,  2 Feb 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fupEQTET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnkcbCIS"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0A1482FC;
	Fri,  2 Feb 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890264; cv=none; b=iMWhvTROgz7oLx6ojiQj2lrkwdqx7IQ8tW3nd3DU+aOIIzqSB0kuWOHflor7gUSHjU6mMB4N3CCZlsfQQDuGACumMoEhojhwDCZvhmnAMY+ZjU6CQGu1DSqfcj6qHrCLLCGGghV1OqBXZO0uH6TsNkGLIMiKIapaiX8PoKyxqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890264; c=relaxed/simple;
	bh=kX8+BVQxSYRnGw0819gNuu29AfOA1dT9NVBEToCHPrQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ehLRdQc54/nsUd+Zi4ee6azgmjazyoVUgO1AKxicSoux5TF84pMcQFKR5NspJ1BKWRY4gTRPz33eoLGlv0AWoBnV/XOG4FbR5AieDGCuDaOKqClN4iB3AYL/TYSe2uzcyGN3xXedO5lsc0BTsKkMzDz+j80v0+6n7jQJQwE1mS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fupEQTET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnkcbCIS; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3FC5E3200B01;
	Fri,  2 Feb 2024 11:10:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 11:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706890255; x=1706976655; bh=2b8pFnyFR4
	gRpQFE8oYwKJiua/TdZSaJZKmQUS52IdY=; b=fupEQTETV1yFF8O5lK0uJpzGgm
	WJeEipvRSfQVqK3q9QukriFXCuGrl/A5rFDj3uu2JsvDp5ku2WDg1MO28mFXvRtJ
	4aGrFl7/muB1E8jWK+dvCmfzqxlUsORpkZlebWTMGimFoN8/K7EG/duu7yFEdhas
	Ms56THyEbnQYqP9nDBJDdljvMdbxLcDTJVuR+9JfskKYDSNb87Uv8w2aJHP+bJ4i
	r9OgdBuus4VBE6chImh9cyzTguslBBOiuSNCB2O9ET23C5/Ru9prZxG5KGDS6jZf
	KBSbtiRKMthNqr5xgXvTudKZK1tnJw8U3vbFEjWPlA6yVbB8z+mvMbpEcp8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706890255; x=1706976655; bh=2b8pFnyFR4gRpQFE8oYwKJiua/Td
	ZSaJZKmQUS52IdY=; b=HnkcbCIShL5JS4xUYseORfLa1KOctLg5H1tdMbKPm1xz
	IEn+/JtJillqyISbvGsqPZ19y5rapjIMMwJe0rI3y5NsBSX2D3sQwfSjqeDKgBgd
	VBiF8ZcEG4wm783Drz+yWInsvT2TrRFx1G4Ym7Az5txpaJuJWkimG+ibtpTJWoIG
	sju+zZxqHEr19YTO1lGIu9AjV1/qVeoiwocgH3SMMZZMznXiy8tF4k+pnD0akTf/
	cZB5MrKdoKh/G2eKRRnKdlJoVEzEw4UAuCJ96Kb6Q/7BLKFx/gWbxbOiIgoe9V6J
	xTb+hi2UY8iAhM4r9Axr0tymKQY9TmIte2RuflPWQg==
X-ME-Sender: <xms:DhS9ZT-bfty49ak_TsE6Wgw5qsubM3RpoVgKWaIUMQQWpYCM5FghZw>
    <xme:DhS9ZfvPbKnCmWhNwoIB46uEQ2m1BuUpOntcmHGosgAhq9AKhrs0DTj1v-7G8ERoS
    LtpnzzTig0Nx5zqk3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DhS9ZRBo9ELzQQwzmG89xWC4GS7JN3HVwgzCOK_Ji1yddMyV8xRAJQ>
    <xmx:DhS9ZfcaMisjyebEb4-8AO7Np9qKjUbem4QhkhQQHZSFN47bUDNugg>
    <xmx:DhS9ZYMph7LnpU09I0VicOivZIzGqF0OsFzahIO194r_ytgJxU4LXA>
    <xmx:DxS9ZXrn71Df2iQYM7II-hjuBT9B-NgKEGBTFjrCcEOvbEeG4-FYJQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 07AF7B6008D; Fri,  2 Feb 2024 11:10:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <819000e2-e638-4bfe-81d4-cb588f86adaa@app.fastmail.com>
In-Reply-To: <20240202140550.9886-1-yan.y.zhao@intel.com>
References: <20240202140550.9886-1-yan.y.zhao@intel.com>
Date: Fri, 02 Feb 2024 17:10:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yan Zhao" <yan.y.zhao@intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] mm: Remove broken pfn_to_virt() on arch csky/hexagon/openrisc
Content-Type: text/plain

On Fri, Feb 2, 2024, at 15:05, Yan Zhao wrote:
> Remove the broken pfn_to_virt() on architectures csky/hexagon/openrisc.
>
> The pfn_to_virt() on those architectures takes PFN instead of PA as the
> input to macro __va(), with PAGE_SHIFT applying to the converted VA, which
> is not right, especially when there's a non-zero offset in __va(). [1]
>
> The broken pfn_to_virt() was noticed when checking how page_to_virt() is
> unfolded on x86. It turns out that the one in linux/mm.h instead of in
> asm-generic/page.h is compiled for x86. However, page_to_virt() in
> asm-generic/page.h is found out expanding to pfn_to_virt() with a bug
> described above. The pfn_to_virt() is found out not right as well on
> architectures csky/hexagon/openrisc.
>
> Since there's no single caller on csky/hexagon/openrisc to pfn_to_virt()
> and there are functions doing similar things as pfn_to_virt() --
> - pfn_to_kaddr() in asm/page.h for csky,
> - page_to_virt() in asm/page.h for hexagon, and
> - page_to_virt() in linux/mm.h for openrisc,
> just delete the pfn_to_virt() on those architectures.
>
> The pfn_to_virt() in asm-generic/page.h is not touched in this patch as
> it's referenced by page_to_virt() in that header while the whole header is
> going to be removed as a whole due to no one including it.
>
> Link:https://lore.kernel.org/all/20240131055159.2506-1-yan.y.zhao@intel.com [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Nice changelog text!

Applied it to the asm-generic tree now, thanks,

    Arnd

