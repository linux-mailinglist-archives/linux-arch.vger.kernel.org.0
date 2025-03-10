Return-Path: <linux-arch+bounces-10655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED6A5A614
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897DE16661F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9A1DF996;
	Mon, 10 Mar 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C1hTxUvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyQRqWqS"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FD1DD525;
	Mon, 10 Mar 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641670; cv=none; b=Ca8pQYcM3Rcy9U27Gs19Xz7c2Vgff/ACtWj3QI/RUsBDyTRquUNSTtXVsFh+MKeWl/iJHTOe5qTDQjLXuSeAnDcGgtROOre3WS8pehgO2/ZEvt4iBaspsvJ17RRRqO2PfBSRtTseRmdh5+Fl0VLYo8K28RKO5C9NcvEe4ZcwwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641670; c=relaxed/simple;
	bh=b+pL5tPz/STvzduyR8tAJGIpWCTLY7xMzNfVgLy+oho=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CXaIAdATkW+xCnbdn6sfgOJg+EBk6pZuCGK0Zm3oaVPKcejZs5FnfP4ySvDQghtfeef7yOhwG+ei9VDX5eyS8PNfRRV8U0jH2dD45m5pw2LBeNZkEaKOvVV/+ZR4qUqbFbnWk8PYRLp+FHLjdlwlPPLW22DRJdj1N/7JhUVQG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C1hTxUvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyQRqWqS; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 939871D41B86;
	Mon, 10 Mar 2025 17:21:06 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 17:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741641666;
	 x=1741648866; bh=E4HKlxVjhIt2MzhfvIo5qMqiVK9k8HOzhVxjjAVbOk0=; b=
	C1hTxUvPA3Fb5iBKVyaB9S0GfSvuHye+iANMUYbqz2WEwKh+PjF2Ig9bEJQVXL8W
	kdPPlIgBhaXBR9cfmZ0PE2Am21WLFpDOSC8cX4CRdGVkwDQwLrkIeM5p0hpYbe13
	dTxmdFfOvUlpJHQMFzsNCj740xYgX3HO88YG9+874W9W3ONJKWU3JnOvcNKUU/4u
	knNl6Vi+hohsFjz5X2QG4iDQUTaDl2o6gl+/SgTvwh+IxFXmzMQL8wdboNLh14A/
	aarOTRDHRANpQ7jaacfHOdK2NKw4xhhoPCgcdkDHdrFJ9fRJG33i70Yr/2EzUjdG
	KxdDzQVgaqrYOM7VHlF73A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741641666; x=
	1741648866; bh=E4HKlxVjhIt2MzhfvIo5qMqiVK9k8HOzhVxjjAVbOk0=; b=i
	yQRqWqSGI6Kt3YUKxrmI/FlE9b26ffQwpxP94u4VFt4R8vOueVcX3AoCZMSsXlsf
	XL00t5hz0HKoZQiWWgBfXmCi3KczhguDU8kRNtshw4wzTjqLWf4R4c8bJijn8DFl
	5yAnjsGkIz+NVAjzqe0v8OCUxD15L05INUOiZ6x/J4ac0ZBqVNbvzgRHbmj5t9Ba
	3j6HgC/97L/dQ3YDHejXKY/xvQz/hLUQihBs2DCB1G8au5Q5PvHhOBLiHxE0gHPx
	sXxfmR9U/Us8LYPKZcy0PiBDAB8ri/wnT4GnQ5IYNOMthafCCbqTTLAJKEw4GxLS
	2eWJA70Uin2M61IfU8uCQ==
X-ME-Sender: <xms:wVfPZ2JStQfl-VXaWTJ_QuMzQ3ObrIeeleBzBmQxfF4Du39ikrBCLg>
    <xme:wVfPZ-I7hmahTLPWORKx4-GCw39p0HhoYbrARohYV_QOvY1Fl0dBQ8OowZ2_vQTBT
    5KFklbFDw_9R3vrcUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    geefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghp
    thhtohepjhhovgihrdhgohhulhihsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrd
    hruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgr
    segrrhhmrdgtohhmpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrd
    gtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphht
    thhopeihuhiivghnghhhuhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopegtohhnoh
    hrodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wVfPZ2vjrGidv7HfBCACY-yGDYl3EfwXvQhqp8jKyTCtNAEsgJj2fQ>
    <xmx:wVfPZ7ZidpufvcbZMZOogXc8KetgC1YVnS_aBECkUMRpwdLI0iDxwg>
    <xmx:wVfPZ9ZPI552vps1YoMhGOloTLMV3PrxFhTqMlOyR0s_NrkTI0YDFg>
    <xmx:wVfPZ3De8byh2Bv17Og3Rg_scmCx5lM1v133qfZGoZiEq96RKyOTzg>
    <xmx:wlfPZ-pxMLQep5aMAHOoE69Tz3LFoYiwRsd_W-SJ689j4Q6-j_dfe3KI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2BEF92220072; Mon, 10 Mar 2025 17:21:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 22:20:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Kelley" <mhklinux@outlook.com>,
 "Roman Kisel" <romank@linux.microsoft.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Dexuan Cui" <decui@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Joey Gouly" <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, "Len Brown" <lenb@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Oliver Upton" <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Rob Herring" <robh@kernel.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Wei Liu" <wei.liu@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Zenghui Yu" <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Message-Id: <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
In-Reply-To: 
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for arm64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 10, 2025, at 22:01, Michael Kelley wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Saturday, March 8, 2025 1:05 PM
>> >  config HYPERV_VTL_MODE
>> >  	bool "Enable Linux to boot in VTL context"
>> > -	depends on X86_64 && HYPERV
>> > +	depends on (X86_64 || ARM64)
>> >  	depends on SMP
>> > +	select OF_EARLY_FLATTREE
>> > +	select OF
>> >  	default n
>> >  	help
>> 
>> Having the dependency below the top-level Kconfig entry feels a little
>> counterintuitive. You could flip that back as it was before by doing
>> 
>>       select HYPERV_VTL_MODE if !ACPI
>>       depends on ACPI || SMP
>> 
>> in the HYPERV option, leaving the dependency on HYPERV in
>> HYPERV_VTL_MODE.
>
> I would argue that we don't ever want to implicitly select
> HYPERV_VTL_MODE because of some other config setting or
> lack thereof.  VTL mode is enough of a special case that it should
> only be explicitly selected. If someone omits ACPI, then HYPERV
> should not be selectable unless HYPERV_VTL_MODE is explicitly
> selected.
>
> The last line of the comment for HYPERV_VTL_MODE says
> "A kernel built with this option must run at VTL2, and will not run
> as a normal guest."  In other words, don't choose this unless you
> 100% know that VTL2 is what you want.

It sounds like the latter is the real problem: enabling a feature
should never prevent something else from working. Can you describe
what VTL context is and why it requires an exception to a rather
fundamental rule here? If you build a kernel that runs on every
single piece of arm64 hardware and every hypervisor, why can't
you add HYPERV_VTL_MODE to that as an option?

      Arnd

