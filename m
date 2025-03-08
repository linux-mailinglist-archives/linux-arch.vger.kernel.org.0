Return-Path: <linux-arch+bounces-10594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354FA57E51
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 22:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7303B01BD
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA5C1A4F2F;
	Sat,  8 Mar 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PbjaYFSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2k09chLW"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23919597F;
	Sat,  8 Mar 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467951; cv=none; b=YZAPlbS9Bcpo6hzh+BlGJsUwoWw3VsXbfyPu32YvVI13tnRmWPEVLmtTGU9JJW4WMUc88MYVZDZJzb+L9pNdhzuyO/ag524pKMb91GdBeynegkyecJllRVeIz0lQORbion+/Sh/rDvJ9N+Bb4pi3SnckW+FVU29Ez3QnHVFHg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467951; c=relaxed/simple;
	bh=soAQYnXR+lBcoAqzICQ9dhN2P4GRiTJuBPmQemVV+zk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LYMtKMWOdR2DJEMF4H5CDhTz3uF3ltjYPyoik5SD664abP3b2cxuB0V4qLCc99By6EzN+EuPU2+SXDXBd5SqlEynHrBRO9sEJ4mPSq6qz7QhZdobXV5FNu7P++Hn62NheYsBlk0C7k7zwPsOnu8SxAzxdbteftpFUbwcnpDOmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PbjaYFSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2k09chLW; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id DE8FE2017E6;
	Sat,  8 Mar 2025 16:05:46 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sat, 08 Mar 2025 16:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741467946;
	 x=1741475146; bh=W4poDmOA64pY4uvHZcOCt8hPoavx9e3hXSZvtxdXHKk=; b=
	PbjaYFSX9IBx2Zrs40HbC9+xW+mfnGRXkjrLnF/lmBTxXHH5vogiHSSOspqIeun1
	NHfBh6H00r3dQfPeg/5Np/6Z9XnSuH0FKD+DR2HubpiuMGQ/cIlXZj4R8B8ROhDL
	goKIgFL/GsoFSOene+PO+8yhXJyNpaw+RIaTc2mAtJJGV6CjknGC9TlrbTxPTF9X
	pWcsaTZU3KhhEbiIyNbOPqhcecuUGjnfGnDJ2dWkoU+YL+V5DIIga1Rn2j0Bl5qL
	u59YI9TE/OHE24iRU+89XEMwS2VxZLS7RtbtY5u5kVRUVTePTpxwefPCm6nJdU9/
	et5ORwsXOuqEk213wxjyfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741467946; x=
	1741475146; bh=W4poDmOA64pY4uvHZcOCt8hPoavx9e3hXSZvtxdXHKk=; b=2
	k09chLWM/lSt9ok/EPaPM1tR7eBje/kIsmlJQe/3mXR56QFqC9W69F7BHwDF0fGM
	kODKlY76T3e9H8oa0C+vm3AnKrYBg4EHOFO+NeDTv9i2LVhrbDe+4On1enx+SXkf
	jCuY+jGWCb7dq6bVKRic6ilsWWRffPxqNl3G4H3ZyFTFR5vG3CC93kYg0GtIJREx
	i7ppS1ZpZObOXtg1acJC8U8r4gnYj7l+dkuLnVJPKp/LgM21hZnVKFd/s3wHJv+C
	oYUKaTLoubtPOBBZsxqlbvftF3FJJh5RQfjk0WIAx3lkCwrtVye9WojKDgsaWm8w
	eqXtQNTKoXuDuJ4eq/jTA==
X-ME-Sender: <xms:KrHMZwqQWf1vmDRRZmKYix9_AvEX71hk9A5-PUg-mMHoqyGuX43GTw>
    <xme:KrHMZ2psuRMKaam0ybx-JZLEC1a7vUGqphSu1hLVSUR3YOE3xwz-daI2PPjxwEq4X
    bngyXPelqUm1rvI9Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudegheekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KrHMZ1O9ctL676w5AHUIxE0SC1uXzVCBMq5d4oaLxLgUSw773mfxVg>
    <xmx:KrHMZ36aWng3VojtFfg9JWrEIO2NAAnLf-1dP-OHoquiOYe6lO0u_Q>
    <xmx:KrHMZ_6_zJEf_V0pq87wzL4JG8U2CRExCG9veX074cbH5tYyr-yvvg>
    <xmx:KrHMZ3iPusvaeexA7SSSlwDrRNP8bOUuPa3aybP_Ilx1k2AiNrnRHA>
    <xmx:KrHMZxAOYkkYPw5ZnbYA_W8w8hNAHsxDFHKJb1ECP7qxkoZka0El8mlf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E676A2220072; Sat,  8 Mar 2025 16:05:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 22:05:24 +0100
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
Message-Id: <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
In-Reply-To: <20250307220304.247725-4-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for arm64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 7, 2025, at 23:02, Roman Kisel wrote:
> @@ -5,18 +5,20 @@ menu "Microsoft Hyper-V guest support"
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> +		|| (ARM64 && !CPU_BIG_ENDIAN)
> +	depends on (ACPI || HYPERV_VTL_MODE)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
> -	select OF_EARLY_FLATTREE if OF
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> 
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
> -	depends on X86_64 && HYPERV
> +	depends on (X86_64 || ARM64)
>  	depends on SMP
> +	select OF_EARLY_FLATTREE
> +	select OF
>  	default n
>  	help

Having the dependency below the top-level Kconfig entry feels a little
counterintuitive. You could flip that back as it was before by doing

      select HYPERV_VTL_MODE if !ACPI
      depends on ACPI || SMP

in the HYPERV option, leaving the dependency on HYPERV in
HYPERV_VTL_MODE.

Is OF_EARLY_FLATTREE actually needed on x86?

      Arnd

