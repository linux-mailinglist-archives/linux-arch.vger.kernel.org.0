Return-Path: <linux-arch+bounces-634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED6F80350C
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 14:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6909A280FB0
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B9250ED;
	Mon,  4 Dec 2023 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IZGCjp5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvYgSbRf"
X-Original-To: linux-arch@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92EDF;
	Mon,  4 Dec 2023 05:36:17 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 1EABB5809B6;
	Mon,  4 Dec 2023 08:36:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 08:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701696977; x=1701704177; bh=p7D+Xo7sPEhZfUDgxFaHhcvI5/bJ/iLJpT6
	NsvxsYAY=; b=IZGCjp5+KhZHYP9OKsgoOTX1yVwwhMfz0Ru/FpC/dhIWHyccv21
	xA0VVCYUSMQc5j97Gl/y2//YuV9ukG8cOnYnyyfOO/XyQ0EWdKuJ2/OikOCxLeUT
	CFf3WiSdjNC+QvBWRD+9JUw/xMDNVhG9CxceOnEpzPCCi7L6XxHT3DSsfFOLLGAS
	Z+SzyaITptKsIY+avthMJbnND3lS99R+CmmAIgvP2vfdZ1CzSyWaohyx3BERlL1q
	54/vE725FufSZ6+ZLnLJcfnanLvaV224Zw2z5MpD5wKQAL5sbrjeY+BVGFXn/zTd
	OEoUpQzMIREsaNiGt2rlVJUeN1Dx+mwhNaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701696977; x=1701704177; bh=p7D+Xo7sPEhZfUDgxFaHhcvI5/bJ/iLJpT6
	NsvxsYAY=; b=UvYgSbRfNSyVnc26zENUs39xAWEyRCnlO9+zMXCzIYBQJ/hkiJ9
	hjzl4n3E6oiF/tbMteud8wxzDaP/z7gapO233sMAROkhmlPSoNIDsQN69HAUFUXM
	r+d1IfDGbljeGLX0cvRrV0H3JnU1ji6dr8HkyDppTo82iqkJ0l7Q2N++36AIDvxN
	je8iG+9ehO8KDvrs6ZPwHaai8zeyR1yD9Gq0rR1NPqfb6Ex461GCdmhj/iTLurdw
	jE68mZqXTYnepCof2kGvMoDLJhirYglTiUc9LNqwKD2JlSlpialeF2FhmXaLx8HY
	oCCzcuIvlGYeS1PEmFkCfy05/U+dT4CUjSA==
X-ME-Sender: <xms:z9VtZQfirqF0BYj9BKCVd3PrUlw1DQu1Dqi5twx6J-wB9aFxaoXjlA>
    <xme:z9VtZSOj8q5qsj1eeYeAhWpALGtcnKupgPwlblhMsELbHFIp003bp5EskuBfpkyvK
    o-jkWGswG18787eNC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:z9VtZRhAhTEk4JVJMD3hEyszHXVjeKNeo_VcmNjhtmaPtLUucxEp_w>
    <xmx:z9VtZV9GVfh7x_cvFFj6_9Po413Qhkwgz6cgodOTqKmDTJdTYT48fw>
    <xmx:z9VtZcsUYNccizBRD4fwF3Y9xoHrZSeu8c4hmzBHscluk2bC8fRiZw>
    <xmx:0dVtZZvgLsdcjOnykmLqVZFDB5FLcE5rnMnEcbgmqLKpA4GhhWlxPw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7849CB60089; Mon,  4 Dec 2023 08:36:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d20acea3-34fe-4c36-bfe2-323ece39db66@app.fastmail.com>
In-Reply-To: <20231204123834.29247-2-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
 <20231204123834.29247-2-pstanner@redhat.com>
Date: Mon, 04 Dec 2023 14:35:55 +0100
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
Subject: Re: [PATCH v3 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023, at 13:38, Philipp Stanner wrote:
> pci_iounmap() in lib/pci_iomap.c is supposed to check whether an addre=
ss
> is within ioport-range IF the config specifies that ioports exist. If
> so, the port should be unmapped with ioport_unmap(). If not, it's a
> generic MMIO address that has to be passed to iounmap().
>
> The bugs are:
>   1. ioport_unmap() is missing entirely, so this function will never
>      actually unmap a port.
>   2. the #ifdef for the ioport-ranges accidentally also guards
>      iounmap(), potentially compiling an empty function. This would
>      cause the mapping to be leaked.
>
> Implement the missing call to ioport_unmap().
>
> Move the guard so that iounmap() will always be part of the function.
>
> CC: <stable@vger.kernel.org> # v5.15+
> Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make=20
> sense of it all")
> Reported-by: Danilo Krummrich <dakr@redhat.com>
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> In case someone wants to look into that and provide patches for kernels
> older than v5.15:
> Note that this patch only applies to v5.15+ =E2=80=93 the leaks, howev=
er, are
> older. I went through the log briefly and it seems f5810e5c32923 alrea=
dy
> contains them in asm-generic/io.h.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

