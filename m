Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C2697CB0
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 14:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjBONFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 08:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBONFW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 08:05:22 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDE36FEA;
        Wed, 15 Feb 2023 05:05:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2D40B582003;
        Wed, 15 Feb 2023 08:05:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 08:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676466320; x=1676473520; bh=NzdIn9sEy/
        TdUrl/ZdBVY4dMEk2Tnlph7NyUne+YOMM=; b=PPD6X7vdu8v5pQCFFeEkwZ+xGH
        hQxkzIm/THMwEiH6lmaNEBYbBzt3pargJVOdi2J1QMA6KHvLC9K1XeMABvJeeUMa
        lTPgSxuAXiTHnvnPs7+H7Vr/fKIWrN+XZApp3CpAC5yE5WgT9W327fh6++AuDJlF
        B9gywk5zLcSwCMvFm6irNxbf5/UMEQOklyQcP+yNMbxqWsOqNEYHAAgGHFLNZqZS
        WLgt7CmsFbv+vqD/Mh8pW6i09fttS8BnRngWkrvO1YOvB+eqJf9YBCzB8hRdQL8g
        Zrmyq7fkrOXYnHgcPd99guxknzQGmfAMstEvWh3k4ZTVkZadU+R5weMlaG7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676466320; x=1676473520; bh=NzdIn9sEy/TdUrl/ZdBVY4dMEk2T
        nlph7NyUne+YOMM=; b=Tp/P1vDtiwaXsxOOvmxonT9LDeiFaEudeIfZX0AV5xmw
        X3ENq+2GlESFOAR7xURKTITb3Q9/bLEcQhyKkak30WygkBgQXOUwH+1TEYwAnfSW
        VN79grgOoloKlVxQxKg9d/GE/aNuuNhUwV2IHK4xpJLpSY9XO1XpwbGHxBbR0DF/
        IjnWEESEaF5s9xx5Zj0yYZVtiwtJOFrRCp6Vfpm8unxAKwLTF76Egia3fqB+SRTf
        HhmCGeRY4V0PNJ2mo3ZpzkurciWsN1Fx3VZnNvLG3nNn/NwNqCwiyIzXTWlmQOpN
        G3WAp6KoO5IxE4n9w+AW7QNxTKU5fRGQe3g4//HLhw==
X-ME-Sender: <xms:jdjsY_Wh-8LcQ3nmLEwGZ7X-cUO_UZrmKOzBi9pl67XX_YGZ0IXNyA>
    <xme:jdjsY3kveCSQ-Laj-6oAgDyXLkBUjq7fx_C7UYY5m4XU_HQAFhNFJiZGPFSylztsR
    Jx6pcGWaR_WFw62yQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jdjsY7ZEvyr4y1ulYt1S1iPqX3mkImnPSdU2AD0rfL5VPKqJb7xP1w>
    <xmx:jdjsY6Ux13tFNHeawURlV0JH7DjSnY4lgf_B232j8MtUR1dl7xMefQ>
    <xmx:jdjsY5klmieqtEjUAp2jmIMBcwIQHQA6TF9wkqBiRc9-j4DSJjfhdQ>
    <xmx:kNjsY5_DeMdprgdbaWkVv0vgYRqpvs9Cxn7CSU6n-WZIW-e7MJJXrA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79450B60086; Wed, 15 Feb 2023 08:05:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
In-Reply-To: <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com>
 <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
Date:   Wed, 15 Feb 2023 14:04:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>,
        "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chris Zankel" <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
> On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> As far as I can tell this is not used by userspace and thus should not
>> be part of the user-visible API.
>> 
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Looks good to me. What's the merge plan for this?

The easiest way is probably if I merge it through the whole
series through the asm-generic tree. The timing is a bit
unfortunate as we're just ahead of the merge window, so unless
we really need this in 6.3, I'd suggest that Alexandre resend
the series to me in two weeks with the Acks added in and I'll
pick it up for 6.4.

     Arnd
