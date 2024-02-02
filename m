Return-Path: <linux-arch+bounces-1988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B88468FE
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 08:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1730D295CA0
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0517758;
	Fri,  2 Feb 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Qy6Htbzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qOtBOZIp"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9E1774A;
	Fri,  2 Feb 2024 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857499; cv=none; b=kF/G0OM5mjeQcqVbyHhwh3I3mt8u71jpkRrAr0SAGa+PIl0JvaszkLl1YMQ635sg8Kp44/WjsfxaZBMzFyk/wgIXpwR1Zf/jSY22RXPvU2hUIp4taQIz9EQNC6cR1eKe0DM3FdoOGBM6kDX6zUqZr5HgaLS9l8Svygcdt2Maqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857499; c=relaxed/simple;
	bh=B42XzyrQHcl1SjCEGkJPm45lI8Bl00Hv4yoLYPmcQxA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FutDYupeY/6meDKv4BdF7l3/gc384aRUPElBmWsOVE5Wgy9yyIWwZ+Uy9xyxvf+o1oHQjzDA6aQas+fZ3jA6Sk7QPGklcutt+y6onNTDkOZ8jJbS7JFawev721KeMdifTDsl6OJFeatcB3iiiQegm9IRJtIk4pC/GfQM4Xjb2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Qy6Htbzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qOtBOZIp; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8F70D5C0100;
	Fri,  2 Feb 2024 02:04:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 02:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706857496; x=1706943896; bh=lu0P7MbFFF
	t26li7WbAVE5d4QrcTX4IgFehhwG1hhXo=; b=Qy6HtbzcWStGTi/SQa6zvMIdeX
	ia6/J2AyWEBTyipgZODWpCfjcEEXTaNc8ZK0VA9+9aKcGHDABrOwpuNefkrmdGFt
	fP0R5dMEtF9nzlp5ORdHw1uVs7rsfNTIuyN869oj6tJUBdT12C5E0zByB3TsBujX
	BBQZ+nzi+2nCUpxkkyEc+F2IyL51Il/X6/GlhbIq/rZv454FNxnYwQcRnrxxP95d
	gDj6oeEuuoL1GCANx0GKW4687yo03ijMd2wnT3Nldr24fmpV0xchq128834QEHY6
	hab7Yschu2B+uzt/7lvRcvvL9q2FHgZm9lJRK9Rt1CGiG3LpNxbIwnqIZwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706857496; x=1706943896; bh=lu0P7MbFFFt26li7WbAVE5d4QrcT
	X4IgFehhwG1hhXo=; b=qOtBOZIpCnOYr+DDduWsKs/lW+/wYKZdQx4lVtgjoztS
	6DLwG4QqJuUcdShbOH9fzDFVt0T1np0TGujKpRKeOSjxelmLIHcTObrQD/TR+Ht7
	zITykQJlPNPGdF12QdqD/cMD7iXYF1sKkXTZFqpGxNZs+G5MStD7MwVCbPtXIlEf
	meNchvyTXC1PL4dW8n/TSx8yqO40hrFQ2sF/FUF45w+WwIZGqr9d7uAcB+4WNbZK
	XZZAxpLukhUe3P16SO4wJ+fvZtS4ksPdKxQw2yEM9btzdUM8vyDSmdZdMABHuOvw
	HS1EjSUzK1AnACYxHGbf2A13Ktc784S09K3GrPMRog==
X-ME-Sender: <xms:F5S8ZbLHrMMvPP5c-kEilMyM2eZbQVuS4z7VeYHSvAGoVjBFWCfpIQ>
    <xme:F5S8ZfIOCUg8y9HrqPXCMMzbPE-R0QGZU65bfBej_S7vLWfnt7rEyngAmFrRtGBJU
    si7Wg-Zjrqzmfec-TM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:F5S8ZTshwWmz1M3TOvpIFZMBysxhzSBjWQ7ej7-4itayCLy3DdZYKw>
    <xmx:F5S8ZUaUXZwZJCz89NdX27opI1oLC7SmxoWgZk2gZ6hpfdTrzTEq9A>
    <xmx:F5S8ZSbK2kcccch9jRhK4FjVeP9hZEzzc34K-6QiPCeeqbLw7SYC6w>
    <xmx:GJS8ZYlSuPuhn0xAh_iYjX9OD1L5u-SE3dN9vaHE04dWaGGg_hncBA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E7616B6008D; Fri,  2 Feb 2024 02:04:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33a5d3a9-3154-4dad-afae-18b16e6cf61e@app.fastmail.com>
In-Reply-To: <Zbw/PpNkCQCbXPdP@yzhao56-desk.sh.intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
 <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
 <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
 <Zbw/PpNkCQCbXPdP@yzhao56-desk.sh.intel.com>
Date: Fri, 02 Feb 2024 08:04:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yan Zhao" <yan.y.zhao@intel.com>
Cc: "Linus Walleij" <linus.walleij@linaro.org>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
Content-Type: text/plain

On Fri, Feb 2, 2024, at 02:02, Yan Zhao wrote:
> On Thu, Feb 01, 2024 at 06:46:46AM +0100, Arnd Bergmann wrote:
>> 
>> I think it's fair to assume we won't need asm-generic/page.h any
>> more, as we likely won't be adding new NOMMU architectures.
>> I can have a look myself at removing any such unused headers in
>> include/asm-generic/, it's probably not the only one.
>> 
>> Can you just send a patch to remove the unused pfn_to_virt()
>> functions?
> Ok. I'll do it!
> BTW: do you think it's also good to keep this fixing series though we'll
> remove the unused function later?
> So if people want to revert the removal some day, they can get right one.
>
> Or maybe I'm just paranoid, and explanation about the fix in the commit
> message of patch for function removal is enough.
>
> What's your preference? :)

I would just remove it, there is no point in having both
pfn_to_kaddr() and pfn_to_virt() when they do the exact
same thing aside from this bug.

Just do a single patch for all architectures, no need to
have three or four identical ones when I'm going to merge
them all through the same tree anyway.

Just make sure you explain in the changelog what the bug was
and how you noticed it, in case anyone is ever tempted to
bring the function back.

    Arnd

