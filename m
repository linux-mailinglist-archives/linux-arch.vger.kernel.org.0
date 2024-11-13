Return-Path: <linux-arch+bounces-9063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F69C6FBD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3DA285C35
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E1202625;
	Wed, 13 Nov 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Glu/V6uj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0Q7M2CX"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5481DD55A;
	Wed, 13 Nov 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502239; cv=none; b=PNfIZKBcFH5iNBhtA83q5ZhueGccOxgzmcHSvAhVlDv79EDlW8P11E0o7QMVRuB1xhAZselVYiBMqsNa9qGXRh3PyxZ8vHUy5uHsXnjiw3yDqUagO+rLZ6MycPvdE/qkBGVy2vczwoAUqtfOHGCEAfeN2hJk2u67uVskJaQIxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502239; c=relaxed/simple;
	bh=svPzHepBWNbI3mRuffkhlsrEFHqUMU/W75hEZV3Wlck=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TYowF5l7nYJSPfAm7R7xdhvg5T/crYQ4nDeL7G0xKA25BYk+2EaEmspJfD9op1hl2eMqn5jBZVCnyqp4rCnKiXueNwfepTupbOMg/t1CVm5yQHM9zv/BGRT9m3cZxWw9PQWt/WX4OsEHISrXzqPwoPpzahKTi7DT9rbN1z2Yf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Glu/V6uj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0Q7M2CX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D24C711401B2;
	Wed, 13 Nov 2024 07:50:36 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 07:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731502236;
	 x=1731588636; bh=Cc7h2TgpM/yAmaZ7kgR9Rv9Nu6LgBcKiBsF2lmwLAks=; b=
	Glu/V6ujlJCNnB/wDFY8SlIgReWbcE/rkXQRuEJtQxyLKhZhforpIHb0vyPhI96g
	OAk396tR3huiiW1H4e02rG4FGIJnQYY63LKgAhYnZfeXsF7JumVtN7OAwzFenfVK
	1jR7/Bu1KQUBFnhZ2jY+7AhdR7A+bKlxeTQWX/tMpks+PnS2ptpAioENnlesNe9g
	QnKJDfVKk5ofzKBDisM9CzzBdsCxpVj3a3olP9mIjSUG+InGzaUdGeL2il5vATgF
	Re1q+n9+7kt8zIk2c+5CCibkDOueyw5DTLg8tb7U4y6ymVMsMcb+OmzO6mzd1DEQ
	t3/qiHCJ1Jqn8C0otQXR+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731502236; x=
	1731588636; bh=Cc7h2TgpM/yAmaZ7kgR9Rv9Nu6LgBcKiBsF2lmwLAks=; b=C
	0Q7M2CXI8DMyrcKIU8oBC+t2LmO+5RB+Dy2q8FxnN688BdrURIJpB5N0rR5WqIzg
	ef1zb+Zg1BmtJnKdvX/19qr70h2Jda82ybY8lAl2s+goz3/xKJG0a2QKnDMs7R+a
	AriX246seK9PMFQ+PUlTaj1jjLgV+ZZuo7qShYRO+ofdiwa3uvvq+1rwe9Tmo9Rn
	23BDjggPt1fqn2J54HyBFcEyppn5QVvAzQkNCgeHvI7nZ72vyZjeRUxynzQQAs3J
	r2dUkl0xlUwjqS2BxqZSkuQTPSbOOBzNKQyeQREh1yyM25kO9NJtnKMBq3nyPYBO
	XAiedXhBsCor55WgACaNQ==
X-ME-Sender: <xms:nKA0Z3d2jjlA7yGqM109qu3EPgaFQW0DgDcb8AJwXOaJ3AB_pKlSZg>
    <xme:nKA0Z9N2wS_TNzjRB-bWlAJkp6RXmSzAgoJ5TaNI-EuDubSkNMp7Nxp8_9III5u_a
    eYm3-v4FzZSv3qn_Gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrgh
    dprhgtphhtthhopehjohhnrdhgrhhimhhmsegrmhgurdgtohhmpdhrtghpthhtohepshgr
    nhhtohhshhdrshhhuhhklhgrsegrmhgurdgtohhmpdhrtghpthhtohepshhurhgrvhgvvg
    drshhuthhhihhkuhhlphgrnhhithesrghmugdrtghomhdprhgtphhtthhopehvrghsrghn
    thdrhhgvghguvgesrghmugdrtghomhdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhi
    esrghrmhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhhumhgrrhgrnhgrnhgusehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hprghnughohhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:nKA0ZwiCBaKo-s-skA9g7gdq4Ag_jW65UFVDN2GpFaBeeSYSfIWQ6A>
    <xmx:nKA0Z4_5bgN3Th2AqLFt89PfQ9Pl0UUEK-yeQrVedCuEGVY4qpDvVg>
    <xmx:nKA0ZzuAjnhmdSt_A_JmeNvbCDMkZUEDq_wQf2GXXq8XUy2eH-sFWg>
    <xmx:nKA0Z3E3LD3HnArdu4LuFtsG1s9rLGcugt4rvrUuVy_re5Y6amVk6w>
    <xmx:nKA0Z8PA8yekBZYK4MwQI5CMdKqtvv9a52SvDB0p3ySdJkFBkWYB77WP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A8772220071; Wed, 13 Nov 2024 07:50:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 13:50:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: "Joerg Roedel" <joro@8bytes.org>, "Robin Murphy" <robin.murphy@arm.com>,
 vasant.hegde@amd.com, "Uros Bizjak" <ubizjak@gmail.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Kevin Tian" <kevin.tian@intel.com>, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Message-Id: <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
In-Reply-To: <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update 256-bit
 DTE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> 
> +static void write_dte_upper128(struct dev_table_entry *ptr, struct 
> dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	old.data128[1] = __READ_ONCE(ptr->data128[1]);

The __READ_ONCE() in place of READ_ONCE() does make this a
lot simpler. After seeing how it is used though, I wonder if
this should just be an open-coded volatile pointer access
to avoid complicating __unqual_scalar_typeof() further.

> +	do {
> +		/*
> +		 * Preserve DTE_DATA2_INTR_MASK. This needs to be
> +		 * done here since it requires to be inside
> +		 * spin_lock(&dev_data->dte_lock) context.
> +		 */
> +		new->data[2] &= ~DTE_DATA2_INTR_MASK;
> +		new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
> +
> +	/* Note: try_cmpxchg inherently update &old.data128[1] on failure */
> +	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], 
> new->data128[1]));

Since this is always done under the lock, is there ever
a chance that the try_cmpxchg128() fails? I see that the
existing code doesn't have the loop, which makes sense
if this is just meant to be an atomic store.

       Arnd

