Return-Path: <linux-arch+bounces-4168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79248BAFC8
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149751C22071
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1034CE5;
	Fri,  3 May 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iCIMBune";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGYORuir"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF11514E5;
	Fri,  3 May 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750167; cv=none; b=LmZuMp+/ZDCzvL60q+wLJRNAUuHhlMv2bnrQVLfFQbmWx3ZzWaIyF7OcMWiDSllDokFpXrKGpB9hUbguy2ucDlAvyc+tVPHoLZwbf15lC1RiLnsU5IcqUPENhCn2Tx2QIv3l172gTwz5QHvYqTX5j3rN8y52EwgxQS3ATED3RVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750167; c=relaxed/simple;
	bh=PaJ11yyj1u29gk5++0CUbqbvDFcDQTeM1r/sMnrKg80=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SyOXzmpVQlrQzJ2GrCvm255C7nwD7Oa/2elDdCEfGdXFe55dNXkRL+FKnmbeoU2AsM8ENpnUL0vKOUoDUA8dX4gJGaRo0wRMM8fpu2rs6O3udQz0yw3Cx9bZr1PXpJ70eqYJbNROWT1dy2GgdxkoeeEitCLyNF82uVBK9iSMYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iCIMBune; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGYORuir; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7458013800CE;
	Fri,  3 May 2024 11:29:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 03 May 2024 11:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714750165; x=1714836565; bh=wY9DfsGGwL
	3WFFF4rDuowcVoD3Ri5Gt9+AThm6ztR9E=; b=iCIMBune9biZ7be+dtUP878Q93
	Sf0/XN8Sm61VPWCl1b9XK9If8cW2NiSS5w8EN0UdqYwtWGC3lSFvxF7sK3ZoUXid
	5GjXllhLlIQJlyGLKwpwZSQhLHi9iGX82dEGqYJebU3idupbr9mH/XwyWj0oduvF
	dUz5eEp9/javg0G5T9NUaSVglGyA9v8/mRLxLArru1L5igJOrYs2YUWreSrOwuHM
	CVWLY8ndAFhGtAYovQyFB2GnGehAOAhxahrl3fHIIa2ZihXc1GT1iqEhIpOlS0Yf
	/v2Y1GOUoLhcGagBCanDzlDDDoSP55O6gaC/niPzveq/W5uG+Jxfvm4WD7XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714750165; x=1714836565; bh=wY9DfsGGwL3WFFF4rDuowcVoD3Ri
	5Gt9+AThm6ztR9E=; b=YGYORuirzvgEP0dcRoZGmyspLXOo9wube2DJxbfTkMkp
	pSAyVvzV2X8BfeyP036rsP6YbbUa31Z9bl3rkPV8q5/WGPfRk9Cw9/MK8lAums1N
	05B9yIqHGJPstrbSw34nT/W/6Wu3BbSKGp7rS0bN7N6O3eK67ugjij3+HValFMvt
	7SHUIIM2VQOonhAY3JHTRnmmzeu0AP1HnKNyaf55JcNnxDETqCs0oO2LmInbVcdu
	ygz3WG6a8ImuZp8LsKjGOeaNW3edEe95Ak7x44udV75neIGR6ifS7xiaJfklKpGI
	XXLMYaKRieG8lu+pZgEWV+nvBhcqLqJ68z7i1RVGWQ==
X-ME-Sender: <xms:1AI1Zgt-RIf_MVtvc0LxunzLgTpoVcbbLYSEIa1hyWRYUFiD8CIQHQ>
    <xme:1AI1ZteogSVAZzkbj9oTdYREHhPVxjCqEGNlGGfJTwPaihNSEop06Q-q30wvqDJep
    4fCBjLFa0eHCvwjEY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1AI1ZrxleoU7IxogrTww9AbE64uBICl1mz4_eLBng6a7XhGVW_5e8Q>
    <xmx:1AI1ZjOlt-JjJyw4GOyKHNjqRF3I2A828aNCnba5Xgdx-mcNldY4iw>
    <xmx:1AI1Zg_t5Ed5yE51wnoAw7ipvQj1dt8MiH-w0kjpB-_Qpd81NgpqOw>
    <xmx:1AI1ZrUFL1bIWpD3lQZXqt7G_yN21Kblz2B54NWe1vNc13E_hoY1Sw>
    <xmx:1QI1Zhj1BGPg0_SHCyV2Ty4IxZgKxMv84vxZso-bp7v4cPVRi_L31pPt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 96CCDB6008D; Fri,  3 May 2024 11:29:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f8cfd1d-a478-4666-a181-040c8d92e8fd@app.fastmail.com>
In-Reply-To: <c281bb8e-0719-4b28-a637-56615ad16913@suse.de>
References: <20240329203450.7824-1-tzimmermann@suse.de>
 <c281bb8e-0719-4b28-a637-56615ad16913@suse.de>
Date: Fri, 03 May 2024 17:29:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Sam Ravnborg" <sam@ravnborg.org>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Helge Deller" <deller@gmx.de>, sui.jingfeng@linux.dev
Cc: Linux-Arch <linux-arch@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arch: Remove fbdev dependency from video helpers
Content-Type: text/plain

On Fri, Apr 5, 2024, at 11:04, Thomas Zimmermann wrote:
> Hi,
>
> if there are no further comments, can this series be merged through 
> asm-generic?

Sorry for the delay, I've merged these for asm-generic now.

      Arnd

