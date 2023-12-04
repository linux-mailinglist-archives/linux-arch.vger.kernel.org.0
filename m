Return-Path: <linux-arch+bounces-640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4018036A6
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 15:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCD2281028
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD728DC3;
	Mon,  4 Dec 2023 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Lj4ikQMV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQufUQL0"
X-Original-To: linux-arch@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA34186;
	Mon,  4 Dec 2023 06:29:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id C86B9580948;
	Mon,  4 Dec 2023 09:29:30 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 09:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701700170; x=1701707370; bh=82
	6yxGHLvKOrBxd7Hd1e9g5EjsLv6zmYuM80wh46KKE=; b=Lj4ikQMVRMBDHagNlC
	YQgSteBDqhRnfrm9Ku5aNywOXhuxNsGpUO4m/FGo3vtgsjEa32I6R17NJRI86sZ5
	TAjD8dPSR3MgK7OFOvOIbii1I8ReyreBT/6qlji0tM780e3jtGv0H/LihldZ4ZSQ
	0sb7ZTAfPUJc3WI+E7J59sT4w4rARxKE65A+4F9zD0vVJZRw28uy/ZfyPY/gh8fC
	rnWbAKLcbjoNismGWm+8p5asoD7lOJka+6GDKrDiS01EbTEc3QDkI+OB2xEv9RQl
	rjIvpFX6MM+IlE5EfDr47OQvpOyk0aZ39O4PuUlfAQoAve7fxD6OOVLhxI2uk/za
	ATaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701700170; x=1701707370; bh=826yxGHLvKOrB
	xd7Hd1e9g5EjsLv6zmYuM80wh46KKE=; b=JQufUQL0mUFBQJBOptInpLuw3oJFa
	33wfnoqHFWL41QNU8kPtG7B9OPz5rgEqTlRC2MxQJqu4xEH5HHjfM64DFzhS/Z0V
	hpY0znEyMQPMg+WWP+B6MreZ5A5V9G2RH2P1uj4MKwpfk2k9jocjCXTVbBhdS1ow
	Ue4x6f3ilk0N0JZP+JEHSmZM0WM3njLSSjgpr8aO8VgMuqj/ecnIarz08VsR087t
	cm4uGSri2sMmasOw7Gcd5G1pvW60nZMOkb4Im33h7ApY8yCKM8uRrVYNgs4eFm/w
	bglpTSdi1eTY2wwfuaWGSz7UzkuTb9b+bVwh/Dt3izR1rJcBXDf9q098Q==
X-ME-Sender: <xms:SeJtZWg6svZDBbVud1Ua0JwM4qA_gnIEnzRtd4C1twiFyVg3-s4Fkg>
    <xme:SeJtZXBqMnrNcqUtOx8TBmCSlsG5n_qE2xjDtE_QZmJdtUddB3q3D5dREAiiCCiF-
    2HPnXqvlIUZNaMOWJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SeJtZeFJuIk9O1oUscNi2M8kr2BynAlOMK3WmaI_D2X3eLcd7bHGrg>
    <xmx:SeJtZfQGJ7ToaiFdj7uOnVLZje6IuNYP3CEWOXXiwsUa55gbgNWUBA>
    <xmx:SeJtZTzyEALPBz_I5AwxT21KGFBDYvbDsTSAGJW5_xcBrX1hG3Awug>
    <xmx:SuJtZWhSLXKyVW4AWBKN1mYB561Sxzjgxx52cE5IuCk5Pyog1TFfVw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47AEAB60089; Mon,  4 Dec 2023 09:29:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d6918ac-a310-45d2-b5fe-c70595918b80@app.fastmail.com>
In-Reply-To: <e5d53e44709f7da1ba4b8f8a4687efcffdd6addb.camel@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
 <20231204123834.29247-6-pstanner@redhat.com>
 <2648aef32cd5a2272cd3ce8cd7ed5b29b2d21cad.camel@redhat.com>
 <05173886-444c-4bae-b1a5-d2b068e9c4a5@app.fastmail.com>
 <e5d53e44709f7da1ba4b8f8a4687efcffdd6addb.camel@redhat.com>
Date: Mon, 04 Dec 2023 15:29:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <pstanner@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Hanjun Guo" <guohanjun@huawei.com>,
 "Neil Brown" <neilb@suse.de>, "Kent Overstreet" <kent.overstreet@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Uladzislau Koshchanka" <koshchanka@gmail.com>,
 "John Sanpe" <sanpeqf@gmail.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "David Gow" <davidgow@google.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>, "Danilo Krummrich" <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, stable@vger.kernel.org,
 "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain

On Mon, Dec 4, 2023, at 15:09, Philipp Stanner wrote:
> On Mon, 2023-12-04 at 14:50 +0100, Arnd Bergmann wrote:
>> On Mon, Dec 4, 2023, at 14:39, Philipp Stanner wrote:
>> > On Mon, 2023-12-04 at 13:38 +0100, Philipp Stanner wrote:
>
> Ok, makes sense.
>
> But should we then adjust iomem_is_ioport() in asm-generic/io.h, as
> well, so that it matches IO_COND()'s behavior?
>
> It currently does this:
>
> 	uintptr_t start = (uintptr_t)PCI_IOBASE;
> 	uintptr_t addr = (uintptr_t)addr_raw;
>
> 	if (addr >= start && addr < start + IO_SPACE_LIMIT)
> 		return true;
>
> and if the architecture does not set PCI_IOBASE, then it's set per
> default to 0, as well.
>
> So we have two inconsistent definitons

No, I would also keep the logic here, since it makes more sense
and the inconsistency is only for the corner case that doesn't
hit in practice.

The PCI_IOBASE==0 case should never happen here, as that doesn't
work with the generic inb(). I think the only target left that
has I/O ports but doesn't set PCI_IOBASE at all is sparc, but
that is special in a number of ways. 

     Arnd

