Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB428659568
	for <lists+linux-arch@lfdr.de>; Fri, 30 Dec 2022 07:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiL3G0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Dec 2022 01:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiL3G02 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2022 01:26:28 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB10AE10;
        Thu, 29 Dec 2022 22:26:26 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:59430.503948632
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 139AE100283;
        Fri, 30 Dec 2022 14:26:25 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-79f476db8-qhshz with ESMTP id 10773a193faf4068ae3c9f824be272f0 for rostedt@goodmis.org;
        Fri, 30 Dec 2022 14:26:26 CST
X-Transaction-ID: 10773a193faf4068ae3c9f824be272f0
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 3/3] kernel/trace: extract common part in process_fetch_insn
Date:   Fri, 30 Dec 2022 14:33:53 +0800
Message-Id: <1672382033-18390-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Each probe has an instance of process_fetch_insn respectively,
but they have something in common.

This patch aims to extract the common part into
process_common_fetch_insn which can be shared by each probe,
and they only need to focus on their special cases.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c     | 26 ++++++--------------------
 kernel/trace/trace_kprobe.c     | 14 ++++----------
 kernel/trace/trace_probe_tmpl.h | 20 ++++++++++++++++++++
 kernel/trace/trace_uprobe.c     | 11 ++++-------
 4 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index ca5d097eec4f..bff0f48f4b44 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -395,20 +395,12 @@ static int get_eprobe_size(struct trace_probe *tp, void *rec)
 			case FETCH_OP_TP_ARG:
 				val = get_event_field(code, rec);
 				break;
-			case FETCH_OP_IMM:
-				val = code->immediate;
-				break;
-			case FETCH_OP_COMM:
-				val = (unsigned long)current->comm;
-				break;
-			case FETCH_OP_DATA:
-				val = (unsigned long)code->data;
-				break;
 			case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
 				code++;
 				goto retry;
 			default:
-				continue;
+				if (process_common_fetch_insn(code, &val) < 0)
+					continue;
 			}
 			code++;
 			len = process_fetch_insn_bottom(code, val, NULL, NULL);
@@ -428,26 +420,20 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
 	unsigned long val;
+	int ret;
 
  retry:
 	switch (code->op) {
 	case FETCH_OP_TP_ARG:
 		val = get_event_field(code, rec);
 		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = (unsigned long)current->comm;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
 	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
 		code++;
 		goto retry;
 	default:
-		return -EILSEQ;
+		ret = process_common_fetch_insn(code, &val);
+		if (ret < 0)
+			return ret;
 	}
 	code++;
 	return process_fetch_insn_bottom(code, val, dest, base);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 714fe9c04eb6..af8b2023a76b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1225,6 +1225,7 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 {
 	struct pt_regs *regs = rec;
 	unsigned long val;
+	int ret;
 
 retry:
 	/* 1st stage: get value from context */
@@ -1241,15 +1242,6 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 	case FETCH_OP_RETVAL:
 		val = regs_return_value(regs);
 		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
-	case FETCH_OP_COMM:
-		val = (unsigned long)current->comm;
-		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	case FETCH_OP_ARG:
 		val = regs_get_kernel_argument(regs, code->param);
@@ -1259,7 +1251,9 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		code++;
 		goto retry;
 	default:
-		return -EILSEQ;
+		ret = process_common_fetch_insn(code, &val);
+		if (ret < 0)
+			return ret;
 	}
 	code++;
 
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 1b57420857e1..17258eca0125 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -67,6 +67,26 @@ probe_mem_read(void *dest, void *src, size_t size);
 static nokprobe_inline int
 probe_mem_read_user(void *dest, void *src, size_t size);
 
+/* common part of process_fetch_insn*/
+static nokprobe_inline int
+process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
+{
+	switch (code->op) {
+	case FETCH_OP_IMM:
+		*val = code->immediate;
+		break;
+	case FETCH_OP_COMM:
+		*val = (unsigned long)current->comm;
+		break;
+	case FETCH_OP_DATA:
+		*val = (unsigned long)code->data;
+		break;
+	default:
+		return -EILSEQ;
+	}
+	return 0;
+}
+
 /* From the 2nd stage, routine is same */
 static nokprobe_inline int
 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1ff8f87211a6..c53b0752533f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -220,6 +220,7 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 {
 	struct pt_regs *regs = rec;
 	unsigned long val;
+	int ret;
 
 	/* 1st stage: get value from context */
 	switch (code->op) {
@@ -235,20 +236,16 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 	case FETCH_OP_RETVAL:
 		val = regs_return_value(regs);
 		break;
-	case FETCH_OP_IMM:
-		val = code->immediate;
-		break;
 	case FETCH_OP_COMM:
 		val = FETCH_TOKEN_COMM;
 		break;
-	case FETCH_OP_DATA:
-		val = (unsigned long)code->data;
-		break;
 	case FETCH_OP_FOFFS:
 		val = translate_user_vaddr(code->immediate);
 		break;
 	default:
-		return -EILSEQ;
+		ret = process_common_fetch_insn(code, &val);
+		if (ret < 0)
+			return ret;
 	}
 	code++;
 
-- 
2.25.1

