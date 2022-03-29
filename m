Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AA4EAD8A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiC2MrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiC2MpX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:45:23 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570723D5BD
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:54 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id n4-20020a5099c4000000b00418ed58d92fso10976939edb.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=enpw47tW5AlKxiO7mK8zQaDRtxatFy2+pOtakd8BlZk=;
        b=mCwjmjg5IEjrVFruDI8qNciYEOnA2jiLkX9pLqN6BnRcekJoE0XFuHwS9ksz9BZuKY
         n2Vq+3ICaYrPhLsEY2JcrP3sAWEO8412GRb/cLfojFWc/Jv/zfHf6VmhfoHQDyibrhRx
         8IC9UaRnp3e1xpCjw97idSW8aarWoqZh0n2KfPjUQhED20Y5dJyYXlGP9d7TDcAtLJjJ
         tGVXH5XRlRg71IARaSa3IaKomYbSYugJMCjnDyryrStOIVf7B/EHB5TBnzADPTie1FVi
         apknmdO2z63KmAh6CYf0AHjMa0AeJ4eU4IOL9/Ql/UgZ21OFy1M4gXnTW1xPdquE8NbE
         svEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=enpw47tW5AlKxiO7mK8zQaDRtxatFy2+pOtakd8BlZk=;
        b=uEq5vQ9eqLls1Peoy6mU6QTJCaCxUhAtqr2bTA9gJcheKY0MiVdgK41ER33qHBbfaM
         Tr7m8y032sFkiqjIv49ZdoTsvx2JDr6IJFu0cNKGSgRMT0iSYiqkxDgcVNSl/ASHUvyo
         Oz6MSEwGkaTbEorNGpXqaYHgl/LyL+UqOSpmYwKf2kO0Y2fe59S2MSUYf3xBi9nrVZxX
         njbmXzNloAamCncez8gjKSO+VsPFms/KloNA2QzUAI/jIXaS+h3ODjfrEmJsTjMqLddT
         pHDP0GmEwJuvOxh6MDg8FDHvsEnNwc+MMYN+GzaGcG0Geci3OT8HyXqf48+kdfFWCH2T
         jQrQ==
X-Gm-Message-State: AOAM532mzryqOeoaY+LRV+VInajssKOJuau9qYY7UWwNkW2aMQ4Um313
        hTnBRBtfiBij0MOCPJGy0zuWLnFbHvw=
X-Google-Smtp-Source: ABdhPJyvopsmMnmkArFS+YVZS01vYvUWgOoKNLhFelQAgUTgMKFm4yxx2n/LM5t8wnbOjIRaXG8/wiLoWwo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id
 nd23-20020a170907629700b006da6388dc58mr35414945ejc.472.1648557712510; Tue, 29
 Mar 2022 05:41:52 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:00 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-32-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 31/48] kernel: kmsan: don't instrument stacktrace.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When unwinding stack traces, the kernel may pick uninitialized data from
the stack. To avoid false reports on that data, we do not instrument
stacktrace.c

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Iadb72036ff6868b1d7c9f1ed6630a66be6c57a42
---
 kernel/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 80f6cfb60c020..1147f0bd6e022 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -40,6 +40,11 @@ KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
 UBSAN_SANITIZE_kcov.o := n
 KMSAN_SANITIZE_kcov.o := n
+
+# Code in stactrace.c may branch on random values taken from the stack.
+# Prevent KMSAN false positives by not instrumenting this file.
+KMSAN_SANITIZE_stacktrace.o := n
+
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
 # Don't instrument error handlers
-- 
2.35.1.1021.g381101b075-goog

