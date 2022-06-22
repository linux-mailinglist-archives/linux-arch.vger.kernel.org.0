Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95F554915
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiFVKQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiFVKQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 06:16:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C53B3C3;
        Wed, 22 Jun 2022 03:16:04 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSfMV2w5KzSh96;
        Wed, 22 Jun 2022 18:12:38 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 18:15:56 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 18:15:56 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <arnd@arndb.de>
Subject: [PATCH v2 0/5] objtool: Reorganize x86 arch-specific code
Date:   Wed, 22 Jun 2022 18:13:39 +0800
Message-ID: <20220622101344.38002-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch set reorganize current x86 related code in objtool, [1-3] move
arch-specific to arch files and extract some common codes, [4] fixes a
cross-compile problem and [5] fixes a call destination search bug.

It make objtool more arch-generic, which makes other patches on different
architectures easier to be reviewed and merged.

Tested on x86 with unwind on kernel and module context.

---
v2 Change:
[5/5] objtool: use arch_jump_destination in read_intra_function_calls
---
Chen Zhongjin (3):
  objtool: Add generic symbol for relocation type
  objtool: Specify host-arch for making LIBSUBCMD
  objtool: use arch_jump_destination in read_intra_function_calls

Madhavan T. Venkataraman (2):
  objtool: Make ORC type code arch-specific
  objtool: Make ORC init and lookup code arch-generic

 arch/x86/include/asm/unwind.h                 |   5 -
 arch/x86/kernel/module.c                      |   7 +-
 arch/x86/kernel/unwind_orc.c                  | 256 +----------------
 arch/x86/kernel/vmlinux.lds.S                 |   2 +-
 .../asm => include/asm-generic}/orc_lookup.h  |  42 +++
 kernel/Makefile                               |   2 +
 kernel/orc_lookup.c                           | 261 ++++++++++++++++++
 tools/objtool/Makefile                        |   2 +-
 tools/objtool/arch/x86/Build                  |   1 +
 tools/objtool/arch/x86/include/arch/elf.h     |   5 +-
 tools/objtool/arch/x86/orc.c                  | 137 +++++++++
 tools/objtool/arch/x86/special.c              |   5 +-
 tools/objtool/check.c                         |  14 +-
 tools/objtool/include/objtool/orc.h           |  17 ++
 tools/objtool/orc_dump.c                      |  59 +---
 tools/objtool/orc_gen.c                       |  79 +-----
 16 files changed, 492 insertions(+), 402 deletions(-)
 rename {arch/x86/include/asm => include/asm-generic}/orc_lookup.h (51%)
 create mode 100644 kernel/orc_lookup.c
 create mode 100644 tools/objtool/arch/x86/orc.c
 create mode 100644 tools/objtool/include/objtool/orc.h

-- 
2.17.1

