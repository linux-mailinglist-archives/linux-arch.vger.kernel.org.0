Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29324556C1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbhKRISc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbhKRIRo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:17:44 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51505C079790
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:48 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so2254902wmb.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rzdCErYR7QVJMqQ7C8iOEn+pKBOJL+BpLP2uqDT2sRI=;
        b=lywc3NBHZZG/l/NByd9QMLrak/0JWSxz9fkaHSvQpFiu6THhd/Nji8+4etKEu/FWb1
         DUr7dTzctJFdTqeiReLlmlOSBqRVuxOd5rYx5nJHm3aM+ZmXYgZ3vl4Ce8tFrt0Av3T1
         bf9NeFQD3uLC7xCUpZwxhl9alcSmSnW523ahX1+J5WE1eN8IqUpB8WLaFMwKtqyVR2H5
         VBmh+uW9lUYfpnV9Dv/+zhxWz2y1F+L14D0bQuciTgOc/C7axKYJxr+/2pkCLLBSQ4sB
         E1t7FIYUwhm4GLpE9UPOpx8Eww9R6mgkFTE33GQnZrk37IxG6T6TO6OsAK9RCGF/iBpM
         yZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rzdCErYR7QVJMqQ7C8iOEn+pKBOJL+BpLP2uqDT2sRI=;
        b=Q14qW2YbidvgNWmq/mY4VlxPH+Gy8GJe8IV8rGbXXZ468DpbA0xmj4C04bNzLvIL1s
         wJflrczYbMIQRZmrDjPxfjTKNkEyLKPpNoEDgsU55u5ZzD4p0PzIJbY2fGDhdrg6Z7H1
         T16u1onxrFzsHSjlAxIcLjX4ehrp24lqyGJ2EcKdonVBeBs90Df24UIkAUu886AUihqV
         kLbG+Xx54OAkBOTDRscoRr2qNiyGrxwqAZvOJlPgejq3RII27g2S3lEwgJXd/+PGxWtC
         arnc8JVRJi0JWdgYhjNDbN+PVCJMbywZKPZS7pS2OZLEhQKLZnoqSHWBlk2CJSISj42+
         BRaA==
X-Gm-Message-State: AOAM5325HTLx2XfXZiI0DThK1hS/wH2I3JfUHwFwqX2CL6c/jRGtWOS+
        YMfGpVmJJBgILyKFQ5L66+tz+YsBMw==
X-Google-Smtp-Source: ABdhPJxAWh/BZwpokjufV74uSy9dmYvaQlEFQf441y59AQVEiD0veafOsEsU+5qgKzAWHYtjU5201SdIww==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a5d:6043:: with SMTP id j3mr28104905wrt.375.1637223106899;
 Thu, 18 Nov 2021 00:11:46 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:24 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-21-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 20/23] mm, kcsan: Enable barrier instrumentation
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

Some memory management calls imply memory barriers that are required to
avoid false positives. For example, without the correct instrumentation,
we could observe data races of the following variant:

                   T0           |           T1
        ------------------------+------------------------
                                |
         *a = 42;    ---+       |
         kfree(a);      |       |
                        |       | b = kmalloc(..); // b == a
          <reordered> <-+       | *b = 42;         // not a data race!
                                |

Therefore, instrument memory barriers in all allocator code currently
not being instrumented in a default build.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..7919cd7f13f2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -15,6 +15,8 @@ KCSAN_SANITIZE_slab_common.o := n
 KCSAN_SANITIZE_slab.o := n
 KCSAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_page_alloc.o := n
+# But enable explicit instrumentation for memory barriers.
+KCSAN_INSTRUMENT_BARRIERS := y
 
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
-- 
2.34.0.rc2.393.gf8c9666880-goog

