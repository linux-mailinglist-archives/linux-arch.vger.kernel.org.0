Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B894556C3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 09:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbhKRISf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 03:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbhKRIRo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2021 03:17:44 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044FC06122F
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:50 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so2010272wme.0
        for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2021 00:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SnYVQxLC6YSHg0QBspCa3KEICf+BvvptqJyS2cHTmDQ=;
        b=q8lE9LF6eLo1vbVpYF4n1ICfJW3NoJ/hLMQz3VMTmpM/aEhlGa4qJ6VUiOnKyvLK8Q
         Oi8I7HXmebdHANR+j99BGIGfFBKv5r18aWiXgSYXRVP+oCwHVORXPU/n08+bF4aC070o
         4Ddh/74+9xIYByQdLDGSqWdmcWUMiKT/dn+E4fzNssfR267fHQ5ri4ABmCuCPmZeXHeD
         EQjo7hnV0pCiRiNZv8eV91KK/GgzYotgsm8DHEB9YlvAUqfjBr4xHiWPvUOGJ3uOlx7E
         GIIMcoADGq6ms0hdPAyC6mEshUnBV6rKSFIlvCkQp+UWhxWcwb1dZnrw8PR2VDwbIjW2
         E28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SnYVQxLC6YSHg0QBspCa3KEICf+BvvptqJyS2cHTmDQ=;
        b=eDgXhfc//8TCwm9uUaenYBfAJ55bZimaKUbh+4yaxYVBu61hkaDDyYDOSGVUe+nrMY
         FP2p/9t9kRCZBa3SK09XC6PkDj/0MoR8ZdXhfgY40qgCcA0Svgitddsrkq6FzdkHmhnn
         sHihLMT543koIOHN9o7/tEofvblh00nkuQj/uEsmLGqmnUqP5w+jetIMO67Px4HXIPyw
         1GuwbCDMIe8rvOpywQVi8JaGyuWV0Mgmlw6QhyyeBfVT52fMyFVQ42OIsYPg7AeGwbpD
         Fxs7MSmjT0zkteVmzf0kAAwOA0/F9P/6otU1zcw6TMbwC5VygpFtNTZePZlmlEOQIG+h
         GeDA==
X-Gm-Message-State: AOAM531m/Gn/lisvJTVa43ROXiWhQlD+Qw53qRTtZn1omYE8xD41Pg6z
        1P7UlTzRKoHxfAFO2qkRh5U7x1m3jQ==
X-Google-Smtp-Source: ABdhPJztL2viLMNJ4W40F+xMcVTMDTh0cI7ELMsOn6MVEO+vm91uJrlBHQ/y6vYeh7i2nbNPusXRUVe71A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:1987:: with SMTP id
 t7mr7663727wmq.24.1637223109239; Thu, 18 Nov 2021 00:11:49 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:25 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-22-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 21/23] sched, kcsan: Enable memory barrier instrumentation
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
index c7421f2d05e1..c83b37af155b 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -11,11 +11,10 @@ ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
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
2.34.0.rc2.393.gf8c9666880-goog

