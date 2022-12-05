Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7C642491
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 09:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiLEI2k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 03:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiLEI2i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 03:28:38 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00836165B6
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 00:28:34 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:59286.703431701
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 6D6301002F0;
        Mon,  5 Dec 2022 16:23:28 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-6cffbd87dd-5n69v with ESMTP id 6754938087e943759d0a36285b07a169 for rostedt@goodmis.org;
        Mon, 05 Dec 2022 16:23:29 CST
X-Transaction-ID: 6754938087e943759d0a36285b07a169
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 4/4] kernel/trace: remove calling regs_* when compiling HEXAGON
Date:   Mon,  5 Dec 2022 16:30:17 +0800
Message-Id: <1670229017-4106-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kernel test robot reports below errors:

In file included from kernel/trace/trace_events_synth.c:22:
>> kernel/trace/trace_probe_kernel.h:203:9: error: call to
undeclared function 'regs_get_register'; ISO C99 and later
do not support implicit function declarations
[-Wimplicit-function-declaration]
                   val = regs_get_register(regs, code->param);

HEXAGON doesn't define and implement those reg_* functions
underneath arch/hexagon as well as other archs. To remove
those errors, i have to include those function calls in
"CONFIG_HEXAGON"

It looks ugly, but i don't know any other way to fix it,
this patch can be reverted after reg_* have been in place
in arch/hexagon.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/trace/trace_probe_kernel.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 8c42abe0dacf..7e958b7f07e5 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -130,8 +130,7 @@ probe_mem_read(void *dest, void *src, size_t size)
 	return copy_from_kernel_nofault(dest, src, size);
 }
 
-static nokprobe_inline unsigned long
-get_event_field(struct fetch_insn *code, void *rec)
+static unsigned long get_event_field(struct fetch_insn *code, void *rec)
 {
 	struct ftrace_event_field *field = code->data;
 	unsigned long val;
@@ -194,23 +193,41 @@ static int
 process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+#ifndef CONFIG_HEXAGON
 	struct pt_regs *regs = rec;
+#endif
 	unsigned long val;
 
 retry:
 	/* 1st stage: get value from context */
 	switch (code->op) {
 	case FETCH_OP_REG:
+#ifdef CONFIG_HEXAGON
+		val = 0;
+#else
 		val = regs_get_register(regs, code->param);
+#endif
 		break;
 	case FETCH_OP_STACK:
+#ifdef CONFIG_HEXAGON
+		val = 0;
+#else
 		val = regs_get_kernel_stack_nth(regs, code->param);
+#endif
 		break;
 	case FETCH_OP_STACKP:
+#ifdef CONFIG_HEXAGON
+		val = 0;
+#else
 		val = kernel_stack_pointer(regs);
+#endif
 		break;
 	case FETCH_OP_RETVAL:
+#ifdef CONFIG_HEXAGON
+		val = 0;
+#else
 		val = regs_return_value(regs);
+#endif
 		break;
 	case FETCH_OP_IMM:
 		val = code->immediate;
-- 
2.25.1

