Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D3455687
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbhKRIOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244338AbhKRIOS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:14:18 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B54C061767
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:18 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so2242515wmj.7
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9MKtF9b1Z9XuvDPczN5keFD3RJ+5M3WbaM5UaZup9oY=;
        b=DMAx5U3Fq0tP2IpTecmx2uzaQrI5aNjYvE+5mnDJ204VI98d/lvz8rkfefRhzdA/E0
         k7gs2A0XYnaBBJMRRkmgTryO2/rf4nmHl0stwY+VnfzrRuuYfa2ApkTwlQVkN4lPePJk
         ZIblsBMvV5I0MtrEotmY6nO/dglGNf5muUAa8aERxSDl7cYVE0b/kB8C2Bhm+bwLQ+Y8
         cM2iFDXi4ilnBKpIPN36Nzhp5jNjC7GuYPEhDYBtogMAfcOSxfXEgOL/XONoElP/K4am
         3/K6Sdenb6LHzN8WCA6jT2l7ifmqfW78PR2IXtCK0mH9madbnkAhB3sR+uNDQpP+4D/4
         3VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9MKtF9b1Z9XuvDPczN5keFD3RJ+5M3WbaM5UaZup9oY=;
        b=59EJ54oKPYU+Ev7w7B0VBGmLzYAUvHVq1lDFzLjlmlkZ43uAC5GHU3E/oDMQd7hJAM
         nKVgxFWbEkhXywTwpeg1sUyccP8jIDSCao/ONL8tZHBN51p8EWwibnOPz8m6Mw+nAzNd
         O6ySxBsE2pAYFfJuzgWTmvTTVwZM5Bdbb/XCdBBO0ALL4l8afJ2Ilp2xOlVBLhUyoVod
         oggmBTPGmCko+VSqsbGhHRVJvyDkzOsXEf5zuzV0nra87izLQ5q2mikJv3C8WuGwmXPw
         IpyBZdUtmhNXvdBnYdG8/hVW2tkRGuFL9aJgn8xe/S/QYtYnDtdDjDl0kSJ6M5iAenur
         cfsg==
X-Gm-Message-State: AOAM532w4KW8Fu2hJ0uJoL8rqn9hW0wHZNB6euMqXT6bjFTz7pPzVdA0
        ugAEPKTzEKQo1u5OI7aYhHV82mn+og==
X-Google-Smtp-Source: ABdhPJxwbovaIILlaArhHRkjnI7oUBUtVLJjVdVc3WM52C6Lf8NNfvQC2lsfzwv+93dShVkkuQEd46P4RQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:3b20:: with SMTP id
 m32mr2109456wms.0.1637223076382; Thu, 18 Nov 2021 00:11:16 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:12 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-9-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 08/23] kcsan: Show location access was reordered to
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
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

