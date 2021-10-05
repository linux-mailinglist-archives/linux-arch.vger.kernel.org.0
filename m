Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F8422474
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhJELDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhJELDU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:03:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA53C0613BA
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:32 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r5-20020a05620a298500b0045dac5fb940so26459426qkp.17
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TKNtzDHuk87hCc1lxzVppXFapgrghO5zpeN0ZyRA5jw=;
        b=JKcUv82mPXqeJdPMCbVh91BG9upZmsAGCCh/2bt+IWLY2yjvITsH/cWV/zU35BdKTM
         jNCdIMmV8ckWS5Du9bS6YqvpmsOpyxG9JOsg8ePp3uP/4/z0HeO/qNWOh2guREdPHWF6
         2ByHNRDO5z9Q3gSP3P+haGegcVGmNGue9HJ8ljLcuxqEbk3AkomVVo1IaOdhXrryVvmy
         qdZyjIh39khqL0eN1TepdMNJRut7rArDExu0CgJa/4U35yc+kvnNRWfL61YAkvrh63ES
         QldniYUzN5VCAcdUFgtq+R9OdRNKMwd89lOkofWQW5sAjXDcndxnzwpFNvf77dR5ydM4
         sR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TKNtzDHuk87hCc1lxzVppXFapgrghO5zpeN0ZyRA5jw=;
        b=EJB9zRhPfjDbguj7acdInFnf0Djyff8DwssQ3zfywOdd0UZruHBCgfFxJCAkreiLsf
         7zi3Gm1/AxpWkNWTIEwiOxfDtgbOzfsderF1WN5JFmHvBe5rHv1CiRCX/52OQQZoXXbM
         mk26VTMFwOJv+UGpIJXtxQHAT200Oqs3KLxOZysIqZHk9M/7Lf4nE96PKqOgJnz/Wy2u
         rWyHZveAdG8epLVb5X9NEThFjdsYpACDjzil/aySU4GbbFOHwJnc2IjLy/+fubyvQ3XB
         YI/4q8maUneBC3pM82PDpDhGNp/y23xjd63oM+JYM2eiAKI6qC2exQAPZDGXcd8NY08k
         1cPA==
X-Gm-Message-State: AOAM530Obwffv1vsLTuiZaiyWP28DmZYASkPNPu7eVs4dvXzCBRgf5Pe
        7KUZRiNlXm+xhB8mFAeQOtdbAEwANw==
X-Google-Smtp-Source: ABdhPJzNiBAgAqz71GJIOzstXGmj9ewgvEQ07LltyxgH0Wyapt+QKybDaL8wqCgtEnvE4ONvgrWG9IIZ8w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:ad4:46d1:: with SMTP id g17mr26469108qvw.5.1633431631997;
 Tue, 05 Oct 2021 04:00:31 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:59:03 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-22-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 21/23] sched, kcsan: Enable memory barrier instrumentation
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

There's no fundamental reason to disable KCSAN for scheduler code,
except for excessive noise and performance concerns (instrumenting
scheduler code is usually a good way to stress test KCSAN itself).

However, several core sched functions imply memory barriers that are
invisible to KCSAN without instrumentation, but are required to avoid
false positives. Therefore, unconditionally enable instrumentation of
memory barriers in scheduler code. Also update the comment to reflect
this and be a bit more brief.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/sched/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfca5871..90da599f5560 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,11 +7,10 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
-# There are numerous data races here, however, most of them are due to plain accesses.
-# This would make it even harder for syzbot to find reproducers, because these
-# bugs trigger without specific input. Disable by default, but should re-enable
-# eventually.
+# Disable KCSAN to avoid excessive noise and performance degradation. To avoid
+# false positives ensure barriers implied by sched functions are instrumented.
 KCSAN_SANITIZE := n
+KCSAN_INSTRUMENT_BARRIERS := y
 
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
-- 
2.33.0.800.g4c38ced690-goog

