Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17106B9774
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjCNONb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCNON1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 10:13:27 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0CA729E;
        Tue, 14 Mar 2023 07:13:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D94543200941;
        Tue, 14 Mar 2023 10:12:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678803169; x=1678889569; bh=iI
        y9CiLa5l8silAFG/oWEvBfHn6PDmPHZgl7iOTs+qg=; b=X2B5Wl4bu9GOPGkddY
        li31c/SfHn4jb6pJLJ/jqJ+tkYsVADp/ceVGMiluUvtGcOEouehVJYNkBJz2e5V4
        iU88ZryJes4EoIPVz9Q8fQFryx5lJj5yUn6TQ6ulEEXE1nIl7WM9FMPYq6IkxULn
        1XsDW/jQQRs6tFRu0M2A+oQQmCZOWslh74LzAMjhEvZkixbrPnNgNuCaxesFVPAX
        7EgJfjSnKwgh/DV3SJm5629nSQbTe9wEz81piuubxJ9/zDa7hdliSg57j8DW4D3o
        pzarHyf8vY8Nb+otNdGIkZw+oVQHaZ+H8XqTg/nkUewLvPgOyN4S1qW+EUCdwohk
        G0EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678803169; x=1678889569; bh=iIy9CiLa5l8si
        lAFG/oWEvBfHn6PDmPHZgl7iOTs+qg=; b=EAHSkomvD9rBK8REvSHAZ6yLADrsR
        oZs6/9eHLOGSmcrbJgkh9l8KbLxB3ta6BeE1AlmONBAdFaqrRyfEaPbKDPb1c4Ec
        XiCyD1I51aPmpTpPIQzsEstJ4SgiGTh+S+KCZnIu+x/K/ywzHV4eeSi2B91YyABZ
        Q6V2gmyDTPXtB9CtpZQOL/f0nmvXLxOR8DbsLEhXLpaRijcwd8cB7esgdOCeUZ0U
        mVPevhwS/6tLhUnhncB1a51Jl2TGndxNiNBjNz5c3hG4dvJ06ho6F1Qaa2lFRKKI
        zSgtA1zBHISKXHeIuk6IpSQNvRIrpUC79qGolFyra/sBCTbgMgNAXZ/Qg==
X-ME-Sender: <xms:4IAQZOPsKJ0R2GPsgsBSQJFNMUcErJCAkUTLgdu7eQZ_yNhMziM6nQ>
    <xme:4IAQZM_qejJSeO_gv_XfQRmjl25-dPYJDdSdIpMcnP_ItE-vA1FI04YP3FqL2HLft
    vUJqUYvt4VldDuvZKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4IAQZFRMgN06nGgsnp7PKgzi2kIRwj5CqHc1K48LXBkTbv8KTZgQ4Q>
    <xmx:4IAQZOtjhw7cOdYQzyxAx7SYrMoZtIBKUxo7KUmNh0F8jzjtzHVemA>
    <xmx:4IAQZGdxUvbSkOnatKqeXlhR5ndqfXGdQkdA2sZpi4xlb6ZBwJI2bA>
    <xmx:4YAQZN8zwOSxqf7VUm8CUoSCQXQ9JyBcEd6V4YACtI8mBkLHu5Pyjw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88E8BB60086; Tue, 14 Mar 2023 10:12:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <e2ce3f02-988c-423d-a1c1-2796ab95026c@app.fastmail.com>
In-Reply-To: <20230314121216.413434-22-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-22-schnelle@linux.ibm.com>
Date:   Tue, 14 Mar 2023 15:12:27 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v3 21/38] parport: PC style parport depends on HAS_IOPORT
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023, at 13:11, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As PC style parport uses these functions we need to
> handle this dependency.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

> 
>  menuconfig PARPORT
>  	tristate "Parallel port support"
> -	depends on HAS_IOMEM

I would leave this dependency, or maybe make it 'HAS_IOMEM || HAS_IOPORT'.
at least the parport_atari driver uses MMIO instead of PIO.

>  	help
>  	  If you want to use devices connected to your machine's parallel port
>  	  (the connector at the computer with 25 holes), e.g. printer, ZIP
> @@ -42,7 +41,8 @@ if PARPORT
> 
>  config PARPORT_PC
>  	tristate "PC-style hardware"
> -	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
> +	depends on ARCH_MIGHT_HAVE_PC_PARPORT
> +	depends on HAS_IOPORT
>  	help
>  	  You should say Y here if you have a PC-style parallel port. All
>  	  IBM PC compatible computers and some Alphas have PC-style

This would revert 66bcd06099bb ("parport_pc: Also enable driver for
PCI systems"), so I think this is wrong. You can drop the !S390
by adding HAS_IOPORT as a dependency, but the other line should still
be 

       depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI
    

    Arnd
