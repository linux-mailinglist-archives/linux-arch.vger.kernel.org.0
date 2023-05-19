Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C740709244
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjESIzz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjESIzw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 04:55:52 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9914AA;
        Fri, 19 May 2023 01:55:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FDC85C0069;
        Fri, 19 May 2023 04:55:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 04:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684486551; x=1684572951; bh=UM
        /Iy78jcidbViTHhtG0ZTxjLYDzr3qTMzVVSL0XtdA=; b=X5hx2jdpsdjrEC4d/o
        pSBO9nUZSth/4yCIhUoNLGlQYSNvrksWdO5qkeOG8Ya72Q0612xDaZZdVXBWaUMB
        1ipGrUoWPZo/BG6qF+xEM2DQG3pG4azrTq7zsuCHvKZUN+EwmdgL2tsAZxzm2Gk2
        M9hlnk4IWnHqaxPG84sVs5o/UGjZsn75SEHOcN/tefngK21lSufEkJwXljoRxw3k
        einpmAI/l+SlAAAR0HXWHkdhev00r8wJlOIGYozaOYEgm7Rxwj242W1DdANji5UG
        iiY41VaWGp1tA5GswS3GBN465vXgfmX6mB1laZSOkAJXln5+LZGQ3H7CCpn5ZOeC
        +wRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684486551; x=1684572951; bh=UM/Iy78jcidbV
        iTHhtG0ZTxjLYDzr3qTMzVVSL0XtdA=; b=vLRr8tOHknaO0lrCXrx+BYGsVmWWR
        Ob07y/paEoQ17DHIPdkDe6xRe3H8G0oRIUSETcJ89mbKDVeKQ8i/23SGUTnMmE0A
        phrtSm/U/m5UgEr+ny/2aS8Yqx35B6O9E5Qdj1J9D8WlHQ3Q5JMHbouQzXNqeePC
        cx2OdQfZypEkcqm7ZTSTl1CeFnyRx7POK4UABjZdQkE/WaaLifCFwLy8i2g6zIon
        O0gNm7t9m0tZw2tcLFNnrq0/NDnN1isNiND01ZElgs1QmvJ80/Eh1ag/E7aBWGx2
        +ZiC4V7q4Ya8ywj/FngIA6GKYSvysFLqs2GoOElAZf8PerKdCTkUKV2TA==
X-ME-Sender: <xms:ljlnZO4gNlipYcpOJklxZU5OQZVzXUidLRbPUJ7V01Mi-oGeLiU_Eg>
    <xme:ljlnZH71_zcXldxXz5UgrdjRbzLt_6P39FBRKoev1R0dGuQ9DgCQvGfQp9H4175wb
    pW6Q7CCChrBuG-6HHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ljlnZNcSE1qaXcHOxE2Mljx0INm6bT6bH9M7svDhqDmJjbUmxxmSYw>
    <xmx:ljlnZLKbI5Ks5AwDeLNx4Cf-sGkNXqr_8TF0-BZGo8ZAVZsRzpeaGw>
    <xmx:ljlnZCL7ZlfGiXQRw_OUynqsfiwgpBUMpxKf6SCCXu5TJVoHU5-1Lg>
    <xmx:lzlnZOqOiyOaWEjH92Ym6MHdryujzavgDElKTq96AqfyXVbSCZHp1A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 718B3B60086; Fri, 19 May 2023 04:55:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <13666898-6f5f-434d-8294-95182a7563de@app.fastmail.com>
In-Reply-To: <454dede3-5f20-74fc-975a-e11e4d8b5648@sifive.com>
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
 <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
 <454dede3-5f20-74fc-975a-e11e4d8b5648@sifive.com>
Date:   Fri, 19 May 2023 10:55:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Paul Walmsley" <paul.walmsley@sifive.com>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>, guoren <guoren@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
        "Anup Patel" <anup@brainfault.org>, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        "Andy Chiu" <andy.chiu@sifive.com>,
        "Vincent Chen" <vincent.chen@sifive.com>,
        "Greentime Hu" <greentime.hu@sifive.com>,
        "Jonathan Corbet" <corbet@lwn.net>, wuwei2016@iscas.ac.cn,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Guo Ren" <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on 64-bit
 supervisor mode
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023, at 02:38, Paul Walmsley wrote:
> On Thu, 18 May 2023, Arnd Bergmann wrote:
>
>> We have had long discussions about supporting ilp32 userspace on
>> arm64, and I think almost everyone is glad we never merged it into
>> the mainline kernel, so we don't have to worry about supporting it
>> in the future. The cost of supporting an extra user space ABI
>> is huge, and I'm sure you don't want to go there. The other two
>> cited examples (mips-n32 and x86-x32) are pretty much unused now
>> as well, but still have a maintenance burden until they can finally
>> get removed.
>
> There probably hasn't been much pressure to support Aarch64 ILP32 since 
> ARM still has hardware support for Aarch32.  Will be interesting to see if 
> that's still the case after ARM drops Aarch32 support for future designs.

I think there was a some pressure for 64ilp32 from Arm when aarch64 support
was originally added, as they always planned to drop aarch32 support
eventually, but I don't see that coming back now. I think the situation
is quite different as well:

On aarch64, there is a significant cost in supporting aarch32 userspace
because of the complexity of that particular instruction set, but at
the same time there is also a huge amount of software that is compiled
for or written to support aarch32 software, and nobody wants to
replace that.  There are also a lot of existing arm32 chips with
guaranteed availability well into the 2030s, new 32-bit-only chips
based on Cortex-A7 (originally released in 2011) coming out constantly,
and even the latest low-end core (Cortex-A510 r1). It's probably
going to be several years before that core even shows up in low-memory
systems, and then decades before this stops being available in SoCs,
even in the unlikely case that no future low-end cores support
aarch32-el0 mode (it's already been announced that there are no
plans for future high-end cores with aarch32 mode, but those won't
be used in low-memory configurations anyway).

For RISC-V, I have not seen much interest in Linux userspace for
the existing rv32 mode, so you could argue that there is not much
to lose in abandoning it. On the other hand, the cost of adding
rv32 support to an rv64 core should be very small as all the
instructions are already present in some other encoding, and
developers have already spent a significant amount of work on
bringing up rv32 userspace that would all have to be done again
for a new ABI, and you'd end up splitting the already tiny
developer base for 32-bit riscv in two for the existing rv32 side
and a new rv64ilp32 side. 

I suppose the answer in both cases is the same though: if a
SoC maker wants to sell a product to users with low memory,
they should pick a CPU core that implements standard 32-bit
user space support rather than making a mess of it and
expecting software to work around it.

      Arnd
