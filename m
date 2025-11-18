Return-Path: <linux-arch+bounces-14876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC0C69E26
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 15:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB5004F7614
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C38355021;
	Tue, 18 Nov 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bLodE3qc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6S6Jjfw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDC303C91;
	Tue, 18 Nov 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474913; cv=none; b=Dj9Ri+lyQA2DtbGPel8qsa8n+iLyY+iyhMCCPR+9ZqfWXo3V+/cj3fb7KEzX2a3+p/NYvLKgM2o1cNyRZJ2aborzhcm+iNwog0p2xnBgxrfyfCugzFuj1DqaJK1CUW3TmjZ5DjmbE2y3TSxEZUHp+jbcLs1NtsbpDU4Zlj8FXWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474913; c=relaxed/simple;
	bh=AFhvFdKp8cfviH/VE/ujKO75Ktut5W9gP4pzr0hI7OM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SjfcsjmIGjbKNgJ8U4mtggvfnT6p5ezPc6tgtKS7wCCh2soeW2gmfl8LPs1dPxc2BAYCyrPG8mf8XGiFqZsPYNhNCIOSA07iZUHgVzZNyq50PVhDGgSC8qu+b4wBwtsmXPtkez01GKI2bwbi8fQ8jGKnJZoQytFyMuRtbsC2RHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bLodE3qc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6S6Jjfw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C4216EC0387;
	Tue, 18 Nov 2025 09:08:30 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 09:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763474910;
	 x=1763561310; bh=mGrPjlDKcSRS8SFdifciDeDEyPLLdWcog8pI3LOst04=; b=
	bLodE3qcYA8cW6ETmFBpP1bjiHBvPPdw8nZHpaNtgu8rZOP5P4h+0XBZqD4IA24v
	4Gk675cJ+OuJnfmKeWsuZWDZyfCOc8GmWIu16HTtbx2vhPMzSkls6NXLzNZkp05N
	8NSpQrVSxlpU97MKHos2ozDsMH3knhGyN5A9tDzpAaIFL8/hf+wbvAaB9hL2vF9F
	6geZj29v8actZFibYwwS/4uoJBtSUl8EJj/nqAx58jg/yml2IfkUyoEH/Gj/KQJn
	4IW/lwiai4HrHAzlUGsaOb7ZTBr3Pi/Dy02E/upSmoq8ut4HDEOPa5BdJKuh3DuY
	On6dpDJd+SJt8AFtyThZTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763474910; x=
	1763561310; bh=mGrPjlDKcSRS8SFdifciDeDEyPLLdWcog8pI3LOst04=; b=O
	6S6Jjfw/Sx834SqiUMlwToFMSKNX5HiVCfvCmHKC/e4KK6fWueGialkEW7yAcOGm
	4OnEVr/EUnhIcYuVj/bFdYSUYff7Tf7nkD00mE+W9x15PyvvrGt/RQKYCdPBShpM
	jRJZm3V8q/00NRUv9DtfdpyiN63E6OChJ41p+odFC9Q6CagJ0H7TtnoIDVb7aChl
	pbCOGeWEnAhzbPRjqcEcE9cJ3cHMzNfCHL1uxjiv1kaKVDBtsChHlyhK8d83ywZV
	gdjw2h4TkQ4foB92oqb/HaS3pAXMmXV0xldliCrwjjDQ2RXmPUW38sGtMxvBlsdF
	MUTacIYvFj/+tYlA/Vxvw==
X-ME-Sender: <xms:3X0cae6vcLqaQvQ-kpCpmMsUFHG58WwxggZpquaOh40gKLETgQFNyg>
    <xme:3X0caSuQAQ-WXylyUKIspGwhVlJ1NOEbSUp-j9YA8QUvMqhViOO9N09jW2e0vTXKy
    d9WlbTeo8PkRMxrJqlrTTQgwap9zthfA_aHr_mvOqxij4axz7IrOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeffleeludehheeljedthfehgedtffehtdffieelheekteffvedtgeehudfhiedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohep
    tghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhorhgvnh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopegthhgvnhhhuhgrtggriheslhhoohhnghhsoh
    hnrdgtnhdprhgtphhtthhopehlihiguhgvfhgvnhhgsehlohhonhhgshhonhdrtghnpdhr
    tghpthhtoheplhhihigrfigviheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlih
    hnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3n0caQc_ypmt7jePS9kX0QSUgnh8_z77YFVJiPnO15Y72Z_68mkZVA>
    <xmx:3n0caaYwox6l0YRGbYH6MNoHPF_cFDVsIBo4LuCJa9RZMd56ndJggg>
    <xmx:3n0cadGcs_9nYojtMMelYgbGm3gClvXngXRR8Pwx8RMLE0za9mzR1Q>
    <xmx:3n0caQkRgm9xvTpHx0g-WjkFr1tWI28oTlvEYc8xpDIqqybp4DMLxg>
    <xmx:3n0caWo_B2VubHV43A5HDUrDBgDXZxEm40Oou1q_BTjOjE6Qrsh_DqHT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E20E1700063; Tue, 18 Nov 2025 09:08:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Amcp8um3uPZB
Date: Tue, 18 Nov 2025 15:07:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, "Yawei Li" <liyawei@loongson.cn>
Message-Id: <29e20a47-3752-49a6-8e3d-ae4ce9ffce5b@app.fastmail.com>
In-Reply-To: <20251118112728.571869-1-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH V2 00/14] LoongArch: Add basic LoongArch32 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch32 use FDT as its
> boot protocol which is already supported in LoongArch64. LoongArch32's
> ILP32 ABI use the same calling convention as LoongArch64.
>
> This patchset is adding basic LoongArch32 support in mainline kernel, it
> is the successor of Jiaxun Yang's previous work (V1):
> https://lore.kernel.org/loongarch/20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com/
>
> We can see a complete snapshot here:
> https://github.com/chenhuacai/linux/tree/loongarch-next

I looked through all the patches, and this seems completely fine
implementation-wise. I replied with a few minor comments, but
found no show-stoppers.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I'm still skeptical about the usefulness overall and would warn you
that you may regret merging this in a few years: 32-bit Linux is
clearly in decline, and the amount of work in bringing up and
maintaining another ABI (or two if you count LA32R/S separately)
is substantial.

In your cover letter, I'm missing information about running LA32
code on LA64 hardware. Specifically, do you plan to add CONFIG_COMPAT
support later, and do you plan to support LA32 kernels running
on LA64-capable hardware?
I would suggest supporting COMPAT 32-bit userspace here, but not
32-bit kernels: based on the experience with x86, arm, powerpc
and mips platforms that allow both, the compat mode usually
results in a much better experience overall. Compat support should
probably be a follow-up and not part of the initial submission
though, so what you have here is fine.

       Arnd

