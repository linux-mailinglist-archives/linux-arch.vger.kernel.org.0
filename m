Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305334186EA
	for <lists+linux-arch@lfdr.de>; Sun, 26 Sep 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhIZHTq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Sep 2021 03:19:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:19364 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhIZHTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Sep 2021 03:19:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HHH7N57H2zRSQg;
        Sun, 26 Sep 2021 15:13:52 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:07 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <ryabinin.a.a@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <bpf@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/9] sections: Unify kernel sections range check and use
Date:   Sun, 26 Sep 2021 15:20:39 +0800
Message-ID: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are three head files(kallsyms.h, kernel.h and sections.h) which
include the kernel sections range check, let's make some cleanup and
unify them.

1. cleanup arch specific text/data check and fix address boundary check
   in kallsyms.h
2. make all the basic/core kernel range check function into sections.h
3. update all the callers, and use the helper in sections.h to simplify
   the code

After this series, we have 5 APIs about kernel sections range check in
sections.h

 * is_kernel_rodata()		--- already in sections.h
 * is_kernel_core_data()	--- come from core_kernel_data() in kernel.h
 * is_kernel_inittext()		--- come from kernel.h and kallsyms.h
 * __is_kernel_text()		--- add new internal helper
 * __is_kernel()		--- add new internal helper

Note: For the last two helpers, people should not use directly, consider to
      use corresponding function in kallsyms.h.

v3:
- Add Steven's RB to patch2
- Introduce two internal helper, then use is_kernel_text() in core_kernel_text()
  and is_kernel() in kernel_or_module_addr() suggested by Steven

v2:
https://lore.kernel.org/linux-arch/20210728081320.20394-1-wangkefeng.wang@huawei.com/
- add ACK/RW to patch2, and drop inappropriate fix tag
- keep 'core' to check kernel data, suggestted by Steven Rostedt
  <rostedt@goodmis.org>, rename is_kernel_data() to is_kernel_core_data()
- drop patch8 which is merged
- drop patch9 which is resend independently

v1:
https://lore.kernel.org/linux-arch/20210626073439.150586-1-wangkefeng.wang@huawei.com

Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org 
Cc: bpf@vger.kernel.org 

Kefeng Wang (9):
  kallsyms: Remove arch specific text and data check
  kallsyms: Fix address-checks for kernel related range
  sections: Move and rename core_kernel_data() to is_kernel_core_data()
  sections: Move is_kernel_inittext() into sections.h
  x86: mm: Rename __is_kernel_text() to is_x86_32_kernel_text()
  sections: Provide internal __is_kernel() and __is_kernel_text() helper
  mm: kasan: Use is_kernel() helper
  extable: Use is_kernel_text() helper
  powerpc/mm: Use is_kernel_text() and is_kernel_inittext() helper

 arch/powerpc/mm/pgtable_32.c   |  7 +---
 arch/x86/kernel/unwind_orc.c   |  2 +-
 arch/x86/mm/init_32.c          | 14 +++----
 include/asm-generic/sections.h | 75 ++++++++++++++++++++++++++--------
 include/linux/kallsyms.h       | 13 +-----
 include/linux/kernel.h         |  2 -
 kernel/extable.c               | 33 ++-------------
 kernel/locking/lockdep.c       |  3 --
 kernel/trace/ftrace.c          |  2 +-
 mm/kasan/report.c              |  2 +-
 net/sysctl_net.c               |  2 +-
 11 files changed, 75 insertions(+), 80 deletions(-)

-- 
2.26.2

