Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590A7D767B
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYVTD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYVTD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 17:19:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B304D132;
        Wed, 25 Oct 2023 14:19:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 217615C02D1;
        Wed, 25 Oct 2023 17:19:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 17:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698268741; x=1698355141; bh=sB
        bmzZrzS7uTnh17vfzRRsLGG5pya0cO071IzBgauVw=; b=cEGW65XAIPb/2izJgp
        CDNL/6qj+dj9I6xTv077eqlR9F9W9CENmDXvCK5w3j0oBgdR7HbmVHLb/MrRWvHs
        6fSWyu1V7USJiN7J/0oYHagyu11Opj2C6e6Jp1rGV5jOBVE8Ea4yqM09svL8kZCf
        pjGGu4CWF4OAcZX1K7FTRNFl/BWFqQXgqkdVEPnGzJa6dVONdvbGDDKwdgCVlHsd
        XMESC0iY7G2qWQgs3P+I7S1kHGTXSfZmvQrykBdFWoIz1qYWR95e7A1Vubgtrb4n
        yNvh/rii5JKXOwmTwghXClJTe5VfJfXno1JEpnPWJ3bdKNMwlGIHc0rYeplYAcR4
        mIsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698268741; x=1698355141; bh=sBbmzZrzS7uTn
        h17vfzRRsLGG5pya0cO071IzBgauVw=; b=B6qwFUmEMob+EA2+IiIud9rsZ2Djn
        G3DTTilrXtsOAaKYdVplWsooJZj+Y2vbKCzWWNxY4Jfhe0di5qFyPcJ/4JQBQkZc
        WYYFytP0NLIGXoUhGP2JoDeANt50t3TAsZla/iURUbw98UK6E1yw3tZcEDP3oCfI
        7Lp2exF8FrfsqOWwhZ/ZYWdN0v3wUyedHltDhjdiw3dQiHiH4QZXP0XavdterzXa
        F8hm2tsjWmUmXptrG1RIGPkVGDU0YyrnJ4XgyHIA2mWAcFRRvHjKrn6rs+GoT3fy
        zX3bxaMerVMOQ3VhugI0tBEane6n35v6cbCNWFAVs2DF6rLy5xHOuV/7w==
X-ME-Sender: <xms:RIY5Zea-J8aJlz7w6-2ldbaHADRfwZNlDp_xPHG4DN8jAUm2rizNTQ>
    <xme:RIY5ZRYIbcw-LKwvoaMCqXDLngVtrU6PvSuCGiMyZnYgNxD9NgjKDjqNYY0s9v2ep
    d5fe48BRg6u6kUsOBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RIY5ZY-NWH8RnQ3Ca-lO8LOcfcWcYxHfLEUraum6ie_cnzR3hq_VRQ>
    <xmx:RIY5ZQosmo5MZQLr0SpZy4s_-fDI_twUf6tm2sZr_llBb7AIBQ9TAg>
    <xmx:RIY5ZZqAsbzFIiWZYVkWTbWaKMVZeUoz2tQJCcG3CgYuhFWXRDTUhQ>
    <xmx:RYY5ZdLDIJ6YFR1ttxQ7mh393Xhg_dl0wsQT0TIOOTuG5imRmN402g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BDBADB60089; Wed, 25 Oct 2023 17:19:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <571211a1-470a-43da-a603-fd12a640b7a8@app.fastmail.com>
In-Reply-To: <ZTmEkYn1NcUvL58n@ghost>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
 <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <ZTl8gauEst2NGrw6@ghost>
 <059f17e6-e240-40fa-8742-7844ad3b3502@app.fastmail.com>
 <ZTmEkYn1NcUvL58n@ghost>
Date:   Wed, 25 Oct 2023 23:18:40 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Charlie Jenkins" <charlie@rivosinc.com>
Cc:     "Wang, Xiao W" <xiao.w.wang@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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

On Wed, Oct 25, 2023, at 23:11, Charlie Jenkins wrote:
>
> Thank you for pointing that out, I had not realized that macro existed.
> Since riscv keeps NET_IP_ALIGN at 0 it should be expected that
> ip_fast_csum is only called with 32-bit aligned addresses. I will update
> the comment and refer to that macro. riscv supports misaligned accesses
> but there are no guarantees of speed.

Just to clarify for your comment: riscv gets the default value of '2',
which is the one that makes the header aligned.

      Arnd
