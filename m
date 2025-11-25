Return-Path: <linux-arch+bounces-15077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B23CC8654F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6BD034DB9A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554532AADC;
	Tue, 25 Nov 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PeguaAvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ehk1v9qH"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB132A3CC;
	Tue, 25 Nov 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093314; cv=none; b=nPa3prhq9EFzHdUsfDqDfOf83C3SGe03Usz+vQMBeDvnLSXJe59BLm2BS9CFCrgoa5QqDeL7NVpM1zsExZmQI0L/ra4I7R+SYPBebRglMiXtCRN+9yp4fkTeh/ILnjbm3CcR0tNtoF4Hscq8lLA4kjVLNK0ZMHipCopgzPaPZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093314; c=relaxed/simple;
	bh=uElAdHpYNr/hV3tK4nsQY3aQszbpy1DIpGa1RTplkDc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BPmAIEdlqD5nDRm1Ha1hNCPXpQscEpAa2CEW45PQTYieV0s+h3f2jHxCGMcEmCFewxRQxN6KMiOzMN3opZoqvGwZYq858iW7uwYsUZVmPxnTY1xWKbWpfhrB3aSCrG6+E4kJhYc49dg6GWYhT8ou73QqB6tWfB9c8U7nnyCyPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PeguaAvB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ehk1v9qH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EFED7A01B4;
	Tue, 25 Nov 2025 12:55:11 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Tue, 25 Nov 2025 12:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764093311;
	 x=1764179711; bh=wQ+whHpjary1WMEWkNxnrXAcMi90fMe4yNNT0YGx6I0=; b=
	PeguaAvBE+gcwiXVVslZRin5ugClJ5Yrvr4LK/0W7CZ9l4p3eqgl2eWRvzE4NFsN
	0JgHoaNqLh8tVX+v29x/9yJ+Q3WffmwtKtha45a/enzuAMwVof2AkjORdTQEsmM/
	ciEN5rONDTOiVhQJ4A/H9pgttyWqnPXav23619ABBSTYemh361p7/6oFVuZRKrY4
	RLLaYGRmryr/NrxDEWJD9vxJoT1N/Lr6MlETpkoo7/H3S8qp49oSz65H+54w80gF
	xSafUoLieHnxxf/8RfBmezfJPSBQJUTH5evuocyMn18LPJyT/+ssEs3smdoM62/E
	qRVq5Vw5JH3gbcaseB0sGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764093311; x=
	1764179711; bh=wQ+whHpjary1WMEWkNxnrXAcMi90fMe4yNNT0YGx6I0=; b=E
	hk1v9qHRFumnnELBJaaMX+6zlAoIz7ggwjJhKGKw8s32orak/dI1PrvlmzNQP8X9
	IswAP8Q6G8VvVOPKxgoVcKGJc1gf5aqeVne/JUyeqd3aIksIMIxk/hPIdaNwJixd
	/zdMT+F/fpSWWaoFVWZt6mrDCUYFbsyqwnP1lOKp51NCKJDVEFzdNx3GVRgQLXYR
	UgSawgRco+H72s+pGMeEHb7H4fcLjDeQs+zRONODhafaSStQiMDsTITaaOO0S/4G
	6QCkQbPZDIyWA/P2VnOA40djrAdBkHHsQpIO/7U7LANPe7f5NnH50HtacqcFx3h9
	dS4gpH73AXv90SFf7LEsg==
X-ME-Sender: <xms:fu0lab0YEOSSGchjllASjqJeyJFyRgD1NDCdzeshq6xNw8XxXwl80g>
    <xme:fu0laU4q3yA036jOcVCFIpdQ7wQ6y4H9iibKao7vv6TBDH3_D7_-3TlWSQPJZh3v9
    jO3t4-XNtJp7iMbhPYfcvFgFyYrBv6KsZ5OdjNRLlmV2ZraMC78BVOu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtg
    hpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    uhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthhgvnhhhuhgrtggriheslhho
    ohhnghhsohhnrdgtnhdprhgtphhtthhopehlihiguhgvfhgvnhhgsehlohhonhhgshhonh
    drtghnpdhrtghpthhtohepthhhohhmrghssehtqdektghhrdguvgdprhgtphhtthhopehl
    ihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fu0lacZcXxet7tgvxvfc9vlKkAZ8VIF05_Wyo_v4n0AwnLnAmuLZWg>
    <xmx:fu0lafl07p2pWB-gX_uWUzaAYaFgJGC0lfpOlnejaCYXZarZ6ZH_yg>
    <xmx:fu0laShGpshITJfYC-VDUvZkZhH0fNWm5cwj9wuoqbJMEzvOekNOTA>
    <xmx:fu0laRRVLJGvzc476OqoZOy43J6VMyfaNYHLcuaJSFxzObpTyl8_-Q>
    <xmx:f-0laSR8gjctsiyeTiaU1pMpnRhzyrDjD6OPSa4gY0p5l5HL-ZDZAwme>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C22DC40054; Tue, 25 Nov 2025 12:55:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsIcsmVbKmaR
Date: Tue, 25 Nov 2025 18:54:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org
Message-Id: <4c58592d-224b-481c-a728-3c279f8e55cd@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H4Df+c47ocBn2SN3iHDbFWGg9-i2+wY27TvtcpBa=pp7Q@mail.gmail.com>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn>
 <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
 <3407d536-a9b5-48e8-a9cf-4bb590941d0a@app.fastmail.com>
 <CAAhV-H4Df+c47ocBn2SN3iHDbFWGg9-i2+wY27TvtcpBa=pp7Q@mail.gmail.com>
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025, at 15:13, Huacai Chen wrote:
> On Sat, Nov 22, 2025 at 7:57=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Sat, Nov 22, 2025, at 10:45, Thomas Wei=C3=9Fschuh wrote:
>> > On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
>> >> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> >> index 96ca1a688984..cf9373786969 100644
>> >> --- a/arch/loongarch/Makefile
>> >> +++ b/arch/loongarch/Makefile
>> >> @@ -5,7 +5,12 @@
>> >>
>> >>  boot        :=3D arch/loongarch/boot
>> >>
>> >> -KBUILD_DEFCONFIG :=3D loongson3_defconfig
>> >> +ifdef CONFIG_32BIT
>> >
>> > Testing for CONFIG options here doesn't make sense, as the config i=
s not yet
>> > created.
>>
>> > Either test for $(ARCH) or uname or just use one unconditionally.
>>
>> I don't really like the $(ARCH) hacks, nobody is going to build kerne=
ls
>> natively on loongarch32, and for the rest it's fine to set the option.
> OK, I will use 'uname -m' for checking. Though native builds on
> loongarch32 will hardly happen, we can give a small chance to use
> loongson32_defconfig, in all other cases, let's use
> loongson64_defconfig.

What I meant is not to guess the CONFIG_64BIT option from any
part of the build environment other than the actual .config settings.

$(ARCH) is initialized from 'uname -m' in scripts/subarch.include,
and I think this should stay unchanged.

>> > Also as mentioned before, snippets can reduce the duplication.
>> >
>> >> +KBUILD_DEFCONFIG :=3D loongson32_defconfig
>> >> +else
>> >> +KBUILD_DEFCONFIG :=3D loongson64_defconfig
>> >> +endif
>> >> +
>>
>> This is also not the change I had suggested in my review. I think this
>> should be a fragment along the lines of arch/mips/configs/generic/32r=
2.config
>> and arch/powerpc/configs/book3s_32.config.
>
> Sorry for that. I know that the default config file is usually
> generated by 'make savedefconfig', and the main purpose is
> significantly reducing file size. I did that, but manually add some
> lines such as CONFIG_LOONGARCH, CONFIG_32BIT/64BIT, CONFIG_ACPI,
> CONFIG_EFI, etc. My original goal of doing this is to let users easily
> know those fundamental options without reading Kconfig files (of
> course we should not increase the defconfig too much).
>
> Sorry again for not explaining about this in the previous version.

I don't mind having the extra options in the generic defconfig
file, that is unusual but I see your logic there.

My point here is that you should absolutely not duplicate the
contents but only put the differences into the new file, such
as

+++ arch/loongarch/configs/loongson32.config
CONFIG_32BIT=3Dy
# CONFIG_64BIT is not set
CONFIG_32BIT_STANDARD=3Dy
CONFIG_MACH_LOONGSON32=3Dy
# CONFIG_SMP is not set
# CONFIG_LOONGSON3_CPUFREQ is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C_LS2X is not set=20
# CONFIG_PINCTRL_LOONGSON2 is not set
CONFIG_GPIO_LOONGSON1=3Dy
# CONFIG_GPIO_LOONGSON is not set
CONFIG_WATCHDOG=3Dy
CONFIG_LOONGSON1_WDT=3Dm
# CONFIG_LOONGSON2_THERMAL=3Dm is not set
 # CONFIG_IOMMU_SUPPORT is not set
CONFIG_LOONGSON1_APB_DMA=3Dy
# CONFIG_LOONGSON2_APB_DMA is not set
# CONFIG_PWM_LOONGSON is not set

This way, running 'make defconfig; make loongson32.config'=20
should produce the same output as your current
'make loongson32_defconfig', but it is much easier to keep
the two in sync because any future changes only
have to be done in the shared file.

     Arnd

