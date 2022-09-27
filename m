Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982AF5EBC03
	for <lists+linux-arch@lfdr.de>; Tue, 27 Sep 2022 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiI0HxU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Sep 2022 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiI0HxS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Sep 2022 03:53:18 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD59AB42F;
        Tue, 27 Sep 2022 00:53:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25D8558046C;
        Tue, 27 Sep 2022 03:53:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 27 Sep 2022 03:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664265196; x=1664268796; bh=iNvjh4i9mw
        F6JRDaPaxX/vIgpwah9txmdb3jfkSg/08=; b=M9KR79LarEaKy+76YWqIPQKdpn
        6NHI6+zDHoArgOGq8UoZrBSLa9tfLiz3YkPzweg8TGXc0UyeuLf5MleCB7ZEmpkB
        mgEq8msJFI09WIwia7KBEkR6o+UkB5dd1Kb2vXTQ87MocogIk0kYBjxqHlKZVZWI
        JdA+rLjquhWV2qSK36nK0HG562/4BCw7i/vd3rok2xt3elEsk9KzyU6CxkhxAZZP
        RE6dvbAy4zdrHDwmL86aqS2b4rdRqhUtUyGKH/CAojCD8wU7IcNHMeeiKHQ4ODMA
        WHnuXme4ryLvC4LOx99VrxocV4tRFQQIzcyyVNmc9yVPWcIuLgU1PF7Qts/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664265196; x=1664268796; bh=iNvjh4i9mwF6JRDaPaxX/vIgpwah
        9txmdb3jfkSg/08=; b=hpsCb0iBo/odkC4ThNILbIap1XwWcUQ2+EFYXp5K8h3J
        SUCCEwW7PGPq9DXzjnLI8NpqJlSSWEldbQsxYKmnDZeMN9Gmz1Wn/Mnn8Hpcoq1z
        qL2BZDFRrYygFrREj4vXoYufrS2+kyMXuDUdNzqRN0fM0FenyzAmCYXRCPpQjKD8
        QYpXLs7KQb6w38ShwLn1P/K8nUjMNdmwXqvkfrXY9f68KI+v3ha10avN8gI502gj
        TkFrY0jZfdBO9JKjoo60x65Pc0tOrk6iqC2FXyqPBl+Xy0W03ppBQqyaFqM2XkX+
        OWbdsAc/5E8Gk7K82hvEO1QSvKCnwHPA/wpMA4bBRg==
X-ME-Sender: <xms:66syYzz5sktxbPsY2ersVAH3yELszpjsyoPPUuujGn_vXh5yXOwW4Q>
    <xme:66syY7QiZhqsMqNsw3vq7XNoawMFit5fLCtfw1xLXgCklrtZB20cRQ64Mv5LjYqSF
    gYTaDL61qy9MHYQjR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegfedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:66syY9XW-g2jIQhbjZFaMOFFgOXthpcex9HERtIks7oWDGRPvGM9Kw>
    <xmx:66syY9hCEFhZSwMSR_pkjkXLhWPDj2843FdPR0UB7LBgjzZXsq84gg>
    <xmx:66syY1BKXkZIBG3VRcBA3Eq_JV6gZRNqrmyHN9hWK-4Lz9XGf937Kg>
    <xmx:7KsyY4NRqsxgBmrpo662XeQTtYSZLz8n28x7kbi-7FGnkGI99rcfBA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE315B60089; Tue, 27 Sep 2022 03:53:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <e5e20a42-ced8-4ec2-8fa4-c8c33b54f0f2@www.fastmail.com>
In-Reply-To: <871qrx3hq3.fsf@email.froward.int.ebiederm.org>
References: <871qrx3hq3.fsf@email.froward.int.ebiederm.org>
Date:   Tue, 27 Sep 2022 09:52:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] a.out: Remove the a.out implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 27, 2022, at 12:15 AM, Eric W. Biederman wrote:
> In commit 19e8b701e258 ("a.out: Stop building a.out/osf1 support on
> alpha and m68k") the last users of a.out were disabled.
>
> As nothing has turned up to cause this change to be reverted, let's
> remove the code implementing a.out support as well.
>
> There may be userspace users of the uapi bits left so the uapi
> headers have been left untouched.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> I was reminded that while this code was successfully disabled
> in the kernel we haven't deleted it yet.
>
> Kees can you pick this up.
>
>  MAINTAINERS                           |   1 -
>  arch/alpha/include/asm/a.out.h        |  16 --
>  arch/alpha/kernel/Makefile            |   4 -
>  arch/alpha/kernel/binfmt_loader.c     |  46 ----
>  arch/alpha/kernel/osf_sys.c           |  30 ---
>  arch/arm/configs/badge4_defconfig     |   1 -
>  arch/arm/configs/corgi_defconfig      |   1 -
>  arch/arm/configs/ezx_defconfig        |   1 -
>  arch/arm/configs/footbridge_defconfig |   1 -
>  arch/arm/configs/hackkit_defconfig    |   1 -
>  arch/arm/configs/iop32x_defconfig     |   1 -
>  arch/arm/configs/jornada720_defconfig |   1 -
>  arch/arm/configs/lart_defconfig       |   1 -
>  arch/arm/configs/neponset_defconfig   |   1 -
>  arch/arm/configs/netwinder_defconfig  |   1 -
>  arch/arm/configs/rpc_defconfig        |   1 -
>  arch/arm/configs/spitz_defconfig      |   1 -
>  fs/Kconfig.binfmt                     |  33 ---
>  fs/Makefile                           |   1 -
>  fs/binfmt_aout.c                      | 342 --------------------------
>  fs/exec.c                             |   3 +-
>  include/linux/a.out.h                 |  18 --
>  22 files changed, 1 insertion(+), 505 deletions(-)
>  delete mode 100644 arch/alpha/include/asm/a.out.h
>  delete mode 100644 arch/alpha/kernel/binfmt_loader.c
>  delete mode 100644 fs/binfmt_aout.c
>  delete mode 100644 include/linux/a.out.h

For the arm defconfigs:

Acked-by: Arnd Bergmann <arnd@arndb.de>
