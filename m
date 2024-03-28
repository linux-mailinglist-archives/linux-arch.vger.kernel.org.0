Return-Path: <linux-arch+bounces-3266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0988FF9C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3392728EB59
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE27E103;
	Thu, 28 Mar 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lJeza5yy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bb0RNIiz"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027D7EF17;
	Thu, 28 Mar 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630342; cv=none; b=uiSNCEECs5/s2mYhzCUegCH5X4dl4KOBlDfyNCAJ4RlNlhpRPeprCS+TXgVQv2d7yV25ctF+nn6anO4ysjRIxXIngKJ98GfcA3azhX8o1n9wNlSbus3ImarCnh7oPIFlTaVSb9i8I1c3046r9Z3csz3emi8TJ5PTy+kZMs6Ekwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630342; c=relaxed/simple;
	bh=K7G216/9Y5GWDmEQjWdPDtD+HZSkcqwWpH0kpXKH9yo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TjYGZ5cN3fKb3LzAekjrRcVjC1R7vpbyF79mvAz9zDBrLzfJzWSP5Emkmj/1crRaUfHEuRUxIhxB68GyO/DWhAHzartKJwmPaGYEx/bTR8huC9HKPmnBaka1W5JMOg5XEcQ9XZDJf9WDj/R4GdoKo9aaPbcgj2u9GIQ+ank72DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lJeza5yy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bb0RNIiz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 521AA11400CB;
	Thu, 28 Mar 2024 08:52:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 08:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711630339; x=1711716739; bh=Lh4MuWdYpt
	nETV0Wdnx8P7s+c4JMcLpkbpgMh56pLFU=; b=lJeza5yyYcri2tqJXpeirr9IYD
	QgEwfGN2RlgSUZc2rPDvxJhYxVV/089I5H8oqHMLkN1+FSFdvimIGpzJdybXiVd5
	2Hh7M3Fpr5K+u/YoqlSgteczcWUPaZe5PebEFQhsn8cz06VmU1/BTqmSG88UpbbW
	IRDHUvWeKM93m9tnIVFqW9PGvlFsvxcia5odqwnh/sOipC53vjPC915vrwXdf3ah
	NQDPw1x0KM/1Z6i113r4SH/r8f13MvPNNpADkwyEjH+JePCvmsqUsdRpbb4ui8li
	J45J5/3Dd68gaDOg4hUkS0HOa1RLi7A6iqh9EgTFdOh7UQ2jAtXzjQh8oNKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711630339; x=1711716739; bh=Lh4MuWdYptnETV0Wdnx8P7s+c4JM
	cLpkbpgMh56pLFU=; b=Bb0RNIizRq1jBDXW2lq5jH171BDUGdtZOBg2yhJaGCQ5
	MBUTySW+5j/DdyxglMRP3qw/rYCu0oiLgYsbKnKkbNOTFRIfXop0TJU5J9/Nuwht
	IH+tgwf4DUiVeonklvbKjpPszY0PLMdnEchwigznQZzcjH99EbmiLLpg1qf34krT
	iJghoc6WkCjfz5VazuLrz8Gy/4B3LuUTJh7DtGLExpprxflXUKQ5u16km0VO9gz/
	/xIY+MDt7wkkOiFfd34Gcgjv5bdHKl97f1ijnvyK1q2AxPNwwE/+Te5MSHhM3YvC
	/1bTpCSbgPPNegyP+O+CzYBZP3dLsoFPbxV98O3B/Q==
X-ME-Sender: <xms:AWgFZudGwHi-Z_ipu-DAtsUL6gJmM5eGp3QTYrVOimzirRINehkvoQ>
    <xme:AWgFZoPWeyCXm0gz801Wq1t5hhpzKklxaM1TLa1qtwhXC7iwXRxMyw3onJxip2eAj
    WWQT6wPeOdpsid83Ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AWgFZvhfmGntOEERrkeD9wQxbG3BBl0ymkFJFs1vm6jkXMFebhBQyQ>
    <xmx:AWgFZr8YnamA7dSxSPnNPmMKwDGtXJdBScUKn5dZp1VpBND1nJVyTQ>
    <xmx:AWgFZqvndgo1Vk3LX14Uj8eNF0kPqgRQgY7FmHK6m8-J_1U1eqBvWg>
    <xmx:AWgFZiHiTqUPJIypCNK7EW6Z8ridICdLObLwSNabIfJrzpIA_ulyaA>
    <xmx:A2gFZq2IF3v0r4kisD05XZs3sJZhIlR4o-eCVWP-cdF5aXis-a6QEw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 69BC9B6008D; Thu, 28 Mar 2024 08:52:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72e8aa58-c732-4a96-bcb1-32310ee041b3@app.fastmail.com>
In-Reply-To: <140d6bb3-5f44-49cb-846b-7141e551eedd@gmx.de>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-4-tzimmermann@suse.de>
 <140d6bb3-5f44-49cb-846b-7141e551eedd@gmx.de>
Date: Thu, 28 Mar 2024 13:51:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Helge Deller" <deller@gmx.de>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Javier Martinez Canillas" <javierm@redhat.com>, sui.jingfeng@linux.dev
Cc: Linux-Arch <linux-arch@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Vineet Gupta" <vgupta@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/3] arch: Rename fbdev header and source files
Content-Type: text/plain

On Thu, Mar 28, 2024, at 13:46, Helge Deller wrote:
> On 3/27/24 21:41, Thomas Zimmermann wrote:

>> +++ b/arch/arc/include/asm/video.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _ASM_VIDEO_H_
>> +#define _ASM_VIDEO_H_
>> +
>> +#include <asm-generic/video.h>
>> +
>> +#endif /* _ASM_VIDEO_H_ */
>
> I wonder, since that file simply #includes the generic version,
> wasn't there a possibility that kbuild could symlink
> the generic version for us?
> Does it need to be mandatory in include/asm-generic/Kbuild ?
> Same applies to a few other files below.

It should be enough to just remove the files entirely,
as kbuild will generate the same wrappers for mandatory files.

     Arnd

