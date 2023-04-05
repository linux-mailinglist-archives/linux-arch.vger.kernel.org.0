Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419096D8825
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDEUYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 16:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDEUYo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 16:24:44 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DA4C2D;
        Wed,  5 Apr 2023 13:24:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id DF0B758241E;
        Wed,  5 Apr 2023 16:24:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 05 Apr 2023 16:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680726280; x=1680733480; bh=N9
        C/awAiXRMgnyyYXvPXUEJhSqaGPpbpLGKv/C3S1H0=; b=WYPwr8/VZV6zBYSovW
        FWa53JW+kTo73xaVm26HaPrq2i7dKIUDM7qfeMtNZC5V8yUXcANudnKjTuwrmFHT
        Bf6+wk1Vs7FzddiB5Fww3LDuUwLRjpNWpTXNZbaNnMZJpNay9E6WnjCkVe//D8OC
        a1+OaRb97j78Z7MDUL04PRkhE34VYZWmntrFiaKjV9XTISuY8/fSAtiwJ6olcwuF
        WA+DDruleUG4eG1RUCTaABOEXRHycG6io1Dvofh5YJy18HBl3YZyi5QFdRH8zPTN
        An8bgpPoA1hf/uyWLDZlmMkKFg4ebIJRTbAoxcXqWaSb60/SOA4weGBXxXcQ3qJh
        KdDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680726280; x=1680733480; bh=N9C/awAiXRMgn
        yyYXvPXUEJhSqaGPpbpLGKv/C3S1H0=; b=awCPWIxoS3smP/8nlGjUXH8x5hhZ5
        g669z2xjXBokBOPK93ThSmEiaLo1ezXohhrV+h6cMD6CioysuAVRHhq5zZ27Y8dv
        EZKxg17wtFmUUbQ/FtL8f+qwX+Wf1DDGalFLZmYHLDYsjHsLD+SGwizDU2yoiRnu
        VZmfzzwzVUmtf0oKnLxjaJ89u1NuxbN0q49Z7aC3Qgn2ji14Wc5AdSYrA43EycyX
        9/xLz5/UcfjD5Xjk6zvLCSzMcaXk01BUhpqlbpgIdTzbm6rAxecXUoRj3nBrExcK
        ZWJNYGvWuKZ2AsqsMBW1UFdR9q+Wcg0Rif72eQ7SEwxKwfyCggQbeNp0g==
X-ME-Sender: <xms:A9ktZN-Ax9W4njI8A8apr9e7Bv-0umsmK6kqSp1lzC3QCYbu0DBMkQ>
    <xme:A9ktZBtVRLv-mQcPRloMA6pGibN8THQNDcRCyBlRM6MLjSdZwlJ16izT-YWqPdMya
    dx4JRZk3yhST7-lJcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:A9ktZLDW0vaw3gVnAnP2EVY99FIImc0hamB7XraCaA329pRxRE3PXA>
    <xmx:A9ktZBf1ylMnZubYx_bSYiP0AHTIWgTnVyi4sRWZI03guTk75tMdxw>
    <xmx:A9ktZCPJFCWwsR1Ipw7GUCT5hlUt-wx7Aqn-uWdjsV_pNCO2eZsPEw>
    <xmx:CNktZAHRdP6s-LYwNXnmW-FmDmhyiU6f90xe3_kv3IFGihfzkUoWng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 764CFB60099; Wed,  5 Apr 2023 16:24:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <5d964527-92ef-49a8-bbb7-413eb09297a1@app.fastmail.com>
In-Reply-To: <248a41a536d5a3c9e81e8e865b34c5bf74cd36d4.camel@linux.ibm.com>
References: <20230323163354.1454196-1-schnelle@linux.ibm.com>
 <248a41a536d5a3c9e81e8e865b34c5bf74cd36d4.camel@linux.ibm.com>
Date:   Wed, 05 Apr 2023 22:24:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v4] Kconfig: introduce HAS_IOPORT option and select it as necessary
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 5, 2023, at 17:12, Niklas Schnelle wrote:
> On Thu, 2023-03-23 at 17:33 +0100, Niklas Schnelle wrote:
>
> Gentle ping. As far as I can tell this hasn't been picked to any tree
> sp far but also hasn't seen complains so I'm wondering if I should send
> a new version of the combined series of this patch plus the added
> HAS_IOPORT dependencies per subsystem or wait until this is picked up.

My bad, I've created an 'asm-generic-io' branch in the asm-generic
tree now and merged that into the master branch for 6.4.

If anyone wants to merge the later patches for 6.4, feel free to
pull in

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-io

as a stable base.

       Arnd
