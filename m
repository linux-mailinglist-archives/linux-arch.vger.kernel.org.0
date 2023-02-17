Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA1769B1D8
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 18:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBQRes (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 12:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBQRer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 12:34:47 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8F6EBB6;
        Fri, 17 Feb 2023 09:34:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 755E15C00E3;
        Fri, 17 Feb 2023 12:34:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Feb 2023 12:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1676655284; x=1676741684; bh=x9il+fO3+krgqqs56NmfA2a+M5nr8m3FwwW
        TXtFGt1o=; b=fb/JrZ9iZGQlh8+5SuYcFxULWSyo4PzYaXs1sAPRlr8/yUrl6fd
        S4806DoEvE+b2BA/vMGjzdD98RKzsgHNm2qjDOpO8QkV6xd8QPC1hLv4LxOVa2MO
        ZHmalVopeohqg5U5Jq6AF7VLIUzQlVyt5q2AJvtB7eocQ1yFDwMhxPUSBKDsSjib
        jxz2bliRtFsDmLm0Dejp/ya1miYN0C1rNgBV/sk5oaxuVatXLOtHSs9fWxu5mN2O
        TH5b6br63PqJ1fjgdVMQLNeo//63gjTcUlolFQcrD8hTEB6uab7mRnWNjPcAeIXg
        +dGa7kFEvQjRitu1S40ulDYmIs4+gMUtc1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676655284; x=
        1676741684; bh=x9il+fO3+krgqqs56NmfA2a+M5nr8m3FwwWTXtFGt1o=; b=S
        IcEmW7Tj0ccfKr5Rtl4H5CZxzggmjI4PZUJo+yvgVZ15yxnWTe0DhEd7TGJfnHzE
        KC8D32la5lfymvjf4x+swf+hzC7KXJUv8iCSr3oN/hvSnNZtkzHoe8Ld3QeIZlmA
        Ar/yWDnRpAnzJioPcaYFPRlv3CNejWxrvvcMtWtSnB+PXaKhXaHESXWYv0latMtJ
        FRoJbsimu8IcaMb4SeM0eq2BaWElTO2O3GdrhS/M7S8x5P2u/ncc1hTqiQI2ZDZe
        bqj30X2RoD6frUuJqJLm+xSXdatzkfTBR3Hay7sNF3+bUgGbag1eb6WrI64t/he1
        ADgHuJuqp1ZvbDktQQdjg==
X-ME-Sender: <xms:tLrvY4z3I4IkvpV8jMqGjMlTpH_9nKEC4RN8IoVzoU2Ki-JSmkdvlw>
    <xme:tLrvY8RKvp5d1fE0YgwJwu90qdrC2R90-qPRyKQ9zclqHcDsO-bsW65cPeJBnpuU9
    zcIPbNzUSW7dKVR7HE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tLrvY6VFQmrQnS9pMIdYJnB3cFH9mnrojZ3nELgtIoSyR-EYvGKKaw>
    <xmx:tLrvY2hRyVdtRRXEJ4D9lDfGO-EfUds9_mDinrTknDcDvqrEVNhHpQ>
    <xmx:tLrvY6Dd_rc0yuvU_6gnTqR02Qg8j2AdOl6Yqn9jVzxIKpH9sUCFug>
    <xmx:tLrvY9P-ayiGtp8fobjdk5u2lUTSkj6tlhRPEbveAFAzT8jcbJhJUw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27510B60086; Fri, 17 Feb 2023 12:34:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <ad5a0fc0-cad5-4730-9ddc-68285c6f13fc@app.fastmail.com>
Date:   Fri, 17 Feb 2023 18:34:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>, "Matt Evans" <mev@rivosinc.com>
Subject: [GIT PULL] asm-generic: cleanups for 6.3
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.3

for you to fetch changes up to a13408c205260716e925a734ef399899d69182ba:

  char/agp: introduce asm-generic/agp.h (2023-02-13 22:13:29 +0100)

----------------------------------------------------------------
asm-generic: cleanups for 6.3

Only three minor changes: a cross-platform series from Mike Rapoport to
consolidate asm/agp.h between architectures, and a correctness change
for __generic_cmpxchg_local() from Matt Evans.

----------------------------------------------------------------
Matt Evans (1):
      locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare against zero-extended 'old' value

Mike Rapoport (2):
      char/agp: consolidate {alloc,free}_gatt_pages()
      char/agp: introduce asm-generic/agp.h

 arch/alpha/include/asm/Kbuild       |  1 +
 arch/alpha/include/asm/agp.h        | 19 -------------------
 arch/ia64/include/asm/Kbuild        |  1 +
 arch/ia64/include/asm/agp.h         | 27 ---------------------------
 arch/parisc/include/asm/Kbuild      |  1 +
 arch/parisc/include/asm/agp.h       | 21 ---------------------
 arch/powerpc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/agp.h      | 19 -------------------
 arch/sparc/include/asm/Kbuild       |  1 +
 arch/sparc/include/asm/agp.h        | 17 -----------------
 arch/x86/include/asm/agp.h          |  6 ------
 drivers/char/agp/agp.h              |  6 ++++++
 include/asm-generic/agp.h           | 11 +++++++++++
 include/asm-generic/cmpxchg-local.h |  6 +++---
 14 files changed, 25 insertions(+), 112 deletions(-)
 delete mode 100644 arch/alpha/include/asm/agp.h
 delete mode 100644 arch/ia64/include/asm/agp.h
 delete mode 100644 arch/parisc/include/asm/agp.h
 delete mode 100644 arch/powerpc/include/asm/agp.h
 delete mode 100644 arch/sparc/include/asm/agp.h
 create mode 100644 include/asm-generic/agp.h
