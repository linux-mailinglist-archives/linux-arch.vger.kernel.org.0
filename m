Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E04F5FFEFF
	for <lists+linux-arch@lfdr.de>; Sun, 16 Oct 2022 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJPLw0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Oct 2022 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJPLwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2022 07:52:25 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522603A4B3;
        Sun, 16 Oct 2022 04:52:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 404C0320031A;
        Sun, 16 Oct 2022 07:52:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 16 Oct 2022 07:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665921138; x=1666007538; bh=3j8ISkoR6c
        dwfWmQo4rJN/bj92WrzimiU8KQFUYoUF0=; b=BwiqToW3oTdY5zXr35/AZUAY86
        Rwm1kHuwPS3CtxuwCPPV10aM+fZSs+Wm1T8C7x6OoJCJlnlBGyiz1oZ11AGE+p0D
        AO71Sdg9wdEAc4YbWVzw3PlNjC2iIzRMoqDwPhkMHee/Be30DQciPSU490SwroEH
        S1XhXZTmzaffK/+IOlGEEcxhqVs6eaHiOzeeFxziHSAbeN3LSoz4xLdjjCRQhBkf
        QP9T+bhdlvm/oj5xAYoIr4vPGBg2hVNNQIH2P3cmYW+yN8+jbACLeTWXB/3HjpjD
        D2Mm9qm4DdtO2W/2pUotuISFbrk6gSUeu6E6Q1vc8iqGPOH1nM7NNmzgKyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665921138; x=1666007538; bh=3j8ISkoR6cdwfWmQo4rJN/bj92Wr
        zimiU8KQFUYoUF0=; b=dCq2XjpLGT/z2XwOBjLsH8c0uzJQ0IJen9keOEt6Yct1
        593a4qk+PDeJnCF7kOWoHla2MAOjwltIASuFOOqJYl9tRPrJ6HiPI8ToRphpjEel
        DJ8s4bBZ/3hZu30HAoytUYaHbBKy1lpwRY/oT1n65DIJdUjx6OI1B+MimKBaJP9j
        TX16kxUzDtXAj5pjUVHm77NJxWvIxbt/8VDmbFpzAacohdCYb8PzKnFSyHsLJJiY
        KZQHEGPh8/3wQ18o9UE4XZ2GWWwjHGZP9dL/sISOllvtK573zFdpqgsw5XcjifdC
        caL6JOctDn3qyHvOQYsW2BpgNrR3AjZp8ILYym/h6Q==
X-ME-Sender: <xms:cfBLY2fFXagqwKbxO7EYGXIAcmuFF6xzzcaLpDAKi20vM09p5llUmw>
    <xme:cfBLYwOzMYTsrHCBANQGJUE78V0QYZ4m7UwSebf1akXk5RKtZ-16_si-0tlrX5GLD
    cRx9j-akYjc3ASWFSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekjedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cfBLY3hCIoiajHCnRgcA0Q3XsEIgYMXrSj3-OKTXuBsMDEJPBkJ9Dw>
    <xmx:cfBLYz-J0VmRW__6uOKpAf9GEdRSzdMPRdNIvsMRunrajNM9CxcgtQ>
    <xmx:cfBLYyvO3eNW7CbIom4HpOxrfLVJKk0jq4SrHl7HMs6I5fKQ5hcDaA>
    <xmx:cvBLYzlB0LKq4VRHgOpDDXmNTOmYY4Me5JmQowNziVzRv_QT0XUwhg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77C46B60086; Sun, 16 Oct 2022 07:52:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <af8ba7b8-5198-42a1-84c7-9b7d7892ceb3@app.fastmail.com>
In-Reply-To: <Y0u4tN+mIgNSWwdi@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
 <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
 <Y0u4tN+mIgNSWwdi@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Date:   Sun, 16 Oct 2022 13:51:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Baoquan He" <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        "David Laight" <David.Laight@aculab.com>,
        "Stafford Horne" <shorne@gmail.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic ioremap
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 16, 2022, at 9:54 AM, Alexander Gordeev wrote:
> On Wed, Oct 12, 2022 at 12:39:11PM +0200, Arnd Bergmann wrote:
>> "Some" means exactly powerpc64, right? It looks like microblaze
>> and powerpc32 still share some of this code, but effectively
>> just use the vmalloc area once the slab allocator is up.
>> 
>> Is the special case still useful for powerpc64 or could this be
>> changed to do it the same as everything else?
>
> Or make it the other way around and set IOREMAP_START/IOREMAP_END
> to VMALLOC_START/VMALLOC_END by default?

Sure, if there is a reason for actually making them different.
From the git history, it appears that before commit 3d5134ee8341
("[POWERPC] Rewrite IO allocation & mapping on powerpc64"), the
ioremap() and vmalloc() handling was largely duplicated. Ben
cleaned it up by making most of the implementation shared but left
the separate address spaces.

My guess is that there was no technical reason for this, other
than having no reason to change the behavior at the time.

       Arnd
