Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC94C123A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 13:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiBWMD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiBWMDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 07:03:14 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978ED9A4F2;
        Wed, 23 Feb 2022 04:02:47 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K3ZRH0zw5z9sSp;
        Wed, 23 Feb 2022 13:02:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fdRTHS91z5Eb; Wed, 23 Feb 2022 13:02:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K3ZRC1vpFz9sSZ;
        Wed, 23 Feb 2022 13:02:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 322AE8B778;
        Wed, 23 Feb 2022 13:02:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1iYLXu2sbge3; Wed, 23 Feb 2022 13:02:31 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.201])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C57C48B77C;
        Wed, 23 Feb 2022 13:02:30 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21NC2Kpc1148173
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:02:21 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21NC2JkP1148171;
        Wed, 23 Feb 2022 13:02:19 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH v6 0/6] Allocate module text and data separately
Date:   Wed, 23 Feb 2022 13:02:10 +0100
Message-Id: <cover.1645607143.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645617734; l=2137; s=20211009; h=from:subject:message-id; bh=5pa1UQ3HwyDZehywSQbAA8grWbJFM4jhq6fIuvgQR1I=; b=jJdm2BkQa9gEif7ktMD48MnhsQfgiuYZWvlcjGqSQAFNn+F4jLeHP92Z3FVUqVGswk4EzrSMHpf7 NMKzfvJiAla9UWgpQe57Sbh0hIA1WZxEqiQX3SY3RU2XBwRh4Nj1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series applies on top of my series "miscellanuous cleanups" v4.


This series allow architectures to request having modules data in
vmalloc area instead of module area.

This is required on powerpc book3s/32 in order to set data non
executable, because it is not possible to set executability on page
basis, this is done per 256 Mbytes segments. The module area has exec
right, vmalloc area has noexec. Without this change module data
remains executable regardless of CONFIG_STRICT_MODULES_RWX.

This can also be useful on other powerpc/32 in order to maximize the
chance of code being close enough to kernel core to avoid branch
trampolines.

Changes in v6:
- Rebased on top of my series "miscellanuous cleanups" v4

Changes in v5:
- Rebased on top of Aaron's series "module: core code clean up" v8

Changes in v4:
- Rebased on top of Aaron's series "module: core code clean up" v6

Changes in v3:
- Fixed the tree for data_layout at one place (Thanks Miroslav)
- Moved removal of module_addr_min/module_addr_max macro out of patch 1 in a new patch at the end of the series to reduce churn.

Changes in v2:
- Dropped first two patches which are not necessary. They may be added back later as a follow-up series.
- Fixed the printks in GDB

Christophe Leroy (6):
  module: Always have struct mod_tree_root
  module: Prepare for handling several RB trees
  module: Introduce data_layout
  module: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
  module: Remove module_addr_min and module_addr_max
  powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC on book3s/32 and
    8xx

 arch/Kconfig                |   6 +++
 arch/powerpc/Kconfig        |   1 +
 include/linux/module.h      |   8 +++
 kernel/debug/kdb/kdb_main.c |  10 +++-
 kernel/module/internal.h    |  13 +++--
 kernel/module/kallsyms.c    |  18 +++----
 kernel/module/main.c        | 103 +++++++++++++++++++++++++++---------
 kernel/module/procfs.c      |   8 ++-
 kernel/module/strict_rwx.c  |  11 ++--
 kernel/module/tree_lookup.c |  28 ++++++----
 10 files changed, 150 insertions(+), 56 deletions(-)

-- 
2.34.1

