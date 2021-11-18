Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFB45567D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbhKRIO2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbhKRIOQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:14:16 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE4C06121E
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:15 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id a2-20020a5d4d42000000b0017b3bcf41b9so868805wru.23
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j+xGmYJ7a6naxsOgId4/Y5ehX22eJTAnRqZAmnKJeqk=;
        b=AFKYBDtNxe/zIpPX6ATOP6Oaf/Q/ogNw/iuYP+kZPqIMpI7lQIp++McD2UNNH1Fpin
         ihP4MNeiSed+OTnLOoVn0uh/0kySxK/Yk0Z1LTYcfyEHKOpLFR3dz9xOUbi2vMRqQA1e
         K8MeKX4ibWJWyagq5O/D04JyuXakUpDsqfcEwbchowFAUBMfZCT0jmD2GaDyWdE/M/O1
         o9NYFL4JjzkzNDER+vaAbRyCE5YkV/7tPiF1eLZHrGIOCrNQev5SHn365wh2dJTMds1m
         pR1to1GIKquZyoS0ryoBzMFyuzgj/NUhPMiB8SAuBj/BlNlPUxNrb7UzTegA7B82czWm
         9OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j+xGmYJ7a6naxsOgId4/Y5ehX22eJTAnRqZAmnKJeqk=;
        b=ZVylyZ1ShOQPeTahVMKHFYIfOh+oH41yjpGH2j1zs0WIvicU+hXksCw+ws6veYQILG
         3FoQqfRV3DFRhKso8ivFfwfeAbFcg7lkPbpwL1StKuItPpV4LoPUQelvC+xCa2wt+m+I
         WAgXCZxEwuhB6uas+lvcPmtO+zEoJ8q5LvppAWWSWI+nQUmi1XLygnpo8rwgzdYeR9Lh
         qJ+dmg/zRG7tDiBbvZhS4BQ9iLhG8U4LWHvpFSXnyXY/U5Lu8tlCKeHwF8wSAEf9mqiu
         KpIPR3e89jUS5EbV/14j/6fQ35jH4Xzubaqw6AZG2oBmB4S5/Fd3Da3KE8HGGsszpR4Q
         sB2A==
X-Gm-Message-State: AOAM532DAEwuWnpL6WZRvp6kyNo0n14aelqRG4tk+9p+rStUKXy+CIKl
        bqn/Dv8Cihjk2M2CMpdWgZ9NCUnnfQ==
X-Google-Smtp-Source: ABdhPJyrAblfdPUbSGFAD6qCfKTgpVs0/aJt2TepI3LGsbV36W6kcYuuz/E/yHTNXjbyTxE0/jLTFnm6jw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a7b:c409:: with SMTP id k9mr7703441wmi.173.1637223073968;
 Thu, 18 Nov 2021 00:11:13 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:11 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-8-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 07/23] kcsan: Call scoped accesses reordered in reports
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
2.34.0.rc2.393.gf8c9666880-goog

