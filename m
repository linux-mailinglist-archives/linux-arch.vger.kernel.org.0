Return-Path: <linux-arch+bounces-8447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A079AC027
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549A71F23C5A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85C153BF6;
	Wed, 23 Oct 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Goq3eOoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eyZzzl/l"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436314C5AA;
	Wed, 23 Oct 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668328; cv=none; b=pl7aYM6Ti/2gl2MwMQxWNqQ4bals0goCv2YmLK0GOtucnJyAgjihwrFH+U8UAU3lEzX+Tlbb8HZ2+ASJRInt/WDo/DCTT5LqQAfy0vwZ6e/XrYDm8OL9IXZnTD5R9btPp0RsJ6nNW4ZXqlVvHP1+1Ix5VO5iavOsZXoI7D9yA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668328; c=relaxed/simple;
	bh=CbAa2vagO67YCVvaDAv+Hv4K8ncO44lBpM8f25tLOS8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZMapraQO3TiGxtyxhB7k8WumHxLcUwfPH5DZW/I8OkDLH2/VgDSs3O1nED5l7rQHsJ5fpgYD2NRs18sqYAu0pLqUJQwalEacLyNKumK5JXXa+rp4ivcPgdwlVQGUjX/Ctd8QwXUR/QpewBzd0BBtRoUcJ90r+XU+pnM6kQZnH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Goq3eOoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eyZzzl/l; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 17E93200728;
	Wed, 23 Oct 2024 03:25:25 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 03:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729668325;
	 x=1729675525; bh=UXBTfHhT58dFhhPd1qMKKQcM/el+Tg2EbjPqxKpvK8U=; b=
	Goq3eOohqsW/kZQORblb6qyxVmvEw4Jbd4WJad6BWDzTf2/LyhDlNZJlPbpkoLy3
	MqmEFytyEUicHJFgEOA8cflB8l09RieuBW6J9/lAyezH8qDu3di0Tf+gnQb9/uxm
	MpY/edl0ZlyEX8u/LDPp/Cc65A+uPttH05+eRXIxzPG1CmOK+qkOltNSdR7kBTJF
	e6nWiXBw02fF1KxnB9QRQpFT4wPtWfigAu548ZGtOqxbkwon4y0oTPJRjJ0dYG29
	Mp3nQ77GEumHIwMuHPD0hwgC4JrEn0Lu9pcZw3LSGm4ognfPHdLdlns837AfK2wK
	XNrzBBwA3Gti57sJrIhj1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729668325; x=
	1729675525; bh=UXBTfHhT58dFhhPd1qMKKQcM/el+Tg2EbjPqxKpvK8U=; b=e
	yZzzl/l11E5vRdvi9t1ucTA7tyrZaEQiLosL/UpAQOhIcnC7VctutqKFRKjV6ymJ
	vd3VnEvFMKHuJ5Du9FaNY6I6Vlfp6aXuEcQql8b1csla1NEvJaYmKZLI3/4tdS8U
	pZW61ClciO6XKLFpKB6paFCB320C+YmUlP8kvZYy9tcK6M8hAfZ5U2QMBYEH+Lbu
	zXTUhnzldTxghofSoc2fg1gTR4gwK7uZMrtzBTmnVXQy5XIw3yFqJRzNhGanMAXB
	2FDsESTrY6uhvoHNrdASDV1mmT2EzgEm8WlbpYQQwBq/mKjc+vajqkafAt2Uk5XE
	1ZkseLLk7PCSJsYcjNtJg==
X-ME-Sender: <xms:46QYZ2TFQjE8QUjhfxKQdHueaLO-DVeszrUW9AjK5DlSDgzdYzEGVw>
    <xme:46QYZ7z_6-4mpb0mSiMljX2B_oZkTYxc-CToj7J-Kky-cabba4CftkwTC9Sru52Nf
    NU0ZMJCmYnQoQLpt3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeiiedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeg
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehnihgt
    ohhlrghssehfjhgrshhlvgdrvghupdhrtghpthhtohepsghrghgvrhhsthesghhmrghilh
    drtghomhdprhgtphhtthhopehmrgiggegsohhlthesghhmrghilhdrtghomhdprhgtphht
    thhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprhhitghhrghrugdrfigvihihrghnghesghhmrghilhdrtghomhdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurg
    hvihgugihlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:46QYZz0j74K4R6dn18nzl_RnC-RHtDV37T06Wc9F6U5Qs6vatt7ZnQ>
    <xmx:46QYZyA7mkATYeCdBw-u5rK6JC0aRZA934G_8lcPZwc6gYOjBlIJUg>
    <xmx:46QYZ_iwjZCb9oY0EiTOTotlY2EnPuJsLXqAGHb0-aPtGqw5-E7mzw>
    <xmx:46QYZ-rF2Y7JntM5w_ge9rHa9f0kmvP0Lowarkj5Zk85nS-Ee6yfBQ>
    <xmx:5aQYZwUPfEJEdK4Cam0AQUO8ei2rCTg1Sn5T-RfYMQ60VyGHrCUKxiP1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CAD552220071; Wed, 23 Oct 2024 03:25:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 07:25:03 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>, "Rong Xu" <xur@google.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Bill Wendling" <morbo@google.com>, "Borislav Petkov" <bp@alien8.de>,
 "Breno Leitao" <leitao@debian.org>, "Brian Gerst" <brgerst@gmail.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Li" <davidxl@google.com>, "Han Shen" <shenhan@google.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Juergen Gross" <jgross@suse.com>,
 "Justin Stitt" <justinstitt@google.com>, "Kees Cook" <kees@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Wei Yang" <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Maksim Panchenko" <max4bolt@gmail.com>, x86@kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, "Sriraman Tallam" <tmsriram@google.com>,
 "Krzysztof Pszeniczny" <kpszeniczny@google.com>,
 "Stephane Eranian" <eranian@google.com>
Message-Id: <a38a883e-d887-4d79-bb52-f28f5efc99a8@app.fastmail.com>
In-Reply-To: 
 <CAK7LNAQr_EusZyy-dPcV=5o9UckStaUfXLSCQh7APbYh15NC3w@mail.gmail.com>
References: <20241014213342.1480681-1-xur@google.com>
 <20241014213342.1480681-7-xur@google.com>
 <CAK7LNARfm7HBx-wLCak1w0sfH7LML1ErWO=2sLj4ovR38RsnTA@mail.gmail.com>
 <CAF1bQ=Qi9hyKbc5H3N36W=MukT3321rZMCas0ndpRf0YszAfOA@mail.gmail.com>
 <CAK7LNAQr_EusZyy-dPcV=5o9UckStaUfXLSCQh7APbYh15NC3w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Add Propeller configuration for kernel build.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, at 07:06, Masahiro Yamada wrote:
> On Tue, Oct 22, 2024 at 9:00=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
>> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > +
>> > > +Configure the kernel with::
>> > > +
>> > > +   CONFIG_AUTOFDO_CLANG=3Dy
>> >
>> >
>> > This is automatically met due to "depends on AUTOFDO_CLANG".
>>
>> Agreed. But we will remove the dependency from PROPELlER_CLANG to AUT=
OFDO_CLANG.
>> So we will keep the part.
>
>
> You can replace "depends on AUTOFDO_CLANG" with
> "imply AUTOFDO_CLANG" if it is sensible.
>
> Up to you.

I don't think we should ever encourage the use of 'imply'
because it is almost always used incorrectly.

       Arnd

