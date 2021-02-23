Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE4322C74
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhBWOfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 09:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhBWOfa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 09:35:30 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DAC06178C
        for <linux-arch@vger.kernel.org>; Tue, 23 Feb 2021 06:34:49 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h30so161533wrh.10
        for <linux-arch@vger.kernel.org>; Tue, 23 Feb 2021 06:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z91iRBzRx2L82S3eGkndbig8apk87DxttK33upPKVz8=;
        b=a431b0ZLlBnPrATBY/DRQE4q8vBQ/N7UJ9ffCueo+lNS8kg8LfkH9ez0z03CoE5lSp
         zxbmJGk/zZL98SQeupAK5IfHXTtXvOehv65MgcrpsdIMRGFk+pRUR6nV3xdCEEjFxV4h
         ybKuEBt3PMXYJpWA0U8TjT/znU+oEdGS846YEdZBtEVMfaNO3g1enGKg64K4mZ576qhr
         kTjeG/IiULQSmxjJEm3Sa09fRM9ne6JUXBvNU1m4kSzb4+XssSmrTSNlNEZN8mc/Ag9y
         YdOHXvNfYSDCPatpb2Mp8nuFrGYPgVFOwmxz8ZJPq1ceYW13BSPOGetpXK//JyySuK3j
         kMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z91iRBzRx2L82S3eGkndbig8apk87DxttK33upPKVz8=;
        b=V56Pxty+M2XfuR/+U8xh6MQs3L/5Dr8hP+/TJXApEE8zJ6P32za73cmNmSO4m/SzDI
         PP507LCp4rZ6eCGhB3zsj84P6OZj9+lQ1AmUwTjix1DKyJtoNx10sc9VXmmYpx0TfDpd
         OetbypsrCZkB/75Az9Pi7a82ognhpC6cOcJMmqcq67OBXT5bq+l06tZJJ9TmQrv+xWx9
         8h1vXNJYlF/Ueek7e284dQ2UtftZdKlKdaV1B/mBxYwxHRFb6mY00OLDE6aPnL993G0J
         UjVtemA58EYF70TQRKlQPoL9dbTpFGfG5e11LI4njRgDk2cdgdDKf1MkTn/ElT2qohOV
         6xlA==
X-Gm-Message-State: AOAM531dpd3FvuNyn7k0vR7Rpp0BIU0ASw9cbZDrNn5+KUYY52GPUGd+
        eFjs3AjLgx30V1kuCRBzi8As1NUwNQ==
X-Google-Smtp-Source: ABdhPJy7g0zcabVF3MNZ/LRvsLUDnf2kQNQpsuRBe4nEbsVMPFhp66EHScWAovu0+nBHYuOPOY6D5n8zGg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:855b:f924:6e71:3d5d])
 (user=elver job=sendgmr) by 2002:a1c:a90e:: with SMTP id s14mr25359822wme.36.1614090887099;
 Tue, 23 Feb 2021 06:34:47 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:34:23 +0100
In-Reply-To: <20210223143426.2412737-1-elver@google.com>
Message-Id: <20210223143426.2412737-2-elver@google.com>
Mime-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH RFC 1/4] perf/core: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
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
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As with other ioctls (such as PERF_EVENT_IOC_{ENABLE,DISABLE}), fix up
handling of PERF_EVENT_IOC_MODIFY_ATTRIBUTES to also apply to children.

Link: https://lkml.kernel.org/r/YBqVaY8aTMYtoUnX@hirez.programming.kicks-ass.net
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 129dee540a8b..37a8297be164 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3179,16 +3179,36 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 static int perf_event_modify_attr(struct perf_event *event,
 				  struct perf_event_attr *attr)
 {
+	int (*func)(struct perf_event *, struct perf_event_attr *);
+	struct perf_event *child;
+	int err;
+
 	if (event->attr.type != attr->type)
 		return -EINVAL;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_BREAKPOINT:
-		return perf_event_modify_breakpoint(event, attr);
+		func = perf_event_modify_breakpoint;
+		break;
 	default:
 		/* Place holder for future additions. */
 		return -EOPNOTSUPP;
 	}
+
+	WARN_ON_ONCE(event->ctx->parent_ctx);
+
+	mutex_lock(&event->child_mutex);
+	err = func(event, attr);
+	if (err)
+		goto out;
+	list_for_each_entry(child, &event->child_list, child_list) {
+		err = func(child, attr);
+		if (err)
+			goto out;
+	}
+out:
+	mutex_unlock(&event->child_mutex);
+	return err;
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx,
-- 
2.30.0.617.g56c4b15f3c-goog

