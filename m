Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82579581E29
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 05:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiG0DR5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiG0DR4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 23:17:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3457DF95;
        Tue, 26 Jul 2022 20:17:54 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LszSg5p93zmVB0;
        Wed, 27 Jul 2022 11:16:03 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:17:53 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:17:52 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-arch@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <mbenes@suse.cz>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] Revert "x86/unwind/orc: Don't skip the first frame for inactive tasks"
Date:   Wed, 27 Jul 2022 11:15:06 +0800
Message-ID: <20220727031506.59322-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
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

This reverts commit f1d9a2abff66aa8156fbc1493abed468db63ea48.

When CONFIG_GCOV_PROFILE_ALL is enabled, show_stack() and related
functions (e.g. dump_stack) will break for x86 ORC unwinder.

Call Trace:
 <TASK>
 ? dump_stack_lvl+0x83/0xb7
 ? schedule+0x1/0x190
 ? dump_stack+0x13/0x1f
 ? handler_pre0+0x3f/0x53 [kp_unwind]
 ...

show_trace_log_lvl() searches text address on stack to validate
whether unwind results are reliable. The code:

    for (; stack < stack_info.end; stack++) {
        ...
        if (stack == ret_addr_p)
            reliable = 1;
        ...
        if (!reliable)
            continue;
        ...
    }

This requires:

    *stack* <= ret_addr_p

So that the first ret_addr_p can be found when stack++.

In normal cases the frame of show_stack() should be optimized out.
However if it is not optimized such as CONFIG_GCOV_PROFILE_ALL=y,
unwind_start() will stop at show_stack(), where:

    state->sp == first_frame == *stack*

And this will causes:

    ret_addr_p = unwind_get_return_address_ptr = state->sp - 1
    => *stack* > ret_addr_p

Then reliable check will ignore all unwind because first ret_addr_p
can't be found.

'f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")'

This patch removed the equal condition when state->sp == first_frame
which makes frame of show_stack() not be skipped. But the reason to
do that is not established now:

'f2ac57a4c49d ("x86/unwind/orc: Fix inactive tasks with stack pointer in %sp on GCC 10 compiled kernels")'

    state->sp = first_frame + sizeof(*frame),

state->sp and first_frame can't be equal for inactive stack any more.

Regard this equal condition doesn't involve other cases now,
revert it to fix above problem.

After revert, stack can be printed right:

Call Trace:
 <TASK>
 dump_stack_lvl+0x83/0xb7
 ? schedule+0x1/0x190
 dump_stack+0x13/0x1f
 handler_pre0+0x3f/0x53 [kp_unwind]
 ...

Fixes: f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 38185aedf7d1..514dc9ef99fe 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -708,7 +708,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	/* Otherwise, skip ahead to the user-specified starting frame: */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp < (unsigned long)first_frame))
+			state->sp <= (unsigned long)first_frame))
 		unwind_next_frame(state);
 
 	return;
-- 
2.17.1

