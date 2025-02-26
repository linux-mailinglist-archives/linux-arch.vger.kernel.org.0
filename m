Return-Path: <linux-arch+bounces-10380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22189A46173
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1676317B5C4
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7E221571;
	Wed, 26 Feb 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bPuQKdaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2p6aK+cl"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3EE2206B3;
	Wed, 26 Feb 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578269; cv=none; b=r3nGw7D7OVML3YM26NHj+pOYKAwv8cbwbwlFQ7T6C5zoWFtqcD7aeMbaoHlny5R3VXn1k+sYnEMuL9/YYeQTS/H/DdZYJgLQDO6S7spBdxOmTv8dZI4J14CHU0u1PMjrCi+z9ctkiuw2puVteiC32NhczRJ4JjaJWleW9KnhaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578269; c=relaxed/simple;
	bh=6JvcNFx82rB512YBjhx8YLiZH3NuPw+ATigJCfDcCBU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MbymlWRgVyLv5GWcPdxdyz1zfNiyfUJFohdlg7Oo9PSfzXvNppHx3bI+O95IEfr3dMLjnoRE7wcXAQlixifLS5m2Uquev6o1NYFzTZ0Xuu8MaZbFzIVIEBre6tOqQ5ovxmrMZvf6CEpP34Ty/kIyJa5Brdw8lvTTifWjduKdX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bPuQKdaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2p6aK+cl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B639114014E;
	Wed, 26 Feb 2025 08:57:45 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 08:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740578265;
	 x=1740664665; bh=tZXytPiubmxqPIS8uOUahYJafTAcorBGJm/Sc4uY4DM=; b=
	bPuQKdaamYG6X7c/5heRAnYVR/n2WZ7jUfo+l69evzOhlDVujNWHITYgXwsS56jd
	9c8wjcoZUFFXkRbqFKjzCqNn1zL17DGGMfg/RClEJh/UIm6zW921ozhV3LSrvWNS
	Fk8EYeB2URFSgX268hc24t7BHJhh6K/JylEbZvuDw4pF4uijwomW2pVmVaUSq3ve
	V/KPZgKTg0ntp0L0NIwKqlaJDDY3rCbfQXSM6ZtELPhF5zdAI5vTq97TA+F0lzI+
	eIkxHEVeMP80AQdMfvnj/6U9x46wFxawG4fEs2h2t9bCNetTIB/ZBcfcgA3JvlGZ
	QbgbW4TF89dMP2t6T0hQKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740578265; x=
	1740664665; bh=tZXytPiubmxqPIS8uOUahYJafTAcorBGJm/Sc4uY4DM=; b=2
	p6aK+clTQqinvRokGkoHOeAee7Ch/BcjiIgvYptz7ndme10+I7qdFx71/QpqYB+l
	dkOjvzxZYJCrhg3PJ7+4OiqfD2YQjARnjHim9UBKXfNnHCLVwHDU4+01vy//Bqp8
	LweavQ6jEHFaJCfKQ3Lg/fNuo/b/sdF4xwADT77nY7R5UefknIRwPHytDnqXEiDU
	EYABC2C/u/uGN5NKiGWWm+gvQdSjugqYEhyMcoL0ix2c3S8bVZcc2y8hU5/8O4i1
	2U5vpXZu7jOdSfCm5nh6F7Xj3McUMNpfsHAvKu+x4D7eqkbYDzWEZQ4fe2J+2FoU
	iZ/GaS+SGDehHCOSTSnNg==
X-ME-Sender: <xms:2B2_Z1NcLAU-ocoX2xOcC9doPyQMM3SzO-PZ0i4O0har6bE_x4wHmw>
    <xme:2B2_Z3_9T20zc6f9v3gcS7Kty6-a1TxmrFM2q37e5uXIA_Hx9r09_Mm7BRyDhvqi_
    _nJ-mxRoMsDEyt1_AE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghonhhorh
    doughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghirdhl
    ihhusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:2B2_Z0RhQzPCtPcX6rnHEdjOg46NTqG6e_kTNaFU-IVZMBqB6pFrcA>
    <xmx:2B2_ZxvupkTidtC7S2F9HnrLl5IlU8tGgVOtQPtM1TAcmjBJMC2VfQ>
    <xmx:2B2_Z9dnJ1xpQw-EStIG715rto0DeXe3SvYUODF7_HQNMR3EWyhxwQ>
    <xmx:2B2_Z938LFEianfpCf7BbxOUaqE57XrdfvncdzqRzXROWA9LXO4Ixg>
    <xmx:2R2_ZzHMsUfh9E43ZZvmvsw-qTD_hFBFCxx1blsqPSVrLbygxzPLoM2e>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A74052220072; Wed, 26 Feb 2025 08:57:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 14:57:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
 bhelgaas@google.com, "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Dexuan Cui" <decui@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, krzk+dt@kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Rob Herring" <robh@kernel.org>,
 ssengar@linux.microsoft.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Wei Liu" <wei.liu@kernel.org>, "Will Deacon" <will@kernel.org>,
 devicetree@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Message-Id: <fe0221bb-b309-4e4b-a098-f6a246ac1f60@app.fastmail.com>
In-Reply-To: <a96f9469-a22e-43e7-825d-f67ef550898f@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
 <1b14e3de-4d3e-420c-819c-31ffb2d448bd@app.fastmail.com>
 <593c22ca-6544-423d-84ee-7a06c6b8b5b9@linux.microsoft.com>
 <97887849-faa8-429b-862b-daf6faf89481@app.fastmail.com>
 <6e4685fe-68e9-43bd-96c5-b871edb1b971@linux.microsoft.com>
 <14a199d8-1cf3-49bc-8e0d-92d9c8407b4f@linux.microsoft.com>
 <55b65ba6-4abe-478c-a173-4622c30ddd7b@app.fastmail.com>
 <a96f9469-a22e-43e7-825d-f67ef550898f@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect hypervisor
 presence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2025, at 23:25, Roman Kisel wrote:
> On 2/24/2025 11:24 PM, Arnd Bergmann wrote:
>> On Tue, Feb 25, 2025, at 00:22, Roman Kisel wrote:
>>> Hi Arnd,
>>
>> If you want to declare a uuid here, I think you should remove the
>> ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_{0,1,2,3} macros and just
>> have UUID in normal UUID_INIT() notation as we do for
>> other UUIDs.
>
> I'd gladly stick to that provided I have your support of touching
> KVM's code! As the SMCCC document states, there shall be an UUID,
> and in the kernel, there would be
>
> #define ARM_SMCCC_VENDOR_KVM_UID UUID_INIT(.......)
> #define ARM_SMCCC_VENDOR_HYP_UID UUID_INIT(.......)
>
> Hence, the ARM_SMCCC_VENDOR_HYP_UID_*_REG_{0,1,2,3} can be removed as
> you're suggesting.

Yes, I think that's the best way forward, as it improves
the existing KVM code and all future functions like it.

    Arnd

