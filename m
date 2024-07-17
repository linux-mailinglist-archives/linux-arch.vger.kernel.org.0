Return-Path: <linux-arch+bounces-5431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F4933615
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0053E1F21915
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74D6FC7;
	Wed, 17 Jul 2024 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PUZwRq6u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCPE/i8F"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D650AD2D;
	Wed, 17 Jul 2024 04:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721191457; cv=none; b=bQsRGoOz4206czIZHK+MYsohOw2XHXMNpiLGCfmJ55iwG5J61IodtZRzvpzK2C7N6xL6onXzJZYGUdUHVz0cb/j1sSfu+JvME4VXqtI/PGa4id/+PhQ7dbquD0ooipzJeoh2qANmztHGV1QvHXt6m3sJUnjw76zRB2QbMCL/APc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721191457; c=relaxed/simple;
	bh=Pi14HGl67fJdhhjMoU6o47s7nSsoDz7zS7MiGEmHg7U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cmvVDA094KjyfOTJcS/F5eAp2TEhTwQ4+ppGoLB/tEfsktdY0lMlgTDoYGpQWQL9B9QP059DpBHZlg8AdpB/OX0JCs+U/j73QOkI8muIP/6sqLOf9HeA9KJm49S3QIPAfy7/l4CxUBm0RAOwSiH7Dg+qjARrKDRuDe5QQRdvb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PUZwRq6u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCPE/i8F; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5206B13801AC;
	Wed, 17 Jul 2024 00:44:13 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 00:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721191453; x=1721277853; bh=j1uYPDYTW+
	bp5WpRRSPeY62M52aqX4EhdnVH8wqNwcg=; b=PUZwRq6u0lOc1vCbOT4gfc+wyC
	QX9J1drxKT1G/9Ndxv8BO0ULJ6NJ9xlW4HIf8R5UOlBTlEwfCcgMovASoJwaeQ16
	yDbytXIOLbHtTuglOOwB0O7h3T7WkLMjQU1y3fn5CLhyRPJsbnDuto05pOqKB74Q
	gcC+JgvyQQXZcp/Zzf+u1kc8AuDLGFgfKoJ4/wzayhR/CD7qkViokQbuHGq4iLp4
	vmrBuuruxcbFO1gvtMYXPBLMPHxAj2IuEhSnsmN+D5WjPohCjSzRlyZ2frT4z8XH
	5iAJ2IFsI/PXvWBFxkSvcC+zoAubtBzh6Qc5uYePP9thfi2AkyppLaR7eG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721191453; x=1721277853; bh=j1uYPDYTW+bp5WpRRSPeY62M52aq
	X4EhdnVH8wqNwcg=; b=LCPE/i8Fbt/mNOIWsCdgieDjtzp1nzn7Q7MZqVeQeYmJ
	PVXVmlxQiifHlS1TfUl6OMAbAojr1Rc2aJwMngkVBiDcaXp1R1Iyb6UvBo6TKiNZ
	puml1XJVvBuPIcwcg1n2qxeT1UnrPA0HK/lkuNlzYD6YBV8oE4HlErstYvp8+6RN
	EV/pIpuBjfkmsNS7bBzwVuF4i9f0pGlMJWXiP90dkag6YdPFYEL7Yng80Ld0F13A
	QViQxrGSGvVrwhw4lbInsJ6WMI8QvfcAzFW0Q6ItuyXnwCyOuJZ9+xK4nrEzQ29k
	Wp4RWrLXVsP9OEgLeIDMjj5Kc++q1iJ/Z6U6fBLjRg==
X-ME-Sender: <xms:G0yXZqPQ_hxFzHQLG84waE4XtvDe_TPpjmQ2nss104fLLGo5jJUZ7Q>
    <xme:G0yXZo9jK0Bdlis86WD6bC8cnI_h-TQWGWd-_9ncJdPhd56737qqVngzvcxPn31tq
    h71U0Yfu0_QuAPogJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:G0yXZhQ2IA9W8hlTkNvqDCisiFJKVE9oJ6jEOzuFwpc5GrLstDsjpg>
    <xmx:G0yXZqtqoNg_lS8t4bY9J2tzke8iMB9x0tjpPqnErMMGMuTyrAQFkg>
    <xmx:G0yXZifRCjjESr43Hsyvc4oUVmwN1QAPuL9Ab3_Q0p-9CeoUPUhUJw>
    <xmx:G0yXZu2zXrc-V4kT5Ryrj_Dy_oQXGybrgb1mRqm4JV6LP7G6O3zn5A>
    <xmx:HUyXZi6MIdQooKmV9QrU0Q4Do5QY6IdwPk2F7IRajy31New4-hS-yVfd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BF18219C005D; Wed, 17 Jul 2024 00:44:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Date: Wed, 17 Jul 2024 06:43:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

On Wed, Jul 17, 2024, at 06:02, Linus Torvalds wrote:
> On Mon, 15 Jul 2024 at 14:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> But that's not at all what I see. It rebuilds pretty much the whole
> tree (not quite everything, but at an estimate it rebuilds the
> majority of files).
>
> And the first things I see in the build log is
>
>   SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
>   SYSTBL  arch/arm64/include/generated/asm/syscall_table_32.h
>   SYSTBL  arch/arm64/include/generated/asm/syscall_table_64.h
>   SYSHDR  arch/arm64/include/generated/asm/unistd_32.h
>   SYSHDR  arch/arm64/include/generated/asm/unistd_compat_32.h
>   HDRINST usr/include/asm/unistd_64.h
>   CC      arch/arm64/kernel/asm-offsets.s
>   CALL    scripts/checksyscalls.sh
>   ...
>
> which is why I'm suspecting your changes without having actually
> bisected the build time regression at all.

Right, I can confirm that this is not supposed to happen, and
it didn't do that for me during my testing. It should only
recreate asm/unistd_64.h if scripts/syscall.tbl changed,
as it does on the architectures that are using the
"archheaders:" rule to get into the architecture specific
arch/*/*/syscalls/Makefile/.

> This needs fixing, urgently. Because it turns a "small pull" into
> always taking 5+ minutes for me. I didn't notice immediately, because
> many of my core pulls I _expect_ to rebuild everything, but...
>
> Btw, I don't see the same effect on x86-64, so this is purely an arm64
> issue (well, and presumably any other architecture that uses
> 'syscall-y').
>
> You might want to do a build like this:
>
>     make allmodconfig
>     make
>
> twice, and then do
>
>     find . -newer .config -name '*.h'
>
> to find things where the build has generated header files with new
> timestamps despite no changes.

I tried now both with my branch and with your latest commit
51835949dda3 ("Merge tag 'net-next-6.11' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")
but can't reproduce it yet. My first guess was that this
might be related to building inside the source tree rather
than a separate object tree (which I used for my own testing),
but that did not make a difference either.

> I'm adding Masahiro to the participants, because of some of the other
> files that *do* show up for me when I do the above thing:
>
> On x86:
>   arch/x86/boot/voffset.h
>   arch/x86/boot/zoffset.h
>   security/apparmor/net_names.h
>
> On arm64 (ignoring the above and the syscall ones):
>   include/generated/vdso-offsets.h
>
> That 'find' also shows that the install headers thing does the same to
> the ./usr/include/ directories, but the kernel build doesn't care
> about those.

I don't see those either (this is an x86 defconfig example):

$ find . -newer .config -name '*.h'
./include/generated/autoconf.h

So whatever caused the regression is probably a result of my
changes, but so far I haven't been able to explain or
reproduce it. I'll keep looking.

       Arnd

