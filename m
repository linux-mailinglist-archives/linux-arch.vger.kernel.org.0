Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA317422430
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhJELCI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhJELBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:01:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56EC061787
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:00 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso18103959qtm.1
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L+fd37WmAy2s0UaVk4scjeutYzqXSn/VtNkU4zfPMW8=;
        b=qNNeZUdV2JGQxqGAo0/w6qMrKU3JqbUS9b0UVnph3olpHC5JuF75PQnrF4tPQkaaHk
         uxAiGqYUYiZzozbFUT442/Q47um4vQjTpcSyhBKv9wrbtGVBMTYLAlw+3qhp0Htre9a0
         w1LGGJDilUSoft9nkOwZPxOJJphY5JlzaV3yd0hK10HtSab4buxxfEGxBJVxwotHlLWe
         ldMX0ltHwaGlkflpxIrbB2XQVE9eDPHfd+0ATGTLzGBMApuyBfBVj5xYBwyJBLsVfhOv
         dIpkvoWqnmm7/3PM3DIjKLk4cVMlKH4X+BSsVH7yq/ZooQiPRnS35swDppdCwbcRedEx
         votQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L+fd37WmAy2s0UaVk4scjeutYzqXSn/VtNkU4zfPMW8=;
        b=d3QWi9QtxEPsPtpTuAAkusjyI9l7+WkcYJqn2zaubKaMvSBV3SH9z+3WTpFw7mbSaf
         Fw0FttrMMHbZTxRYkC7PVCq210Xur8MSelLczgpA2+RRb/CROIk/8H5xBv0TJJm0cukV
         U+wSuyK1sXoRkod8jE460MZYtwaBBlyi9P8MXJirDSh180sy9Uu7+C2RRZn2EzcULsk0
         Xq6BGKkwYdbHSfZ/I/F2pbR3hEoH1QLbTyms2XBwi3WvhuFFoNYNyb31EK+28XgZgckV
         ZffvVZBLvDT3wJ/qa5kYWtJ/R+2GhFSE9XBo+nmq+AKYaQfBvFAUAJu5clRT7iUB4jWq
         YNgA==
X-Gm-Message-State: AOAM532zNnv5JxogPS0KS1TWvAs343Pg9tTTuv2LA/h8pY2yoDoC+NRh
        GqrDQmsX36nLhl6hLzsQGQ7NnXGR6Q==
X-Google-Smtp-Source: ABdhPJxH1CU4wC0r2IQDVPstmeRQev0ImQ7cg+e7CJoF4IERulSuQC3qqUPSqtroDZUVOx2jurztMzMl6g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:1083:: with SMTP id
 o3mr435430qvr.57.1633431599435; Tue, 05 Oct 2021 03:59:59 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:49 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-8-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 07/23] kcsan: Call scoped accesses reordered in reports
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
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

The scoping of an access simply denotes the scope in which it may be
reordered. However, in reports, it'll be less confusing to say the
access is "reordered". This is more accurate when the race occurred.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c |  4 ++--
 kernel/kcsan/report.c     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 660729238588..6e3c2b8bc608 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -213,9 +213,9 @@ static bool report_matches(const struct expect_report *r)
 		const bool is_atomic = (ty & KCSAN_ACCESS_ATOMIC);
 		const bool is_scoped = (ty & KCSAN_ACCESS_SCOPED);
 		const char *const access_type_aux =
-				(is_atomic && is_scoped)	? " (marked, scoped)"
+				(is_atomic && is_scoped)	? " (marked, reordered)"
 				: (is_atomic			? " (marked)"
-				   : (is_scoped			? " (scoped)" : ""));
+				   : (is_scoped			? " (reordered)" : ""));
 
 		if (i == 1) {
 			/* Access 2 */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index fc15077991c4..1b0e050bdf6a 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -215,9 +215,9 @@ static const char *get_access_type(int type)
 	if (type & KCSAN_ACCESS_ASSERT) {
 		if (type & KCSAN_ACCESS_SCOPED) {
 			if (type & KCSAN_ACCESS_WRITE)
-				return "assert no accesses (scoped)";
+				return "assert no accesses (reordered)";
 			else
-				return "assert no writes (scoped)";
+				return "assert no writes (reordered)";
 		} else {
 			if (type & KCSAN_ACCESS_WRITE)
 				return "assert no accesses";
@@ -240,17 +240,17 @@ static const char *get_access_type(int type)
 	case KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "read-write (marked)";
 	case KCSAN_ACCESS_SCOPED:
-		return "read (scoped)";
+		return "read (reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_ATOMIC:
-		return "read (marked, scoped)";
+		return "read (marked, reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE:
-		return "write (scoped)";
+		return "write (reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
-		return "write (marked, scoped)";
+		return "write (marked, reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE:
-		return "read-write (scoped)";
+		return "read-write (reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
-		return "read-write (marked, scoped)";
+		return "read-write (marked, reordered)";
 	default:
 		BUG();
 	}
-- 
2.33.0.800.g4c38ced690-goog

