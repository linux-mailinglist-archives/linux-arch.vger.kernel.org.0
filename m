Return-Path: <linux-arch+bounces-13748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75262B993A4
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A9516A1E3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6112D0C83;
	Wed, 24 Sep 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lyZd5i9f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQAb8pZT"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483115624D;
	Wed, 24 Sep 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707202; cv=none; b=mctRv7xIZauVHH4vzWmOfs6zUBVOwiUoGwPzW7GcsHdTncCrCs928gCWP0DC9iaF4lqdTB79joWTXMyNJ8UU0qoFMwp/zvKmSxSi2ueVtzDUbYZbQIEEyro4EnIBQf05qudH4PRwsmJJSTuzYQWw13Fmt7zEMRqqXqNkraLcKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707202; c=relaxed/simple;
	bh=fSxRVyo/pMPa/I79auD8RfJ4O+5vdqWiZEHAy0nNK+g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KL99gquil1IN7Oo6H/rkAzboOpR8iohRhtBCmuyDtfBLwsV11Ca2M5AgoBcYBhgNLJ5r0EUudZLZMdenSqkXS/aJU7fIwUBrf4j0aznvxqC5kbE5EfLDq6XVuPwoYlgvNv+PFPtgQv/g9cxQrRB855od9Q4ljfZ4/zf5q/uhU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lyZd5i9f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQAb8pZT; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B66117A00BA;
	Wed, 24 Sep 2025 05:46:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758707194;
	 x=1758793594; bh=b5TdmWqkw452UM8Bf7B/LPrFNL90ftzUSgyeyf0uzK8=; b=
	lyZd5i9fFDWc+xDlnLhBaj+EGZd9z46Hv525Z/SqjHJqGSBuInsQoWPUv0SR7glC
	znelC8ukVetRmLY3oEMWhJsgUV52hJ1AFUujnMgnEDAq3mj/CtJM9TfC+XKbbqrG
	hW1wysag9cW7EMW57VyiZFo5mX8elHmWEorDcdurE0rC4ddbdeEaZPex18yfAOkX
	2ESDvxjAK52mgXWFby36+rwFIIZuTa1KMKEmS1UeUv4KEULItxOp0Ius6s0WU5vZ
	KqnQ3xynKucursBttt/OfzRxI7Z7R+0o1uAr82gj+xY7trObelrqDePr7cr9ZJrJ
	MpNatNe2PqCYISY7Z4dMxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758707194; x=
	1758793594; bh=b5TdmWqkw452UM8Bf7B/LPrFNL90ftzUSgyeyf0uzK8=; b=l
	QAb8pZTsHT3rya9324iqo8mzqa7FTbLfDG8w64xDdaO1lgsio85bqLobjR4vYOmw
	Fa14u/wmHEQbjff+9A4LPkzRiksdhXxCFGqNCQhh0BHSyya1T4NIhcskzwwZ7X3K
	uSZUQGqD8r+meAwD1vlcy0pi+2khVDJpeI22bTd5raqGMbT32q8Z0sICA9cDXUFG
	giOgc+wISeMS7/zEeB6frxYfl1v6k4pV3QNLydX6n3NP40QJPDh5gA1qbPS1oCt8
	nuA9S4z9EaU0bgJZxELNWDGapJFrOIJaIpa3tM4FFFMLkE4m2XU4fkz9jv4SQaA5
	dg9NWeIWTxSzUR6QkuXIg==
X-ME-Sender: <xms:-L3TaBepn2HTAlRpPZmOHSO77GLGL5rczhv9X5qn7TlhMNNlzDfNAQ>
    <xme:-L3TaKB8qLGRwh2vyBxKfhTssLgrVcIVIkEiWO3WEG6hFxriQAFikgDd7zzgv31cK
    A_CPYMjCBj9D2nsnrpvEJLPjj2lCVv-ar0N2x7yX_gpQC60ILICEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtg
    hpthhtohepghhithesrghmugdrtghomhdprhgtphhtthhopehmrghnihhkrghnthgrrdhg
    uhhnthhuphgrlhhlihesrghmugdrtghomhdprhgtphhtthhopehmihgthhgrlhdrshhimh
    gvkhesrghmugdrtghomhdprhgtphhtthhopehrrgguhhgvhidrshhhhigrmhdrphgrnhgu
    vgihsegrmhgurdgtohhmpdhrtghpthhtohepshhhuhgshhhrrghjhihothhirdgurghtth
    grsegrmhgurdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhgohhuugesrghmugdr
    tghomhdprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghssegrnhgrlhhoghdrtghomh
    dprhgtphhtthhopegsihhllhihpghtshgrihesrghsphgvvgguthgvtghhrdgtohhm
X-ME-Proxy: <xmx:-b3TaJ8SqsgUOmUtPUFxa5H9tWeJiha7CiHyyIxaP06HQit2lkLpbA>
    <xmx:-b3TaAUHrt02ToCkiwb391fIMHMFJfso9alneh1NaCvW-f0cw-cfcw>
    <xmx:-b3TaGgpHeZ8MSiv3XbvzNZQ2QA3N-VApOQKK83jhFyXmI2FMrnONg>
    <xmx:-b3TaOwEBDnii0YQLK_YXJYub5k6EmTd0YJT_zjzUzLRL8YC-OKveA>
    <xmx:-r3TaMZkWptKM_wMyITCMLa0QwFiQkzYYISSUYnZW2uBDwv-qFQwCblv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8395700065; Wed, 24 Sep 2025 05:46:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5BcZzk33eMV
Date: Wed, 24 Sep 2025 11:46:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>,
 "git (AMD-Xilinx)" <git@amd.com>, "Michal Simek" <michal.simek@amd.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Rob Herring" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
 "quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Jarkko Nikula" <jarkko.nikula@linux.intel.com>,
 "Jorge Marques" <jorge.marques@analog.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "Goud, Srinivas" <srinivas.goud@amd.com>,
 "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
 "manion05gk@gmail.com" <manion05gk@gmail.com>
Message-Id: <77978246-11c0-4cea-8a22-26536a78eef1@app.fastmail.com>
In-Reply-To: 
 <DM4PR12MB610982CB7D66D9DEF758188E8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
 <cde37e36-4763-48ca-a038-4a19eb1ef914@app.fastmail.com>
 <DM4PR12MB610982CB7D66D9DEF758188E8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
Subject: Re: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 24, 2025, at 10:59, Guntupalli, Manikanta wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Sent: Wednesday, September 24, 2025 12:08 AM
>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; git (AMD-Xilinx)
>
> From both description and implementation, {read,write}{b,w,l,q}() 
> access little-endian memory and return the result in native endianness:
...
> This works on little-endian CPUs, but on big-endian CPUs the 
> {read,write}{b,w,l,q}() helpers already return data in big-endian 
> format.

> The extra byte swap in io{read,write}*be() therefore corrupts 
> the data, producing little-endian values when big-endian is expected.

> The newly introduced {read,write}{w,l,q}_be() helpers directly access 
> big-endian IO memory and return results in native endianness, avoiding 
> this mismatch.

No, in both your {read,write}{w,l,q}_be() and the existing io{read,write}*be()
helpers, big-endian platforms end up with an even number of swaps
(0 or 2), while little-endian platforms have exactly one swap.

The only exception is your {read,write}s{w,l,q}_be() string
helpers that are wrong because they have an extra swap and
are broken on FIFO registers in little-endian kernels.

     Arnd

