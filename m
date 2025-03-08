Return-Path: <linux-arch+bounces-10595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED5A57E66
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 22:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C533AAF51
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCE1A5BBB;
	Sat,  8 Mar 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Nv/GxENc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eI5CCWFT"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2DF1A08B1;
	Sat,  8 Mar 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468143; cv=none; b=kSeyJEckQ/v38MRZBM7XwB1qdYniv5lEjIQA1KZSnKB0QoA4XxR4pPC8OIGdEJM4lJrS7e7++UwENyJXdWQScff9Q5rcVY2E38pAO+TjfMditQ8y9eEZsm95/MDK7cnCvtzwIV7bo0EUWtTeTBkYxfGazpMgGDRPNWju/pJHfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468143; c=relaxed/simple;
	bh=k+KV9tKviVmM2X3+Wn2rrN1rFxZjkLzC9PykDJ3S5x8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dMPTnWVTCmTyXprkwtbOF6zHsnJU6LSRSl9QPqvyeXGif0Yc2ZjohRxuas9gkZnv7rMRhNRSceOmUYgfzwhOllpyxJmlB1+q163pMsusLcqLT/f3E0TcAOnG3Vq3epnbVWBeE+CjZ7zc3lDsIs+8m7jpNfzLQO8F+7evEBBzUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Nv/GxENc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eI5CCWFT; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 3281A2018F1;
	Sat,  8 Mar 2025 16:09:00 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sat, 08 Mar 2025 16:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741468140;
	 x=1741475340; bh=k+KV9tKviVmM2X3+Wn2rrN1rFxZjkLzC9PykDJ3S5x8=; b=
	Nv/GxENcjbiTXX0M/0R6ZGrLyeXCXkxkr2aOaYV8bkV5CzS5a4FV6e3tiqaYopTP
	KCdgyCmDjRQlD4HYMx4ZrDAmyEwyEk8NYG9/Z/Hn8RYfAfhPx/SMIbe+IAw48qm8
	2spqL17hTDE03Nm+AAH2TCmss64eFXkteWrxEL33X8uQXJofMhhDDt6R9flV2pvB
	dqI8yMcFAPFLA2/aLSfzyhwMfKk5Awg87dTS3HoH4PnOKSEgwRxJzY73vw4o3J5b
	UZ+eSFoMtKcEkf0trJxIjrysUU/ZRPZv6TS1vRENCVHlUxgiicRwH5g73NFjmhkI
	hGovT0nQCGrLVYaWvF4Fnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741468140; x=
	1741475340; bh=k+KV9tKviVmM2X3+Wn2rrN1rFxZjkLzC9PykDJ3S5x8=; b=e
	I5CCWFTua5Fc7wh24wgGy94EUNDorBhALYhPof+wHpXd43yI8TfqZpqnKbISITx3
	23l8jrvqes/RxrsBaFjmclqur1DZW6vyWZS3rccojFaKRkQk0Z4BwO03SSqJenux
	SCERBGpODmJWY7GmVysGWLu4pMBXR3anTPRx4BBNlDSPaczNSBANOvsA6lJSQCaa
	8DL/XFWm3/PeUhN0oP+g6YCJCMvc9yB1w+tTPbxagrMsM9mj7zG5L7dHfs74KVK/
	uc/ZLA27AUG2r/rMdQnxwzzeGNXhWP/EYJX88JyZr/AdEDUIxQVp57uUKsyTIAYK
	BM9GOfQrFUh8VzkgLvkcg==
X-ME-Sender: <xms:67HMZ9KWp6ZYUbeFsuY3l09pr50Dj-C3sup9kOX8ZswgBJI6emuGJA>
    <xme:67HMZ5L_afSSPqyVTd_Z-aahy3HFR6QTjlwC9xXNpbF98_vUtFhk2jDwNyHxNtxVQ
    NhfKPRdBce2O3xlR10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    gedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghp
    thhtohepjhhovgihrdhgohhulhihsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrd
    hruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgr
    segrrhhmrdgtohhmpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrd
    gtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphht
    thhopeihuhiivghnghhhuhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopegtohhnoh
    hrodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:67HMZ1tVt3rXCzZQeGE66XMoKGj9boBkgSZbx2lOmdz7VHEQMfkFRw>
    <xmx:67HMZ-aFhtXfWkZsKg1bH24QbhtNlbIsGdltt8xDedSN0t6gkv2AlQ>
    <xmx:67HMZ0Zr3-aXmtSBqKsorxnr3ZynTyqVlYGpxf94c8rgG28VIRwAdg>
    <xmx:67HMZyAt8CCVl4VoHRCjlAysj6-YlkMjPri4pn4apoSxpNnBi2v0jA>
    <xmx:7LHMZ9haW67EhlxVxdsnGax7T6bJXPMulYE31rfpgxTnTOdc2B3HmTw6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B040E2220072; Sat,  8 Mar 2025 16:08:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 22:08:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>, bhelgaas@google.com,
 "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Conor Dooley" <conor+dt@kernel.org>,
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
Message-Id: <d15274c2-6d61-4db3-ab0f-90591d28bc34@app.fastmail.com>
In-Reply-To: <20250307220304.247725-2-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-2-romank@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v5 01/11] arm64: kvm, smccc: Introduce and use API for
 detectting hypervisor presence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 7, 2025, at 23:02, Roman Kisel wrote:
> The KVM/arm64 uses SMCCC to detect hypervisor presence. That code is
> private, and it follows the SMCCC specification. Other existing and
> emerging hypervisor guest implementations can and should use that
> standard approach as well.
>
> Factor out a common infrastructure that the guests can use, update KVM
> to employ the new API. The cenrtal notion of the SMCCC method is the
> UUID of the hypervisor, and the API follows that.
>
> No functional changes. Validated with a KVM/arm64 guest.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>


