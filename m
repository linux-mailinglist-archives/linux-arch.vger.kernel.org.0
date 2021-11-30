Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5232A463321
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhK3LuP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbhK3Ltj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:49:39 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A90C06174A
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:52 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id ke1-20020a056214300100b003b5a227e98dso29052196qvb.14
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rzdCErYR7QVJMqQ7C8iOEn+pKBOJL+BpLP2uqDT2sRI=;
        b=iiJU/NFxnkO4QpNuEziwm44ZddXcfbqTjJ27RND0XQcNYVVoxyYjAqEozptVgUXNwN
         tUotgFLhO6hTdCXy/8o38iy2aym7FJT+LW4h57+kXk+ITZwaPtmf/ukrKduYHtwrNNVy
         u6zRnFErKVJc5tA07nIb20yQJs/rjFgBkkJfiMGCJ0+/frkqjjvq7sB5Qlsbun/G1B3v
         mpVqufLXr0RiWnvRXu2PZPDLndJRxYoHPg3pEXSdStYWib1eEQIROpsu8lv6/UvQvgN4
         KcSqzQSZ9rtkXbOEAqLYcx/YblyNiiImRh54NndbnYSq+4cJ1Y/85RKTI5bPUsrRqqxr
         ZZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rzdCErYR7QVJMqQ7C8iOEn+pKBOJL+BpLP2uqDT2sRI=;
        b=LLwNu/37zIkd4EBSa/09WVL2YsNQsZ9cmZDrbSlBkxfrstsN7LuUMd1UX8VwRZQAfO
         pQohOcrb+tGllVT7X/J7VPUPqr1+bpVdClcZJD5VKn3SpXmzz2v+GSg8NVg4aDbtaMbY
         UeAeBb/sRLO86+f+DHP28Zw0yD1UJ5+0p5jd2vgSNKcI11FQcHk04X2ywkYkr/38fo6/
         w1IcZY9LlJv4F2ReC5CRBuXb8SnUjQYyaVtAxUlNGxFKoAwG7lpnrQGJRZQO8tlTZqlv
         eCPOCMJQfvvdsO50M/arHL2tnSjXOvwI6GLGXk2M3NmZS6zqdnqoMBBtrgMz+I1pzOo9
         Gjww==
X-Gm-Message-State: AOAM530xzA0Rua4d5nF/xroebsBkBP24/N3MGVwikedvQuiigkpi9dmA
        8gHqHVXnMunQUAhdeZ+A55+rRYektg==
X-Google-Smtp-Source: ABdhPJxS2DvHFjm5rRAa2Cv18Mr86xucn8I+904NmrEkNJGoQhVDVa+JTgno3MDa7PBFHMKHIzeyW8Gdjg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:ac8:5c45:: with SMTP id j5mr51253786qtj.58.1638272751779;
 Tue, 30 Nov 2021 03:45:51 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:28 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-21-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 20/25] mm, kcsan: Enable barrier instrumentation
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

