Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2C3B4D58
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhFZH30 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5431 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFZH3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBlj962tnz74RW;
        Sat, 26 Jun 2021 15:23:41 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <bpf@vger.kernel.org>
Subject: [PATCH 0/9] sections: Unify kernel sections range check and use
Date:   Sat, 26 Jun 2021 15:34:30 +0800
Message-ID: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are three head files(kallsyms.h, kernel.h and sections.h) which
include the kernel sections range check, let's make some cleanup and
unify them.

1. cleanup arch specific text/data check and fix address boundary check in kallsyms.h
2. make all the basic kernel range check function into sections.h
3. update all the callers, and use the helper in sections.h to simplify the code
4. use memory_intersects() in sections.h instead of private overlap for dma-debug

Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-arch@vger.kernel.org 
Cc: iommu@lists.linux-foundation.org
Cc: bpf@vger.kernel.org 

Kefeng Wang (9):
  kallsyms: Remove arch specific text and data check
  kallsyms: Fix address-checks for kernel related range
  sections: Move and rename core_kernel_data() to is_kernel_data()
  sections: Move is_kernel_inittext() into sections.h
  kallsyms: Rename is_kernel() and is_kernel_text()
  sections: Add new is_kernel() and is_kernel_text()
  s390: kprobes: Use is_kernel() helper
  powerpc/mm: Use is_kernel_text() and is_kernel_inittext() helper
  dma-debug: Use memory_intersects() directly

 arch/powerpc/mm/pgtable_32.c   |  7 +---
 arch/s390/kernel/kprobes.c     |  9 +----
 arch/x86/kernel/unwind_orc.c   |  2 +-
 arch/x86/net/bpf_jit_comp.c    |  2 +-
 include/asm-generic/sections.h | 71 ++++++++++++++++++++++++++--------
 include/linux/kallsyms.h       | 21 +++-------
 include/linux/kernel.h         |  2 -
 kernel/cfi.c                   |  2 +-
 kernel/dma/debug.c             | 14 +------
 kernel/extable.c               | 33 ++--------------
 kernel/locking/lockdep.c       |  3 --
 kernel/trace/ftrace.c          |  2 +-
 mm/kasan/report.c              |  2 +-
 net/sysctl_net.c               |  2 +-
 14 files changed, 76 insertions(+), 96 deletions(-)

-- 
2.26.2

