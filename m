Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31BE347722
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 12:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhCXLZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhCXLZ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 07:25:26 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37639C0613E0
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 04:25:26 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h30so946682wrh.10
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3/AI1hI3URzVJhSImUodjFuCeBbn3a274zCrbDQNsz8=;
        b=nYXjrHCePsgAK8BPD+DnHKGQq7GtEjrFuE9gHmxBFFLFRWvLGEXGjuBJLOFRh1dsM7
         ZtSxLGbqif1878vnrwTKmhd472kUNwV0Xjdv/Rdxq6AHVX+LZfw/gwbVs+vUx9hBw2o5
         NbOEqyyA1TFdBt0IR3aBtx8zmQPkUFi7uf3qHmjQQhx2e/erDxAMQ/K7Rmi4W5bJIzw7
         R/eiQ5K0tV9qI36DooN2DKajMOGeekMgASJQ16S/IYx5cqaKNyqHqDK6QMhV7vhMWlhy
         bt4bAM/uanGAX6LjUPmh9VW1J5+KbuHEXii5LF2+2OZd6nAjLN6HESTC7r/8WxYGGfV0
         YyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3/AI1hI3URzVJhSImUodjFuCeBbn3a274zCrbDQNsz8=;
        b=VStgYaWGW/3tIHyrmlJeZNzHh8iLWIWRBtWT7DbSOUqP+j2cZqsY6O2rUjBa5rBS0U
         ov+8/cWUtACSYt8huRtI5QdIP4gjCm6gHwVeH9kFik7jQ6wANOcvip8OauzfZBU66uAU
         gwotVV/vc7zCqo1o+QOxuKhoH7AcETwsQ73J3Cuwiia19tfThcXANRiRCgjWynt8ByVE
         Ok/trhenH/8nHuIyrOkCmXES0tT/ty5jEN2zwcch8saBO6MdL+zFavcft9roxH3jCI1P
         /b4H+Yt7qojbrgUDIvsCHC4vppzytP+WvdGH+0vtZ4MM5K3JXCdfQnCBVJxn/nZE86mX
         wBaw==
X-Gm-Message-State: AOAM530yVlSzWmSIH7vgSBfx65/EEbrtdiwHEqE8ovIojfb2hnOIxpEe
        /U3PAOxAd1TRKC/ML80C1smZfNFWKQ==
X-Google-Smtp-Source: ABdhPJzC1uVnnqF8Li3pJXrgtkV7ERbfbmCjHEARswnFkMMYg7bWmwwmsIPqsg3Cw/2+2Xbh4Z6dhHhGjQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:a5d:4903:: with SMTP id x3mr2936933wrq.143.1616585124744;
 Wed, 24 Mar 2021 04:25:24 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:24:54 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-3-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 02/11] perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
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

As with other ioctls (such as PERF_EVENT_IOC_{ENABLE,DISABLE}), fix up
handling of PERF_EVENT_IOC_MODIFY_ATTRIBUTES to also apply to children.

Link: https://lkml.kernel.org/r/YBqVaY8aTMYtoUnX@hirez.programming.kicks-ass.net
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57de8d436efd..37d106837962 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3199,16 +3199,36 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
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
2.31.0.291.g576ba9dcdaf-goog

