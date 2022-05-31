Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7E5389CB
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiEaCJg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 22:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiEaCJg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 22:09:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27CA5C772;
        Mon, 30 May 2022 19:09:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBwfL3YjGzgYTq;
        Tue, 31 May 2022 10:07:54 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:09:32 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:09:32 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
CC:     <jpoimboe@redhat.com>, <peterz@infradead.org>,
        <madvenka@linux.microsoft.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <andreyknvl@gmail.com>, <wangkefeng.wang@huawei.com>,
        <andrealmeid@collabora.com>, <mhiramat@kernel.org>,
        <mcgrof@kernel.org>, <christophe.leroy@csgroup.eu>,
        <dmitry.torokhov@gmail.com>, <yangtiezhu@loongson.cn>,
        <dave.hansen@linux.intel.com>
Subject: [PATCH 0/4] objtool: Reorganize x86 arch-specific code 
Date:   Tue, 31 May 2022 10:07:40 +0800
Message-ID: <20220531020744.236970-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
arch-specific to arch files and extract some common codes and [4] fixes
a cross-compile problem.

It make objtool more arch-generic, which makes other patches on different
architectures easier to be reviewed and merged.

Tested on x86 with unwind on kernel and module context.

Rebased to:
tip/objtool/core:22682a07acc3 (objtool: Fix objtool regression on x32 systems)

Chen Zhongjin (2):
  objtool: Add generic symbol for relocation type
  objtool: Specify host-arch for making LIBSUBCMD

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
 tools/objtool/check.c                         |  12 +-
 tools/objtool/include/objtool/orc.h           |  17 ++
 tools/objtool/orc_dump.c                      |  59 +---
 tools/objtool/orc_gen.c                       |  79 +-----
 16 files changed, 491 insertions(+), 401 deletions(-)
 rename {arch/x86/include/asm => include/asm-generic}/orc_lookup.h (51%)
 create mode 100644 kernel/orc_lookup.c
 create mode 100644 tools/objtool/arch/x86/orc.c
 create mode 100644 tools/objtool/include/objtool/orc.h

-- 
2.17.1

