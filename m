Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF55B2114
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiIHOpr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiIHOpi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 10:45:38 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79E5F7CE;
        Thu,  8 Sep 2022 07:45:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E13A4580AF9;
        Thu,  8 Sep 2022 10:45:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 10:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1662648328; x=1662651928; bh=SPGeHN3LN2nB2HRb9TjiHHXV8F5bbIF+9zw
        vQ8/QAmk=; b=a4AZUOTQfrf9eYAEhx7fvxawPNOycWbjQv+0SVtsIZSVJUv8eXH
        m7G2XiAXtLZpAoXfS25o3x6Z/tIToKvS48hRGuyH/DZqf5hJZFkkB8SsfbT1sR43
        0T6Vlw7sorJevCpZlc9cIgJ1rk07U0U5op6mZh2bibaL0RroG8amXDEuT7W6QpwX
        M3z6T1b0pgUNMLXOmYSxv4ntOvTCTG/joJ8jF7lSI6npthhm5UEPJvucwZKyDSkP
        P+I35hwGJJBqskSAyfkLu6tta5h1NA2H23SbL8YMWBxd9gQ7j7NzFzUngESLAsU7
        LuHuKR/NQbVlLURPCJd7Yt3yOD0iKair+mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662648328; x=
        1662651928; bh=SPGeHN3LN2nB2HRb9TjiHHXV8F5bbIF+9zwvQ8/QAmk=; b=m
        KD0AvHMzH10BAdpwtcrbiKa7ehS3AodA1dNMOzP18aJU1fUVQdXAEW6cUj6uO0Vu
        TJMs/ZkLwlQrildepm4bBybjcOGt35ziGfcC4sGiTtFipgjD39eaCL0RKqq0eYe9
        Zs+gCkMMXky1BXilt2hXOAW/2TH95Ry3pOoLnwMoBt0V90CfRouIxo1kIeZPsoPK
        gtclndlHe8l+dZ5huX/vuKCo+H2NQGDBDmsS/i/l2C2uI5yby/DCHNSLYW/vKMgI
        bPLKY5M96DUcdRY5Pc5m+Fy1Fr27DYXjYhoNTJUbctBBwHEnbz1f2rq9yAcaiWZI
        X2QQp+CRXmTuekNFoIopA==
X-ME-Sender: <xms:CAAaY-wN57JOxo-d-aoF_CWZGlpVZLz81l_ZnX3KBQE9JVbLqmeU_Q>
    <xme:CAAaY6QRaYggFq0V1-yw7yUm27v-6Z-l6nY8SCShVzF5STEPzizOGf0-_aNpfXK9A
    GUi_jP7n076Z9tIC18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CAAaYwUzJu3JTcRmbTb8kuJOMZVtqf0FQfZF1es-6rpYE1AvxEKWzw>
    <xmx:CAAaY0ijme5QnmjK2Ih3rXMQhT03R3LQN4wI8ov7cUNEN6PoLYeQkQ>
    <xmx:CAAaYwD6wNLusk8rw_reuSHRq2yEwaTsup0yCViqkPyex7V1QEpCzg>
    <xmx:CAAaY57P9prGQj2l8vECB_CfE06GTjvtopUc5p049L0vXberM65arg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7DFC8B60083; Thu,  8 Sep 2022 10:45:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <6ba5a3a9-93b0-49a9-ab49-7b6006e23067@www.fastmail.com>
Date:   Thu, 08 Sep 2022 16:44:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] asm-generic: SOFTIRQ_ON_OWN_STACK rework
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.0-rc4

for you to fetch changes up to 8cbb2b50ee2dcb082675237eaaa48fe8479f8aa5:

  asm-generic: Conditionally enable do_softirq_own_stack() via Kconfig. (2022-09-05 17:20:55 +0200)

----------------------------------------------------------------
asm-generic: SOFTIRQ_ON_OWN_STACK rework

Just one fixup patch, reworking the softirq_on_own_stack logic for
preempt-rt kernels as discussed in
https://lore.kernel.org/all/CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com/

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      asm-generic: Conditionally enable do_softirq_own_stack() via Kconfig.

 arch/Kconfig                          | 3 +++
 arch/arm/kernel/irq.c                 | 2 +-
 arch/parisc/kernel/irq.c              | 2 +-
 arch/powerpc/kernel/irq.c             | 4 ++--
 arch/s390/include/asm/softirq_stack.h | 2 +-
 arch/sh/kernel/irq.c                  | 2 +-
 arch/sparc/kernel/irq_64.c            | 2 +-
 arch/x86/include/asm/irq_stack.h      | 2 +-
 arch/x86/kernel/irq_32.c              | 2 +-
 include/asm-generic/softirq_stack.h   | 2 +-
 10 files changed, 13 insertions(+), 10 deletions(-)
