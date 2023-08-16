Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034177E248
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjHPNMg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245448AbjHPNMV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 09:12:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A82712;
        Wed, 16 Aug 2023 06:12:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1C83A3200941;
        Wed, 16 Aug 2023 09:12:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 16 Aug 2023 09:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692191534; x=1692277934; bh=ZR
        T106v0hiqgMDmrCmS6eySFqP6+naQFmpKPfl1LC4A=; b=vnOGsLEBWf6iRqdcGe
        aKN5BWG0fJGAVU6JVIXw2r5trEbi4U8HGAkyD0+6xPYUebCuLdj/BgvHcLXQ3VWz
        DM86GEBHF5q/32OBTSQ1jAmNdTLIKRxKeTpDjT17bQgiqwms96qRRheqtFVNxibZ
        hwb68kNFhtdjc0mMi067Ltuik7Sz8Ub0DzdHrBDczZvPLkmNw72p43WeSwcA6Uhd
        jlAAKWZ6Al07ksUMdho4dSrDxHjxQNY7apoz3xCtR88uxRhkG9xkFDGscnnRTo5l
        WiGl5SfVo9TNOcr+c7G2H0chHBT3ePUGo7ZEdPXRmkEqRq9XFAWEkvI8BxCAowqC
        qylw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692191534; x=1692277934; bh=ZRT106v0hiqgM
        DmrCmS6eySFqP6+naQFmpKPfl1LC4A=; b=J253saPLCyaYpeIDlShp7YvjJgenV
        Ht1wUlTeHrAp+sMBGixfNZyUOs+v29RrlwC/Ff32lR6rR8Ptf/e2eCzpS7zg4WOK
        JYImEvkjD5EcWi13FT1qPlKSW+lxLDrtzkAe+SPR9zQ5OXHVI5o5ZavoAdaJjrvF
        mYs/WGtCNnfkuosVJ63bXDJlTIEuUUTya6gHAHWER0NlUHQA4H1Y/6SUWW5k7VGX
        CgelTXP6IMV844RF/eUDrOP+e8y9sL3KhWck/HUsbwg8VPAFec37UpcjQLZf4mWh
        uldSfe9YCl3AXDW8zsfBvdpTuUvrJa25ROBLezhFUT/OIhB48LEBQcZnA==
X-ME-Sender: <xms:K8vcZHO8GGtKsWaqQcWz1qpw7lABKKHBkhe_YqZz2EzFfnfT05ISiA>
    <xme:K8vcZB-r0Y6dBNf9v4cUL_7yF6uQAKk9sv7-_V3dOoxP_cvdsp3JLUt2S3lonyhXT
    Ls1v4Sr_SabhXlhEhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K8vcZGQO-MgdXr5jJldoDAQTHH6Ovgm0uSHlTvzKqKADkMryTvW66g>
    <xmx:K8vcZLtkn6_JnzcwFpD1vZfMnl9JtfeWnWAVnzNARqjEiksaIcRtOg>
    <xmx:K8vcZPepBT5Oy2rf3fQLmMFTs8XTCaO1eXozKuHr43Q9B1oPLmqWGA>
    <xmx:LsvcZBc7lnjA2S24fyGf-1Kbi-eqlGDcVFzJeOS9w2dwF53-Geo3HA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C1305B60089; Wed, 16 Aug 2023 09:12:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <0681968f-743d-4b55-bb1e-dbd665ea8783@app.fastmail.com>
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
References: <20230816055010.31534-1-rdunlap@infradead.org>
Date:   Wed, 16 Aug 2023 15:11:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Brian Cain" <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Jonas Bonn" <jonas@southpole.se>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        "Stafford Horne" <shorne@gmail.com>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "Max Filippov" <jcmvbkbc@gmail.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 16, 2023, at 07:50, Randy Dunlap wrote:
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
