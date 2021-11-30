Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB6C4632E9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhK3Lsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbhK3Lsn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:48:43 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214FFC06175E
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:24 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so12683356wms.7
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9MKtF9b1Z9XuvDPczN5keFD3RJ+5M3WbaM5UaZup9oY=;
        b=Mld6ftuJH52h3z9GNnJEoeByNAIFNrr3QsNiiYZFnnrRHu2TfyHKAOcJkvA9ddFunQ
         W7HZZRZi9E4yV65PPNgG1ZDF1sY+of3aAI7j56Q5/0C9Rf6OEWGZdfCOHijSM7jH24g8
         MVLT5isv+V73ghLIyYaQFtX5YyvwcwZyo/T+1dJKwD98Y6BxcjtQUUE6n88U0hqpVvoY
         UpGN74vd/umUgR6ig9WaMplU3Lwk7NfegtTFIdPQ5VkTrkzbI2fxuQ/5vuHN+oBn0Xdi
         sO5Ln/L8f8ToTg1xO7zWC3T1pb7NBofCBNGXDgSJNWb9JpMCv7fM0CpBoL76ByPi+/ZN
         Y5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9MKtF9b1Z9XuvDPczN5keFD3RJ+5M3WbaM5UaZup9oY=;
        b=DqWyo69eTMUI/pTo632pYG2NU11DgLli6G2kIgs4d6KZUD/komSJnSANkxAfkacpXn
         FNgBKVDkEqO60iwk+50qiFY8SG+TJLAFkho1eyvF2EEPK9faqFO16qxpjvnQZMHBDeIs
         jznS0n0hy5LuR9lfploMqMp5KWt6eEZk7ssKpTE8N7APJlCfIrOHThmOs2b7RyQK89zy
         fEo1YsOH1Ki2TlCfZkJGbXnSR8gBco4CKnyDF9X0ZaOS1dCCOsW5Z3ceQqR88RVHhiWi
         5GTszJwtMksDaEpVEhaPuxYpaLsaORVFVVzkywI/tZYVdeOgj9h96qIVsxNn7OSYHJ5R
         ZubQ==
X-Gm-Message-State: AOAM530wtA79pL/avAqb/A6S5jlvioQj5HrJwMBUMY/tRBRldll1/TXX
        0YxsLQ0M4EhGYrmGh6wkymQA3ZYn6w==
X-Google-Smtp-Source: ABdhPJyx3pgU+2VvMa2o5fdiF7HS3H4QggTKNbC1lmMB3t56ozszLnF7zTA+qkAyyD9AgjtVUW/GzzlxOQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a5d:50c7:: with SMTP id f7mr38501609wrt.327.1638272722693;
 Tue, 30 Nov 2021 03:45:22 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:16 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-9-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 08/25] kcsan: Show location access was reordered to
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Also show the location the access was reordered to. An example report:

| ==================================================================
| BUG: KCSAN: data-race in test_kernel_wrong_memorder / test_kernel_wrong_memorder
|
| read-write to 0xffffffffc01e61a8 of 8 bytes by task 2311 on cpu 5:
|  test_kernel_wrong_memorder+0x57/0x90
|  access_thread+0x99/0xe0
|  kthread+0x2ba/0x2f0
|  ret_from_fork+0x22/0x30
|
| read-write (reordered) to 0xffffffffc01e61a8 of 8 bytes by task 2310 on cpu 7:
|  test_kernel_wrong_memorder+0x57/0x90
|  access_thread+0x99/0xe0
|  kthread+0x2ba/0x2f0
|  ret_from_fork+0x22/0x30
|   |
|   +-> reordered to: test_kernel_wrong_memorder+0x80/0x90
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 7 PID: 2310 Comm: access_thread Not tainted 5.14.0-rc1+ #18
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
| ==================================================================

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/report.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 1b0e050bdf6a..67794404042a 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -308,10 +308,12 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 
 /*
  * Skips to the first entry that matches the function of @ip, and then replaces
- * that entry with @ip, returning the entries to skip.
+ * that entry with @ip, returning the entries to skip with @replaced containing
+ * the replaced entry.
  */
 static int
-replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip)
+replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip,
+		    unsigned long *replaced)
 {
 	unsigned long symbolsize, offset;
 	unsigned long target_func;
@@ -330,6 +332,7 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
 		func -= offset;
 
 		if (func == target_func) {
+			*replaced = stack_entries[skip];
 			stack_entries[skip] = ip;
 			return skip;
 		}
@@ -342,9 +345,10 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
 }
 
 static int
-sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip)
+sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip,
+		       unsigned long *replaced)
 {
-	return ip ? replace_stack_entry(stack_entries, num_entries, ip) :
+	return ip ? replace_stack_entry(stack_entries, num_entries, ip, replaced) :
 			  get_stack_skipnr(stack_entries, num_entries);
 }
 
@@ -360,6 +364,14 @@ static int sym_strcmp(void *addr1, void *addr2)
 	return strncmp(buf1, buf2, sizeof(buf1));
 }
 
+static void
+print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
+{
+	stack_trace_print(stack_entries, num_entries, 0);
+	if (reordered_to)
+		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to);
+}
+
 static void print_verbose_info(struct task_struct *task)
 {
 	if (!task)
@@ -378,10 +390,12 @@ static void print_report(enum kcsan_value_change value_change,
 			 struct other_info *other_info,
 			 u64 old, u64 new, u64 mask)
 {
+	unsigned long reordered_to = 0;
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
 	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
-	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip);
+	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip, &reordered_to);
 	unsigned long this_frame = stack_entries[skipnr];
+	unsigned long other_reordered_to = 0;
 	unsigned long other_frame = 0;
 	int other_skipnr = 0; /* silence uninit warnings */
 
@@ -394,7 +408,7 @@ static void print_report(enum kcsan_value_change value_change,
 	if (other_info) {
 		other_skipnr = sanitize_stack_entries(other_info->stack_entries,
 						      other_info->num_stack_entries,
-						      other_info->ai.ip);
+						      other_info->ai.ip, &other_reordered_to);
 		other_frame = other_info->stack_entries[other_skipnr];
 
 		/* @value_change is only known for the other thread */
@@ -434,10 +448,9 @@ static void print_report(enum kcsan_value_change value_change,
 		       other_info->ai.cpu_id);
 
 		/* Print the other thread's stack trace. */
-		stack_trace_print(other_info->stack_entries + other_skipnr,
+		print_stack_trace(other_info->stack_entries + other_skipnr,
 				  other_info->num_stack_entries - other_skipnr,
-				  0);
-
+				  other_reordered_to);
 		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
 			print_verbose_info(other_info->task);
 
@@ -451,9 +464,7 @@ static void print_report(enum kcsan_value_change value_change,
 		       get_thread_desc(ai->task_pid), ai->cpu_id);
 	}
 	/* Print stack trace of this thread. */
-	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
-			  0);
-
+	print_stack_trace(stack_entries + skipnr, num_stack_entries - skipnr, reordered_to);
 	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
 		print_verbose_info(current);
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

