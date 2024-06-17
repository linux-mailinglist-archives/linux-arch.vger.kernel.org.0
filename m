Return-Path: <linux-arch+bounces-4938-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 196BF90A5FF
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21311F239D1
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40AB18413E;
	Mon, 17 Jun 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z0GKrHEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mE9L4mGc"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462179D3;
	Mon, 17 Jun 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606185; cv=none; b=Qja91+46j8NDekBbf9AmWUnrc60ddWf8ovzaSqkV+QzO0SAUBw00dMu3q8qUuyJdhTBeIxKCv4U3q3R/3XRgIzxs7UT09AkY8KGz1V6XESUyMYjfqE+GAUDa+gK3V/FtCcnyPPPPU+nFySHZJIdxtk4wfUa9EmWY9XyDG9wsTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606185; c=relaxed/simple;
	bh=LesqrcRAV/4/c3Sfk1y7gMK+fZWVSQ8qF9tdeEoHRLs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RB8GTFawpa2gwfP8EapdrGBM+a9ixsECTq7nX9P8LlRqze5FySRunQnA0z7OIynGHXUYxHdVWVk+4Lky4QcTM//Bt1RC6Uhwr4CNsmJ294jV5f/+tJ0WfIRDws9a8RvfB07iPKLndD/2YFkyB+onPMZzrl5KqUdwsV0Jm0a6phE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z0GKrHEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mE9L4mGc; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 590DA18000B3;
	Mon, 17 Jun 2024 02:36:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 02:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718606181; x=1718692581; bh=8+FywWapc3
	z4ZbGE7d/673rjs096swl6YfrxaP7mzMc=; b=Z0GKrHELQJBzl93uTlwRbxQur9
	tNZlaKmhS0oBHMNg5jNdGgkV2cZLgu1Dgut6ziKvcuOmdkfNn9VImM9ml55MneDV
	eEBCZT8sOR49O8yg9GLhbnAwi0qoupl+u2dVHqE+D75wxoDlr+YHf6iEK4WgO/1q
	spnT98TYmukMlJ2wxD1oBqOHDp+SNIkpPWwhXSWqrryEPXQ4Lw7oU9R3sCqcpChC
	o9pGjMtExv5+rSbF6/HuKIlf5xinaESFjgKcnO8p2cWqLdOskPCErNFDDeA1wcJq
	OXYoDV7K9jcike1nFyDUvcrWM6sLEJ7T5pEYaBxNFt8uVid7fH9gMDT0/Yrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718606181; x=1718692581; bh=8+FywWapc3z4ZbGE7d/673rjs096
	swl6YfrxaP7mzMc=; b=mE9L4mGcDVEUg3ZRcSiw+7y7pLyme0TuzkiISoulnI65
	/JDTzc2O9//N84f1ttuPM83wJH/FyHu2fLeopMc/ginbY+BjvqqjOtFeR4u5Km9c
	v7S2gO3Rno64hJl/XAQUEw+Gq2REdGrEDWdB9yALo983On4v4wZ5Pkbfz2MujksZ
	ScxKuZONcsGrRuS8AbOVHvpHSPhFU66/lOPSDBpjY1paZmA0ULc3gQX0xMPk369O
	HybcO2G9hPaw6WkRw5waunLYbQtNCTSsya0SmECdMaXS6uHguQmDdq1DVthU5Cmi
	0xv8zZUAYovgckvG76HMH3WEB7WQg6YqiwHMrdc5EA==
X-ME-Sender: <xms:ZNlvZtl71_jzBOLRI3DtvJ6ehUCA7cc43psm14Dw7qjid20ICBSGxA>
    <xme:ZNlvZo3NBi_RlSNEfSCfStikyH6DgaSYuM4EIScPynUXqSGk3kQQgVn6B-DD2Dy1W
    pQQyijutlYkCYIf_p8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleffueeiiedufeffteetleeuueefveefgfffteegvdekfeetkedtudffhefh
    hfeunecuffhomhgrihhnpehsvggrrhgthhhfohigrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZNlvZjqL7t1Lp4CVZ2Ud_3K_smNSEQVh6qlv-luThoaGRqVJzAnEWQ>
    <xmx:ZNlvZtnPArqX_0Q10eJYe3WxAccV4vB02diFiB1C2ZwUrPUEaJQnjA>
    <xmx:ZNlvZr05P8D5-AUhcnSeUmGUrQ0IMvmqiyHwsSHqmpk7GonaHbvSAA>
    <xmx:ZNlvZsv_7UmebJapBehxilcaPS2i-wwGRR-pWuhxjBWl4Dtqogfdiw>
    <xmx:ZdlvZkub_-d2jnVgKc3l9Jqir5uFZNjez8sYaZVepsC9qV_6PKQdUiU2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 207AAB6008D; Mon, 17 Jun 2024 02:36:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4fd0531d-e8f8-4a4c-9136-50fcc31ba5f2@app.fastmail.com>
In-Reply-To: <a70e8b062fc422e351fe2369b9979a623fa05dfa.camel@xry111.site>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
 <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
 <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com>
 <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
 <a70e8b062fc422e351fe2369b9979a623fa05dfa.camel@xry111.site>
Date: Mon, 17 Jun 2024 08:35:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Xi Ruoyao" <xry111@xry111.site>, "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Content-Type: text/plain

On Sat, Jun 15, 2024, at 15:12, Xi Ruoyao wrote:
> On Sat, 2024-06-15 at 20:12 +0800, Xi Ruoyao wrote:
>> 
>> [Firefox]:https://searchfox.org/mozilla-central/source/security/sandbox/linux/SandboxFilter.cpp#364
>
> Just spent some brain cycles to make a quick hack adding a new statx
> flag.  Patch attached.
>

Thanks for the prototype. I agree that this is not a good API
but that it would address the issue and I am fine with merging
something like this if you can convince the VFS maintainers.

      Arnd

