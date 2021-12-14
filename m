Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA24747B0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhLNQWr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhLNQWm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:42 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E3C061574
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:41 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id u20-20020ac24c34000000b0041fcb2ca86eso6751262lfq.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ue972WbBd9grr+IhEpVqeTCdlW/8PMCymIUxIIoyED4=;
        b=Vr7vmjXO/ZQNUilyHT6HA/4buGSLSIYLl/qRHTXk31zD+EY7VC067MV2GQ1gcTKpSL
         34PYjt2oZaAHuR1Fn95QkJiDKtzO0ehg1sLaVJ3mV9Y/Q8LNlPIsbFpa/FZvil+9C22s
         RghE2q3Ejxg6cCW4gIHjwKLyaeOXsYQgRcgWD67OGB4gKUL2V1URRinmICyKUNyEpVoH
         YKwBGln2CVKOxUWHj7Mi81ouKRz2wk5IcSIbyOVRKabXX5rqPMETegoTJdq7sPCtpPmD
         xJeoztIdPUYuXWvmGaaEgBf6cjVJ0hyqY+1sd85pw7pOleo8UCuNLkXCZnmUeWgy27o7
         ZsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ue972WbBd9grr+IhEpVqeTCdlW/8PMCymIUxIIoyED4=;
        b=1Msv10flPB9FDyS/Q0HkNL9cVFV/8Bm9qqpo3a7xKb+T0C59P+upLeXoIenUUCTZN6
         gYvABF7xNIqO3lK2lX4WUzyZYdld8w1r8QHeWoJdaGFaLRWratapMUYQ3jY2QqNkFiTM
         FNyCWJeaCC/exPLxTYUietQDiWjitB1G6QEh3s+Mf3Jy1uiGSfbkd1EqGtvwdV5+l7EY
         rkls8lg9vf/xfCZ5VeMKh6dBaqDG3ROhINUFhEDSbETyAykoSKYnkxr5GQyMI+2ESG2d
         3dUzwXuLbhwD67Ed3Bdf21o5z1G3fCF5tNtt5zOikPHf67xgrSWNtjgFfTXA20pJ2Vrk
         F+DA==
X-Gm-Message-State: AOAM5326Kx+Yp2ylnVttnoQboP3FMzqZdfxF+9uyI9h1QlBI53Ttasrs
        D49a6kHy4oR8fsnaZ9PPZUBV1lnmnFE=
X-Google-Smtp-Source: ABdhPJwof4yAzLY6jvFwcb35lrlAFHi9TWhnsoYR/pbbpZnrib18G9NF9LFXSvNYzy5cHEt+ggjwBFIkk8g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:ac2:5110:: with SMTP id q16mr5605822lfb.56.1639498959625;
 Tue, 14 Dec 2021 08:22:39 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:24 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-18-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 17/43] kmsan: handle task creation and exiting
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tell KMSAN that a new task is created, so the tool creates a backing
metadata structure for that task.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I0f41c3a1c7d66f7e14aabcfdfc7c69addb945805
---
 kernel/exit.c | 2 ++
 kernel/fork.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686e..a276f6716dcd5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -59,6 +59,7 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/kmsan.h>
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
@@ -767,6 +768,7 @@ void __noreturn do_exit(long code)
 
 	profile_task_exit(tsk);
 	kcov_task_exit(tsk);
+	kmsan_task_exit(tsk);
 
 	coredump_task_exit(tsk);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697d..5d53ffab2cda7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -37,6 +37,7 @@
 #include <linux/fdtable.h>
 #include <linux/iocontext.h>
 #include <linux/key.h>
+#include <linux/kmsan.h>
 #include <linux/binfmts.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
@@ -955,6 +956,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	account_kernel_stack(tsk, 1);
 
 	kcov_task_init(tsk);
+	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
-- 
2.34.1.173.g76aa8bc2d0-goog

