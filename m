Return-Path: <linux-arch+bounces-10131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C74A31F87
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 07:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5803A2F6D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459271FECC2;
	Wed, 12 Feb 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PTBtnGr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJ6uMQOP"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEF11CA9;
	Wed, 12 Feb 2025 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343314; cv=none; b=b+1r1EjoQwlZj+3rt2KGumFDpEpMNoT1+1qcgwXJvXPnGRtqO09ySLGJquKrzNpJjS3AVIw8QAe7TECpIfvW0I30L7o9KbbfgD3Z/g15X+VNbYsNmi6d4WV4FsTLk8346qkQnN3gr8ePCyR32HJzE/6ZUd/TaGLsY1lvDuhq5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343314; c=relaxed/simple;
	bh=XXj/8N3WiTbadg4dcS3JnZHFs6Fr8RVjIsEGpwQzGzI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R5+XkdECxqzjqcCu+wjhZAp1/wP2lHAN3L2xJv9TQrBsENZ50Q+YNETiCOV8LLat7NIn7hmp7u4uxODjaitNsySDNMd8a6AY3bWiL0LNUBvxUza/s6+0hiPhCK+C6FJxNQj490YzLjMHVr/zN/T3WHMUKxsAXk+xnJyMkI62olA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PTBtnGr1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJ6uMQOP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B05AE25401C7;
	Wed, 12 Feb 2025 01:55:10 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Wed, 12 Feb 2025 01:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739343310;
	 x=1739429710; bh=5NJuwD59cIzb4Af+tlSAfPPA3lFxGUeAX1fygvbn4iY=; b=
	PTBtnGr1VGKL6GzZtS+f8euXR5URncpa2RCMq8nsApxHnYPt57OogC2J63cPOmVp
	2k+9i0nPJX9TEl8G/ZiP5h0yOQa1xu4qw51VbAJXQ1Wu8u7Bj6+jfU4uhvuysesI
	727d0E+HYkerv7Q81K6OVeWVKY2PC5ZIkoPaQjKjbNaSLv7NBUcBXeJRPEEpE8YF
	EuEpv2KYEWStwFIxKHE8LT5EIQefwIJPPwF49NzWR3uOX+uhHR12Qo2NqK7BofE8
	wktQY9797xenfrmWwA/Dw0y55q/mksw5t6JoP+WmFbV85NR5v+6Fj4eJBc+6H20o
	LGiVuXrdnfhBpNnYJcUMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739343310; x=
	1739429710; bh=5NJuwD59cIzb4Af+tlSAfPPA3lFxGUeAX1fygvbn4iY=; b=b
	J6uMQOP/ZjuxxmWkQIK/wR5R+AhoSeFUoSNOWsZzWewkE4rnAMUCcIg8zqpZRjHJ
	nGLLIp2cNmlOq1h6sUNv9NB6+IzFOlo1uXWlidbtxEYBg52BUHXNmOXIkyitDuB8
	9nCxaEdjfsi3NwVUloaG9rgHpE3Tdyo014H+7DbWsx+0rrMOWA3gGO20tBVOVOxp
	ps/42VI1Y/a1mrMOLuQvfdoL3gpdJ3MflO3ZU2LiCB7s6tMtCOr3u6knY3aQ5nWD
	f3QA8Em5/hFCO+ky7i8BidC4O7fF8B5NbxtNf2C4Hn2CI+K5W8IlRtvvzDM0RzVO
	ioSidDQLPdVwFaugH5+YA==
X-ME-Sender: <xms:zEWsZ-AdUSE0llP3YTj9D_riPe38n4a8-S846_dSLESMca6szqvpNg>
    <xme:zEWsZ4gU1yIJxHIJeThH9z34fLnj_gt02NgXQkvFSXtLXizKP1gKzqDDzMVdF8B47
    0qSaRi6DBavpwQ2G_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:zEWsZxlGxubx8akHImGwweAAVqHfLj02gdt0HRtm0QHmJkREYeDxiQ>
    <xmx:zEWsZ8y6VffcBHiAZMvEZNsvNcFZccVRAilv2Eq-q5RxDp3G1YVHHg>
    <xmx:zEWsZzSVp61Hd4Hv4zNOoukfTc36UKdf69WP_ZovMFngikNyV4DEZg>
    <xmx:zEWsZ3bbPaWbsC8kxvmjxEPz_x3XcG5--tH23KnFwo_f3H8rsUPBXg>
    <xmx:zkWsZ3KHhotJDpG9j-OOWPYElTXm-Qj6unZyqYe1db0466EDl8xDRZnQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A02E1C20066; Wed, 12 Feb 2025 01:55:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 07:54:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>, bhelgaas@google.com,
 "Borislav Petkov" <bp@alien8.de>,
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
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Message-Id: <1b14e3de-4d3e-420c-819c-31ffb2d448bd@app.fastmail.com>
In-Reply-To: <20250212014321.1108840-2-romank@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
Subject: Re: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect hypervisor
 presence
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2025, at 02:43, Roman Kisel wrote:
> +static bool hyperv_detect_via_smccc(void)
> +{
> +	struct arm_smccc_res res = {};
> +
> +	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
> +		return false;
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return false;
> +
> +	return res.a0 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
> +		res.a1 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
> +		res.a2 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
> +		res.a3 == ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
> +}

I had to double-check that this function is safe to call on
other hypervisors, at least when they follow the smccc spec.

Seeing that we have the same helper function checking for
ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_* and there was another
patch set adding a copy for gunyah, I wonder if we can
put this into a drivers/firmware/smccc/smccc.c directly
the same way we handle soc_id, and make it return a uuid_t,
or perhaps take a constant uuid_t to compare against.

      Arnd

