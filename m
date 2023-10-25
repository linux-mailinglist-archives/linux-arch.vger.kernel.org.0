Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91427D75F7
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 22:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjJYUw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUwt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 16:52:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E803181;
        Wed, 25 Oct 2023 13:52:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1688C5C010D;
        Wed, 25 Oct 2023 16:52:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 16:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698267164; x=1698353564; bh=Lw
        km4by0Rki3JY+h6pP3hgKn84sTDYv48INvl6mOPx0=; b=EVs5SINrDuZyr+FdoB
        /KT2yCpM/aCvcgrKTwKt82ffUgNjPCOaT4detltoHGvUR8aujlpORn8a0u8niErV
        Zx2WyilaDcWVHGLVy2GheqlfE8XS3UyMlknBPkfqii2hcZtAwQrFhVe+7+LvngBI
        eRt7qJoteMZvrkXivybaTeYAwBuCaZTLgeyDG89ptUzBsyt9jFo/Lsjg5oM4r7w+
        mY36Bs5NZ1Bxxit7llkhrYpWRVYAxWbgAYvzfFcfeaYTe5bUe+BHmNeqH76hJhWQ
        +9OwQXlH+KcAICkD4KApf7elWDkAPZjUvogsrmoW1nlZCJtIZ1Hzk7muoj3ihij8
        oRPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698267164; x=1698353564; bh=Lwkm4by0Rki3J
        Y+h6pP3hgKn84sTDYv48INvl6mOPx0=; b=nYndhwyOjJwKekFfaJQ96GLSjBtgR
        6KDIyg3YBnVEpIIWHoTtGVhJBmMyFqpXAmOoxOTQkS0al7c6R4xZh509P6ZSaBJt
        g8heyn4Ke8YhmqvFsj/jtlyFLLYzul3dAnOqt1IVwjTThbDIut0ZfkYN+bYP8MxK
        Aehus9MxE5cqcd0PKTXSjQe5j1PXtxMAHWySXaa8XRg7MZz9QVB9ogmv8gBkSjB3
        qgmlBJNxxH7GmYhja5rTWgBz8TqahESrgLNmHAW7hhBWRSgcI3MyUf0cX6DFlWDE
        ai7vFOv9anFePpue4GW5iPtM9AzmwqgVa5wnAPLhuzDcwETvbliU726fw==
X-ME-Sender: <xms:G4A5ZTPvNocsC00WmySUy_U0FZgPnCwlQeegak5ez8YvXyxKts7Frg>
    <xme:G4A5Zd_GRfIeCramOakSE5ulbqAFppoOwn-M2pZAAsxzo8u3UZKgypONYRhlT2Hxc
    gDc-RFAKo8BF2GbZi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:G4A5ZSRfVof2wTyakLYZQ0JE-z6rYY5k6tc5niOEhzeB6vqFNMizKA>
    <xmx:G4A5ZXtGVGtSLpJIHvDjGmgjahUu88W7EbAvuPYY9qoZ12IAbeWu9A>
    <xmx:G4A5ZbdI3EktLJRSy1ZJQU7g0bK8iBLodDZDRFlKEKsoHbIUzRHbQw>
    <xmx:HIA5ZdvGur4GYsps9tn6DzlV-YwTIkvIs02dVgRfO3yXqRbC21bHvQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 773ABB60089; Wed, 25 Oct 2023 16:52:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <059f17e6-e240-40fa-8742-7844ad3b3502@app.fastmail.com>
In-Reply-To: <ZTl8gauEst2NGrw6@ghost>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
 <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <ZTl8gauEst2NGrw6@ghost>
Date:   Wed, 25 Oct 2023 22:52:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Charlie Jenkins" <charlie@rivosinc.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Conor Dooley" <conor@kernel.org>,
        "David Laight" <David.Laight@aculab.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 2/4] riscv: Checksum header
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 25, 2023, at 22:37, Charlie Jenkins wrote:
> On Wed, Oct 25, 2023 at 06:50:05AM +0000, Wang, Xiao W wrote:

>> > +
>> > +/*
>> > + * Quickly compute an IP checksum with the assumption that IPv4 headers
>> > will
>> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
>> > + * @ihl is the number of 32 bit segments and must be greater than or equal
>> > to 5.
>> > + * @iph is assumed to be word aligned.
>> 
>> Not sure if the assumption is always true. It looks the implementation in "lib/checksum.c" doesn't take this assumption.
>> The ip header can comes after a 14-Byte ether header, which may start from a word-aligned or DMA friendly address.
>
> While lib/checksum.c does not make this assumption, other architectures
> (x86, ARM, powerpc, mips, arc) do make this assumption. Architectures
> seem to only align the header on a word boundary in do_csum. I worry
> that the benefit of aligning iph in this "fast" csum function would
> disproportionately impact hardware that has fast misaligned accesses.

Most architectures set NET_IP_ALIGN to '2', which is intended
to have the IP header at a 32-bit aligned address, though
some other targets don't bother:

arch/arm64/include/asm/processor.h:#define NET_IP_ALIGN 0
arch/powerpc/include/asm/processor.h:#define NET_IP_ALIGN       0
arch/x86/include/asm/processor.h:#define NET_IP_ALIGN   0
include/linux/skbuff.h:#define NET_IP_ALIGN     2

I think it's considered a driver bug if an SKB ends up
with a misaligned IP header, but it's also something that
some of the more obscure drivers get wrong.

    Arnd
