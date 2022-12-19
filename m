Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5E6513EA
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLSU3U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 15:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiLSU3R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 15:29:17 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0CD6599;
        Mon, 19 Dec 2022 12:29:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BDCA5C0120;
        Mon, 19 Dec 2022 15:29:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 19 Dec 2022 15:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1671481756; x=1671568156; bh=pfkagIuhE7CfwQL8bON3iNU6to3dC/ZAaMg
        aVhzAzk8=; b=pqBRIDz82N44U8PO+/wzIHFE0rKim54Zsp+QZ6euvHd+WLNiP6y
        8+V4Cy1k6t2qlyPG0xxtVsSUyu00lvGw7syrXZ7JDnIqk0kr7+0mIJUhPxFRecd1
        EvNJcs+PEUOnUF+zdczaCKPVpzlLeov/lOZR/J9kdsspzDrGGSjng5n84V8v6hGn
        kcGHVP01vcdNaJjgQMU55FDZOtT3UfJAGf59HJJG+GOGP/dySMQXwKgta6XGR8sj
        S+lbYlySHn5eBUsok+t+BvcowMm+RSsd856amCXOBqDavjBtR62yLgSwvDpjr3wF
        l0Pa/cCLtpas1uxeqGnxG1rK6XlqCjmVdxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671481756; x=
        1671568156; bh=pfkagIuhE7CfwQL8bON3iNU6to3dC/ZAaMgaVhzAzk8=; b=q
        mInxkw0FT7n564cu6pyhx6mR9AXpoaXMo6arUjoevn0z1hwvEvCGbErYljk5+x2c
        WqYYNr0PL1+DH7Ck7aS/+xhdG0XLQLaM/8yWWsuOdxSOTeR1aixWUk6VgrciytCv
        DZQyUUUcQrZjegENnXveBizRaWv5IAN4S4eVAqBfceQPtxUZGQ9//GnO+ejtRmWA
        vH/0I1jzy4KTbemYid3IZp0bkTyUgqTCNGEj/tWperCrN3CBWf5EFt2Jt5Fb3Qbs
        NwiIHrclZq1ZVFC0BbpIJbvvuGL9K7+EsuHJRGx5Paykvy1/QJSogO+bTxqTWnvF
        9elrljqRQjqvz8vgwG5Nw==
X-ME-Sender: <xms:nMmgY5Ca97AY8VILImRKzfjMVtjHN2X9FA7AagL9OLPfyGWRA2YHXw>
    <xme:nMmgY3hLAHNKXWR5zi7bUJeKiH4qMgF_yKna4UrpzoxodiXiVkE5Uq-S0dMjZ4gzh
    yJKYaO84PgrVSdSjtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nMmgY0lK7tR1ZqUQwaNh2wMQJk5uBUePihilqf4VyegKoU5EvxTq9A>
    <xmx:nMmgYzyjYs4R7layYNS9nOFVn0ilvyg-kg_TB2bLt23z9mLgRij30w>
    <xmx:nMmgY-QsOz6xw4asOr-81Af1UmthZjEggOBT6X-mtfsmmrElvqzORg>
    <xmx:nMmgY34Hta4tlSBLgHsyodNrUOs-ELzLINqz8M6CTlMUBlq00b_Giw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B7D8B60086; Mon, 19 Dec 2022 15:29:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
Date:   Mon, 19 Dec 2022 21:28:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: [GIT PULL] asm-generic bits for 6.2
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

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git asm-generic-6.2-1

for you to fetch changes up to 32975c491ee410598b33201344c123fcc81a7c33:

  uapi: Add missing _UAPI prefix to <asm-generic/types.h> include guard (2022-12-01 16:22:06 +0100)

----------------------------------------------------------------
asm-generic bits for 6.2

There are only three fairly simple patches. The #include
change to linux/swab.h addresses a userspace build issue,
and the change to the mmio tracing logic helps provide
more useful traces.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      uapi: Add missing _UAPI prefix to <asm-generic/types.h> include guard

Matt Redfearn (1):
      include/uapi/linux/swab: Fix potentially missing __always_inline

Sai Prakash Ranjan (1):
      asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug info

 include/asm-generic/io.h         | 80 ++++++++++++++++++++--------------------
 include/trace/events/rwmmio.h    | 43 +++++++++++++--------
 include/uapi/asm-generic/types.h |  6 +--
 include/uapi/linux/swab.h        |  2 +-
 lib/trace_readwrite.c            | 16 ++++----
 5 files changed, 79 insertions(+), 68 deletions(-)
