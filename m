Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE976A09C3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjBWNJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 08:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjBWNJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 08:09:50 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BD16332;
        Thu, 23 Feb 2023 05:09:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 22E3A581FE1;
        Thu, 23 Feb 2023 08:09:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 08:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677157779; x=1677164979; bh=7qpJ4fyuUV
        Fw9F28lxEJyIMUTjdhT7HcNbFM6c+Ezgs=; b=HxQNx9y5lkyPfQ9EucQyFAYeXv
        +wBR4Ci7rIGXcf143C5IPzx2ZqOJaNF3jH5KmZtz7FNxSNa7UoskPstWQeZigMq4
        WxcCQ/z8bM77PvSxe3rqZoHfF3/mUHrwHyZBzZyDjUboQ9PAUWQIgKxeLmPPaybo
        9/oRTW8VDP0nTjfHs0i59PhLTfNd8oWYpFzHOr0hyB1JlkxO557CYUNzTcaySrYq
        HfLz3P47VseG4GU6ljvciKdgu2WLAHI0ASvuTQe3I7jJxJymgUN3BAWU2M5XA1VM
        uz8KTTIcMwkEpMCm/wKVwxs95KyUmVotFEk351GtecxQeN6fTZ8IWLBMqI8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677157779; x=1677164979; bh=7qpJ4fyuUVFw9F28lxEJyIMUTjdh
        T7HcNbFM6c+Ezgs=; b=RNlma8km1MAuSRNBq9ipJtyRBtTc/ZaAqtJnrMAUd01N
        A3vr/e+h0oVB8QM+EKHuX7FBVUPTgKtTYa2OG7uDKF7mduylXrp7vgdnX2bpO6hn
        LS+Tf+OM77FKRpjy1JUZ2k0z0u/ejvDE6PI/VehVVhk2zuyRoIGqumjHPpY/bmKf
        gvFjjmEnsXN8V98XE2pj0tKi9Raz1zeD5754Phu10AF+P5RZcfvQiwYY0QyK/8IM
        Z39ZZNv3bEYOxSsbpEC/pekLv/VdBZd/iO4Lnr0WCAnTGVKHo4fDKs57IjC2i0EP
        d1qc3PDGC8rYTjrBw1CIt1iMeMmgiwXuDce1d0Oivw==
X-ME-Sender: <xms:kGX3Y3ous26euV3YoyiFJjq3ixwKAGVcNF8YOm8J6PvPHtK-RotuAw>
    <xme:kGX3YxqCegrJEbUNfah7isGKrsvvXcWdV6BiyY6iP9_c7iKPA4gwBe8CDKSxsQmsp
    iSx53Wsw9qCkCqiXG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kGX3Y0MZZfqfcD0VGp9DlsZ1Swf2ynZlE3p_Z8X_FJsHbAIjqOEPMA>
    <xmx:kGX3Y65fZRpBccwKrsV3jr7sAnG0lDQI0aqT_-pKFxlTBQg3DS1ixA>
    <xmx:kGX3Y27Vy6XJ9Ep718BXrLdXAhCs5gSA4QbBN1kcE8ycfHfyCwcofw>
    <xmx:k2X3YyBwHlCTwxFQtAXbLNTtXf_KnKgFaDgG5zL8sv-qdX4Uj_y99g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 24130B60086; Thu, 23 Feb 2023 08:09:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <874b8076-b0d1-4aaa-bcd8-05d523060152@app.fastmail.com>
In-Reply-To: <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com>
 <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
 <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
 <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
Date:   Thu, 23 Feb 2023 14:09:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Jonathan Corbet" <corbet@lwn.net>,
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
        sparclinux@vger.kernel.org,
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

On Thu, Feb 23, 2023, at 10:54, Alexandre Ghiti wrote:
> On Wed, Feb 15, 2023 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
>> > On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
>> >> From: Palmer Dabbelt <palmer@rivosinc.com>
>> >>
>> >> As far as I can tell this is not used by userspace and thus should not
>> >> be part of the user-visible API.
>> >>
>> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> >
>> > Looks good to me. What's the merge plan for this?
>>
>> The easiest way is probably if I merge it through the whole
>> series through the asm-generic tree. The timing is a bit
>> unfortunate as we're just ahead of the merge window, so unless
>> we really need this in 6.3, I'd suggest that Alexandre resend
>> the series to me in two weeks with the Acks added in and I'll
>> pick it up for 6.4.
>
> Sorry for the response delay, I was waiting to see if Palmer would
> merge my KASAN patchset in 6.3 (which he does): I have to admit that
> fixing the command line size + the KASAN patchset would allow 6.3 to
> run on syzkaller, which would be nice.
>
> If I don't see this merged in 6.3, I'll send another round as you
> suggested in 1 week now :)

Hi Alexandre,

I have no plans to still pick up the series for 6.3. The patches
all look fine to me, but it's clearly too late now. What is the
actual dependency for KASAN, do you just need a longer command
line or something else? If it's just the command line size,
I would suggest that Palmer can still pick up a oneline change
to increase it and refer to this thread in the changelog as a
reference for why it is not an actual UAPI break.

     Arnd
