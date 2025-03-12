Return-Path: <linux-arch+bounces-10688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27698A5E54D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 21:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD597A7445
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235951EDA03;
	Wed, 12 Mar 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KmMWY0E0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQc1jiJc"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F401DE894;
	Wed, 12 Mar 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811186; cv=none; b=bHJun0DOmVKvA1pjGT3TAbLDiBwc31oR3r2jMVl3Td0fKtHTdTkLlkLamn/FgYaGfNFysdR1nlxqLxpEiZ6o9bbhkWflxoXC1Uu66XSe8TfgWVZxJOf2qKrDCaoEk8zv6ZioHjVcjmJfSbsMXdVUhYPAmwK9msrP6BMvHvHbhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811186; c=relaxed/simple;
	bh=WuwQge+rJTDKGisV/EMaMK8oPw9olRZ9vdfkuSUhAhc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sI6hYyMJz+821CybuSk3Mj6LW5thiYAM/vWyfODWq7wSVnOnqu9eOLE//mFOz/7uNZp2ES4dg6xglpisc18IxBjGbyLxexBug5zsub4392DideRJs4rucypj4enF4LDZE9TnvArTpiVcvAoqQiraYAO/eKAe+Vxg32SZbPd6s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KmMWY0E0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQc1jiJc; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 9B1FB1D4168C;
	Wed, 12 Mar 2025 16:26:21 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 16:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741811181;
	 x=1741818381; bh=2/9NHPLSqg7QqXzfoJ63jB8jV8sd4gks43M2NovTi4c=; b=
	KmMWY0E0+Q6RzmW2S+j76uRY4rSbvCqMC4vLI1dwVNnv53FEJm+MpLO6vUYUmGd7
	XFZTzcDeKI0o+vSM+t5J4fawTUqh+7jKHp/za5vtwNFs14Fkw19VquCQHliK0Ft0
	R2lea/60a4oG01qi9I9pbLO8w6ROK2KOXwQ316MVnDReRl2/YTsaaTtTTu1yacgt
	VSYS88spnzwqNGr3ZWZtCOioGyw/HzJ32RnG+ecyvA/o1X2UiR08OWbdnEmskW7f
	8HqhQmjsJGtqt3hnRZJNrIlmDz6nm9PRC89TdGkurB1xgv1nLvAkT/bHNbXiMRRs
	DOT/g4B2/U41xKuHV82TuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741811181; x=
	1741818381; bh=2/9NHPLSqg7QqXzfoJ63jB8jV8sd4gks43M2NovTi4c=; b=j
	Qc1jiJcXM1PAFWyZyDRFunYLZaBS+VBDdpBkdR1yzWP9EkarcG1ftbG3jVca9yhi
	1MpGreZEyX2iekJ+4Z3kaIv0qTFTPGCZyCeBvc9ecYYkRvbWR5hNApsoWquRCwtB
	goc/jiesxwv4/aD8SWgMDOd8WgXelOFz6uJFEAT7msBuqx3Q5B7KTPLKo14zmzBA
	jClWThoji84U/me3O42ynbpB/Eitd++qZalEWQXPgZVZiuQGjp0GBvkO+ftyFROO
	ZS8X97+rWh3ZuGscOBttg2Rurjl+2ClQ68rJmVIa6hGg8CehHbPz8jtSXpVbrGW/
	tSoId9bvYGYyUdJcveo7g==
X-ME-Sender: <xms:7O3RZyAGEWoZP5sBNP1pN8zxh-f0SapGaoPRg3HgVxLZGBbBVY7jZg>
    <xme:7O3RZ8h3NiK1M2Uv8Bjoon1q4TIY9_kf__EXZnmo5lvyzVRWMsgRy0fTpT18BEsGs
    z8hGxJqC71ZbQelWRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeitddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7O3RZ1kIj1RcQTiUeBf-7lyZUFZN-3mCEwmWe8a_ZsG6GRktHTJrcw>
    <xmx:7O3RZwzwVadowoq6zpxWnvOOwsuudToLHRiCTIN1-8AkgkhA6jcpzg>
    <xmx:7O3RZ3TBlWRUSkkkWnxjt_dP1GbfIvj8F5I2_FH-mBjfKMZFcoYiqg>
    <xmx:7O3RZ7YyaM8RCLIDprDHhiULISHTCcIq57mOwey9LyD94nXNdhskeg>
    <xmx:7e3RZ1AeqssfSmsui9TM8EP6fVr5Y5wmkT5sn2uMjoCbMqbQGhuO3VmO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 370AE2220076; Wed, 12 Mar 2025 16:26:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 21:25:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>,
 "Michael Kelley" <mhklinux@outlook.com>,
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
Message-Id: <45171fb1-7533-449f-83d4-066d038c839f@app.fastmail.com>
In-Reply-To: <caa0d793-3f05-4d7c-88d0-224ec0503cfb@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
 <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <caa0d793-3f05-4d7c-88d0-224ec0503cfb@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for arm64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 12, 2025, at 19:33, Roman Kisel wrote:
> On 3/10/2025 3:18 PM, Michael Kelley wrote:
>
> That's a minimal extension, its surprise factor is very low. It has not
> been seen to cause issues. If no one has strong opinions against that,
> I'd send that in V6.
>

Works for me. Thanks for your detailed explanations.

       Arnd

