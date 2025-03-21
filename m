Return-Path: <linux-arch+bounces-11022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82BA6C19B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 18:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1DF7A3D33
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D96D22D7A4;
	Fri, 21 Mar 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DLLkrbjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ui4Dx6rw"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA678F52;
	Fri, 21 Mar 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578426; cv=none; b=l/A27Zqh3lo4dTbMzOCqbYN5XGIM7NFQLcZNGDGx3+3Ez9U0O8VW2pCxI1cAIMXcy+s/vloIgvXaw4rr0WnqC2SsvMgPkX4QkUSfk38z+fosNVp4N2WuG+mj42oJ2aHhyBD8JrDlGBuuaBLJYMAPEMOmIXECriG5KWqxbi3REpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578426; c=relaxed/simple;
	bh=GoduICvSWMNnvmCK1a97gNxQC7pQOAUrZGAEO6pXgYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UUxU4koMJZ7bXdsYbVfBvTk6h+/q5ZrF2g6DS9T4eDeZumoSgx4kuvOIiEc5Mhg/wSZBbotGwminlChDK6U9ZxKpJIJGnm/UQohNVZGgT0E/NnBqzGzb9zeJbFG1EIOUKCvN10h8HSYX4nmet0LxGWHTDCl1Zu3cFgInmD6XJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DLLkrbjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ui4Dx6rw; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id F0255202146;
	Fri, 21 Mar 2025 13:33:42 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 13:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742578422;
	 x=1742585622; bh=jcHwQGpQOx6GZtNDddAxOwDOWSoyBujaJTuqoyGqXDA=; b=
	DLLkrbjxdeZ5VZIGvPAZd4NM/kpOB5yjaRA2bvhlRZZqiAajItla9WOumvbn54t1
	awAa2WdDiftQwM9VUrrdOy2B8L6rbJZP1L2CHyFMjUo2bYV5jiVdUCBJ+txYzcyX
	YfNdALHqJ8vA1g0fKqj/rYooeIPG8pW0+DKZ5pjBDdQ/ov2TUOQvQoS7XX0pmiXf
	E0jtTwHqb2w3VcZDUJJbENArof3r2e/WJIEaKvPw8kCHgD/xH5vt/Oaa41CisOOt
	aLby2QkmaE23J33Sau22v+uw207knEJBvxfygvvXmXMkokkBEsxQ+juulQzszHxF
	prI/sAddxyIp9Iv/S2/Rhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742578422; x=
	1742585622; bh=jcHwQGpQOx6GZtNDddAxOwDOWSoyBujaJTuqoyGqXDA=; b=U
	i4Dx6rw8n6KelCD0qaTj5zmZdQsre1O+uqLIzcbok/RNBBKaWZy4PEX4GXch+Jbj
	lGeF4rm/KmmivV4flBuVWpy9M3ugVKbWVfcXdHTDAu4/CJgKdGaPnkWToVcfc1Hw
	pGV6HAeXLkOX5OanKtfkRnUF8XHkfi0qbIavNs+iHqhH4TTY1MrqulMRfI/e6DwS
	PJXbL6UQXAhfw+r1cX0pjR9yekCg707nyiuGR2GY3F0MLay1n+DxG8jMS6OyEQen
	5c7eHiflpY3UpwHTif8k8jnnl5jgO/iJjoATUB+TYxcGJdukz4ej7g5g44pnW5D5
	wL+dD+0XGM01ti8O6vuyQ==
X-ME-Sender: <xms:9aLdZ1FWQqOziPqqoohR2Ek7ZIBNYbxHCOcRkjf-xbQHxvCD9abBXw>
    <xme:9aLdZ6WibTWFxk_WdQPYzwJQ8ENd3FCvBOXO81gFbAz0-NmJ4fiVzoewL77Jow-f_
    b8Bs0S4SK0muK6g9C8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    feejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvshgtohhokhestghhrh
    homhhiuhhmrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehffhiflhhlrdgthhdprhgt
    phhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvghssh
    grnhgurhhordgtrghrmhhinhgrthhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggr
    vhhiughgohifsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhhnihhtqdguvghvse
    hgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehmtggrnhgrlhesihhgrghl
    ihgrrdgtohhmpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgesihhnthgvlhdrtghomh
    dprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9aLdZ3LWSj3ee0DpgDBVQgR9N6em0f5-W_bT607OLi8J56P-PHjwdg>
    <xmx:9aLdZ7EmgyfsMK79595Ji4fqyaEgzpUx28qERgbScF30VauOkMTTZA>
    <xmx:9aLdZ7VDCg0me11XgjTCMnOtsbEkwp9VdJtw9WRuZpovB9sSdPMWvQ>
    <xmx:9aLdZ2MO9qdvK_ExIyuwHK5jCpMbl8MVknK5QRVW7ddiQcxb6VhGrQ>
    <xmx:9qLdZ7URYi_A7oI0zqTv7Ebk9x9UFrrUdpb50OelwEli-e3q19QxBoz_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F6E52220072; Fri, 21 Mar 2025 13:33:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T46bf3c12e1d9de2d
Date: Fri, 21 Mar 2025 18:33:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guenter Roeck" <linux@roeck-us.net>,
 "Alessandro Carminati" <acarmina@redhat.com>, linux-kselftest@vger.kernel.org
Cc: "Dave Airlie" <airlied@gmail.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Kees Cook" <keescook@chromium.org>,
 =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
 "David Gow" <davidgow@google.com>,
 "Arthur Grillo" <arthurgrillo@riseup.net>,
 "Brendan Higgins" <brendan.higgins@linux.dev>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Maxime Ripard" <mripard@kernel.org>,
 =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 "Daniel Vetter" <daniel@ffwll.ch>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Alessandro Carminati" <alessandro.carminati@gmail.com>,
 "Jani Nikula" <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 "Linaro Kernel Functional Testing" <lkft@linaro.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
Message-Id: <a6f90bdb-8459-4d33-8874-7e724bd22d9f@app.fastmail.com>
In-Reply-To: <b6bb68f0-7e93-4db2-9fe6-f615f06ddeb1@roeck-us.net>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-11-acarmina@redhat.com>
 <b6bb68f0-7e93-4db2-9fe6-f615f06ddeb1@roeck-us.net>
Subject: Re: [PATCH v4 10/14] s390: Add support for suppressing warning backtraces
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 21, 2025, at 18:05, Guenter Roeck wrote:
> On 3/13/25 04:43, Alessandro Carminati wrote:
>
> gcc 10.3.0 and later do not have this problem. I also tried s390 builds 
> with gcc 9.4
> and 9.5 but they both crash for unrelated reasons.
>
> If this is a concern, the best idea I have is to make KUNIT_SUPPRESS_BACKTRACE
> depend on, say,
> 	depends on CC_IS_CLANG || (CC_IS_GCC && GCC_VERSION >= 100300)
>
> A more complex solution might be to define an architecture flag such
> as HAVE_SUPPRESS_BACKTRACE, make that conditional on the gcc version
> for s390 only, and make KUNIT_SUPPRESS_BACKTRACE depend on it.

That is probably fine, there are very few users on s390 that build
their own kernels, and they likely all have modern compilers anyway.

I should still send a patch to raise the minimum compiler version to
gcc-8.1, but unfortunately that is not enough here.

     Arnd

