Return-Path: <linux-arch+bounces-10889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A491A62D47
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 14:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94873B46F3
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C81F9F72;
	Sat, 15 Mar 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lZ2/HmJ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5fbJXZv"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B411DF24E;
	Sat, 15 Mar 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742044371; cv=none; b=Hrm4bmqdNsRO9FP01HUQXCMjIL2S4Ks+IOalJoc70vZCcKBY5msadBrNQ6UliYbj0cDCnJV+m6hELozGnsaBNzQcwqOm9LWZ4EkKcFdoktUqs4rTDTy2/PVeSgEeJLvHG2XaKRKXu5zZJ8cw+N9f/pB2dF4wpEUq1JYKVRspT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742044371; c=relaxed/simple;
	bh=Ir7gaVJJx081V4ur1/3ISg9vasrkT0sEwxI357Klsss=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fqICufFMBWHKmb/XVWg1CtAH941RMQtR9zJZ8AQoAIiFdSj47+pfpXn70b1kkIZ02Zi/9MnC/p/fedWLIM1DZyGulnhTdrUA5RC6JKCEa+emcHXCSOHeHwixVIbDF+oP0p/lcn58y0WEK4Jx8Ef/oqrIR2+Sc1ye/SA2xYAlstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lZ2/HmJ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5fbJXZv; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id E9D261D41476;
	Sat, 15 Mar 2025 09:12:46 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sat, 15 Mar 2025 09:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742044366;
	 x=1742051566; bh=zjpqPzRFbrMWa9s0+G/5KdhXuFCxnkj7sVYO/d8vBxQ=; b=
	lZ2/HmJ4Luof3h0jM9GjUUFV2YpYFeD7OGy2kLNvpLkJjviGMki9XUyLU2U/0OMB
	CkwvIYIhidWAd1GKRWdV6TEbefX53lV5jKtRRfa23y2b9ef4wcfx6yUlJ/FJmy9o
	fIWWzZNpLG9eT9hCRQGMUVkJ4jPTjeKEnKU1uTIz4UKNdqytzIe+pGxQ/59IZDiQ
	l6uMIJOcPnk4WZpTL9cJdkidWOcgJJuOqXi1sJkWQ8RwVEMtHtVZJxE9vq8CyRLI
	228k4aXecExrqxH4IPg6EpqxBGqmpaQA6RlGidCe7aM1NNTb8gkVO03iTGcdDykQ
	n2HMhtm5wnKClR7xeIEezA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742044366; x=
	1742051566; bh=zjpqPzRFbrMWa9s0+G/5KdhXuFCxnkj7sVYO/d8vBxQ=; b=H
	5fbJXZv8JDZz2yet9pCdXyzltbiv1u7lorfHdCFab6j/MODdd1FrsTK19ZypetAO
	OBwVbn0H+RdYm34vJZnCxfkiutdnBBXHhTAv1I4KUjUAMMVBnWS3Zx4JpN4OdteV
	lgEstOBROYSojsFLGIq8AApnm2XyHoFjjjYwFRY224P0YanLHjQRCMq0taH/p2M0
	fXj2+HZYDWFZF0KDTmo3JWNNVX5+fwfKTvAoZ1jIsCOac0rwSMZO6GQzG4NXNWEV
	VWzYg4UcwWlsN/Ms5mThJrs3x1evFn6Fg43gWYM2onHPKw6vPmDGidNAxsioUKhz
	tIyTTW25KsI/qgII9GrPA==
X-ME-Sender: <xms:zHzVZ5e5bbccQ71eoT8MsSnlXos6dj6O4LkQW_sKfOjBwJN9ga_7XQ>
    <xme:zHzVZ3PLn__o3phvppzjPnaRYNaigd1xifdYMmPHdAtgA2EfSEDm-96xVIk_mpwIH
    N52W5V-y9tAcT1cwxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeefkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:zHzVZyhKN6cMRS4T7Hyae4tpIeUndwwkmU8hurEs_dOE89UDlPVf6Q>
    <xmx:zHzVZy_v7TD1PtrsgQplvuTn8Rk60LqhHhFGQUaeKuGzNK7CLnbYHg>
    <xmx:zHzVZ1vVyhc3jQx09MJdCmVEumffhYKMcs14uJ8B14nC6wN-yqYSHQ>
    <xmx:zHzVZxE213fSgpsEbMo0wfDUAThAM6CnHsoTjCTY9GC3DBJyiy-zsw>
    <xmx:znzVZztE_URjpvPiI1QQu-wngtUYNO6vdD-kx2_N6EFnVyHS0jhLgu_A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6EB5A2220072; Sat, 15 Mar 2025 09:12:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Mar 2025 14:12:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>, bhelgaas@google.com,
 "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Dexuan Cui" <decui@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Joey Gouly" <joey.gouly@arm.com>,
 krzk+dt@kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, "Len Brown" <lenb@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Oliver Upton" <oliver.upton@linux.dev>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Rob Herring" <robh@kernel.org>, ssengar@linux.microsoft.com,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Wei Liu" <wei.liu@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Zenghui Yu" <yuzenghui@huawei.com>,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
Message-Id: <50ec2615-97cf-423d-bfe6-f65092a14348@app.fastmail.com>
In-Reply-To: <96bc4caf-b79a-4111-bafa-a7662260f4be@linux.microsoft.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-2-romank@linux.microsoft.com>
 <96bc4caf-b79a-4111-bafa-a7662260f4be@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v6 01/11] arm64: kvm, smccc: Introduce and use API for
 detecting hypervisor presence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 15, 2025, at 01:27, Roman Kisel wrote:
> On 3/14/2025 5:19 PM, Roman Kisel wrote:
>
> While the change is Acked, here is the caveat maybe.
>
> This patch produces warnings wtih sparse and CHECK_ENDING.
> That said, the kernel build produces a whole lot more other warnings
> from building with sparse by itself and/or with CHECK_ENDING.
>
> I am not sure how to proceed with that, thinking I should
> not add warnings yet at the same time there are many others.
> Not certain if folks take these signals as fyi or blockers.

It would be best not to add warnigns. There is slow progress on
fixing all the endianess warnings and I hope this can eventually
complete, so even if there are many existing ones please try to
keep new code clean.

     Arnd

