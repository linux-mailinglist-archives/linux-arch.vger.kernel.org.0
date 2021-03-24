Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F853347726
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 12:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhCXLZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhCXLZa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 07:25:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B888C061763
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 04:25:30 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l13so960137qtu.6
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LX/BpTku7Mw/ygEVGiq+Ue/R3uDPIzOnmcdooJRuOrg=;
        b=HP/OpHnG2ZFFfMhsPxHanxNPNbRGbkkO9H9OzCxJvjy/Tt+raDo9BOU3aIH06rF9sA
         toWjQ3xNR1eG0jWW0kzIQZorkb7pg7WxYyOstU0ZVSi9+Wg4qFdjMRjTTkrnEv5SKH2/
         wgQx94I8UDcETmS8OAsXbELYY3L7gFLf7RS/cSBUJrIGM5OhKt0yHfhKEtOSusmod4PQ
         69QlRiJVVmUz1NAQ7uO+/2qlpTMcbX1U7ZDqQK1V0icEvK6bQop5EhVfupRcgI6oE+cc
         qAS2+NXPmM5zs36n6+ifmNA+OV0knc2vFWCC5ScE3bLeDQoHsIYDXZ/2EBAIp+ClFeAO
         yDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LX/BpTku7Mw/ygEVGiq+Ue/R3uDPIzOnmcdooJRuOrg=;
        b=Iw6Kdzk3BiRIbk9ibURHj4ja7YvMeaYMrrw1JFMfG2enqd9TusbyIg8tkaA40kCP3g
         /gxgeDP93JJz9crgSG+RVAISu2JK6EsWzca5bESQofzrrLyrvmWzvPKjYkaTgN/WZkEX
         ojv8ezftG4/2tfJDebN49sLDy0YLcT030y5O2bdNo9aB2RVSN7OnnljtB4mIftE4LhrD
         dxmDYKfIYktj/L7MyyTxRnqWXSntpd50vZAVCup6IElGLfMfX9Kwd/QEsT6SdWEgopJ/
         pREmrqBVUA34Zv0bfvAONuEQ4mAC33aVGIIBhaOvIm0+ygNqTLByWxWyvclfuopVpQ2e
         uGFA==
X-Gm-Message-State: AOAM5313zwcPlRsp3wbyLyqql4eevHu/bXoeV7N2suNIsujiSQ4qnTW4
        oKV3JB2u9CLT42ZJAoMqiLjW50l7Gg==
X-Google-Smtp-Source: ABdhPJymE5f6div96+zRGYVKESwRGTt8KpfjhJI/DuvO09EJRIG57AT8Ms+lMfsGLO9T6B6eOEXEf63QpA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:a0c:a5a5:: with SMTP id z34mr2625271qvz.4.1616585129586;
 Wed, 24 Mar 2021 04:25:29 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:24:56 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-5-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 04/11] perf: Add support for event removal on exec
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adds bit perf_event_attr::remove_on_exec, to support removing an event
from a task on exec.

This option supports the case where an event is supposed to be
process-wide only, and should not propagate beyond exec, to limit
monitoring to the original process image only.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Rework based on Peter's "perf: Rework perf_event_exit_event()" added
  to the beginning of the series. Intermediate attempts between v2 and
  this v3 can be found here:
	  https://lkml.kernel.org/r/YFm6aakSRlF2nWtu@elver.google.com

v2:
* Add patch to series.
---
 include/uapi/linux/perf_event.h |  3 +-
 kernel/events/core.c            | 70 +++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 813efb65fea8..8c5b9f5ad63f 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -390,7 +390,8 @@ struct perf_event_attr {
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
-				__reserved_1   : 28;
+				remove_on_exec :  1, /* event is removed from task on exec */
+				__reserved_1   : 27;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 224cbcf6125a..b6434697c516 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4247,6 +4247,57 @@ static void perf_event_enable_on_exec(int ctxn)
 		put_ctx(clone_ctx);
 }
 
+static void perf_remove_from_owner(struct perf_event *event);
+static void perf_event_exit_event(struct perf_event *event,
+				  struct perf_event_context *ctx);
+
+/*
+ * Removes all events from the current task that have been marked
+ * remove-on-exec, and feeds their values back to parent events.
+ */
+static void perf_event_remove_on_exec(int ctxn)
+{
+	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event *event, *next;
+	LIST_HEAD(free_list);
+	unsigned long flags;
+	bool modified = false;
+
+	ctx = perf_pin_task_context(current, ctxn);
+	if (!ctx)
+		return;
+
+	mutex_lock(&ctx->mutex);
+
+	if (WARN_ON_ONCE(ctx->task != current))
+		goto unlock;
+
+	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+		if (!event->attr.remove_on_exec)
+			continue;
+
+		if (!is_kernel_event(event))
+			perf_remove_from_owner(event);
+
+		modified = true;
+
+		perf_event_exit_event(event, ctx);
+	}
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (modified)
+		clone_ctx = unclone_ctx(ctx);
+	--ctx->pin_count;
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+unlock:
+	mutex_unlock(&ctx->mutex);
+
+	put_ctx(ctx);
+	if (clone_ctx)
+		put_ctx(clone_ctx);
+}
+
 struct perf_read_data {
 	struct perf_event *event;
 	bool group;
@@ -7559,18 +7610,18 @@ void perf_event_exec(void)
 	struct perf_event_context *ctx;
 	int ctxn;
 
-	rcu_read_lock();
 	for_each_task_context_nr(ctxn) {
-		ctx = current->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
-
 		perf_event_enable_on_exec(ctxn);
+		perf_event_remove_on_exec(ctxn);
 
-		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL,
-				   true);
+		rcu_read_lock();
+		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
+		if (ctx) {
+			perf_iterate_ctx(ctx, perf_event_addr_filters_exec,
+					 NULL, true);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 }
 
 struct remote_output {
@@ -11652,6 +11703,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->inherit && attr->inherit_thread)
 		return -EINVAL;
 
+	if (attr->remove_on_exec && attr->enable_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
-- 
2.31.0.291.g576ba9dcdaf-goog

