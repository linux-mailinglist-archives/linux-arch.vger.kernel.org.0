Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92C5F63AA
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiJFJbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiJFJbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 05:31:15 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1256171A;
        Thu,  6 Oct 2022 02:31:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id ED8A7580420;
        Thu,  6 Oct 2022 05:31:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 05:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1665048673; x=1665052273; bh=fyun8m++OCXQaSzrMWRm/s4+lmV+aUX5yLj
        qKG/xgY8=; b=vuJSqGHrU/yyR5YCgbXwOv+J4DvFookOIeodLLhOjW+m/5FDrKi
        5IEYVbn0oVMcet1C6FBAEjuu6TGz5Iw2IrjWQCA3+RNHPYIrPl8OvNbPvXCJ3C8A
        3Wu1uxLznmLilePKxNFMVgWItZXnxKqzNN+rxbyl2WpI4a8AS+rI66pfCGNHUIn6
        iRVSmqYKMuv1nXOcdxDD77Rw0/CbVLuc4cCkpj6tEzUMexOUvUFj8MZV5z/73isA
        tbgDmg9be21TS05Re896BLn/bwG57BxXu9DGNCPNLPv8NMOmMd451ewqTLd/pA+i
        u6A8WQL9t9fMICQsWkSTxNfxhHDQKK6rBWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1665048673; x=
        1665052273; bh=fyun8m++OCXQaSzrMWRm/s4+lmV+aUX5yLjqKG/xgY8=; b=D
        29u2egZPzdgQwDiA0GEWSq5TR4F1bxUUtqyxImUaz6SOxVTKUFHPHAW0HGEQGM2l
        dGamWgTwuZMkMLn3Aubmd/GmKKoF+ngDLVY0OyKB+JW1U7YTrZPYIx7zJmW3cvtp
        mEcjwLbLj33vPH240ktkyZ+X5Rtuq3eQd/KGyK9sMONWVI+NRV3kCWbpLQtaiL62
        arpA/7sRDKpH7BwEEGrR3Gxygr6rQ0XqeGLmrSHdajUtyWNB4dc5r3qKfubAQhu9
        D0iXxdggaWVAPL1rZrn+7R3Wx0oaJzWengim91P0RlL2lZ0QHHB7Y7si/VQK8q7y
        AkXJP6OsdtFaT31P+4K+A==
X-ME-Sender: <xms:YaA-Y3vgfDvBONVNg63le4yi6XwNeErtPyf54WcphtCdDLhYe8iLwQ>
    <xme:YaA-Y4cyNGkfPovEZx5x1ix1nv3jlXU_7tjn0dXMasvpDFK1zSazY9eqZbqLNuvBd
    G3lWkl0XibAZcftj30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YaA-Y6wlc07QnDJPDUIvwT1AZZxsETF5f6nxd3ACad_k9t60dmiCWw>
    <xmx:YaA-Y2P-UgKVqZrVlUxk5Iad7afcTPwvzrUwwAbGcETEZFSIX7IZow>
    <xmx:YaA-Y38GaydwfrOG-FlFF9-jUH_jNwGOY_HhNWqAzxtFp0qoFmXIeQ>
    <xmx:YaA-Y0HMZg9DWC007Wi2TB0cDoxWSsb7NqAbx6wAZP3oGkgm1AVNXg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A25DDB60086; Thu,  6 Oct 2022 05:31:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <5c3aa67f-bc78-4abe-aba2-e5679cb66994@app.fastmail.com>
Date:   Thu, 06 Oct 2022 11:30:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] asm-generic updates for 6.1
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.1

for you to fetch changes up to e19d4ebc536dadb607fe305fdaf48218d3e32d7c:

  alpha: add full ioread64/iowrite64 implementation (2022-10-04 11:23:29 +0200)

----------------------------------------------------------------
asm-generic updates for v6.1

This contains a series from Linus Walleij to unify the linux/io.h
interface by making the ia64, alpha, parisc and sparc include
asm-generic/io.h. All functions provided by the generic header are
now available to all drivers, but the architectures can still override
this. For the moment, mips and sh still don't include asm-generic/io.h
but provide a full set of functions themselves.

There are also a few minor cleanups unrelated to this.

----------------------------------------------------------------
Arnd Bergmann (2):
      parisc: hide ioread64 declaration on 32-bit
      alpha: add full ioread64/iowrite64 implementation

Christophe Leroy (1):
      asm-generic: Remove empty #ifdef SA_RESTORER

Linus Walleij (5):
      alpha: Use generic <asm-generic/io.h>
      sparc: Fix the generic IO helpers
      parisc: Remove 64bit access on 32bit machines
      parisc: Use the generic IO helpers
      parisc: Drop homebrewn io[read|write]64_[lo_hi|hi_lo]

Randy Dunlap (1):
      ia64: export memory_add_physaddr_to_nid to fix cxl build error

 arch/alpha/include/asm/core_apecs.h  |  22 +++++-
 arch/alpha/include/asm/core_cia.h    |  22 +++++-
 arch/alpha/include/asm/core_lca.h    |  22 +++++-
 arch/alpha/include/asm/core_marvel.h |   4 +-
 arch/alpha/include/asm/core_mcpcia.h |  28 +++++++-
 arch/alpha/include/asm/core_t2.h     |  16 ++++-
 arch/alpha/include/asm/io.h          |  97 ++++++++++++++++++++++---
 arch/alpha/include/asm/io_trivial.h  |  18 ++++-
 arch/alpha/include/asm/jensen.h      |  18 ++++-
 arch/alpha/include/asm/machvec.h     |   8 ++-
 arch/alpha/kernel/core_marvel.c      |   2 +-
 arch/alpha/kernel/io.c               |  17 +++++
 arch/alpha/kernel/machvec_impl.h     |   2 +
 arch/ia64/mm/numa.c                  |   1 +
 arch/parisc/include/asm/io.h         | 134 ++++++++++++-----------------------
 arch/parisc/lib/iomap.c              |  60 ++++++----------
 arch/sparc/include/asm/io.h          |   2 +
 arch/sparc/include/asm/io_64.h       |  22 ++++++
 drivers/parisc/sba_iommu.c           |   6 ++
 include/asm-generic/signal.h         |   2 -
 20 files changed, 341 insertions(+), 162 deletions(-)
