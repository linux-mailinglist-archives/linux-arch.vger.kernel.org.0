Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024BF699497
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 13:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBPMmq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Feb 2023 07:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBPMmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2023 07:42:44 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B883311C1;
        Thu, 16 Feb 2023 04:42:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C9095C00BE;
        Thu, 16 Feb 2023 07:42:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 07:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676551328; x=1676637728; bh=4av0BcgO57
        q6PB48qfskBTT3lQalafxs0+Jkv9f+ETk=; b=fwdeBLH8dTHrGbPNhRjaH73LJ4
        g4YLate0C/+/NPvvKigVGKh3hgOLc7x0K8dOTpvE4yhsoD9MnXdvPq3PwbNjY1dN
        0Fx76WBWTnnH8D/hnn3ienM9XCsQfQ0vWKorriw0dvI8UCZ9X/nsQvht+pvdaO0m
        9Uz+/yHQCUVIKYg8xCUR87WSl3bOlgi/FBwWwpEmb1HXEV9oU+Nux1chsF6/m7bG
        QaLKoAFXxPxFHMiG73SV0xUi4b2edzxivQoB+J79vY6fSLZ77YGXRw0bR/29pOyI
        GnuBLVdTFm+U1ExWgLUOX7s4+jZCdzNyYiVUUAR33fEcUnh61qmIbxjhgmrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676551328; x=1676637728; bh=4av0BcgO57q6PB48qfskBTT3lQal
        afxs0+Jkv9f+ETk=; b=dEoQmo4s0anb3S3N8HPNR0ZZy/aYvoMKXJiWyaxfG4rX
        GcF3gnjZrskxj9C1nFPjFXzF5ozgikRom25Co8ySi30qJMDV7ZS85l6IbscIcemL
        1rR2PHTRRkJ/G5MgjlpPv5zEcvofztTP27zMPfzjCfsMOnJDPSn1oZVEz8obbhfS
        RaQGXt1ds3uFrJP3HansNLJYIEpapHmSmyxt0ewbaRkeQqIY49j4ogeX/gZ5CFGF
        mH7DaiocUH0ch7JWFch8/AXvOrN/6RwfNLtbHlI522U8taigMBdhgpIVnacDWeL1
        IviOVslVI6VdnsDXky35glkRGZFULHo/T2lMlfwzyQ==
X-ME-Sender: <xms:nyTuY_zFlIxyhMAhKUQoT2wFloAl6rRRnytiAYpYO14eZ-3TfPMYow>
    <xme:nyTuY3TQftmcV8XyxkbV9st_qJnVfohlFUyF-gNmqepd4TxKVCjeOfXAQgPQwx65R
    MtdmlMq1LBBbev2xh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:oCTuY5VRl0RYfyjZhprRZvs1jPfVlprFM2S4EeC4A2HDIA9HyileIw>
    <xmx:oCTuY5gG-dcLiyJLDfsl7Ex8tJV4tIP6oFuDVLB94mX_SyzjEdqVQA>
    <xmx:oCTuYxAjWNG7VDdsTI5wRgqV4IajPABfCd8vVY0H922XnBIYTpK1-w>
    <xmx:oCTuY1v9POI7Q7M-iwZBb-OyZNqVVEbqn90QpipewMEiJOgBIZ3-Qw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD2F1B60086; Thu, 16 Feb 2023 07:42:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <f4f4c47a-7bd1-484a-8190-203357efa0ab@app.fastmail.com>
In-Reply-To: <20230216123419.461016-5-bhe@redhat.com>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-5-bhe@redhat.com>
Date:   Thu, 16 Feb 2023 13:41:49 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Stafford Horne" <shorne@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 04/16] mm: ioremap: allow ARCH to have its own ioremap method
 definition
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> Architectures can be converted to GENERIC_IOREMAP, to take standard
> ioremap_xxx() and iounmap() way. But some ARCH-es could have specific
> handling for ioremap_prot(), ioremap() and iounmap(), than standard
> methods.
>
> In oder to convert these ARCH-es to take GENERIC_IOREMAP, allow these
> architecutres to have their own ioremap_prot(), ioremap() and iounmap()
> definitions.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: linux-arch@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
