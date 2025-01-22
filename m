Return-Path: <linux-arch+bounces-9855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF8A199E2
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 21:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4493A070F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDAD1C1753;
	Wed, 22 Jan 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PKohlQ4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWLsIJmk"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A91C1F34;
	Wed, 22 Jan 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577815; cv=none; b=RGwba5FxH5roWEjDK9qubATU1H68mT7a2W4P0BgDOqDScKs0GWkcaJ5KTVnoD9bk2ACNQY7ghQKPQ+S5S9qnqaBNBKdRNWe9NhJLzOF7XBjnDDxcQmStibwD0HXqfzVFk2Jbg9Q89lw9ZoHM6sio1DCnqHInGbeYlxV+lV/nqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577815; c=relaxed/simple;
	bh=ipgI7wHGTr/giYhjnCIlPAmUcilXuIwDSO/Yi3o2Pz0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TJa0vIyV0mLvhQuVu76pzEKEm3mjhvPpN0mzh61nioe64UiiTQAscIElmkp/Tkk7rs6Zn0LODbWErmMHGNEnJPYLoLKMe05oMfoskFerU7C0KfoPPf3+ItKMm6bW3D9Ys37ftcteCVKpSusXFRuPNeKKTZ/Uf8gjchD2SVElXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PKohlQ4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWLsIJmk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 69BBF13801F0;
	Wed, 22 Jan 2025 15:30:12 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 15:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737577812;
	 x=1737664212; bh=bvOr6eELKK/8/q70N6ap7S2VJku4+BpsyEmLsAm/q18=; b=
	PKohlQ4UA8jg170PEYEzbdV68/SAspiTnOdxFP+C76YcIo+QkToGVGrxCZI9Vy7j
	eyHCPW63EHM1ZYItNxDfocJcJMeTAp9eCCmtBrTAVvygz5FePDlKUtOJs10HDem7
	lWM6zorYMdLOtjRzEE87WhA6nWii4pCEHMqo99R/NjReSKq7/Xy+bbZ8KGzFuVG6
	NM1sce9dyyNDk56FBJwCF+6KkHAo5PAY/h33J+/vkqfqdWUoxLg0yWi7DyebGhVZ
	9+GUXeLdHlIZvi7+HQq6CzJlLIfqhBC4DxR+f/wm/h0nVPbgF2D//KXYhBCYUOJ2
	3ZxaObyge7dTW+VEyheFzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737577812; x=
	1737664212; bh=bvOr6eELKK/8/q70N6ap7S2VJku4+BpsyEmLsAm/q18=; b=L
	WLsIJmk7C8xNZVLdO5MPG7TfNmyflugBOPF/pBvzGFZwpkg+mnurzEyL8qpNQbkp
	pgjp1ZOLmh+BSrQuDLEeYdLQTWsYK0ij8s6GBOcTcRr+nZ3lvvddAeTFtUSRRkEp
	tKe1lTFfDV7+dMaPjgbH+/6HbXUxJWTg7jF14T1zcU/gQpkj8Q536e1VuU4fe8yJ
	3mMDg1HtZUiGGWhHTkqnz4GYR/4PQ0/UYDMHoXEvE5gY+FiZZx1iNkYNTFMgnucr
	rThdd5AbiNTj37Az2Bd9j3d8IbPBlO38cB8Ium000bwIpFUvdbnbhPIu6ZC+9g3G
	8zLV9gH3xXxuwxYMT8aLg==
X-ME-Sender: <xms:VFWRZ3KsYRhFs4xJ_Ye7fpDrPB2DWTyQUZuGlP_Vy0r3SWjE_FE52g>
    <xme:VFWRZ7L0kj8wkYOYv9R4etyhVROnws0dcZsyg5ZWmrFaDAzaxZfSAwTWYYGgPHPE5
    pZ-JEXmlw2moCxhUtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    pefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcuue
    gvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhn
    peehffetueelhefhleeghfejjeduuddtueetfffgleeffeeuiefhhfdtkeduffffueenuc
    ffohhmrghinhepphgrshhtvggsihhnrdgtohhmpdhgohhoghhlvgdrtghomhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnh
    gusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhvghnhhgrnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepgihurhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrg
    hthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnshes
    lhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:VFWRZ_tz4gBDU-XCVB5Uc_8rEd3nXwihjlqi2cy8tKwzh-4u7C8kbA>
    <xmx:VFWRZwZQ5q5_v5o21S04G2xYc_ev5Rxsv_pAo5TJJBSa7fQjGPtFdQ>
    <xmx:VFWRZ-Y6wZnJdBNC7_4J2CSPx1174-FYmzbc-gtz0qwIFFN-YJHFjg>
    <xmx:VFWRZ0BUH1MQpNUxN3vSPVasVDkmTbUfq16sv4_Pqhp6dmhaILrOvw>
    <xmx:VFWRZwD3MsXxDoO6e9xY3rSmF7bLk1RnzI_EraageD5CYhvylbYgMA9q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 102072220072; Wed, 22 Jan 2025 15:30:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jan 2025 21:29:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rong Xu" <xur@google.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
 "Masahiro Yamada" <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, "Han Shen" <shenhan@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jann Horn" <jannh@google.com>, "Ard Biesheuvel" <ardb@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <04db1d00-8801-4d29-bed9-54b2cc39e4fc@app.fastmail.com>
In-Reply-To: 
 <CAF1bQ=SEybO_+UMDqspA+9OecYqJhE56D-zJyxEUiPcj+Af_fA@mail.gmail.com>
References: <20250120212839.1675696-1-arnd@kernel.org>
 <CAF1bQ=QFxE8AvnpOeSjSeL1buxDDACKVNufLjw99cQir0pyS_Q@mail.gmail.com>
 <c5855908-df1f-46be-a8cf-aba066b52585@app.fastmail.com>
 <CAF1bQ=SEybO_+UMDqspA+9OecYqJhE56D-zJyxEUiPcj+Af_fA@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025, at 19:47, Rong Xu wrote:
> On Tue, Jan 21, 2025 at 1:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> On Tue, Jan 21, 2025, at 18:45, Rong Xu wrote:
>> > On Mon, Jan 20, 2025 at 1:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.=
org> wrote:
>> >
>> > Yes. The order could be conditional. As a matter of fact, the first
>> > version was conditional.
>> > I changed it based on the reviewer comments to reduce conditions for
>> > more maintainable code.
>> > I would like to work from the ld.bfd side to see if we can fix the =
problem.
>>
>> Makes sense. At least once we understand what makes the linker so slow
>> and fix future versions, it should also be possible to come up with
>> a more effective workaround for the existing linkers that suffer from=
 it.
>
> @Arnd: Can you send me the instructions to reproduce this regression?

My report had linked to the config that I saw originally:

>> > Link: https://pastebin.com/raw/sWpbkapL (config)

This is for a x86_64 build, and I used 'make savedefconfig' to
simplify it, so you have to copy it to arch/x86/configs/test_defconfig
and run 'make test_defconfig' to get the full file back.

I have also uploaded a reproducer to
https://drive.google.com/file/d/14xWdD_S51XBgV6kOajLvdtOef7tQTZQq/view?u=
sp=3Dsharing
but it's fairly large. The reproducer is from ld.lld --reproduce=3D, but
you can simply unpack it and do

x86_64-linux-gnu-ld.bfd  -m elf_x86_64 -z noexecstack --emit-relocs --di=
scard-none -z max-page-size=3D0x200000 --gc-sections --build-id=3Dsha1 -=
-orphan-handling warn --script home/arnd/arm-soc/build/x86/0xA8B23FFD_de=
fconfig/arch/x86/kernel/vmlinux.lds --strip-debug -o .tmp_vmlinux1 --who=
le-archive home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/vmlinux.a ho=
me/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/init/version-timestamp.o =
--no-whole-archive --start-group home/arnd/arm-soc/build/x86/0xA8B23FFD_=
defconfig/lib/lib.a home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/arc=
h/x86/lib/lib.a --end-group home/arnd/arm-soc/build/x86/0xA8B23FFD_defco=
nfig/.tmp_vmlinux0.kallsyms.o

    Arnd

