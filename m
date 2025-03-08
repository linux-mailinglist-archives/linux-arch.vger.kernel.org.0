Return-Path: <linux-arch+bounces-10596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C13A57E6E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D6D18921DC
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D186E1E8340;
	Sat,  8 Mar 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LMSLDj/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVdHKRZu"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE151A3177;
	Sat,  8 Mar 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468316; cv=none; b=RslGpYclB+b7Z3QYehVlEpVFZlazhQnl0Cyg/qKPQmBM1oNGiENfk/pZBMkJqmADUCaHC7P0mJJuTIqWodE7s0TTgRo+WkCBB0Oecg1R2U9AtLN83Wee3V3wceGoyo81YJ2VzrMnbI8pZXbnhfnKN8tnDMTpxmQiAOQVX4QrBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468316; c=relaxed/simple;
	bh=/7+C4C4iku3+3KLHxP+lyMp2LEAUxLeZEbSA4EWH9TM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WIJ8a39kN88PkaijEBh/RI40ikDAYkYKJdsIiMjS2C/lc3Oq4iuBjAbefc2scdWrk7M/ptz8Bsy0vNA5+7dP0mAs/KGm5YFhMnI1uDKoHyvqJPd7798hX912OIQGRIS344vdDrjMM8TPLb7zBBJXylngfuTGWPry5GqDhOosH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LMSLDj/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jVdHKRZu; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 5993620160A;
	Sat,  8 Mar 2025 16:11:54 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sat, 08 Mar 2025 16:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741468314;
	 x=1741475514; bh=C6cJwbVoDRAeuF6ka+Poa5zkvDE5zFIAQzAGXRQkSJc=; b=
	LMSLDj/6zCFJ3UvyQ1/MypoE1FqzZAjNGpopT2+pL1QmJaKkUV1WihocrQswxNKX
	zDJO8+UYV/7e2VYvlPckk22mlFoRrOfywd3NTpdgmgp3yf5ilBeS7s21bqLOD9N3
	z8mnx/ufAe1MCtibKBNzXU3AvqsAgQFWLNZOEyWEKCdS8fcvfXBLhNptNCOZTbiy
	wlD0hctNLDfawhtRater4q3VUgxv0ROg4aw1mQIUJrjR/XgolGWLcyVCVFPKETNo
	DBkEnpDwJ7oG9Oa/gHEzeVI5d8k6EO3M8oMj9UxIlH/8REhmUxj8hk2EAJpPZp5l
	RhhPUesHZshdO/EYMV8EWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741468314; x=
	1741475514; bh=C6cJwbVoDRAeuF6ka+Poa5zkvDE5zFIAQzAGXRQkSJc=; b=j
	VdHKRZuf3U4fb9uunzGPvL6CNmqhjPYTe3rsKqtNKhaY/pZrp2IINPNJY2JWuXZd
	RY33BATElzY53tfeQxSBqLuTqbpJLnWv5wbK4rVeRDL2HUp6G+xE/MnoH24Q4she
	Zw0xya7sNy+jy6xa23YkFrJIsewKyZBbM3oBg/sVYzVbSE7jucsBibWRVn8HVC9B
	6ncXJ7c/BSSn5NFlw7sn4dwhZ2KZKrDp5xBFbLvYp9676I8hKrUapubErrnML8Eu
	MHXEkU/mAZ+wflm9hMCWuppvIcWS53HsHXjuw99qvf2QyEr8Tbk2JmNRd6xt1Nj+
	hp2dFCv/g0gkhZrCq7VHA==
X-ME-Sender: <xms:mbLMZ596wPb40_JXIyPtfloWsKkqrCL8QDEm8QgWDvunyGq4pGVH9w>
    <xme:mbLMZ9srqTK0BZFWCgSX-KfGSfBS4jByBYE1PxpJSKF8z3zNBeVNfOE6Li8LAWsyN
    mt5f5VASQmltaFYOjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    gedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghp
    thhtohepjhhovgihrdhgohhulhihsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrd
    hruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgr
    segrrhhmrdgtohhmpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrd
    gtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphht
    thhopeihuhiivghnghhhuhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopegtohhnoh
    hrodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mbLMZ3DGst5K0ncB2CMgLSb0fFckv9GtAIwLMQFO9xM_fVSk6CPhoQ>
    <xmx:mbLMZ9eJisR2lNOiGIPKNcjrOHGDl2yZroJ90LxetiT4_8C6ww40aA>
    <xmx:mbLMZ-OeS-fHGEYgpwJpark3S_3tUdUzYdgXahPvkpqbMH8mPMmfbA>
    <xmx:mbLMZ_k0HUBm-OqkJPuCwRYt895o1R20ovOBLNSpi-Sk8TXTbjUGww>
    <xmx:mrLMZ2VW74UQPiuOOyAuXJ1EzqtujuTLZeYILoa5kZL7Oq9jb1T0XPOr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE4422220072; Sat,  8 Mar 2025 16:11:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 22:11:32 +0100
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
Message-Id: <29bb5b7a-b31f-4b32-92c6-e2588a0f965a@app.fastmail.com>
In-Reply-To: <20250307220304.247725-9-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-9-romank@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v5 08/11] Drivers: hv: vmbus: Get the IRQ number from
 DeviceTree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 7, 2025, at 23:03, Roman Kisel wrote:
> 
> +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)

Instead of the __maybe_unused annotation here

> 
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	ret = vmbus_set_irq(pdev);
> +	if (ret)
> +		return ret;
> +#endif
> +

you can use 

       if (!__is_defined(HYPERVISOR_CALLBACK_VECTOR))
                  ret = vmbus_set_irq(pdev);

and make it a little more readable.

    Arnd

