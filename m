Return-Path: <linux-arch+bounces-13653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00832B59171
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 10:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29AD7A2389
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C3283FD8;
	Tue, 16 Sep 2025 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="p/B+WJFJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZSbvBvX"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598D275B1F;
	Tue, 16 Sep 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013139; cv=none; b=lwlSpGC7XDQMIfDOX9sLB6QiqnV+sBLp+fOE4pNaPbzvIZtMBqMAlIntPxI/pfx167+zd+we70676XQ6CvpkuTs1X2hW7gypfaFtCHgknjulfD/wbwugHbqVCtB9PVEL09A7jZTWEx149h7a1lPVwF6vq4scdQUabgZCe6eBpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013139; c=relaxed/simple;
	bh=RDFVS/12vlPEvpAPazD0+caxnLwdBqgtuPi/RSkpkIE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jHGPNkiRpIL4Cofn2PXWC5/gTijneB6X31P/fjW0SDcsqb3RTT6WwU/SN22+QQTkvhnP4mDkbTJ7VZ/gTrCR/hhDwQXdRiLc9RnYlIBuGuwKYlNYzcPKTSH5rNQnk5idt+hVNRN1kTNKvuQ0qM8J+1ZtsnI3/M08is7NIzshBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=p/B+WJFJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZSbvBvX; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 5ED701300B79;
	Tue, 16 Sep 2025 04:58:54 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 04:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758013134;
	 x=1758020334; bh=9M1JEPa5y3WON6Gl+eiqRK9O7fk6z6pQgd71K0v19EU=; b=
	p/B+WJFJ3zvsd0DyDuUadqyZnXAI6cYiqhiv6unBmCXntIE8psMAM6DfQy7CG4tu
	dwuUTBcBHSAmSEokKeGyllqybSHONkBvptXBA49szippYTJiD18aJSwaXIGwCtNY
	M4Vexja9gLMW6tG7GZSUPNj3XbnBGmnMLH8EJxrwOk1Pupiwv1Y8zd0I3brVRvq4
	D9DwKD12EGhlSPUUQlTZtgs7UmYHav2Vee+sSpz2O3FkdqJ04sN2DYT0Fa261rdJ
	zUCK8nQojIxcEGwn8mnKjGJLQ7OKURxhnaFzwYgYF5uPtmLhEztOEtqrDnlAIMa6
	KsXxnW3BCtMxV2+qIVjtRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758013134; x=
	1758020334; bh=9M1JEPa5y3WON6Gl+eiqRK9O7fk6z6pQgd71K0v19EU=; b=k
	ZSbvBvXbZuuI9RT3eGTsfHKByF+ZYaWJ2C56VraoQgu7pifGWWofVsbIIEVdktZD
	Zgq9DAEqiHxGxdfMtJ+kR7aKKqn1sPCY8D596jXBIhNGyK/SBEeXdScxW0InqE6O
	qrY5nRnQXuYODkZ3xzAIHdQT7dtovownRaXBEC5LhXtolsSjNT+UIzmLu3WT+1ie
	x36JKxShesGDBx1YNAhv4/BnouYSGpy6XplG4rLes4MUUJXHfdacX4Qc+hwgSNTq
	edzDF2TvkCrNunZbdVxobnKXzw5lWyp1YcjOcWz+B929Qbl+ty+UkBq+ymJtzfNC
	L+YLd5TA9UfPFkMGA66Kg==
X-ME-Sender: <xms:zCbJaEaLHcyIvWW6yAWebvipT0oeBmOpqiAOk2PxnEu8TuEJOpTtHQ>
    <xme:zCbJaPZMM9QRAWhJwYx9hvmc0gwpjKOD1eLOaoGD2PqomqH5rQvWYoIzG3axry8pT
    DOXKryxEXEd8GyNWIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheptggrthgrlhhinh
    drmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghn
    ugesrghrmhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsg
    hosehgohhoghhlvgdrtghomhdprhgtphhtthhopehnuggvshgruhhlnhhivghrshesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghird
    gtohhm
X-ME-Proxy: <xmx:zSbJaFqf1ylLAb5gbeCOgjC42fcc-bcdMn6ok2S1qEyqHza2sq_ESg>
    <xmx:zSbJaKHheu5wueAQCpzv6yMqp8xGn9dh1VJoHL0vji4s96JlMLoipQ>
    <xmx:zSbJaP6YqZyPZevTNB4oava3p0DgaX1jC7Tr_5cyKn-xfAkjAP_DDw>
    <xmx:zSbJaABJudgqO6Fn60G_MknxnUxo0wlD6rpwQbgzC-V0LETDssng-A>
    <xmx:zibJaGV2CuE5GYECVXMv7P9FR615dxHK3VuxLkHNVBVgrh4Vls-mjUw3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E3F0B700069; Tue, 16 Sep 2025 04:58:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApGCQqXJ7W6B
Date: Tue, 16 Sep 2025 10:58:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Patrisious Haddad" <phaddad@nvidia.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Tariq Toukan" <tariqt@nvidia.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Saeed Mahameed" <saeedm@nvidia.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Mark Bloch" <mbloch@nvidia.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, Netdev <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gal Pressman" <gal@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
 "Michael Guralnik" <michaelgur@nvidia.com>,
 "Moshe Shemesh" <moshe@nvidia.com>, "Will Deacon" <will@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Justin Stitt" <justinstitt@google.com>, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev, "Ingo Molnar" <mingo@redhat.com>,
 "Bill Wendling" <morbo@google.com>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, x86@kernel.org,
 "Yisen Zhuang" <yisen.zhuang@huawei.com>,
 "Leon Romanovsky" <leonro@mellanox.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Michael Guralnik" <michaelgur@mellanox.com>, patches@lists.linux.dev,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Jijie Shao" <shaojijie@huawei.com>
Message-Id: <9d4cd8d2-343e-4448-ab59-65e69728c850@app.fastmail.com>
In-Reply-To: <d259ffa9-6c9e-488f-a64f-81025deba75c@nvidia.com>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162> <20250915222758.GC925462@ax162>
 <20250915224810.GM1024672@nvidia.com> <20250915231506.GA973819@ax162>
 <d259ffa9-6c9e-488f-a64f-81025deba75c@nvidia.com>
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test reliability for
 ARM64 Grace CPUs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025, at 10:39, Patrisious Haddad wrote:
> On 9/16/2025 2:15 AM, Nathan Chancellor wrote:
>> External email: Use caution opening links or attachments
>
> ifeq ($(ARCH),arm64)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFLAGS_lib/neon_iowrite64_copy.o +=3D -ff=
reestanding
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFLAGS_REMOVE_lib/neon_iowrite64_copy.o +=
=3D -mgeneral-regs-only
> endif
>
> Which is actually equivalent to the diff you sent, Thanks for the=20
> heads-up will fix and resend.
>

I think it's better to handle this inside of the inline asm itself
by adding

      ".arch_extension simd;\n\t"

at the start of it.

     Arnd

