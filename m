Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9D7D82C3
	for <lists+linux-arch@lfdr.de>; Thu, 26 Oct 2023 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjJZMgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZMgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 08:36:46 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E10111;
        Thu, 26 Oct 2023 05:36:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6632E3200943;
        Thu, 26 Oct 2023 08:36:41 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 26 Oct 2023 08:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698323800; x=1698410200; bh=7Ou35+gtN5wPlKenTK4K7QdEWtUFHuuBjgj
        vnmJt2so=; b=ReK/1CPMHcj4oFv60BrYhPVG1zqUf01nfY1GKPWcNf69ULCkO8o
        cnP8yuy5WQmqBeNLBdnx5BJVYm6Z2qRPNSb+q6QXW4R2/Wrq1GKORxLZsnMNIxxY
        6PG1jsYaHi/9fj96JAPLCKrr9OoudlC6RYE6s3RFVPOJ7vN/X7LpY01xWgNevNa7
        +7RYD67P1hdjp4srkFlYBgiob57FfonvLTXqde6ri0zooVr+EH/pEoQRfKos+1Ce
        Og+toa/ApC7M0jWyY7X6ONmOShWHFE+3zpvt2vINo9n4c3Tke38wISEe4yipxtDc
        aGrfNOqerCiyDzq34glZqQRkLneKPgek2Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698323800; x=1698410200; bh=7Ou35+gtN5wPlKenTK4K7QdEWtUFHuuBjgj
        vnmJt2so=; b=loijJ83r4Let7U+9tN186djBs/D0jVuaFqRfByNiqGvgbW7yuIH
        IQ8/m6s50xNKY0IdAKlVGkIB/4qRjrxAEKKypCIPTL0w0PoqoXhUhj7PFx4dGFny
        bxj04yVY9TpU2p41660X7hqq6Fu4r2k3qIBdbfmlzEBMbE3PDa4QU8qzsanHZ4E5
        JA0NuwKApPdV5RXu+3uAayL+yZPFPb81lpcu/yEwS6jLq61QXKobVB4YcMeWelWO
        kwCXkgkxMiawKTxtP+8jpKLB9o0IMpMULEX7pxPQFVDIbSXoAoBG1nwDzapRYOut
        Eafmz0T75gCZLMLT+WgcQEvCTpR+efc8Erw==
X-ME-Sender: <xms:WF06ZR_oEwY7nQqu-JgSf15pAQKz9G4xHIa3ctQTy88aJKmxLQ7Mpw>
    <xme:WF06ZVvLj596brZxRQG7TJqhIdo__s5djGJhFbP2FEWlSYpn2Zlpqx3d2p0EmxVar
    eHfLlXHMV2CIkAKhRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:WF06ZfCvMXqNGY963g5bF6Z2PeH8e47FzVTL5fbAZPN2fAKmpPEVwQ>
    <xmx:WF06ZVf1XEF6HYkgxH75gdFnHnUl3TOVInxr2CRbL2SgbzZWFfugkA>
    <xmx:WF06ZWNkeDMfuZ9oB8bQT9QclpRwTSh6a8cFR5l3zjszWN7zUsVfDQ>
    <xmx:WF06ZXHVnC-rSqPU1vPCnVB1PSViYfPqZdx49gBkbH92JFieBzB7lA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 06B5A36A0075; Thu, 26 Oct 2023 08:36:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <a7e3fdcd-d5e6-4261-85be-3ec1221edf24@app.fastmail.com>
In-Reply-To: <20230921110424.215592-1-bhe@redhat.com>
References: <20230921110424.215592-1-bhe@redhat.com>
Date:   Thu, 26 Oct 2023 13:36:13 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Arnd Bergmann" <arnd@arndb.de>, mpe@ellerman.id.au,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>, hch@infradead.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Florian Fainelli" <f.fainelli@gmail.com>, deller@gmx.de
Subject: Re: [PATCH v5 0/4] arch/*/io.h: remove ioremap_uc in some architectures
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82023=E5=B9=B49=E6=9C=8821=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:04=EF=BC=8CBaoquan He=E5=86=99=E9=81=93=EF=BC=9A
> This patchset tries to remove ioremap_uc() in the current architectures
> except of x86 and ia64. They will use the default ioremap_uc version
> in <asm-generic/io.h> which returns NULL. Anyone who wants to add new
> invocation of ioremap_uc(), please consider using ioremap() instead or
> adding a new ARCH specific ioremap_uc(), or refer to the callsite
> in drivers/video/fbdev/aty/atyfb_base.c.
>
> This change won't cuase breakage to the current kernel because in the
> only ioremap_uc callsite, an adjustment is made to eliminate impact in
> patch 1 of this series.
>
> To get rid of all of them other than x86 and ia64, add asm-generic/io.h
> to asm/io.h of mips ARCH. With this adding, we can get rid of the
> ioremap_uc() in mips too. This is done in patch 2. And a followup patch
> 4 is added to remove duplicated code according to Arnd's suggestion.
>
> Test:
> =3D=3D=3D=3D=3D
> Except of Jiaxun's efficient testing on patch 2/4, I also did cross co=
mpiling
> of this series on mips64, building passed.
>

For whole series:

Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Hi Arnd and Thomas,

I've got some work pending based on this series, however I'm unclear abo=
ut
which tree this series will go since both of you give acked-by.

Given that there are some tree-wide modifications, I guess it should go =
into
Arnd's asm-generic tree?

Thanks
--=20
- Jiaxun
