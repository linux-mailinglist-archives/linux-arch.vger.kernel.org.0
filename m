Return-Path: <linux-arch+bounces-6144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5420694D7CA
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 22:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE2FB212DA
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8B49643;
	Fri,  9 Aug 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hDWdtJuv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMEjCWQ1"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34321D551;
	Fri,  9 Aug 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233691; cv=none; b=DblB2cyPwSp28gEeuj8PRVIL140A6I8I2twUhFVrmM5IovrxjaRz+MioXNSdCce4VdoOvY1nAMDsgPYJqnsS1oP7pkHmBei97MIbTDRgaWroTQGcfl2PH4Qnq2CQnCPpa0wUoGnq2jKU3DlQxsLDqCokIgL5SvTfJoB5QkyOjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233691; c=relaxed/simple;
	bh=rt8n2BzdzW4NEsbf9W924RPJfQlH12dEuOTh47WtQ7I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oOEZPvDZhMuFUFppD0Mss/BVbB/PbbjmTaux3ge6v7LCSR46lOJyoueo9ITeHS4/4UtjfUGRChvYCCDX1BQTl1tQf7I5/RK+GvHfwVwORp2uBii78mIxt0vrXhyFULmwnvyMaugE47rR8w0r82vK+bSdMIOQKqGwzdLHvGIJW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hDWdtJuv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMEjCWQ1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D159F1151644;
	Fri,  9 Aug 2024 16:01:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 16:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723233688;
	 x=1723320088; bh=qWV5qB3M+Ov5ylhWgimjzrAUVghDwxMLEMd9su0pyq4=; b=
	hDWdtJuvHFJPR5hIVYM3Jh6MCdcit23Bi/FxWj0tapZTlHFvNg+On1899zWAt7JD
	KRUq1s3iSt46dgr8WKLQoSl/ArLlFQ1A37207DGQB+Zt9EdWDny9U+pgWiXXw91D
	WzbRTjv6e2OLInqwN/OofzyqWhWDMndHrbUzcGKTI095DjsN4eaA8n9rUXAkMT0n
	Vx9wl1J8dMqz/6x7rd3hYAdam+Yz7mb8weOVZfnXmhWTuHSI8HUve+yCwTds36cc
	cvRYOHwD+2AnJtE2ALl8C4rtdRSSATfNzyTs/mCppTAkdYyXGSNl0X9LYLRmRyMT
	vRuDgzs6UmAJ1NtBeX8Q/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723233688; x=
	1723320088; bh=qWV5qB3M+Ov5ylhWgimjzrAUVghDwxMLEMd9su0pyq4=; b=i
	MEjCWQ1wpXrCKzL1uR1Hi4NtZYEjRSfZZ0Gah0yAuTqER/QLM4jI3OImyli6Z1yr
	EXy6LSndQqrURcYG7k/kP2DNMBFStIf8gjPk/qgcgTjLoGaNbpvV8UJb26Kz6LQK
	fKL6lA7qhKCAtCO7YFGV6S1kMELcSwj0num7cE5dfhUrT2BTBj0sm2PQ7C1EjJjC
	jNfGsIEl3OiyMaA3VB+8vCy9yVb0Jdc/DLmM0z32RigCU8LMw60ytIYsnpUWhUNI
	6vpCd+skGLiHSI2zEJekrDRid0iJ06WgGH6iOsQ/yUmAIfTnTaadB+YgEclK7LBv
	uNNCIoqXKNZizUxXrFX/w==
X-ME-Sender: <xms:mHW2ZrkZsUJuJqKEWAr5euKj1cvE4DndZnwg38j2y5pw25tgfLJF1Q>
    <xme:mHW2Zu1FBu_-BmvW9nA2PWv8ghC1jtOJH63ngoKv7W3RekKQiv-UiwwbnzZl8OTAI
    6n_QQZzscbbZqSP_bE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrd
    hfrhgrnhhkvghnrdguvgdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mHW2ZhoMW1wnmgZrLHG1Ch8lxSvQECiMo7ybzsXKWPmvdeG5jm7yvw>
    <xmx:mHW2Zjnvfhi9BZorstLg-9KUCRzMCF-9lypTH3j2kdfFCBO95WyHwg>
    <xmx:mHW2Zp3VyKvBrjY1fk5teSNm_M6jN5Ia1cyzxMALVsc4YLLOkCG3hw>
    <xmx:mHW2ZiueECjVE0fbhVCqB9LXSu-QsAWUU_C_64Xz-8gVACqoFUXiBw>
    <xmx:mHW2ZjpfbARIPFKOg4mqDXIqgo5ivZeHxG4VQgAHg5JjJYx8rSwt1Z0a>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9544FB6008D; Fri,  9 Aug 2024 16:01:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 22:01:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-Id: <bd8bbd60-be0c-4add-8c61-5e569af9eaf3@app.fastmail.com>
In-Reply-To: <f61081e8-6e48-4161-afa5-ec3a7a58ecd6@app.fastmail.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
 <20240809-mips-numa-v1-1-568751803bf8@flygoat.com>
 <70f908d0-7cca-40c3-9aaa-c838b02dc4c4@app.fastmail.com>
 <f61081e8-6e48-4161-afa5-ec3a7a58ecd6@app.fastmail.com>
Subject: Re: [PATCH 1/7] arch_numa: Provide platform numa init hook
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024, at 21:56, Jiaxun Yang wrote:
> =E5=9C=A82024=E5=B9=B48=E6=9C=889=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=
=E5=8D=888:41=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
>> On Fri, Aug 9, 2024, at 21:25, Jiaxun Yang wrote:
>>> For some pre-devicetree systems, NUMA information may come from
>>> platform specific way.
>>>
>>> Provide platform numa init hook to allow platform code kick in
>>> as last resort method to supply NUMA configuration.
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>
>> Can you do this with a Kconfig symbol in the header instead
>> of a __weak symbol?
>
> Sure, is this some kind of subsystem policy or general recommendation
> applies to the whole tree?

I don't think it's a general policy, possibly it's just me, but I've
had to debug too many issues that could have been avoided by not
__weak symbols, so I try to not have them in code I'm responsible
for like the asm-generic headers.

The main places that use __weak symbols are arch/mips and
drivers/pci, but there are also a number of them in mm/
and kernel/.

     Arnd

