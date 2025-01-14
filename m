Return-Path: <linux-arch+bounces-9743-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5EFA10427
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626873A82FC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59777284A69;
	Tue, 14 Jan 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ITYW9mJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHOK7lxm"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B81C4617;
	Tue, 14 Jan 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850637; cv=none; b=bGhj4sJ9/ZKtT7iOYtvaeELGPrXtnvXMHVfLbQzpBG3tvEkDh2nYw8dIuD2iRAY1GUCZ9TIzdV+tqHRzXpcOyYNJfgkVrb7yWd0nB61K+hks/8DUnEb0jdG8RPvXU2ATQF+UjTQSwh/kYqPVvNYq9hoQQMkwmPm1TQtfTtY+gHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850637; c=relaxed/simple;
	bh=V/sLQBOHxCg3OYdFncfOgkbnGLdjxrZh1AeMD/hdr2A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ii/TzAJoxl4Bvwy2rlYWsm4D9dMY+JIDyEqBPMvj2XrPbQsbyYRH6Rkm5jfJ2EZMnDeDBRNacxFcWdDFVyIF0mkbCGS5wX2NNOTpj7GT8tN6iQ48pyiCxwl6aO/CYGRTRAxI7eyLxPX/CyC7RxweW00PvaO2jrZSyPi5v6RY7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ITYW9mJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHOK7lxm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 35DCC11401AB;
	Tue, 14 Jan 2025 05:30:34 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jan 2025 05:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736850634;
	 x=1736937034; bh=t11qRYdRsrweCje2/Slj4NaG/J6s/a6AQQBMjcyNzkk=; b=
	ITYW9mJkWirHpdOtUvkeVmVZWl2THjVvpWzhmHRxZyQstZLkshWZM4pHIr+AvEMT
	HzZBTUWIfJ3rVUU2ML5Y4obT4lvbn6NVfTxbsqkr5UmSDxqtf891SaV41Clmslv+
	M202Z/b+r9qyvKvpIckJHEHjIsvNjygFMtaOpQhQ3cciqGlON37dQ9NKDocXTRqY
	ZJH6S3sMKqqyEtaNb2ek1or+66s2PAJCunJG+RyvR+LzV6mmcP+qlc0v1oCU8+hy
	3YEmIY6UWaoeFtQRr/R5AVZQuEQhik8PrYkDhd2BqhzwRZ0IoHlcsSNUqcvLh1R4
	2AOViqdswn0uptOP99lQXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736850634; x=
	1736937034; bh=t11qRYdRsrweCje2/Slj4NaG/J6s/a6AQQBMjcyNzkk=; b=W
	HOK7lxmC6FMTRelpmH8mIngnl9cSARaMV+QEN0rEePpfbJn0hcV8APTgSJrf60lw
	AeIkZZOFBUqNB0g888vZPcqRM53R9MstpuT3iTssWEN6v5CDR9u+PrSuEb03nbaE
	5UrUQXBBbdl6P6JRIXvUbL8dq1lQ8C3lMGYUzoRWpHtV1pTysOW12xT1aFss2yy3
	V32Nm9nST70nz+/DYayfGAJF3PDCjMmYZfSpYMeXCRVqNboaOIOeLBYddT2ue2s5
	nXOm10MyRlyyb5M14kPTtsdAL/IUhyCyrqXwzegwpBVbuhlg5TVJcunnlOZnhXwY
	ftKZ5HF1Yq1bkg9fog+Ww==
X-ME-Sender: <xms:yTyGZ-OR1oWrO29uY412IZvZSCuwRCyhhdl4-L72RWMTStLHnfeE-w>
    <xme:yTyGZ88rqGLx1PnrH1qjzqddgWy4iytKOYziydqwx3SdVsGw6-oRgKMmryFiUK-Uo
    P7XgrkdlaQLgSLKic0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrg
    drfhhrrghnkhgvnhdruggvpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhn
    ihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdho
    rhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehmrghtrdhjohhntgiihihksehovddrphhlpdhrtghpthhtohep
    sghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yTyGZ1T5KvXg_jj1bNA7UsBROiDekuERRMkH14X8OEJMymBT5lTc2Q>
    <xmx:yTyGZ-sMofWyJoyNUvZaHPPzpw1VqgT4eUsRljTgFZqlo44Huu3bJQ>
    <xmx:yTyGZ2dmFTZAJBtrqS-rKyESloXgt0l0vEgonwMeTF8bBZMAbPGQEA>
    <xmx:yTyGZy3A93r6nanAj0P22pN_zeQkNi5m_AQUfemwNkMVUMnLGizeZA>
    <xmx:yjyGZ24-j7eUPWGGRrkrlad2UAAYIzrS_WWsLGPlumF8GBiJ3mb6hkAX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B76942220074; Tue, 14 Jan 2025 05:30:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 11:30:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Baoquan He" <bhe@redhat.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 regressions@lists.linux.dev
Message-Id: <599d4ef2-38dc-431f-a65d-c76fc81f02b3@app.fastmail.com>
In-Reply-To: <12aa35c3-3f74-40bf-9fa1-7540aa4292c3@app.fastmail.com>
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl>
 <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
 <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
 <12aa35c3-3f74-40bf-9fa1-7540aa4292c3@app.fastmail.com>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025, at 11:09, Jiaxun Yang wrote:
> =E5=9C=A82025=E5=B9=B41=E6=9C=8814=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=
=E5=8D=888:02=EF=BC=8CGeert Uytterhoeven=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Shouldn't arch/mips/include/asm/io.h do
>>
>>     #define PCI_IOBASE mips_io_port_base
>>
>> unconditionally, _before_ including  <asm-generic/io.h>?
>
> The problem here is defining PCI_IOBASE implied use of logic_pio and V=
M mapped
> io access, which is not true for many MIPS systems...
>

I don't think that was ever meant to be the intention of the
#ifdef in drivers/pci/pci.c. Checking for PCI_IOBASE there
should mainly ensure the default
pci_pio_to_address/pci_address_to_pio don't cause a link
failure on architectures that don't have any memory mapped
PIO at all.

For MIPS platforms that don't need logic_pio because all of
the PIO space is mapped to a fixed physical address, the
default pci_remap_iospace/pci_pio_to_address/pci_address_to_pio/
pci_register_io_range could just be replaced with a trivial
architecture/platform specific version.

    Arnd

