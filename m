Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACAB4747C3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhLNQXW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhLNQXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:04 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A57C061747
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:03 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso17404237edc.10
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xZMxa2IZ9PyGSHm3E9nGFaCLmWiCwIuxu82/2O/up20=;
        b=XR+HPRlPVgp78GgAQuXZH5EQe+yT8LUijF4sCwhvF/Hnl2NqxVTDK9SVnMw66GBEJu
         9MJcKFO47mf2RV6dBMSD8MJlu42CJz5Fobu3cWzWHeBIHvHhwEQfcveY7UAMaO3+lbOj
         7pGfZC6Hhi0JHaqKHBVS3+baxymCGyDAP/tOyKyVsTFQxZ0jk9GsbnJWM2v+Nvltl9Xl
         vDDvMPR/OWSerW+7NPfx4TCClYTIbelFjoom9NBRy7ROahI4mxVi+nSTfWE+K/i72AtV
         1npD3HLpmFQnKAcdbk/A/Rdy/L4fROYY8r74NOnhZ6NfET6hFBZEqAs8Oiu8SZiJw3tX
         K+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xZMxa2IZ9PyGSHm3E9nGFaCLmWiCwIuxu82/2O/up20=;
        b=L1WE1xcrtslqiFswjUmPIX5QLxnDpFR8gtvrQ5sBSISuIh7YoCG57sj9sMhx/jdSyz
         tXTgXkOwOtR976FC4Htz5S/XU9XaOvZDF+ZzlVFoOuOXfbSCCpgs7UDBcUWddq/E68Tp
         DeZ2p5+h54cEGksXOeG74vB221eLkPUzQdpHKiw0LKSTkVulW5YjEdNjUenV/mfZdxmU
         B0ATWsIYIgk72PVdV+hi5PmHVvILe6oO9OhmPHr5TwflQEfWASzBOB6Ki7EHCHuKV1Kv
         btFhhBzRdt8aiMBNSDUGW2XZqg0lN8otp0NNjmMoIj4eFGd5aTDoE8Qr3LjIvAiUKkdw
         NRIw==
X-Gm-Message-State: AOAM530zu9ugorPsGlN4LU+7SN/hNHNRHLf2GjXDqoByxOsiDgOPODYE
        HTzuTvoK1RgXc3EAzL7kz1B+Ho4wxwU=
X-Google-Smtp-Source: ABdhPJxDkINsrpRRtIs9J8NAwlws+KUcn4Kx5kT7tsSTkMEEIdTp8/ftKoVvOM/tsE5G/T9PjyGyMQkzT+E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a17:906:9459:: with SMTP id
 z25mr6688322ejx.331.1639498982009; Tue, 14 Dec 2021 08:23:02 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:32 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-26-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 25/43] kmsan: skip shadow checks in files doing context switches
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

When instrumenting functions, KMSAN obtains the per-task state (mostly
pointers to metadata for function arguments and return values) once per
function at its beginning.

If a function performs a context switch, instrumented code won't notice
that, and will still refer to the old state, possibly corrupting it or
using stale data. This may result in false positive reports.

To deal with that, we need to apply __no_kmsan_checks to the functions
performing context switching - this will result in skipping all KMSAN
shadow checks and marking newly created values as initialized,
preventing all false positive reports in those functions. False negatives
are still possible, but we expect them to be rare and impersistent.

To improve maintainability, we choose to apply __no_kmsan_checks not
just to a handful of functions, but to the whole files that may perform
context switching - this is done via KMSAN_ENABLE_CHECKS:=n.
This decision can be reconsidered in the future, when KMSAN won't need
so much attention.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Id40563d36792b4482534c9a0134965d77a5581fa
---
 arch/x86/kernel/Makefile | 4 ++++
 kernel/sched/Makefile    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0b9fc3ecce2de..308d4d0323263 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -38,6 +38,10 @@ KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
 
+# Some functions in process_64.c perform context switching.
+# Apply __no_kmsan_checks to the whole file to avoid false positives.
+KMSAN_ENABLE_CHECKS_process_64.o			:= n
+
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 
 ifdef CONFIG_FRAME_POINTER
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c7421f2d05e15..d9bf8223a064a 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -17,6 +17,10 @@ KCOV_INSTRUMENT := n
 # eventually.
 KCSAN_SANITIZE := n
 
+# Some functions in core.c perform context switching. Apply __no_kmsan_checks
+# to the whole file to avoid false positives.
+KMSAN_ENABLE_CHECKS_core.o := n
+
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
-- 
2.34.1.173.g76aa8bc2d0-goog

