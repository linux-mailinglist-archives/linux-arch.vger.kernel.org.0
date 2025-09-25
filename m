Return-Path: <linux-arch+bounces-13774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013CB9F69A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082C67B0A88
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73932101AE;
	Thu, 25 Sep 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2sy9lRm+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDFbe+E+"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7E1A5B9E;
	Thu, 25 Sep 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805587; cv=none; b=ASSIepC2o9gv5mZ2Ski2K3ILPcuQtcwHdpEsfKdXEquR3ifnc0JmfPYnAYYr/XWMTubDluRn8gVL4MXkj1QjBdqmvfNpt3rRjHR3BN2kpqFYJgjU9ElvEtaabGvEzTDspbsErZvIBBXhhoEgenPKm5tkMm3Lo8rZXkF9aV0SVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805587; c=relaxed/simple;
	bh=q4ye3IXiZsxvGSYcC9c9EM/q62U5jr861gIEvwgcJ4k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oJ/oErxF/+rlFePfHyEsYdvdepwh6tbTUyefqFvT+rH27tWbvEStCEmb1f4UPscp1q1f5xO5S1wwlg/XcogCX8uZt7tp6rN/5E58kVJ/Ji8F50Tk1dCTdw1gQLQyv9D2FeXbYs/d61bruD6j7MpR6+bcae13V2x+H3u6Ec0keHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2sy9lRm+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDFbe+E+; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id CBE32138017F;
	Thu, 25 Sep 2025 09:06:24 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 09:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758805584;
	 x=1758812784; bh=u2t/IQnp2g1FbVsKAQ8P89KTHzrqE0MZVHtdNZXXUsE=; b=
	2sy9lRm+gAWZynhTnnCoQXRW35ce44lRrHZk/Cj9ytb440KmET5Ee2VrjZ2i4vfw
	MMA5DLOA52iz5f+9Tk9cDJENLM2M9dqv/A2AtWJebWPMhYT+pGAk0Po6sF8u6F2P
	GvPDxasy8rYihjkIMnRv2WHO63/xYwIR1an9t+8GSFbDmpZTRV0lnpt03KhmvY7A
	7a5QzHCsz4u3rYwdfsAHjHE9sHNjWIeoBQ1uhn9mT/D1myooWR8bf0aAycnO+pMP
	HnVzVB7J8xNhoB5ORSk7ILbqFkB2z3O93fjhBfnmNPLKOAsq/3IpuL9l4nVG8g4N
	mkrIfUjiAm8MHu4xzK2JGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758805584; x=
	1758812784; bh=u2t/IQnp2g1FbVsKAQ8P89KTHzrqE0MZVHtdNZXXUsE=; b=Y
	DFbe+E+QUPnk8ohwlw+7+tCt2thZQDd39kOlIwkrNBEU7Co/agHx0rWkKjcOjA4I
	UxezTrOOu8BXHzRgSapyFYfG9SX1kIl/WGWgr/Hfp6GIqR7/HMSXj7UQOEatrk/5
	DYrufeME9R6pr2M8lcqPnU6gX0GrkJCdHskdDkmWzcb9zfiBMS+s0WlLS/oW+Fji
	rolpwCYMrC24e8wBaRGrus/OOdlsyf7EYszqmc8M32TORASYA+2gMpkkmKd7FE8f
	U/wa81NqjBlZM0fqPAQa3NUPT4FZNk3k8m626tF6kSBG3D0qMQbHLltDHBgwa3QR
	eRtVlFB9twL0AnwY0Z01Q==
X-ME-Sender: <xms:Tz7VaOuN1fHT7_CJ1M6Gnkl8KMZjSvhMKV9e7dIZabjJhgMnpIIGPA>
    <xme:Tz7VaORioU__2iKdwpL9HoErjM3EvudsXvEupsPo3pA1NxFV5V1QU7XN8Wib-zp_S
    16KYYY4OGNVTs2zP_NC6uWHukZ9PRhBi-DiKYylxhwmAU-XX15Cudc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheptggrthgrlhhinh
    drmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghn
    ugesrghrmhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsg
    hosehgohhoghhlvgdrtghomhdprhgtphhtthhopehnuggvshgruhhlnhhivghrshesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghird
    gtohhm
X-ME-Proxy: <xmx:Tz7VaLONgGDZn_yzUUvrXVOl0hfFzMUiEkhzxoWqQOi-PcUPFwP-pg>
    <xmx:Tz7VaMhnVxcbYGiNq_WRkNKihp9YFbK9lF2FWAxrC1U7-1vSgIYB3g>
    <xmx:Tz7VaHcMXgUMVAMUHYoZfREurZSQ8d1L55qd6WjCburksshl5MIoFg>
    <xmx:Tz7VaBwaJ4XBSeHmatUTHuC0iN8fiuQ4V0Fp0oXEq2VXGUQBPl5GsQ>
    <xmx:UD7VaJv9R6PSAHhGKSRFTmjzH4H84iAYseEmAQRQ9mtcsAYdejym4Av0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E579E70006D; Thu, 25 Sep 2025 09:06:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiLhtS-R-ASF
Date: Thu, 25 Sep 2025 15:05:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Patrisious Haddad" <phaddad@nvidia.com>
Cc: "Tariq Toukan" <tariqt@nvidia.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Saeed Mahameed" <saeedm@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Mark Bloch" <mbloch@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gal Pressman" <gal@nvidia.com>,
 "Leon Romanovsky" <leonro@nvidia.com>,
 "Michael Guralnik" <michaelgur@nvidia.com>,
 "Moshe Shemesh" <moshe@nvidia.com>, "Will Deacon" <will@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Justin Stitt" <justinstitt@google.com>, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev, "Ingo Molnar" <mingo@redhat.com>,
 "Bill Wendling" <morbo@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, x86@kernel.org,
 "Yisen Zhuang" <yisen.zhuang@huawei.com>,
 "Leon Romanovsky" <leonro@mellanox.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Michael Guralnik" <michaelgur@mellanox.com>, patches@lists.linux.dev,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Jijie Shao" <shaojijie@huawei.com>, "Simon Horman" <horms@kernel.org>
Message-Id: <13c5072c-dc93-477c-b72e-02156a0ecc2e@app.fastmail.com>
In-Reply-To: <20250925122139.GW2617119@nvidia.com>
References: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
 <20250925115433.GU2617119@nvidia.com>
 <d548b14e-ae28-4807-9b29-9961543ea549@nvidia.com>
 <20250925122139.GW2617119@nvidia.com>
Subject: Re: [PATCH net-next V5] net/mlx5: Improve write-combining test reliability for
 ARM64 Grace CPUs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 25, 2025, at 14:21, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 03:15:46PM +0300, Patrisious Haddad wrote:
>> 
>> On 9/25/2025 2:54 PM, Jason Gunthorpe wrote:
>> > On Thu, Sep 25, 2025 at 02:48:33PM +0300, Tariq Toukan wrote:
>> > > +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
>> > > +				size_t mmio_wqe_size, unsigned int offset)
>> > > +{
>> > > +#if defined(CONFIG_KERNEL_MODE_NEON) && defined(CONFIG_ARM64)
>> > IS_ENABLED() not defined()
>> I just wonder why, Is there a preference in the driver from like
>> aesthetic/convention point of view?
>> Since here it technically doesnt matter - IS_ENABLED have no functional
>> difference from defined since these are boolean configs not *tristate*ones
>> (cant be loaded as module).
>
> I think it is an aesthetic convention to avoid defined(CONFIG_*) as
> the reasoning it is not tristate is a bit tricky.

In my impression there is no general agreement on this, I would
probably have picked defined() here myself but don't mind the
IS_ENABLED() variant either.

On the other hand, I would in general strongly prefer

     if (IS_ENABLED(CONFIG_FOO)) {
            ...
     }

over any of the preprocessor conditionals, both for readability
and for improving compile-time coverage of the conditional code.

Unfortunately that does not work here because kernel_neon_begin()
etc are only defined on Arm.

     Arnd

