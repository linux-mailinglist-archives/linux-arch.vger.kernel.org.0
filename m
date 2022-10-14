Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE275FF499
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJNUgI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJNUgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 16:36:08 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A68BA3AB3;
        Fri, 14 Oct 2022 13:36:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C33BC5C00DD;
        Fri, 14 Oct 2022 16:36:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 14 Oct 2022 16:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1665779765; x=1665866165; bh=cgminPofg1RLj9BxqHFC5hOgaw0qxKHmXer
        u9UifK8U=; b=Rz9PM/oHl/cDGtURC4z7HWomZI3JSg2jtSA2E7qnpFfUTcPO4rk
        GwxfMcR83vsvOH7u5ZkDlm5sdjfAPR7Z4rXB7QNElcPD3ik+1wNFTvoJOZa+Af2r
        kWaY05mkn/RFMQlcQ0A8HGMynttqEfiDan0UXKt8x3aQ+eOQbswrHdcfv4+xmUrm
        FFxV4uwaLdHhSqS6nEbm8F6hPBfikXFqkY5hCIgWoSZF17BO6vBDbpxP8j13jQ9E
        0Iq3uEssZhoRzQ0pZ12PxfJlvRX8+UK9a0yl8+CD2Gd7u+8oAfq8AO5kLzqUZ+c2
        j1zG+k27kgr8eQnr45eoklRTr9ewjpkK6PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665779765; x=
        1665866165; bh=cgminPofg1RLj9BxqHFC5hOgaw0qxKHmXeru9UifK8U=; b=O
        8aYNMEt6AISbzZRHNYmTYCVpRUvad6zg8iBIa/jtnft2bnqosS9NhOeTamUSoR+v
        TR2MOpW6OWq/4p7Y+hHe8qXEYFZlB/M/R15RFgXsw5Jm6cWzN1dtHJy6zVLDh+V/
        iO8J5OqH37CZlSmQeYmP6brlLR6STonjdCHhv8yllBlM1MEiEfYIU+WX/+d4yR4b
        FqSOZ7Izaf2uwzPKKB5pG8eGIVX1IBnEGzFyYpJ4l10TmvDbHnCNBGkQwed3gtPs
        THVnXqQ240FkZXUnpMYVzQeiqk+qPR+9jp5ceK1us8GmZyA6Tm3wYLQY7O8mzDoU
        4O4xDzOJx2fT8V/DeCtfQ==
X-ME-Sender: <xms:NchJY8za6Jng8suot_fwPaUW3pvIt44X8JtIygl-MnRFPdtf7WtNsg>
    <xme:NchJYwSNvqBOtgbOTy0iv47RfUM1Yr32jkBCyphFWaq5_am4Tw88b4Oca9srwXLsp
    huRtZeBYZbSLXDbF3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NchJY-X64xIUweHQx9o4Tb8ByybIVLOFvxbv4hRif137VGuufIA-cA>
    <xmx:NchJY6j9egT_BaHd1B_pnPJqzIOLxbnyJcCM_i_V4Nx7Qi8CBDIXPw>
    <xmx:NchJY-C0Zivv5Yx2Re6QK1i2gOhPHJ1p_84zToCK5sp3Kj6OZl70aw>
    <xmx:NchJY_4VBRQFlokrPcGOSR-zgumKaj_1BmNGp2m4dE2_bIPb9apngQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 930BCB60086; Fri, 14 Oct 2022 16:36:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <796854e9-ccbb-4dc1-aec6-bf3461d9d813@app.fastmail.com>
Date:   Fri, 14 Oct 2022 22:35:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: [GIT PULL] asm-generic: arch/alpha regression fix for 6.1
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

The following changes since commit e19d4ebc536dadb607fe305fdaf48218d3e32d7c:

  alpha: add full ioread64/iowrite64 implementation (2022-10-04 11:23:29 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes-6.1-1

for you to fetch changes up to 2e21c1575208786f667cb66d8cf87a52160b81db:

  alpha: fix marvel_ioread8 build regression (2022-10-10 10:33:55 +0200)

----------------------------------------------------------------
asm-generic: arch/alpha regression fix for 6.1

A last-minute regression fix in the previous asm-generic
branch contained a new regression from a typo.

----------------------------------------------------------------
Arnd Bergmann (1):
      alpha: fix marvel_ioread8 build regression

 arch/alpha/kernel/core_marvel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
