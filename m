Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D0B76C51C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjHBGAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjHBGAU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 02:00:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24C213D;
        Tue,  1 Aug 2023 23:00:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E63BD320094E;
        Wed,  2 Aug 2023 02:00:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 02:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690956010; x=1691042410; bh=Yt
        vb0mJTCqFvSWUzjrpJ3J+FljcDta2FuHCw3g9+xyM=; b=X8GskQHKcF/CLu6sH9
        eHdMyaeNGKePN3uazuZn7+yG1MgasXQeSW+4D5a9qh01PZJ7ruxAhWLUmqLv/5A1
        W6H07qlbCkDckdcSq23RL5reCF4qGn2CJ7AFFzvrvuiIyF6avFGWDuPiIDTDDza7
        sITrpD0bLEVEOugi610GvCf2CpcRN/uAN7rFDfopQ9Kls2M+mvohHTIgclscWePT
        IzeLsuUrotGQT+H+7RNajuQNxx1XCoa1DvJJ5Hga0P3V/DrFgmlN48jWyzxywzvR
        EIsEeQt1j8VMOaYXXdnLEFTpd/PIDbv3gVRDO2Rf4qW2CutL5wCa7f3aFyUesjBm
        qnXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690956010; x=1691042410; bh=Ytvb0mJTCqFvS
        WUzjrpJ3J+FljcDta2FuHCw3g9+xyM=; b=rVZI7NEq96ProyK7mRRMmZ9uNP1XY
        U60ejYdcwBAhAR8FRm0b43P47NNM4476RHXJVqz/nect8HFS32ww2FrZLZfDJNFj
        nTnKfBQ8SOHjto76Bp9hInu8Z2aQgIa95Tj0/F+hnsevQld0WJob9UOapGSFOrr5
        N+cc0kc4CXtrZ9sb+emUOVvGisqm5TaiFNe0yyVC4BFqIe069x7BSdzhm3i9GTlL
        AxvGwPLPUCK3283/Shk2fhcVU6K8QFI2TOkxy+6PQD4C/MzdLPr25hYGQV6ncCu9
        K1tQdzUC8qIQLrxnIQQcYoqNk6IjHludpZUC7nMTg3HpQ+ejVpLz7Nv/A==
X-ME-Sender: <xms:6fDJZAxUer9v1pqOKwDKxJPmHD6m2WEnq-gFKAVMUjSs92lscT1I2w>
    <xme:6fDJZEStnpkvBnfb_iENwlU_lnFYxbd-7Ho7ravoYFk-448ZPHdfLsBkq7D46yGlE
    bia4TPj1nkIiLw9Bhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeejgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6fDJZCU2S6Lh3XFdHrkVmf5T2UyWJ4LVI0770K80Yb5gBkjxojhaXA>
    <xmx:6fDJZOi3qvEj8IktGXtLSuF7DBXnlsvyVKHFAUaYBLa9QLkaV2_Mxw>
    <xmx:6fDJZCCCDj2SyFda5G2C6Lr1Bd-i411TdgCr_MhafwfaBdfxVAY9sw>
    <xmx:6vDJZDK3c5_EB4fgcQFgzX4-go5CWzYwLeKaw7J7u6zkYYoyze36mQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5750B60089; Wed,  2 Aug 2023 02:00:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <847747a8-b773-4b7b-8c14-b8ef4ba7c022@app.fastmail.com>
In-Reply-To: <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
Date:   Wed, 02 Aug 2023 07:59:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Cc:     "Nathan Chancellor" <nathan@kernel.org>,
        "Tom Rix" <trix@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero regardless
 of endianness
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 2, 2023, at 03:07, Linus Torvalds wrote:
> On Tue, 1 Aug 2023 at 15:22, <ndesaulniers@google.com> wrote:

> Who ends up being affected by this? Powerpc does its own
> word-at-a-time thing because the big-endian case is nasty and you can
> do better with special instructions that they have.

powerpc needs the same patch though.

> Who else is even BE any more? Some old 32-bit arm setup?
>
> I think the patch is fine, but I guess I'd like to know that people
> who are affected actually don't see any code generation changes (or
> possibly see improvements from not turning it into a bool until later)

s390 is the main one here, maintainers added to Cc.

Atheros and Realtek MIPS are older but still shipping in low-end
network equipment, and there are still users on old embedded
big-endian mips (broadcom, cavium, intel/lantiq and arm
(intel ixp4xx) hardware. All modern Arm hardware (v6/v7/v8/v9)
can do both big-endian and little-endian, but actual user numbers
for big-endian are close to zero -- I have not heard from anyone
actually using it in years.

And then there was a lot of the old-school workstation/server
hardware (m68k, mips, parisc and sparc, not alpha/ia64) that is
mostly big-endian and still maintained to some degree.

      Arnd
