Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0C657375
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 08:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiL1HBK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 02:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiL1HAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 02:00:47 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3102338F;
        Tue, 27 Dec 2022 23:00:45 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:60898.1416967110
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 9B43F1002B3;
        Wed, 28 Dec 2022 15:00:41 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-79f476db8-8kzc7 with ESMTP id e2a796c87bf0415ca618d27dfe820380 for rostedt@goodmis.org;
        Wed, 28 Dec 2022 15:00:41 CST
X-Transaction-ID: e2a796c87bf0415ca618d27dfe820380
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v4 1/2] kernel/trace: Introduce trace_probe_print_args and use it in *probes
Date:   Wed, 28 Dec 2022 15:08:11 +0800
Message-Id: <1672211291-31439-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

print_probe_args is currently inplemented in trace_probe_tmpl.h and
included by *probes, as a result, each probe has an identical copy.

This patch will move it to trace_probe.c as an new API, each probe
calls it to print their args in trace file.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/trace/trace_eprobe.c     |  2 +-
 kernel/trace/trace_kprobe.c     |  4 ++--
 kernel/trace/trace_probe.c      | 27 +++++++++++++++++++++++++++
 kernel/trace/trace_probe.h      |  2 ++
 kernel/trace/trace_probe_tmpl.h | 28 ----------------------------
 kernel/trace/trace_uprobe.c     |  2 +-
 6 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5dd0617e5df6..bdb26eee7a0c 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -310,7 +310,7 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	if (print_probe_args(s, tp->args, tp->nr_args,
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
 			     (u8 *)&field[1], field) < 0)
 		goto out;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5a75b039e586..a4ffa864dbb7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1426,7 +1426,7 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	if (print_probe_args(s, tp->args, tp->nr_args,
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
 			     (u8 *)&field[1], field) < 0)
 		goto out;
 
@@ -1461,7 +1461,7 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	if (print_probe_args(s, tp->args, tp->nr_args,
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
 			     (u8 *)&field[1], field) < 0)
 		goto out;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 36dff277de46..ae13b6b2d5da 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1218,3 +1218,30 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 
 	return ret;
 }
+
+int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
+		 u8 *data, void *field)
+{
+	void *p;
+	int i, j;
+
+	for (i = 0; i < nr_args; i++) {
+		struct probe_arg *a = args + i;
+
+		trace_seq_printf(s, " %s=", a->name);
+		if (likely(!a->count)) {
+			if (!a->type->print(s, data + a->offset, field))
+				return -ENOMEM;
+			continue;
+		}
+		trace_seq_putc(s, '{');
+		p = data + a->offset;
+		for (j = 0; j < a->count; j++) {
+			if (!a->type->print(s, p, field))
+				return -ENOMEM;
+			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
+			p += a->type->size;
+		}
+	}
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index de38f1c03776..cfef198013af 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -343,6 +343,8 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
 bool trace_probe_match_command_args(struct trace_probe *tp,
 				    int argc, const char **argv);
 int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
+int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
+		 u8 *data, void *field);
 
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index b3bdb8ddb862..1b57420857e1 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -212,31 +212,3 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		}
 	}
 }
-
-static inline int
-print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
-		 u8 *data, void *field)
-{
-	void *p;
-	int i, j;
-
-	for (i = 0; i < nr_args; i++) {
-		struct probe_arg *a = args + i;
-
-		trace_seq_printf(s, " %s=", a->name);
-		if (likely(!a->count)) {
-			if (!a->type->print(s, data + a->offset, field))
-				return -ENOMEM;
-			continue;
-		}
-		trace_seq_putc(s, '{');
-		p = data + a->offset;
-		for (j = 0; j < a->count; j++) {
-			if (!a->type->print(s, p, field))
-				return -ENOMEM;
-			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
-			p += a->type->size;
-		}
-	}
-	return 0;
-}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fb58e86dd117..1ff8f87211a6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1041,7 +1041,7 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	if (print_probe_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
+	if (trace_probe_print_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
 		goto out;
 
 	trace_seq_putc(s, '\n');
-- 
2.25.1

