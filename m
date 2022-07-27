Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5085581E30
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 05:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiG0DXq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiG0DXq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 23:23:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D222FA;
        Tue, 26 Jul 2022 20:23:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lszc901VYz9ssr;
        Wed, 27 Jul 2022 11:22:33 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:23:42 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:23:42 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
CC:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] kprobes: Forbid probing on kprobe_insn_slot
Date:   Wed, 27 Jul 2022 11:20:58 +0800
Message-ID: <20220727032058.60444-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Syzkaller reported a BUG on arm64:
Unrecoverable kprobe detected.
Dumping kprobe:
Name: (null)
Offset: 0
Address: 0xffffa00010019000
------------[ cut here ]------------
kernel BUG at arch/arm64/kernel/probes/kprobes.c:235!
Internal error: Oops - BUG: 0 [#1] SMP
Modules linked in:
CPU: 1 PID: 31060 Comm: syz-executor.6 Not tainted 5.10.0 #11
...
Call trace:
 reenter_kprobe arch/arm64/kernel/probes/kprobes.c:234 [inline]
 kprobe_handler+0x23c/0x26c arch/arm64/kernel/probes/kprobes.c:339
 kprobe_breakpoint_handler+0x24/0x34 arch/arm64/kernel/probes/kprobes.c:406
 call_break_hook+0xf4/0x13c arch/arm64/kernel/debug-monitors.c:322
 brk_handler+0x2c/0xa0 arch/arm64/kernel/debug-monitors.c:329
 do_debug_exception+0x140/0x230 arch/arm64/mm/fault.c:867
 el1_dbg+0x38/0x50 arch/arm64/kernel/entry-common.c:182
 el1_sync_handler+0xf4/0x150 arch/arm64/kernel/entry-common.c:219
 el1_sync+0x74/0x100 arch/arm64/kernel/entry.S:665
 0xffffa00010019000
 do_futex+0x2f4/0x370 kernel/futex.c:3735
 __do_sys_futex kernel/futex.c:3798 [inline]
 __se_sys_futex kernel/futex.c:3764 [inline]
 __arm64_sys_futex+0x168/0x3a0 kernel/futex.c:3764
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common.constprop.0+0xf4/0x414 arch/arm64/kernel/syscall.c:155
 do_el0_svc+0x50/0x11c arch/arm64/kernel/syscall.c:217
 el0_svc+0x20/0x30 arch/arm64/kernel/entry-common.c:353
 el0_sync_handler+0xe4/0x1e0 arch/arm64/kernel/entry-common.c:369
 el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683
Code: 91018360 97ff1838 aa1703e0 97ff1fdf (d4210000)
---[ end trace 767503e946e01b15 ]---

Syzbot tried to porbe on a kprobe_insn_slot.

kprobe will replace instruciton with a break and store the origin one
on kprobe_insn_slot. However these slots are not in .kprobes.text and
exported by perf_event_ksymbol so can be probed by perf interface.

Probing these slots will triggers kprobe handler inside single step
process and for some architectures such as arm64 this will causes a
bug().

These slots are kprobe process so they should not be probed anyway.
Add kprobe_insn_slot check when register_kprobe to forbid probing on
these slots.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c088ed..3e798b62db70 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1562,6 +1562,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	/* Ensure it is not in reserved area nor out of text */
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
+	    is_kprobe_insn_slot((unsigned long) p->addr) ||
+	    is_kprobe_optinsn_slot((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
-- 
2.17.1

