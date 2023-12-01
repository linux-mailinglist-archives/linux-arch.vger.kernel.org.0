Return-Path: <linux-arch+bounces-610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4C80162C
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 23:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABC11C2031F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBEE619A2;
	Fri,  1 Dec 2023 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wn853AVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fx99YuvU"
X-Original-To: linux-arch@vger.kernel.org
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2D128;
	Fri,  1 Dec 2023 14:17:44 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id C2DAA2B00432;
	Fri,  1 Dec 2023 17:17:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 17:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701469061; x=1701476261; bh=EI
	RXyofmqrPd13/Ro55ULfkGqrMFOWjZCVCRuGyg6nE=; b=wn853AVu8W0Tfbo+jk
	1Wf8qs5cSXge4s3U1fwiNaqVoS/OyuETR65p9vOJ7wSizzTgibqq89TwBCuL7ZKo
	WwIAh7RzCCD7qB98W2cReZCigQaChczVIPXpXFOM6i+5NJi8U1DQOm7UsaiM/xvu
	Nd6/fN8Tb6ctqkGsXPyCdWSuASzLVAjlEGQolpb8DY03ougAuBSYOVRnGD7wPoNF
	PZlBZLIHri9uhXACmHbs/w6P90hvgYTL0SkKksJaLKGSsN6KII5d9T3bUgfJDzUw
	WnyCGa9ByvxnMB8/N/mEPehfjwjOYFnuDWnu0OBDhEPz+komEgwSgXkpGqE8gTKU
	R/ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701469061; x=1701476261; bh=EIRXyofmqrPd1
	3/Ro55ULfkGqrMFOWjZCVCRuGyg6nE=; b=Fx99YuvUsl3WHkepXVbxkX+JvY82g
	afBWGFEfL4ZhqjVvOErM/ShCsUw2K5NvWGbW9Mq+zBCem+aiuqKUhixiW4T6eZfn
	w1egZtJC3YPjy4giXM/FNm3m3MZFTvfI8ze6SrvhCqHjJIPUpUVDdrQ79NGZWWai
	Rnvv4AVlczDYwM+5YNSSshukDQIqaT6pmtGkTFoC2yd/muXmwx33Aqr+XZYaBYwT
	HZhSrubowpw9AXQDRZNsPUxj2VQnFh7rO6oaHWZUJNBXpOnPsXSvYacaVa6FWmuw
	HL/W9MTPPwGLJfSj/qHM5Zd1F8vYjt5+dGBITQ0JalJ7xnOC0970yEuOg==
X-ME-Sender: <xms:g1tqZWZ1E5IwmGCUjTdHTBfNPrJ6RiVYeoaCXAM3V3KtL5EcKNoRyA>
    <xme:g1tqZZa8wKMvlHCFTAMtMYL3v8EcfIl_3CZWkDU2MRQmtAK_hlmAfu8vnWoxG71oZ
    QeCeLYIBRVqZ7RzSJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:g1tqZQ9oJ8gxaAQtYkqHWCtNmoL6bt6Ksyh8wg3A-q_lJsqdD8j-Bg>
    <xmx:g1tqZYo0_NSVBCicyo9EhtFB4mDGvGsYCTOXTgLY3VuU_DwJAEp8NA>
    <xmx:g1tqZRofEp7Awm1fiLAHFSeB8aC8a0GZfGYLPPlQJ5Ocobckms7yFw>
    <xmx:hVtqZVBa_pJo1VkhWuwiRPUlCSqj7tSfZKgfPnb9C2m3voQO6ZNoAMWfvZA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C65D5B6008D; Fri,  1 Dec 2023 17:17:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ce4e2af-efe9-4049-8b56-60de4a1e942a@app.fastmail.com>
In-Reply-To: <65079f6d5f512f9aff003bdfea127b214a9f9290.camel@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <3871b83a-0e80-402e-bbe6-359c17127842@app.fastmail.com>
 <65079f6d5f512f9aff003bdfea127b214a9f9290.camel@redhat.com>
Date: Fri, 01 Dec 2023 23:17:19 +0100
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
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Regather scattered PCI-Code
Content-Type: text/plain

On Fri, Dec 1, 2023, at 20:09, Philipp Stanner wrote:
> On Fri, 2023-12-01 at 17:27 +0100, Arnd Bergmann wrote:
>> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
>> 
>> The one special case that I missed the last time is s390, which
>> does not use GENERIC_PCI_IOMAP and will just require a separate
>> copy of pci_iounmap() to go along with the is custom pci_iomap().
>> 
>> > The two exceptions are x86 and m68k. The former uses lib/iomap.c
>> > through
>> > CONFIG_GENERIC_IOMAP, as Arnd pointed out in the previous
>> > discussion
>> > (thus, CONFIG_GENERIC_IOMAP is not really generic in this regard).
>> > 
>> > So as I see it, only m68k WOULD need its own custom definition of
>> > iomem_is_ioport(). But as I understand it it doesn't because it
>> > uses the
>> > one from asm-generic/pci_iomap.h ??
>> 
>> At the moment, m68k gets the pci_iounmap() from lib/iomap.c
>> if PCI is enabled for coldfire, but that incorrectly calls
>> iounmap() on PCI_IO_PA if it gets passed a PIO address.
>> 
>> The version from asm-generic/io.h should fix this.
>
> So, to be sure: m68k will use the generic iomem_is_ioport() despite
> defining its own inb()?

It depends, as m68k has two separate asm/io.h implementations:

- arch/m68k/include/asm/io_no.h uses the default inb()
  from asm-generic/io.h, so it should use the asm-generic
  version of iomem_is_ioport().

- arch/m68k/include/asm/io_mm.h is rather special when
  it comes to inb()/outb(), but since there is no PCI,
  I would just use the default iomem_is_ioport() because
  it doesn't matter as long as there are no callers.
  If we ever need a working iomem_is_ioport() here, it would
  need the same special cases as isa_itb().
  
>> The "#define pci_iomap" can be removed entirely I think.
>
> I also think it can, because first arch/asm/io.h includes asm-
> generic/io.h.
> I was just wondering why many other functions in asm-generic/io.h
> always define their own names..
>
> It's obviously very hard to test which config will break, so I thought
> it's better safe than sorry here

I'm fairly sure it's not actually needed, but since the entire file
does it, there is probably no harm keeping it consistent for the next
added function.

This is one more thing to maybe clean up eventually in the future,
possibly as part of moving the contents of asm-generic/io.h into
linux/io.h, which is something I'd like to do now that all
architectures finally started using the asm-generic version.

      Arnd

