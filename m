Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF66D6824
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjDDQB3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjDDQB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 12:01:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DA4EC2;
        Tue,  4 Apr 2023 09:01:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E0A415C006F;
        Tue,  4 Apr 2023 12:01:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 12:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680624079; x=1680710479; bh=Qn
        6ZM6O+VkPQESTQhCqrbkz3xFurEda57CnQ1FINQ08=; b=HljWSxrguEuItbBSH2
        zRbg9l5WDAqQrDWhNz/NLnZdl0uzb6dkYOM6lCFsE4zp2I6ly8DGWPi23+FXZPAI
        q3aIa8OXrd7Bmwn73GDD6vtSfCTCI7c3LfA+ZP91q2FrIdnAXCqFtosFBBjjbckZ
        pB3h1OZM2LqROyKHc74t4enh8T+w1jCNQ+uQ3Omgsqt35q+GXNmDfjH/Dg2cFowq
        IzFhKoDG7roj6K6XPv8S1rdPfx5MWMB/GSgvuFPLu3xv86d6ClQ0lbnQR2Mw22i5
        aaOg0OGxdt2HJl9Mw0C6yR2y+fBL4sqbRoDKe/YLT+iTlxK9TP76q4k9EZOtf+QF
        twXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680624079; x=1680710479; bh=Qn6ZM6O+VkPQE
        STQhCqrbkz3xFurEda57CnQ1FINQ08=; b=Gq+QVSlfmiiGUexss/yoaHUBoGD+d
        mvYFkktVS5znav1yEyY0++vQSAnvr/dkWzLE5HJyohIRMCf2hSCyD1QLCiLKMvkE
        e9eb25Se7lw+SoqpOQsYZL0BXNFCr8rEaL1sOhHq6yCdeESW8l0JobvRQSJcjT0i
        Lxt7dzG98fLAplRLwHTkOsNr0+t12DuJrXm6yZWkDQmnp8A0Sx7+aGaK87gyV9jJ
        iW4IzaZasoFn9QRfc4zQjPSSvRjHYN9c/g3/gP30SfjkxOy1T0o0Aee/fKHZcCVa
        4SA8BBZ9mJup7Taown5uNlcH0lFESO47x/3ohaGOn2XIewwkx1I0i3XaQ==
X-ME-Sender: <xms:z0ksZJRHO4JaB5fJ6XDbWe5Okye_QR-0V8WNvN69DRsss-sXug9EPw>
    <xme:z0ksZCyO8lHVVp8nipU4ejH1FU78Daw0kF4hiN69crFAWVyuSQiZ5t2U2TnYjR_gu
    6nV1TWOv0N6lLuueN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:z0ksZO1o8v_RJ5xcSp62wzBUNt8ydlexnY6ZPt3ln5letcjmX1lLsw>
    <xmx:z0ksZBAH20nsWJMAyoTTPkWjuxFFniZKayj9N_hCcdfY9xtZ--do2g>
    <xmx:z0ksZCgmntnmKBnVj20-6CgWz1A2pN4ykrY1KmB9qYmSL8pAFIuf9g>
    <xmx:z0ksZKLW-BIf06gIEVntBK03r2Oz0unaUAoeCynnkphRlOFlkCMz8A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A518EB60092; Tue,  4 Apr 2023 12:01:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <a270b336-fc10-43fe-9c0f-8035e5bccb5e@app.fastmail.com>
In-Reply-To: <20230310093047.dneojlst5x4qqgwg@skbuf>
References: <20230109131153.991322-1-vladimir.oltean@nxp.com>
 <20230310093047.dneojlst5x4qqgwg@skbuf>
Date:   Tue, 04 Apr 2023 18:00:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] asm-generic/io.h: suppress endianness warnings for readq() and
 writeq()
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 10, 2023, at 10:30, Vladimir Oltean wrote:
> Hi Arnd,
>
> On Mon, Jan 09, 2023 at 03:11:52PM +0200, Vladimir Oltean wrote:
>> Commit c1d55d50139b ("asm-generic/io.h: Fix sparse warnings on
>> big-endian architectures") missed fixing the 64-bit accessors.
>> 
>> Arnd explains in the attached link why the casts are necessary, even if
>> __raw_readq() and __raw_writeq() do not take endian-specific types.
>> 
>> Link: https://lore.kernel.org/lkml/9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com/
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>>
>
> Did these patches get lost?

Yes, sorry about that. I picked them up for 6.3 now, along with another
one that I just remembered.

     Arnd
