Return-Path: <linux-arch+bounces-11865-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06948AAD8DF
	for <lists+linux-arch@lfdr.de>; Wed,  7 May 2025 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EED4C59BD
	for <lists+linux-arch@lfdr.de>; Wed,  7 May 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8D22126C;
	Wed,  7 May 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b="m6ixM4t0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZA4fxjI"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A22139DB;
	Wed,  7 May 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604163; cv=none; b=ehNqNoT8lM9MfOtmfpeUMaF7cYfT/GsBXjxpFd5GqtER3PokFry5OR5wFymXzBUMV0jorUIQayvSlKJKpOPBC9euGZawPA2KBPLyBQpKD/IfCXq2omiv7QtLKBXyjT4VAXMVZ4uY4xeP30e7ICVLwJDSvuVkX5TKIXpEE1rY1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604163; c=relaxed/simple;
	bh=cokU17empCsgLXMx0CVbpVm5/GG0ANMWp2T8HsVJzNA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uMzku4tzDet+uh9aFEl9S1kuVf81Yab5fAEl27im+55h3o6Dc6TT1aWClr6eqlmiuztHAuOxExZlkxb3ewoO4UfJIoOaTpixaBYS+EPqf5z3edRkaLoUWtuZcPy0ZL+Jfokb2zP1zri563MsmQNcSsQVvozJ9j63CFu+tpmFYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net; spf=pass smtp.mailfrom=bzzt.net; dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b=m6ixM4t0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZA4fxjI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzzt.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B39121140120;
	Wed,  7 May 2025 03:49:18 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-12.internal (MEProxy); Wed, 07 May 2025 03:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bzzt.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746604158;
	 x=1746690558; bh=JcQmMXNVSlii7PXek34Y/lx8uJAyMcBAejqngOH419Y=; b=
	m6ixM4t0Bd5/+Uss2nIYQ1/8T+lGP87Kg95DJvDFeb7DqFU29pVjw++3Li/Ley4k
	ZrzM0BTeOpxvwh0sxNtp1QLtmfEYacvZlaBLB36B/w5i+GcjjskXQ0NzqZ/J8mTP
	0YaZMKdN2faVUFAATg5ZwGTmea9qyr9RUA6YVKZsk0Ynsui8h881co/aN0ZXJuwi
	5Sj7qnbnfM/R3UdL8fSmn+rvlyKNZHlus1rZIwTZiL7RBtLT9PzGjn64VYzcfQcL
	K31sNpaJp+rsMDYUDKWzrVzvYvr+Orkj6MVMJBYkLw1cNBnaMgMmUWIW90Mo1Pz8
	Th8btXk/wU2H3HrP1aEw3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746604158; x=
	1746690558; bh=JcQmMXNVSlii7PXek34Y/lx8uJAyMcBAejqngOH419Y=; b=k
	ZA4fxjIvrDac2vbflfR/MW94tnMJZme863HxGuBbuLxnJnRgxnFSpP9pmL1bJ6Hn
	GwrmAA0bCs013xnar98UKcdvEKlDyOMViA6Ll+6K0qq4GehsaoV25FXc095wkrfm
	ARJbKlcWT+oSnf3JFc/90YW82bEOsZ6Q05NtJirhJsI2n6diyAXIfLOztBgceqlv
	zMCw/UOhobb+tlAbOVIkP5KjU91f+R/jwFvELLUZ2kIUna7Kr57xbbWw1Lc+YFNc
	9GdUEF5rtofNpvc0UeGxakfKT3O5BroTxokSKGbhNBCPSe8rxTVj1ZDoNivbyC0a
	E10rzrUGPhBZWCiPGqFFA==
X-ME-Sender: <xms:ehAbaFqS2VNSdrrCBKfKPArS0Gqyyqv5CLshf_qm6RWOqC7P6yzTdQ>
    <xme:ehAbaHpIDmwdOxMLOentJK9Nd5ZQ-GbYT2KYBTe9j5pBuLP1Z84rJCkZnNpuwkFU1
    MvZkTrEA8H9ukbh2wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhhouhhtucfgnhhgvghlvghnfdcuoegrrhhnohhuthessg
    iiiihtrdhnvghtqeenucggtffrrghtthgvrhhnpeefgefgfeektdefkeeludetteefkeef
    ffdvkeeujeegveethfdthfffjedvgedtueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgpdguvggsihgrnhdrohhrghdpvghnghgvlhgvnhdrvghunecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhhouhhtsegsiiiithdrnhgvth
    dpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    phgthihrugesrghrtghhlhhinhhugidrohhrghdprhgtphhtthhopegrrhhnugesrghrnh
    gusgdruggvpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhho
    uhhprdgvuhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtph
    htthhopegumhhithhrhidrkhgrshgrthhkihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgtrghjuhelheesghhmrghilhdrtghomhdprhgtphhtthhopehnphhighhgihhnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhithholhhvrghnvghnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehsvghrghgvsehhrghllhihnhdrtghomh
X-ME-Proxy: <xmx:ehAbaCPQCmtU0_XRz8-vmJUTunODN6LJ5XAJdUQXl8MZC_JaCjxFOg>
    <xmx:ehAbaA59wckYPtLYhTZVffPcvxO_BZijemUeXnd5cHTnWqBB3GWO6g>
    <xmx:ehAbaE6X6GZm-X-h7CHtIj_tqXHUMbSzEVEZwOfDgLuZu2J5RbipmQ>
    <xmx:ehAbaIgcx2n28RoC1hGQYgUotGxNuE0nTYRb07t4aUhf_rREVRpkqQ>
    <xmx:fhAbaPRdhTA1xuKM3DUYaFI8sfLgbhVSaXODaU-UBjVBXGPdpqtaF29z>
Feedback-ID: i8a1146c4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 74285336007C; Wed,  7 May 2025 03:49:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5f9a5891fefab612
Date: Wed, 07 May 2025 09:47:23 +0200
From: "Arnout Engelen" <arnout@bzzt.net>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Daniel Gomez" <da.gomez@samsung.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Roberto Sassu" <roberto.sassu@huawei.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>,
 "Nicolas Schier" <nicolas.schier@linux.dev>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 "Mattia Rizzolo" <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 "Christian Heusel" <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Message-Id: <6615efdc-3a84-4f1c-8a93-d7333bee0711@app.fastmail.com>
In-Reply-To: 
 <2413d57aee6d808177024e3a88aaf61e14f9ddf4.camel@HansenPartnership.com>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
 <f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>
 <840b0334-71e4-45b1-80b0-e883586ba05c@t-8ch.de>
 <b586e946c8514cecde65f98de8e19eb276c09703.camel@HansenPartnership.com>
 <072b392f-8122-4e4f-9a94-700dadcc0529@app.fastmail.com>
 <2413d57aee6d808177024e3a88aaf61e14f9ddf4.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 6, 2025, at 15:24, James Bottomley wrote:
> I'll repeat the key point again: all modern hermetic build systems come
> with provenance which is usually a signature.

I'm not sure the 'hermetic build' parallel is so applicable here: typically a
hermetic build will produce an artifact and a signature, and when you embed
that result in a larger aggregate, you only embed the artifact (not the
signature) and sign the aggregate. With module signatures, the module *and*
their signatures are embedded in the aggregate (e.g. ISO, disk image), which is
where (at least in my case) the friction comes from.

> Plus, you've got to remember that a signature is a cryptographic
> function of the hash over the build minus the signature.  You can't
> verify a signature unless you know how to get the build minus the
> signature.  So the process is required to be deterministic.

Right: there is no friction validating the module signatures, that is fine.
There is friction validating the aggregate artifact (e.g. ISO, disk image),
though, because of those signatures embedded into it.

As you mentioned earlier, of course this is *possible* to do (for example by
adding the signatures as inputs to the second 'independent' build or by
creating a hard-to-validate 'check recipe' running the build in reverse).
Still, checking modules at run time by hash instead of by signature would be a
much simpler option for such scenario's.

> > > All current secure build processes (hermetic builds, SLSA and the
> > > like) are requiring output provenance (i.e. signed artifacts).  If
> > > you try to stand like Canute against this tide saying "no signed
> > > builds", you're simply opposing progress for the sake of it
> > 
> > I don't think anyone is saying 'no signed builds', but we'd enjoy
> > being able to keep the signatures as detached metadata instead of
> > having to embed them into the 'actual' artifacts.
> 
> We had this debate about 15 years ago when Debian first started
> reproducible builds for the kernel.  Their initial approach was
> detached module signatures.  This was the original patch set:
> 
> https://lore.kernel.org/linux-modules/20160405001611.GJ21187@decadent.org.uk/
> 
> And this is the reason why Debian abandoned it:
> 
> https://lists.debian.org/debian-kernel/2016/05/msg00384.html

That is interesting history, thanks for digging that up. Of the 2 problems Ben
mentions running into there, '1' does not seem universal (I think this feature
is indeed mainly interesting for systems where you don't _want_ anyone to be
able to load locally-built modules), and '2' is a problem that detached
signatures have but module hashes don't have.

> The specific problem is why detached signatures are almost always a
> problem: after a period of time, particularly if the process for
> creating updated artifacts gets repeated often matching the output to
> the right signature becomes increasingly error prone.

I haven't experienced that issue with the module hashes yet.

> Debian was, however, kind enough to attach what they currently do to
> get reproducible builds to the kernel documentation:
> 
> https://docs.kernel.org/kbuild/reproducible-builds.html

Cool, I was aware of that page but didn't know it was initially contributed by
Debian.

> However, if you want to detach the module signatures for packaging, so
> the modules can go in a reproducible section and the signatures
> elsewhere, then I think we could accommodate that (the output of the
> build is actually unsigned modules, they just get signed on install).

At least I don't really come to this from the packaging perspective, but from
the "building an independently verifiable ISO/disk image" perspective.
Separating the modules and the signatures into separate packages doesn't help
me there, since they'd still both need to be present on the image.


Kind regards,

-- 
Arnout Engelen
Engelen Open Source
https://engelen.eu

