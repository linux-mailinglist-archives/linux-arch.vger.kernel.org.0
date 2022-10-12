Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE43B5FC379
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 12:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJLKKS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLKKM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 06:10:12 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB172FC3D;
        Wed, 12 Oct 2022 03:10:07 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MnT0s0w21z9smn;
        Wed, 12 Oct 2022 12:10:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GbtNKkzFQGBY; Wed, 12 Oct 2022 12:10:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MnT0r72dfz9smC;
        Wed, 12 Oct 2022 12:10:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA9368B770;
        Wed, 12 Oct 2022 12:10:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lM_RYFeq6Elz; Wed, 12 Oct 2022 12:10:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B03D8B76C;
        Wed, 12 Oct 2022 12:10:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 29CA9oZU1165765
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:09:50 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 29CA9mL71165760;
        Wed, 12 Oct 2022 12:09:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com
Subject: [RFC PATCH 0/8] mm: ioremap: Convert architectures to take GENERIC_IOREMAP way (Alternative)
Date:   Wed, 12 Oct 2022 12:09:36 +0200
Message-Id: <cover.1665568707.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665569381; l=1985; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=qbQ5kiECI3xAGYRd2tHO6GsSKBbKenBkBtxcE+svX30=; b=j91j73TEntd2i4rb6Z5GxHS2S/s4t3KOUF5BfEWDBhSV8rZQmS7XmJGvVQALTIK44dOT9K0XRGDF u59gxZ6KAI6EwAGY8jSZ7DgdUAOBOAv8zgTDp4VNKLQ6RbPZyXab
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: 

As proposed in the discussion related to your series, here comes an
exemple of how it could be.

I have taken it into ARC and IA64 architectures as an exemple. This is
untested, even not compiled, it is just to illustrated my meaning in the
discussion.

I also added a patch for powerpc architecture, that one in tested with
both pmac32_defconfig and ppc64_le_defconfig.

From my point of view, this different approach provide less churn and
less intellectual disturbance than the way you do it.

Open for discussion.

Baoquan He (5):
  hexagon: mm: Convert to GENERIC_IOREMAP
  openrisc: mm: remove unneeded early ioremap code
  mm: ioremap: allow ARCH to have its own ioremap definition
  arc: mm: Convert to GENERIC_IOREMAP
  ia64: mm: Convert to GENERIC_IOREMAP

Christophe Leroy (3):
  mm/ioremap: Define generic_ioremap_prot() and generic_iounmap()
  mm/ioremap: Consider IOREMAP space in generic ioremap
  powerpc: mm: Convert to GENERIC_IOREMAP

 arch/arc/Kconfig              |  1 +
 arch/arc/include/asm/io.h     |  7 +++---
 arch/arc/mm/ioremap.c         | 46 +++--------------------------------
 arch/hexagon/Kconfig          |  1 +
 arch/hexagon/include/asm/io.h |  9 +++++--
 arch/hexagon/mm/ioremap.c     | 44 ---------------------------------
 arch/ia64/Kconfig             |  1 +
 arch/ia64/include/asm/io.h    | 11 ++++++---
 arch/ia64/mm/ioremap.c        | 45 ++++++----------------------------
 arch/openrisc/mm/ioremap.c    | 22 ++++-------------
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/include/asm/io.h | 11 ++++++---
 arch/powerpc/mm/ioremap.c     | 26 +-------------------
 arch/powerpc/mm/ioremap_32.c  | 25 ++++++++-----------
 arch/powerpc/mm/ioremap_64.c  | 22 +++++++----------
 include/asm-generic/io.h      |  7 ++++++
 mm/ioremap.c                  | 33 +++++++++++++++++++------
 17 files changed, 98 insertions(+), 214 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

-- 
2.37.1

