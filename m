Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C6651B6B
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 08:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiLTHS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 02:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiLTHSS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 02:18:18 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970311F;
        Mon, 19 Dec 2022 23:18:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 901993200984;
        Tue, 20 Dec 2022 02:18:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 20 Dec 2022 02:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1671520685; x=1671607085; bh=K3K6NVaUa+62P6XLkRs/A2J6as2Tpe1jcJ3
        LQAubuOk=; b=vNVm1rx90pQteNf+kc1Kx4JBHKD5AOFQgpRuvJ2L/0Uy8crpRv4
        bvi3A8vUOHtsD6v2ip4j1HL+GzUtshECiGMuZarIJgCLfwPCofjaG831/InQYZjU
        2AfiNlHULO9gnk0gGyTg3dxZpCEQwmYOsP6I8PAuJVVHyhlRUghWEesaJH/VPtiv
        Ioe+CZwiCxqQdRMWnFzUIGZP9Jg/bk3zfSr5iVRemje2cAB14sdLwF/O03l8DLpW
        tnjWwencHsPCZsZ00iNoP9k7Wn70NBlA0KV52mTaHBT6UQ/xRzfqjC9OPKZCu7l0
        jewcWXEAzJiXldABAHgIhunPAgYWKP1BfAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671520685; x=
        1671607085; bh=K3K6NVaUa+62P6XLkRs/A2J6as2Tpe1jcJ3LQAubuOk=; b=o
        L1YU2esUidJhggFGhSyxLcVkhSnM3qStkMFgXnGtCVX7Fc/vNH4dOQYnfqeqkHgX
        zTd41a4YBG2OfDZrKAunQVHU5fBnS2zokbxVWaE10RadULzYGvj2T0VPe2puMdBd
        4GSIDpm5lOSAop1lixUsaI2kIzkV8JHG6HVR5C7gXgyLgzIwl4CQpswaUtMgj4tZ
        m/8Tj0qv/0sc4O9BdWSdhaL50rGrpWgSuwP/c8xYpuWBd+4Ev03X9rPrAcK1s1JP
        /N/M5SPZBxxBy9VeGAWus4zns72o5ShtMIgGRWe4Q9mQKY+GTMZHdKJ3S4C6Fyf9
        xWYzWZjdnqYzX74LA8SIA==
X-ME-Sender: <xms:rGGhYxEYSDX-m6Uk9O0Fa3DUjSenCQXHM7705xu-k-Zn1au9JQofZg>
    <xme:rGGhY2Wh86pzP62Icta6fHCSzNgUQK0VU1BIwWOG2dzUugnf_q7oD_xpWjDEKxoCo
    2_qcfEP1GXQOwd0xz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rWGhYzLOOAPK-rb3Pq7CYgCua8hRMyctSBzZgSpi1I8SvdEDJoaiBQ>
    <xmx:rWGhY3EjbB8x_cJmfYkJUCjPLs6vRXci3Jk7IGZnmjsuFVQyfpXDUw>
    <xmx:rWGhY3VhUm_jXk0rzuRgr-1Cw4oBnFFtTLePjoWuP3zcDMSvGk7i8Q>
    <xmx:rWGhY4e_6rWKSLaEcc84-zDuQovp3THisQg6byZcmL0DuEaWLIV8Qg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E154FB60086; Tue, 20 Dec 2022 02:18:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <1b6fcf4b-41b5-49d8-be6b-9259b2f35cd8@app.fastmail.com>
Date:   Tue, 20 Dec 2022 08:16:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL, v2] asm-generic bits for 6.2
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.2-1

for you to fetch changes up to 32975c491ee410598b33201344c123fcc81a7c33:

  uapi: Add missing _UAPI prefix to <asm-generic/types.h> include guard (2022-12-01 16:22:06 +0100)

----------------------------------------------------------------
asm-generic bits for 6.2

There are only three fairly simple patches. The #include
change to linux/swab.h addresses a userspace build issue,
and the change to the mmio tracing logic helps provide
more useful traces.
---
v2: correct git URL
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
