Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCED07A9708
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjIURLB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjIURKb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 13:10:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B1EA5C9;
        Thu, 21 Sep 2023 10:05:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D723832009EB;
        Thu, 21 Sep 2023 08:25:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 21 Sep 2023 08:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695299122; x=1695385522; bh=Qt
        VbcPXLwmPHbqM7Z1JFnFzIc7YAtI2BYnyrt95OPhk=; b=Cu8cylWkfAYqM4kdKA
        E0MUXpGBIZnygnpCeE2qbClbzc+r82AC9G4kcFl6d1f3KQ9tZrKxdWm358GD10FS
        9A+C918gXnGOtCToboUZLWoDRNUVoJaIy+r3JpfHBeMRhjQpQNCyEFOTDeb7SxiU
        TR/aIxr7lhgp2kJxbXovIZc3qBCBRm8amFslmXGS5B6bAmUycT5hpwJMkw+mizKH
        mwzax1tg1v/Pj9uP/kgxsP+qwQxqWkUnkRVdcoDpES9bGtlPC9dWgoT71IhvgLYd
        w0Wxq4wdNoEj4M1ps7kktxszrSjUuQpJj1Tg42EhY1N0/zfctp1UZeDFx0NNX3jF
        f+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695299122; x=1695385522; bh=QtVbcPXLwmPHb
        qM7Z1JFnFzIc7YAtI2BYnyrt95OPhk=; b=DDeBOwHhwDXEaTztHATTvfe4jIk3Y
        4FIjRbYQ0f9lgPxfl0ZlMvexXSzxTp4DQ53S2Vnm+3vjxu7Y2lLSW0Ro7rBnV4ka
        3OkI0SKH5tgaLTClViXESDyvCGcS3m5Ky0PAaCNuETCPt9EOW9iqURw3B3vg6I8W
        3pva8IVYF+FH+UR7vBPjaYU1RKQTORhvnX6ryUkq+wIZoANCzbunVeqB4honcHEZ
        N+yIOBxhjzNubNM90lyVdk4NM71Y86FLGKYRdpg2E9Df79DsBbfX+J/kyee5NZs8
        EsoYTAz0Ko1lEzgI+VdpRcUJxDFUUIM7QQ8dNks8sZcWhfxnMoX7yFxbg==
X-ME-Sender: <xms:MTYMZSSEg_SSqGx5AGZe4oU9f0aKxlr-qUhBubmHtIx8pVYcnMCn-Q>
    <xme:MTYMZXy33ZVSyvUq9BX316kG4OfB-mZMOPOiTUehtC2J2ttC6xtsAe2WiBeeojUEA
    LD0EcVt96vrCtR5E7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MTYMZf3f8KfjcqJQRDz8SU1PHtJvnR0afaNP21xbMt37zhvmWSoXOg>
    <xmx:MTYMZeAY7BKRDTnqh1zyDybLCkYzoVpj29UVdZ2Am7NmWDsHcr8JaQ>
    <xmx:MTYMZbibo5dvZkxXU98F6xDuuKRk5XuShs5_fQaka5qHJiOnHPAvwg>
    <xmx:MjYMZWR-kXl52lIkKZjN4zS-ggkjUeUB_2c2-uIknDLPgbAtRzT8iA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50E5CB60089; Thu, 21 Sep 2023 08:25:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <2c3e0545-c00e-412f-9ab3-d736d07df045@app.fastmail.com>
In-Reply-To: <20230921110424.215592-5-bhe@redhat.com>
References: <20230921110424.215592-1-bhe@redhat.com>
 <20230921110424.215592-5-bhe@redhat.com>
Date:   Thu, 21 Sep 2023 08:24:59 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Huacai Chen" <chenhuacai@kernel.org>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v5 4/4] mips: io: remove duplicated codes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 21, 2023, at 07:04, Baoquan He wrote:
> By adding <asm-generic/io.h> support, the duplicated phys_to_virt
> can be removed to use the default version in <asm-gneneric/io.h>.
>
> Meanwhile move isa_bus_to_virt() down below <asm-generic/io.h> including
> to fix the compiling error of missing phys_to_virt definition.
>

Acked-by: Arnd Bergmann <arnd@arndb.de>
