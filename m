Return-Path: <linux-arch+bounces-607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF2801596
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 22:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00A281CA4
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448959B5E;
	Fri,  1 Dec 2023 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ha+WtJNw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uaCCuLPf"
X-Original-To: linux-arch@vger.kernel.org
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 13:40:49 PST
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD16310DB;
	Fri,  1 Dec 2023 13:40:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 8F0AC2B003FF;
	Fri,  1 Dec 2023 16:32:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 16:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701466364; x=1701473564; bh=EJcI3n/uJ+tyVR7t2YzAuKRIYKbllJExxoU
	8CSyelqs=; b=Ha+WtJNw/9/yBPf+qCDeJsxi4wbEdXtVXTJwPIVr7hphlE1Cseh
	CxUTAcflSnUBVVQl3GPxui2/JbjbcscQKbVvGpA/snPzqB3KJs/DGG9mMjrBNDpQ
	QuuJeXKO6vOuDNzYSfoXH8Or7zdaOK1QK2LZMLCZC1yjnXqPe4UJsSvFNeQy/SGI
	MDWgVQIJtZkcfoE95VHugnfnWawCffXYSUHbDnqoYuKG2USxIuRfekh0lZxcjfWo
	uttyshfytiOJIFjmTxw5RJDPAjueGBPIG089jGy6W4rnP2vR2rqCEVagYkDNBQ2d
	t2R1Yy101W8RfGoFOB/1xYs5hYJNriTPCQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701466364; x=1701473564; bh=EJcI3n/uJ+tyVR7t2YzAuKRIYKbllJExxoU
	8CSyelqs=; b=uaCCuLPfAVLn5GQiRkbAngaCzzUFPmJX87puR5QOry5DRRke/CQ
	gsaZO1F1zRsAZd36tBxh90CZnCoQWqmAtcigmOqjhuTxXqAVD2QH/tPt3rASpIqh
	eYaDHj9vf1W2cUKkLCJhE0d6nKnJcyMYneRaj2gTr6n4eP425IV/xnS6y1NG8YHM
	QMVAXjAFKc8wCmvWkfJdI9HH6ff8lSdgq2LbvbHyfoL5VyhzrSCoV7BymzZXzgvD
	DK5uPrOYWUfGMepESDIS4F/zNdd38tsm02FbzUiIXZ49uydjq9qo2BNejeid6Pwc
	AsgXFtJEfcSL2xJ9r8X1ojcEGrxpekcJdTA==
X-ME-Sender: <xms:-1BqZfcgDWSLq9eHpXr0jgW21vTOuypcyZ9rDdQkL3bamSLfSmHrDQ>
    <xme:-1BqZVMP30L2wHwUEB8m9h_z3k_fVo3ST1rIexLctYvLug9qJl6mmkOI9jQaJrNO2
    LAOop80933raiou4rY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-1BqZYhwovKRLdns9H0BhF7vgHFVWMvRv71PT2gDJISqiwd2ZRpfaQ>
    <xmx:-1BqZQ-GhzIyXBGmfvZ_03aatO-NdZVKlLQMMmOKzQYF5-_fAHw7Wg>
    <xmx:-1BqZbtSPRquHUqCKwPcI_t3DUrPG_fkgceN1k3wJ67g4gTmsMEgXg>
    <xmx:_FBqZbcC0Weo24M59vBMuH6ScicJ1NrZCeQWhiCwHMYmgnu5GDQMtXZXYxc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EC766B60089; Fri,  1 Dec 2023 16:32:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <330df2f8-3796-4f74-8856-06ae1e46ec9b@app.fastmail.com>
In-Reply-To: <b54e5d57624dae0b045d8ff129ac2a41f72e182d.camel@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-5-pstanner@redhat.com>
 <619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fastmail.com>
 <b54e5d57624dae0b045d8ff129ac2a41f72e182d.camel@redhat.com>
Date: Fri, 01 Dec 2023 22:32:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>, "Neil Brown" <neilb@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "John Sanpe" <sanpeqf@gmail.com>,
 "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Jason Baron" <jbaron@akamai.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023, at 20:37, Philipp Stanner wrote:
> On Fri, 2023-12-01 at 16:26 +0100, Arnd Bergmann wrote:
>>=20
>> static inline bool struct iomem_is_ioport(void __iomem *p)
>> {
>> #ifdef CONFIG_HAS_IOPORT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t start =3D (uintp=
tr_t) PCI_IOBASE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t addr =3D (uintpt=
r_t) p;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (addr >=3D start && add=
r < start + IO_SPACE_LIMIT)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return true;
>> #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> }
>>=20
>> > +#else /* CONFIG_GENERIC_IOMAP. Version from lib/iomap.c will be
>> > used.=20
>> > */
>> > +bool iomem_is_ioport(void __iomem *addr);
>> > +#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
>>=20
>> I'm not sure what this macro is for, since it appears to
>> do the opposite of what its name suggests: rather than
>> provide the generic version of iomem_is_ioport(), it
>> skips that and provides a custom one to go with lib/iomap.c
>
> Hmmm well now it's getting tricky.
>
> This else-branch is the one where CONFIG_GENERIC_IOMAP is actually set.
>
> I think we're running into the "generic not being generic now that IA64
> has died" problem you were hinting at.
>
> If we build for x86 and have CONFIG_GENERIC set, only then do we want
> iomem_is_ioport() from lib/iomap.c. So the macro serves avoiding a
> collision between symbols. Because lib/iomap.c might be compiled even
> if someone else already has defined iomem_is_ioport().
> I also don't like it, but it was the least bad solution I could come up
> with
> Suggestions?

The best I can think of is to move the lib/iomap.c version
of iomem_is_ioport() to include/asm-generic/iomap.h with
an #ifndef iomem_is_ioport / #define iomem_is_ioport
check around it. This file is only included on parisc, alpha,
sh and when CONFIG_GENERIC_IOMAP is set.

The default version in asm-generic/io.h then just needs
one more #ifdef iomem_is_ioport check around it.

      Arnd

