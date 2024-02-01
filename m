Return-Path: <linux-arch+bounces-1959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707C8450F6
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 06:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB07291A1B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 05:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3C779DA7;
	Thu,  1 Feb 2024 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ofcCD7y9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0Z9bQxZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3A7869A;
	Thu,  1 Feb 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766481; cv=none; b=jKdMwCw8TPgQauJnswjuOd4tjtHNu4x2bZyPvZ4es4JWMO8VhPkiL5iLVI0qDSdgg3wC3gKYAjuW/4qttkL+SzcOWj+I+gIKqey9MViS1DxVHAjfln5v5WyYeG2Kcs8uGS2Bb+dAJj/8WsRA/8R5g79Nbj2IPm+gqN3ACd6zlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766481; c=relaxed/simple;
	bh=zzu8lVaM5bUvdOhbpWfG5cOKtg+i8Vg7Hw3qhA1wYXA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dNEwS4B/GOJocOqTxVFzpdZjxBKCOG6sbuYLDWL5LOMLZAM6uy955qvdZOueXEIWEboxsnPT+HgP9lfGgRG0U8ksjtRlwxJEayzb+yo8/kfp6jdcbgY9CAF6nGBsOhyGJJSAQh2T2Rl1PWw0DFqdV9wGZnXgUca1sMKaM++yY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ofcCD7y9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0Z9bQxZ; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 939405C0116;
	Thu,  1 Feb 2024 00:47:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 00:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706766477; x=1706852877; bh=CpotEzYlW1
	lmLAWEU8O++zTNrosbiHDCaZ3gtXPQArY=; b=ofcCD7y9E1SMralIsej2I7/ElJ
	9qB8+JKSqlt90zsZ/VlQ3e5rD5eDVW480dmsAHaZrWS+9oeOSBukpkuidcFz50cX
	pziLdZ++lgCnSYWOQiKXh0xrj24+a1qV+7IDPOzW3uIrj+Z4YFyIO5dWCqYUV0ep
	+907Vk4+CqAUs2hHjK3Yw92MC7Q7faQW5iQGZOcDoqFOKDT04o8uJ4D3D62WvKSp
	IYZp9Sk9Bwwqnn+8BDy4cLQJTHYK72iIkpNL5rISuQWxOOVChliraSIinPhLrsdg
	jUgSXieg442R2TEKu+xmHkeitn2zS295YQSH/k6u6PtqCT5p+e1IBu9QuZZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706766477; x=1706852877; bh=CpotEzYlW1lmLAWEU8O++zTNrosb
	iHDCaZ3gtXPQArY=; b=a0Z9bQxZwmNq7T6m+Y6Wq792Zn9K8cPWGchlPBhgRreL
	LmetZ9OStKFS2X9fTpZJ2wP+KCHJCt2BulvVml7m9chmQoeUQwwCx9ziGGBzGS4l
	85fBu0jgo3KPiWtvPVf4LtsvaBGdjaA123jpTHX/oxaH9H2I1gO0VUho/vQ6NcDe
	2KVNfrhgzeJLeogzkXvD9IuM/vMSlwATLnNX8hJHwMkZIzkHP1tAZ4fM7lsTzrgK
	LZdMx8HPgnhIX0fgThAnXDvUN+zIF3IwNn/kDMbB0sQXdys8jzFA28W2mPFQ3fiN
	ItWKQpXIKSrCpdlimiT9WeL2h/T8J8Hcp06gydO+rA==
X-ME-Sender: <xms:jDC7Zbi54YRFUiT4scy9KKjdOMnQOULALkFBp-NF3AsmPPZj8deDsQ>
    <xme:jDC7ZYB_jW4sHqYVgHfzuEWoNYw-m20YQo6DWnJQafiiyLG27sP1YkR7R6mWa9tfm
    g4xjJBpQnRcVAoTxto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jDC7ZbGhLLSlK4aZrPll8xb92W8ZEWoxOG_Mi2E7YOqJund-InOb_A>
    <xmx:jDC7ZYRKVaLr8jcMeCqc6AdwF5-OAriSVV7HgiZvbaZDi4gUxwl7Kg>
    <xmx:jDC7ZYwWNyVr3dX1ypRiaZWJtbupayrMovQpob_KeW9lctEv9JR3xw>
    <xmx:jTC7ZUcUIkO5lEJJeU-Z3BQGn9j5fA_P7AQALJvTx0MrvWsoJiq1HA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6975DB6008D; Thu,  1 Feb 2024 00:47:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
In-Reply-To: <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
 <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
Date: Thu, 01 Feb 2024 06:46:46 +0100
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

On Thu, Feb 1, 2024, at 01:01, Yan Zhao wrote:
> On Wed, Jan 31, 2024 at 12:48:38PM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 31, 2024, at 06:51, Yan Zhao wrote:
>> 
>> How exactly did you notice the function being wrong,
>> did you try to add a user somewhere, or just read through
>> the code?
> I came across them when I was debugging an unexpected kernel page fault
> on x86, and I was not sure whether page_to_virt() was compiled in
> asm-generic/page.h or linux/mm.h.
> Though finally, it turned out that the one in linux/mm.h was used, which
> yielded the right result and the unexpected kernel page fault in my case
> was not related to page_to_virt(), it did lead me to noticing that the
> pfn_to_virt() in asm-generic/page.h and other 3 archs did not look right.
>
> Yes, unlike virt_to_pfn() which still has a caller in openrisc (among
> csky, Hexagon, openrisc), pfn_to_virt() now does not have a caller in
> the 3 archs. Though both virt_to_pfn() and pfn_to_virt() are referenced
> in asm-generic/page.h, I also not sure if we need to remove the
> asm-generic/page.h which may serve as a template to future archs ?
>
> So, either way looks good to me :)

I think it's fair to assume we won't need asm-generic/page.h any
more, as we likely won't be adding new NOMMU architectures.
I can have a look myself at removing any such unused headers in
include/asm-generic/, it's probably not the only one.

Can you just send a patch to remove the unused pfn_to_virt()
functions?

     Arnd

