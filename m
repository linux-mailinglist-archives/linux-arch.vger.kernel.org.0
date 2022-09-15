Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FCB5B9E65
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIOPKh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiIOPJN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:09:13 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AEB99B70
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:09 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id m3-20020a056402430300b004512f6268dbso12394416edc.23
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VswCSWA+rV4PC5eDv8SsttMbBbTb1fmAEKvfw1RwEtM=;
        b=qfYRjxVXvUP5x+DcPXm3cMpN29PKGbNCTHYBFMXzeLDQrOVXXcI7lnw1mKbLyfQDyf
         zl3gs2m3r+JCNAr/TDs0bhFO5u7OCk1B7yPDbCbyn/nyJ8moWGvVbwEJ8b/NTADuA2hu
         GVJM48X6WPcJX77xHjwdMXCTk2TzlmcM2WmbJN+Tb7cJYZ8ZMxb4lsDwYDszYJI7C8rM
         1v90JwvujpMn91tjws4xJKu3q+aRZi4qRprrXtU3qcvqWjX+oI7M0nFmjrmJqS8Xks0S
         V+NPLDQXzcvw7OagUuNKL/XuXS9vYYBVB/CqPRy/mO0mjIB75a2Iuvk5eZtREaBUnGAd
         /+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VswCSWA+rV4PC5eDv8SsttMbBbTb1fmAEKvfw1RwEtM=;
        b=OcgDmNkGOH3DRFfLDu+c5h0voYvwNeZ8Q58/m1MwqhTfsMAY6MjAhAmouBeJvvFqmk
         ekE7tNOSbSON7KusYsLlAd/NRtfe7MnIGMLccpcgYeCaH/eUE2nOFtPcGA4vCeNQoPTY
         3tnV5RqVR82It7YKjvjTB8KcMa+0nm/G1AmYJO2vE1Y3H2+stBkgM+CbA+9NSEyZ/M74
         etBu98ICvQxHBRi40Wh/cPIxnrFmQkfzY9ieC77K/acaReTJXvki7mxVKQx4OQEqBAAL
         w2aCA6vXoQglW+eo5oT+/JFDJ374s8NjGCkYKw8VKZLfRBR8HXjKemb3jPZ65CkxdiTE
         dH7w==
X-Gm-Message-State: ACrzQf2dXCXoCx46KMSWVJyoZ7kn3Jb2Zj5FBF4Ysv9S5dy5tMJszihE
        JwOmDz33s8CzrcOsDdDn2qWBbfLI9Iw=
X-Google-Smtp-Source: AMsMyM40+Qmw8A7AGwDvjdL9jpgt8Lg9YP9jjEB7Zsvzh23DArp5ev7LtXtgv12tVm2rdXsgBXwpmJSl8vI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:1655:b0:44e:b208:746d with SMTP id
 s21-20020a056402165500b0044eb208746dmr253604edx.229.1663254368151; Thu, 15
 Sep 2022 08:06:08 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:07 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-34-glider@google.com>
Subject: [PATCH v7 33/43] x86: kmsan: skip shadow checks in __switch_to()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When instrumenting functions, KMSAN obtains the per-task state (mostly
pointers to metadata for function arguments and return values) once per
function at its beginning, using the `current` pointer.

Every time the instrumented function calls another function, this state
(`struct kmsan_context_state`) is updated with shadow/origin data of the
passed and returned values.

When `current` changes in the low-level arch code, instrumented code can
not notice that, and will still refer to the old state, possibly corrupting
it or using stale data. This may result in false positive reports.

To deal with that, we need to apply __no_kmsan_checks to the functions
performing context switching - this will result in skipping all KMSAN
shadow checks and marking newly created values as initialized,
preventing all false positive reports in those functions. False negatives
are still possible, but we expect them to be rare and impersistent.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- This patch was previously called "kmsan: skip shadow checks in files
    doing context switches". Per Mark Rutland's suggestion, we now only
    skip checks in low-level arch-specific code, as context switches in
    common code should be invisible to KMSAN. We also apply the checks
    to precisely the functions performing the context switch instead of
    the whole file.

v5:
 -- Replace KMSAN_ENABLE_CHECKS_process_64.o with __no_kmsan_checks

Link: https://linux-review.googlesource.com/id/I45e3ed9c5f66ee79b0409d1673d66ae419029bcb
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe7437..6b3418bff3261 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -553,6 +553,7 @@ void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
  * Kprobes not supported here. Set the probe on schedule instead.
  * Function graph tracer not supported too.
  */
+__no_kmsan_checks
 __visible __notrace_funcgraph struct task_struct *
 __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
-- 
2.37.2.789.g6183377224-goog

