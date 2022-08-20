Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68D59AD0C
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiHTJ5B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 05:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJ5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 05:57:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522A65817;
        Sat, 20 Aug 2022 02:56:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BB5B45C023C;
        Sat, 20 Aug 2022 05:56:55 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Sat, 20 Aug 2022 05:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660989415; x=
        1661075815; bh=kdaAC0zun6WCRzZrFQuABIy5yngIWQJVDLY5tm6Rge8=; b=z
        +knXgqPKnfrkEtJt3sGcxBJkZpKqAlhwMj+QqtV7NIKmudXW+xI43CKG8YgL6vZJ
        S+9KJcginCH7pEYuufb333TcRdVsfDNn8XqVJi4E3PFturGyyJeJ4SA6lCpWzrkj
        OFsmmRRWRejokK5VnAcXed2s0S7ewXFOJB+oT1bApLYbjU9l3Ar3VDQK7Ku9KrYP
        50dOcrqVczXe7f5tA8Qqh/rqmIOlFfVY2nSUiaD0ddrGRSqkIphY+PJs3428Eu0x
        cZMmVloz03jtv4jKfTtffmIQb8X7pPIxr2tYJ+GLITRmrRH2yw4pxlbdgCltN48a
        F0SNp4PMdf0hwXu7pJR5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660989415; x=
        1661075815; bh=kdaAC0zun6WCRzZrFQuABIy5yngIWQJVDLY5tm6Rge8=; b=c
        b03vsUwSOrJyZsHaoz64PZG/b8vT8PvoGFWTRs/ouxm9HQ8DjeDVuSLWMYH4tiyu
        Bh0G192rNDe0HBf/yO3jontQ6iNfxBaMZxcMQYY3Vv+I7PFOup3dOndJFN9rWPSu
        vl21m2PTkj4Pjro9EyHZYvxqNLn4UbwnsBrQOzMZaXwb4wRPcnvyg6BpFQnBRV08
        voTuPfI36Cmj8C5kx4C9axXWX6ctW1lYapZwCwtOCokMakGYZ5/TpW0jq+JX3Qn8
        exTFGkJnOrMXaVWbIWQEEGDQiE4tYT7b9yrdyjmm6QsDgfAVMATg08N9Tn6NGKnb
        BXXlzfbhYMU3aIoMCMp6Q==
X-ME-Sender: <xms:5a8AY1AzzlEH9iwpT8crJF6DyqJULOrHkYz06MJuHNatB-PbJSoe-g>
    <xme:5a8AYzjVmwzJ2C062nhWTmuf5vSIvAuUCbn2bF6LjMq1yptC4veXiZSqjjmVLptHN
    jp8hPJKvBmVE96vg8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeifedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5a8AYwlx6nZMkS1JUqQJS2qoJb8Qie8GNWpawDqUswLRUpqZXBdTrA>
    <xmx:5a8AY_yij4oOSG2Nn4RcHKOGWp172zizxkky_Yur4fWl2oUoCRWkQQ>
    <xmx:5a8AY6SRKhAf3bEvX3gcm0w1uo5IFg15BiBUEjOJt19bYDYP1wZi_w>
    <xmx:568AY7KyxKX9cjDCuErqlHbJpvGzP-mmysuIGhLzHeFF-Zl7c-Ielw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C18AF36A0071; Sat, 20 Aug 2022 05:56:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <d91451dc-b9a2-4f10-b908-687cbb94bd73@www.fastmail.com>
In-Reply-To: <20220815123613.3291770-2-chenhuacai@loongson.cn>
References: <20220815123613.3291770-1-chenhuacai@loongson.cn>
 <20220815123613.3291770-2-chenhuacai@loongson.cn>
Date:   Sat, 20 Aug 2022 10:56:33 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Dinh Nguyen" <dinguyen@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Feiyang Chen" <chenfeiyang@loongson.cn>
Subject: Re: [PATCH V10 1/4] MIPS&LoongArch&NIOS2: Adjust prototypes of p?d_init()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B48=E6=9C=8815=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=881:36=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> From: Feiyang Chen <chenfeiyang@loongson.cn>
>
> We are preparing to add sparse vmemmap support to LoongArch. MIPS and
> LoongArch need to call pgd_init()/pud_init()/pmd_init() when populating
> page tables, so adjust their prototypes to make generic helpers can ca=
ll
> them.
>
> NIOS2 declares pmd_init() but doesn't use, just remove it to avoid bui=
ld
> errors.
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

For MIPS part :-)

[...]

Thanks
- Jiaxun

