Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513F5A96B0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiIAMZ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiIAMZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 08:25:56 -0400
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 05:25:52 PDT
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568F1223BC;
        Thu,  1 Sep 2022 05:25:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 2ABA82B05A0B;
        Thu,  1 Sep 2022 08:20:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 01 Sep 2022 08:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662034817; x=1662038417; bh=QVvMCa4+T6
        ZMqUOPgma8k9+JUx813GP4FVbXnu5gwBM=; b=bVlFFJ0fKvw/Ll4XFFZf9z1zA0
        Yvbu8io1K54ClVhBkTamCjcTR1AtF5gNcg0smaq3EuqEkRp1w2XOSkwXQgbT9QU7
        4wKvXhc0wDJ9O2wjxluNvsdIAayZhZzDu4h/gRj+SZfgMJFmWvWUQQEKXykbhEer
        RNWf7zSvqbIYUSpTvZm0dIyIRLonaAnl30BW2CS+8xtTkOkRaJe1AOk/qNM5uFmJ
        o8eGqQ34B2yzfqo6/+uiDFncZ3oKSGFnZLrisrg4Q7wXu2MDCZLs5q5yFKnYhgvC
        3i96AoYJhlFtD09SvsG1ynPs3qX4QxYWfB1GaEV6Q5Vcyj60HGYhd7d7JFVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662034817; x=1662038417; bh=QVvMCa4+T6ZMqUOPgm
        a8k9+JUx813GP4FVbXnu5gwBM=; b=WFrqDIviaN5CM9moICEsopvlBhEeiFYHXV
        CUqpa0sklykj6AqbRnLB39Z5jl4U80qXGTd8nU9/LZUf+ySbujxl6kbPh8PapvuC
        ncvVZNJoQ23CQs5QWmSfzIHLmT0JcGmdm+VdVz46XCPLvnS56OK1Ily7AMV/cYTo
        PtMAD2oPAu9ti2W4bxMjtYK/k+WzmnjcYcZrUMAVQzmvhXP4jH4uKHLUI+gdnRvL
        n2U9PYgOEPABmsrIbLlxRIM52GXKMCPS6pPBLoyhdRx3k78Hrejx15+DK149nZqH
        Z7Z6ZsXIpoHv2E5gBg2JHs9ktF7NMdYMupS34MwDO3MpXKNQakig==
X-ME-Sender: <xms:gaMQYzAbhgdaEG-tkJm7KrPp8E-fub4fcxz35jARGMpG4BCtyrkBwg>
    <xme:gaMQY5jPvKgEASaA5FmAKYOunl_1FL0UcMO3XpkqvRmElU6GLiuLSBgBDEuws79c1
    y1dabqy9vKUcLSRcUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gaMQY-lLZ6Jlsg22CrKdpp7neikL7pztlX3bs_twcOb3XYdLcv4uxQ>
    <xmx:gaMQY1wU3kGWkzP7o1KEKoHzRsFf1WQyvrMSuwyYaQXSJHxvOFHA-Q>
    <xmx:gaMQY4QX7VoS8c39YIhOedDjTi2lThIFo_e7vEhaT16RdH5GITN76A>
    <xmx:gaMQY-NGbW6bXxYtKkQsN4fgHB2fBE80FIjRxG2Lpd-TnJhF2OVO90lkZbk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2A865B60083; Thu,  1 Sep 2022 08:20:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <911742ca-d653-421d-8c55-d0cc5d2be777@www.fastmail.com>
In-Reply-To: <CACRpkdapZCrhQjFfGM_mU2+kUTBO6tpDUAY5k7sDRZUNWAKnVg@mail.gmail.com>
References: <20220831214447.273178-1-linus.walleij@linaro.org>
 <5b1f418e-3705-4093-9a13-3fe7793ed520@www.fastmail.com>
 <CACRpkdapZCrhQjFfGM_mU2+kUTBO6tpDUAY5k7sDRZUNWAKnVg@mail.gmail.com>
Date:   Thu, 01 Sep 2022 14:19:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] parisc: Use the generic IO helpers
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

On Thu, Sep 1, 2022, at 1:56 PM, Linus Walleij wrote:
> On Thu, Sep 1, 2022 at 9:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> You should not need these overrides here, since the
>> definitions in asm-generic/io.h are only relevant
>> for the !CONFIG_GENERIC_IOMAP case, i.e. architectures
>> that can access port I/O through MMIO rather than
>> special helper functions or instructions.
>
> parisc does not select GENERIC_IOMAP.
>
> Are you saying that it should?
>
> That seems like an invasive change to me...

You are right, I missed that part. So parisc just uses
the declarations from asm-generic/iomap.h but has its own
definitions instead of the lib/iomap.c ones.

According to the comment, the parisc version was originally
meant to handle additional special cases besides MMIO or
PIO, but this seems to have never happened. The current
version looks basically equivalent to the generic version
to me, except for a small bug I found (see patch below).

Changing parisc to GENERIC_IOMAP is clearly something we
can do, but I agree that it would be out of scope for
your series.

      Arnd

--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -212,12 +212,12 @@ static void iomem_write32be(u32 datum, void __iomem *addr)
 
 static void iomem_write64(u64 datum, void __iomem *addr)
 {
-       writel(datum, addr);
+       writeq(datum, addr);
 }
 
 static void iomem_write64be(u64 datum, void __iomem *addr)
 {
-       __raw_writel(datum, addr);
+       __raw_writeq(datum, addr);
 }
 
 static void iomem_read8r(const void __iomem *addr, void *dst, unsigned long count)
