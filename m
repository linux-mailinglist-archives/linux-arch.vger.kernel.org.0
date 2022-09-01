Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938E75A98D7
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiIAN3o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiIAN3J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 09:29:09 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C372ED7;
        Thu,  1 Sep 2022 06:25:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id D5D272B059B6;
        Thu,  1 Sep 2022 09:25:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 01 Sep 2022 09:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662038724; x=1662042324; bh=vIO5ZJR7KE
        xB4bARHen9aUxGuNe/+3E8DwvQYBe/pkg=; b=Oz9q3z2sRWRVzWZaOqpzvkAM0J
        r85mamoTHWBqv2/wRJB20hnevB1zLTEpVyuuA34eFp30pdtU3TvJhusnj7Js3Bg2
        XPWmnfYJZFQsO+KtjUGoOb644PHICVT6UXp7RoCxb0kw5Ah2CVeiC3tdqBcWJjDk
        79LeqKpaRWxpz5Ura0CY0xv/Q+2IzrZuJW1W27lIjSDLBYOh4ZeuvhARNFF+L4g8
        b14nSCAXFoBPhPcmO384DZ3A+1W21pWQtb3imD5WGTszAAWX5/j4ted2mfUO8EtG
        +TLdZDfNMYAiDZYLnTbi9vYn3u+b0CutzEMgGvtY/gToMQXqucelTtXKq/Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662038724; x=1662042324; bh=vIO5ZJR7KExB4bARHe
        n9aUxGuNe/+3E8DwvQYBe/pkg=; b=q7uHQBuSqAa4kcrNLtKaBeagrK9gqEC0ap
        qD3v3XdB6BRuPbtOaG7/ZCLYUV0bp/FhvrEEm3RtNdb8guP5lMnAShxZ/Yk8uCvU
        lFTRAyCyAX6k84rus7WDKZt//behnerusZ1WX/PqF0jJeAvYQxI7O7MK4Luvur38
        IiFpUtliFnGdxnCpnme10bwl7V5v3+3f+Iy8cPSmeyO5P9+PtoSarEvGX/gAp+v7
        NgxLOpRiIAdL06l+2Nl7lbmHcpC5k7mkjKTsBpzB8U19FSW3Apspt0fStRkAAZji
        WvjTpzWSGbPKg+cjcNAijkfWMlPeLwYuSsFTocWgSe0T1BP+1MMQ==
X-ME-Sender: <xms:w7IQY8DtGRWwpd_lViFbWdId4BI_wzQV8t-4-ybzUFfQIPpdE8GJPA>
    <xme:w7IQY-jWmjxSZkjisvq-YVB_L_zLnss5y75mGKN2OjzAGgjUrBP3mJ-HOr872tgmH
    j5NuJ5uwn17oIACxWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:w7IQY_lIQjCp9h1Nu77CNQ53mp4OMhmPOFl6h-qovMrBsgR-Y-aAZw>
    <xmx:w7IQYyw0OJKcqqWpKxFFMEuBF4XfLX8ZPqLcafz5W_6ssP480LaMEg>
    <xmx:w7IQYxSDoT0mgohszSADCEZQv66DSmDi80-oTFOGmUgSDUEeYQfIhw>
    <xmx:xLIQY_O2dF76WTjclI6VBA6t8bq8RMYN2JUUTUiT3dY9NDAnsXPEXW8T4No>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3FACB60083; Thu,  1 Sep 2022 09:25:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <55a23cfb-fe8c-41bd-b1d9-b056c1402360@www.fastmail.com>
In-Reply-To: <20220901130654.177504-1-linus.walleij@linaro.org>
References: <20220901130654.177504-1-linus.walleij@linaro.org>
Date:   Thu, 01 Sep 2022 15:25:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v2] parisc: Use the generic IO helpers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 1, 2022, at 3:06 PM, Linus Walleij wrote:

> In arch/parisc/lib/iomap.c the .read64 and .read64be operations
> were defined unconditionally using readq() and
> drivers/parisc/sba_iommu.c also expect writeq to be available so add
> parameterization to <asm-generic/io.h> to make sure we get these also
> on 32bit parisc: platforms can now opt in for generic 64bit
> IO operations even if they are not nativelt 64bit by definining
> GENERIC_64BIT_IO before including <asm-generi/io.h>, while
> these will still be default-enabled on CONFIG_64BIT systems.

I don't think that is a good idea in general, as 64-bit I/O
operations on 32-bit machines are not well-defined. Depending
on the device, one must first write the low or the high word
to get the correct behavior, so each driver that needs to
do this must either include include/linux/io-64-nonatomic-lo-hi.h
or include/linux/io-64-nonatomic-hi-lo.h.

The parisc definition of writeq() just uses a volatile pointer
dereference, which is not guaranteed to have one or the
other meaning by the C standard, and this is why architectures
actually should define the __raw_* accessors using inline
asm for correctness.

For the arch/parisc/lib/iomap.c version, I think we just need
an #ifdef CONFIG_64BIT around those. For the iommu, we may
be able to get away with either the hi/lo or the lo/hi version,
since the 64-bit register accesses appear to be either
reads without side-effects, or the write to IOC_PDIR_BASE,
which probably always sets the upper half as zero on a 32-bit
kernel.

At that point, I would split out the fixes for 64-bit I/O
accessors into a separate patch that can be backported
without the cleanup.

     Arnd
