Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF720BB06
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgFZVJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgFZVJj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:09:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A0C03E979
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y3so11236464ybf.4
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0yqonjfzX9QxirGgFehpVVIaduO9UwtK5AmrI3GZ6yQ=;
        b=FaG6BPJOXqjkyKLdRnfSYXHm4L0jMa167g8811Lc7KLLlCTrzx/EQhd2p1zEmN8PgZ
         eB/39SbjyqN9BS8uPjwCNk7B5FsKAFwGTf1tuQeTrrcWg0NmPDwVVJs2OdysNF250ny5
         VYaIvUovIyhI0P7CGnSMLOC4oR5g5U3C2mMCTEaBeRjRz4nSG9vfnZlX1rK6IaoepxUC
         OETugj/DQlGSwMOcs9b8H9dJLwc6Tt/4GycvP67g10bX3dUOb3wTDg7Yur+2thuv7XMd
         8zfhI3HS7mzzji3B8LIE8DyWvvEPyzQNBqzsZvR7kNzhDpKtRNvWLOtXRNexo7z4c1j/
         ay6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0yqonjfzX9QxirGgFehpVVIaduO9UwtK5AmrI3GZ6yQ=;
        b=mBUyhbgJUA/I07dmgG6mlh4FpiDOXH0krOPVulmZByMnq99Y7hSvxUFPzkrbsYv40W
         ZCefYK0GFmefdg6XfqU34K0Cm4lx6xidDae2E68Pp9c+Eo4zehGGfNOUeo+JlNl9M38A
         Fx0scnQaK9B71LJCq81i111c913zPxSOG1OFY1owp8hfPSVjhAMTWEOhLecfFEShdbbb
         ePIL3uXJiRaozcaRcCglPoAk/NnVa+ROvTXX8m3mo60w4TI7P+5b8ULganxYikFQCTAb
         Nf0I8BcaanPOiUv3N8h3Nble6pA+lQStksPT+LKGLawSR2r8SlZHpCNB9DC+85uXh6VF
         MIhw==
X-Gm-Message-State: AOAM530wBd0S/LgeD9J2UjXuYMl2HXO9ikXSbieBtExRc/Z4wS63Rs+L
        GgDQC0gn8tIO2TuXsFjqDkviFb3RCDa/ODf3mJiBTw==
X-Google-Smtp-Source: ABdhPJxVflv3SCvp9JwoHo/UGnaxlb8CfXLJfB6dEMmcpSpa5wRtOC4xX2AOsngFm6ZmdW4ISlhdBDuYipqi7x98m3Pohg==
X-Received: by 2002:a25:e8b:: with SMTP id 133mr8080620ybo.13.1593205778812;
 Fri, 26 Jun 2020 14:09:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:13 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 08/12] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index f3e86c3953a2b..795039d9f1917 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -228,6 +228,15 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites);
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+int kunit_run_all_tests(void);
+#else
+static inline int kunit_run_all_tests(void)
+{
+	return 0;
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5aa..d3101d8874dea 100644
--- a/init/main.c
+++ b/init/main.c
@@ -106,6 +106,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1504,6 +1506,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_run_all_tests();
+
 	console_on_rootfs();
 
 	/*
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 7015e7328dce7..4aab7f70a88c3 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static int kunit_run_all_tests(void)
+int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
 
@@ -23,6 +23,4 @@ static int kunit_run_all_tests(void)
 	return 0;
 }
 
-late_initcall(kunit_run_all_tests);
-
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
-- 
2.27.0.212.ge8ba1cc988-goog

