Return-Path: <linux-arch+bounces-14897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B91C6D607
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53BA7360899
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D392F1FC4;
	Wed, 19 Nov 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DXj6F8HF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Li07cv7o"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B72F361E;
	Wed, 19 Nov 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540017; cv=none; b=dgVhTGjro4MvRrnOQ0yW+VgwlqwKPHJBouWObHdHoVxNvH98zSwtUHU+bMmHvm3FWsBXSrE17dmhgys0o0gCT7cpz8ct+ZoRWT3+RVqMOi/l04PsgcEj9utKjCSLHhVGgb1cukjS6GVRH5IjqLEpJ1dbZU+IdC6BRerF3oE5hV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540017; c=relaxed/simple;
	bh=p7LfMfULrQLHXStk2y9g9SfDkwd+XXbsx7cs2P9dYAs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s78xQKfDvySM3+YH1booUdJKLxJEPNTJCNL63DWiIGx8giTt35RyH5d+3/bnDegtXkNA/dtSylrZe4Jh85G4iJtxVdmIuN4S3Tw+9Z7oqbOKH02Mh/MwsnFoZfGTRz8Q29BbR0cXnPtzDPl1PJCSZoimLoALghVsqPQNlIAZS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DXj6F8HF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Li07cv7o; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDD841400229;
	Wed, 19 Nov 2025 03:13:33 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 19 Nov 2025 03:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763540013;
	 x=1763626413; bh=iG6rGwLPRZRDIpYsHw7EFvfVicsalc1b8gYj00Il/us=; b=
	DXj6F8HFBzrvmGwGqMfC5ELbu1GWTGjI0ZRWXD1J7nX6S5lF25EViNxFcb+MG05C
	4J/1RR2BlB6lAoypfP3W1TTjgcc4hXM/+23JiLRWSpaYD4uXyI3GkYPHEQYUXKrj
	qJ8sWGcIxiOYrfRc3uO6l4crIbV69V8SFwB+vSDjqDWzGb8UCdSl+q62/2sI/xUD
	WlCi8tsWsbY6tEcuqfftl78g/GsW58kpDvdejt+KkmPv1SychyLQ0uXS/nmsCVJo
	4KJOgoycJ27hML9npUpmRxbIzsDoiAP2JhNR4djqoTYvPz2NCcfxwWBwQotIJth8
	YU65xm/hH/euUvxBWHn18Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763540013; x=
	1763626413; bh=iG6rGwLPRZRDIpYsHw7EFvfVicsalc1b8gYj00Il/us=; b=L
	i07cv7oJzv1iiO0GsJwQBzYntiyovUV15z/QFUCTilu40+3bQ3QxEVqqTUSykjmU
	vq3cJXzqBC8HmshuQLz0SqpDdtHyqgy6Uknm66085jlM7fV84TrPbWl1A0nNQBK4
	Jj0/TNLqop6hfvfKEcssT/WiMHhGIfppmKZOz5XGinPEU0GiOAdXSTrp5psXwDEk
	b3FcebSeoKZ5AMRfYZNJzjFYkpqHrzs0F3dhCIniiXlF30ujyoE9m1Bf9KEbIAQU
	+A2y2VqUtLWSRzpF3kn4DVBNYPzRpG2LGZ+9Fq0ukUSRxMgikVBiU7In8UJ4tN5h
	8usWdr4uYdAUY/b57rSNw==
X-ME-Sender: <xms:LXwdaTtShyVRc08Qu_Cd3vwbSk3xEd7mscseTRlsgdyg0eXtsvdG3Q>
    <xme:LXwdafTYcWLgevJrjbeIWv28GL2cEgu0HMErcHa2gDlT_8qQHaOYiT6BUU5FoUE90
    fevFZIAzRu2LiN3UGiqU0pjSRc0iYUipMwmgEaEh3no_dYO9NHGkY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtph
    htthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhu
    ohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhvghnhhhurggtrghisehlohho
    nhhgshhonhdrtghnpdhrtghpthhtoheplhhigihuvghfvghngheslhhoohhnghhsohhnrd
    gtnhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:LXwdaXtNkwaX_IZ8Fhm6xj0pQUp05gmR1mKO0vMcxOqb_l3F9YuDYQ>
    <xmx:LXwdaVBmhLNkOG4P4Oo1IOnoAGQY3cdyWpC_WnpYO0ttKWITyKqNCw>
    <xmx:LXwdafOosYgqibzW-eBMP_4SiSsycMbBCI5HYcsay54Gdpqv-LYLmQ>
    <xmx:LXwdadBC6Hv_OATj8TtiLorLKH3pYPOtA7fCBmvJZQ9PTNINTZE0Dg>
    <xmx:LXwdaVOLkKdFK6tnnI6_mUdO4SSpRp50IwIzEm9mMS8pX14KHE0RGjWi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 72AAF700054; Wed, 19 Nov 2025 03:13:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYdjRdHGnams
Date: Wed, 19 Nov 2025 09:13:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org
Message-Id: <a618d371-3489-4e7b-830b-bec843e117d5@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H7NU5z4bZDG3ZW+oHEp3jUE9_69g+zUXmT-+RcM07bOOw@mail.gmail.com>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn>
 <debb8b35-8253-4422-a197-6d92e8d0c701@app.fastmail.com>
 <CAAhV-H7NU5z4bZDG3ZW+oHEp3jUE9_69g+zUXmT-+RcM07bOOw@mail.gmail.com>
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025, at 09:01, Huacai Chen wrote:
> On Tue, Nov 18, 2025 at 9:46=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
>> > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig=
 to
>> > loongson64_defconfig (for 64BIT).
>> >
>> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> > ---
>> >  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++=
++++
>> >  ...ongson3_defconfig =3D> loongson64_defconfig} |    0
>>
>> I would suggest using .config fragment here and only listing
>> the differences in the defconfig files in there, rather than
>> duplicating everything.
>>
>> > +CONFIG_DMI=3Dy
>> > +CONFIG_EFI=3Dy
>> > +CONFIG_SUSPEND=3Dy
>> > +CONFIG_HIBERNATION=3Dy
>> > +CONFIG_ACPI=3Dy
>> > +CONFIG_ACPI_SPCR_TABLE=3Dy
>> > +CONFIG_ACPI_TAD=3Dy
>> > +CONFIG_ACPI_DOCK=3Dy
>> > +CONFIG_ACPI_IPMI=3Dm
>> > +CONFIG_ACPI_HOTPLUG_CPU=3Dy
>> > +CONFIG_ACPI_PCI_SLOT=3Dy
>> > +CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
>> > +CONFIG_ACPI_BGRT=3Dy
>>
>> You mention that loongarch32 uses ftb based boot,
>> so ACPI should probably be disabled here.
> I have tried my best, adding #ifdef CONFIG_ACPI all over the world but
> still failed. :)
>
> LoongArch is deeply coupled with ACPI and can hardly disabled. On the
> other hand, it is not forbidden to use ACPI for LoongArch32. So let's
> keep it, and I will modify the description for LoongArch32 booting.

Ok. You will probably want get back to it eventually, since the
32-bit port is likely intended for small-memory devices, and the
ACPI code is fairly large.

>> I would suggest turning off CONFIG_FB here (also on loongarch64).
>> There is a replacement driver for FB_EFI in DRM now.
> Do you mean simpledrm? It probably works but not always works. From
> sysfb_init() we know it only mark EFIFB as a simpledrm device when
> "compatible", so we still need FB_EFI as a fallback.

I meant CONFIG_DRM_EFIDRM, which was added earlier this year.
EFIDRM should work more reliably than SIMPLEDRM.

     Arnd

