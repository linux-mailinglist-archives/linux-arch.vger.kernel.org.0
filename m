Return-Path: <linux-arch+bounces-5656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC8593DE14
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 11:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706C21C215D8
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7944C94;
	Sat, 27 Jul 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vwsb80mB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8tE1NCs"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132791FB5;
	Sat, 27 Jul 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071916; cv=none; b=TmfskuesA03YmWOOXkwr2hx3kfByu3UT8LjBnoajeeLKMJbEqNTCastim2+tv78yb+WECNgbwthyvCaBgsyKmQi6PAvqKvgep0eAQC4fxgeTtNDHbEQpj0GJDtsrWo3LLPxvEPROxkNw2m2aAYrmWQDsXiJYW4vQAK1qte7E0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071916; c=relaxed/simple;
	bh=y2dG+G0nnRLQZWcd6zOfH8rBi1ZBAKyqiICQAdFOaVY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dUXY4Eo67CgdZiXjyilJuR7dt/W+gSBUSCfHnHtxhdx7OXwo9u4MCThBiwNJ9eW/NJ9Uvzje+MJxFoMYvXQQKHROrATAIyix0Gs4o69IstdQvtDzXJz2kUgUNITSpfYFeg40HUTxmFk3oSihM6OcGhabSQXiH7bcWDGtAm14irE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vwsb80mB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8tE1NCs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 54C921140232;
	Sat, 27 Jul 2024 05:18:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Sat, 27 Jul 2024 05:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722071912; x=1722158312; bh=MUJNkf4ZOs
	N6MRFqntaQ9YXhMts4wValu3FLtPMdRvo=; b=Vwsb80mBda9YHwY5nkdmj4m/px
	NfE6cpBO/MWFOUttswOS+4b/rEwjUENj1Fpffe86h+j1kAr8gSWj+DQ2Juv4lyLN
	1lE1Vt7zN/TveuOg/eMo4k3jdgNpMyet3tpxgzBNOXKB+5TrW6GbY3YZpdfecIOd
	s7pYJ3WEXibQ9wfu5Wa0h9Q0MfYiQQE2HXgp+mZrKAvtlYMnKTSiAf6orxq/B2u4
	Oqu0hHDobgxFWBgOla5j88ypehBoXWdcCDVkGwpuoRAoylmIHBLbPuM+osmFjGOz
	tVeVrtUaeU1FEOPBGbio5zLxhYNPQpy4PEBKTh1esG1hraZsSquWbkG8/iUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722071912; x=1722158312; bh=MUJNkf4ZOsN6MRFqntaQ9YXhMts4
	wValu3FLtPMdRvo=; b=J8tE1NCsGmx3Wo/Ucu1lxNOo/YpqhlH/rV5IanvORhi1
	Wz1Yo3dIo3YBD7MLhUWMIlqZ20fZC3LQZXB01X8pTz9E4Wbu24DysE7nScueCfZc
	wJLlebdu0+eVTtEiXw8Huk9ufrCbYweg2kRjqtDxr9yQZ6TB3qFeL2SaCLLTg3/1
	KL4NbQeTKsGw4oIssHYL6RV0hY4yJHgXT3xKbgnFwS5f2yQ562HBV/CmI8I7tqKc
	g9nJ33sDtu/elzfSXI5vLketfjw0ET2ztJTJnq8wU4tjzRKB177K6fJRwkQw4CGC
	RYbsy/9cP53juoo0eWJMC/lNUu/m2M3EyMFuCHxIsg==
X-ME-Sender: <xms:Z7ukZpQyASgwQDgFbqYKyo32eWAX1x2URFmy-ax_TmuEr1m2Cl1rBA>
    <xme:Z7ukZiydWVyp5UtdcPc1dSJ_seTzBBIO0iZvfkaVLRavdQ1kqOHPJ14d_mY4Ec6-w
    QJ3aLYOsoljgJss7Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Z7ukZu3LTdkNYWSlX1jwmefzaFBO8_E94v1l_VTe3LpauB3BICNjMw>
    <xmx:Z7ukZhAutjRNcAkI2QE9v-ZYNOPTF-HjcbRkKQLrjHxpreiaSgD4uQ>
    <xmx:Z7ukZijB97ER1JfXRebe6PXPgsNXxLldQ36n6_9ELpRYVArv2DWsLw>
    <xmx:Z7ukZlrKzZ8Xz3fDdSdM57B9h7RFFezqBC8ExvYFOQH8ULEBSJQBcg>
    <xmx:aLukZnuoP4QO8AgBabCDQZ7idE7Up5DtofrPv2AMS5TeL91lrbXowEuY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EA031B6008D; Sat, 27 Jul 2024 05:18:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
In-Reply-To: <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
Date: Sat, 27 Jul 2024 11:17:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Roman Kisel" <romank@linux.microsoft.com>, bhelgaas@google.com,
 "Borislav Petkov" <bp@alien8.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Dexuan Cui" <decui@microsoft.com>, "Haiyang Zhang" <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, "Len Brown" <lenb@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Wei Liu" <wei.liu@kernel.org>, "Will Deacon" <will@kernel.org>,
 linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Content-Type: text/plain

On Sat, Jul 27, 2024, at 10:56, Krzysztof Kozlowski wrote:
> On 27/07/2024 00:59, Roman Kisel wrote:
>> @@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_device *pdev)
>>  		cur_res = &res->sibling;
>>  	}
>>  
>> +	/*
>> +	 * Hyper-V always assumes DMA cache coherency, and the DMA subsystem
>> +	 * might default to 'not coherent' on some architectures.
>> +	 * Avoid high-cost cache coherency maintenance done by the CPU.
>> +	 */
>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>> +
>> +	if (!of_property_read_bool(np, "dma-coherent"))
>> +		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coherent' node supplied\n");
>
> Why do you need this property at all, if it is allways dma-coherent? Are
> you supporting dma-noncoherent somewhere?

It's just a sanity check that the DT is well-formed.

Since the dma-coherent property is interpreted by common code, it's
not up to hv to change the default for the platform. I'm not sure
if the presence of CONFIG_ARCH_HAS_SYNC_DMA_* options is the correct
check to determine that an architecture defaults to noncoherent
though, as the function may be needed to do something else.

The global "dma_default_coherent' may be a better thing to check
for. This is e.g. set on powerpc64, riscv and on specific mips
platforms, but it's never set on arm64 as far as I can tell.

     Arnd

