Return-Path: <linux-arch+bounces-638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3C803590
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092BD28101A
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F82511A;
	Mon,  4 Dec 2023 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DeguT/wr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMqsGnY/"
X-Original-To: linux-arch@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F090;
	Mon,  4 Dec 2023 05:53:56 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 62C805809CB;
	Mon,  4 Dec 2023 08:53:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 08:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701698035; x=1701705235; bh=Cl
	4o1FU4NGqJM5T9UpnZFt1yxCty62LHdz2C3rL1jgU=; b=DeguT/wrfrIyi2gOFg
	+UKkbYLPEVKcpJo6S6ZSrUgxaK9qlFLEPJxXgN0EpI09QYhmowtWba0WCm8Ky3/Q
	7DXrSR9d7U1XTjPMTvGPWYnAGehs+EHl6TtESHET38j0xvuzU5b3FUX1d8dqjiUJ
	r/KdBItet01TpaKzCnS82ZLJmAWERJXkZ0tqAzS3J8IB6GupAzmjUAkIZKLPhcbd
	pVSdMUhO0eHLax9YAlLfoKwMpLNR1GTWKlascOJwqP6dzYQKtLu4CiGjKjjNYjeo
	KyKbrrG5OGPQYLZ1qK/b2THx945DhH3AmtfHH1IEUn5IT/VF35I8lfn6vcNhF/Sd
	Nh5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701698035; x=1701705235; bh=Cl4o1FU4NGqJM
	5T9UpnZFt1yxCty62LHdz2C3rL1jgU=; b=lMqsGnY/xBg8KEro3ysGpxsSGEv2y
	4FZpQvBFaLTIS/ZU5BeHFo0xlzkJSz+6NFr+JAaEbYfHiryJPA35Obg9o+SRR8qC
	u+7rriapGR3vmC1o0YbLNSCeKZecQu0b7GlLmSW3YLDPTLqzpklBEi1dCL0eToS+
	gAoyefrnXk7pva8qmy0smTgTgeob4fF85QVINccq/OJCyQGlOUIqoWyXi4o6m4+4
	yuIPU8hnr3ia2i9az4ktoguuWHIimDYNUKsSCP0UDUUE3kW+ITpnU3U5Dpg+SDLm
	evfAtd0odQhdD9twMmjNT+5bYJrty+xwvKxrc3v+2zsiy1AOs7/fsSKAw==
X-ME-Sender: <xms:89ltZcU-c51ZN3jIdvpHVp446j6YAZrWQ68eEWtbOj9M85PeptmvEQ>
    <xme:89ltZQnUCJA0dR1SEVrlHdxL3Y3SnkGlEysR0EPsrie0GxOF3G87bikIOdbMenYgv
    XhgKJzL9T1YwG9ouiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:89ltZQa27n8y-v-xvIeFzWHqCHxPubpn1212ESzsRY9qSxO6rJd7xA>
    <xmx:89ltZbVQmDbN1OeMHWJZmryhXVVdmw8nG4IG6FK2KnxFRd21yM912Q>
    <xmx:89ltZWm_fLBfZmwgZn3LQVy_IvyICcbNcW5jl-Wng-3FFaUXccVm7g>
    <xmx:89ltZYF8HbAMhR3CZkRoF5-cM0_q2gMUZ1NYY5g5rwvkE7vNnccxHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0FC68B60089; Mon,  4 Dec 2023 08:53:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a2cc43d6-38ea-4bd8-a828-e836326e8aeb@app.fastmail.com>
In-Reply-To: <20231204123834.29247-6-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
 <20231204123834.29247-6-pstanner@redhat.com>
Date: Mon, 04 Dec 2023 14:53:29 +0100
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

On Mon, Dec 4, 2023, at 13:38, Philipp Stanner wrote:
> The implementation of pci_iounmap() is currently scattered over two
> files, drivers/pci/iomap.c and lib/iomap.c. Additionally,
> architectures can define their own version.
>
> To have only one version, it's necessary to create a helper function,
> iomem_is_ioport(), that tells pci_iounmap() whether the passed address
> points to an ioport or normal memory.
>
> iomem_is_ioport() can be provided through two different ways:
>   1. The architecture itself provides it. As of today, the version
>      coming from lib/iomap.c de facto is the x86-specific version and
>      comes into play when CONFIG_GENERIC_IOMAP is selected. This rather
>      confusing naming is an artifact left by the removal of IA64.
>   2. As a default version in include/asm-generic/io.h for those
>      architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
>      provide their own version of iomem_is_ioport().
>
> Once all architectures that support ports provide iomem_is_ioport(), the
> arch-specific definitions for pci_iounmap() can be removed and the archs
> can use the generic implementation, instead.
>
> Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
> Provide the function iomem_is_ioport() in include/asm-generic/io.h
> (generic) and lib/iomap.c ("pseudo-generic" for x86).
>
> Remove the CONFIG_GENERIC_IOMAP guard around
> ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
> CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
> function.
>
> Add TODOs for follow-up work on the "generic is not generic but
> x86-spcific"-Problem.
>
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

