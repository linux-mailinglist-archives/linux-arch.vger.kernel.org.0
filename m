Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3724EAD93
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiC2Mtm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiC2Mr0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:47:26 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57921C046
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:15 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id j39-20020a05640223a700b0041992453601so8688609eda.1
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vfNewWnsnLKjgrLxloInM3ksKktMuhZ88Cjjen8dSfw=;
        b=k2grIaWEX10+pjmxqhkcyCA78d3h23qdz2hQwriW/AtBkEbXWlTAWHSjR5jVjwbRd0
         HKX1zG6uUcVNaozu8WxucSiCuQwHnnudt3nW2uxWtac7hF54EJ1kbSIlqPv4TwsjdCTr
         G92SqYktPjAwRps3tSeMbzJyGmoMawImGJXnVDm7RQbHHOMHmWqFKxMC2IeRQOg1Xhxq
         OJFN3e7mKc2NOaXlMGXsa9yHEVB8W3tfRWFhpSrRETeApxMNk01V3f1Rz7tcgby1LDeH
         XGjGGEIIihzXVuI4E4ZD/omsJ5xBfcLQ6Erf+tZ7ZaeE1xczews93WWLLOk7DrdHF6hz
         Ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vfNewWnsnLKjgrLxloInM3ksKktMuhZ88Cjjen8dSfw=;
        b=sarWoaH/orJoMoMGZPdwNcJ9wPtW2+KJ8zJvStAt7j3kB89Gkmhw2n75I5jHAU43Lh
         37zkPLnScmEEkv0tEU+PKa+RnhVASpqdCTqPfYw7WlriTXz/N6XnBVEUkCgMDIBqUCvl
         /Gw27PHF+epkZPHu0bFGhpvRcuH+UHtpZAfESRBW5gixiNxTbkIYyTH1PMX64MqKFUsJ
         UZsl2ePhBOKIC6cd6I8okc/yYVXq3TtxisGB7QzsHmcheMXZ6WBJNRlPUOctcrfoW2x0
         qarwT6M25jLTiQZQE8PLxMDZVDx+VFf4cbiywYA8VzCYDWMVd7p6YGHltpzsPGKS7Bbi
         5VJw==
X-Gm-Message-State: AOAM531D/SB8U+gyqxi71X9xQTOgy//edZugrrPuYaEDrhNjTzCupJtU
        jCYWztWUvKJwsUZeeTeabNY9L20qSPc=
X-Google-Smtp-Source: ABdhPJxYhi4C5lMRGBP4ot4j5u4X+r6OfqpTJ+iIL9kMkH3POTY1BlEuc6eV3fFfpCDp3jcSR0ZuHMnxazU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:2699:b0:6d0:9f3b:a6a7 with SMTP id
 t25-20020a170906269900b006d09f3ba6a7mr33007227ejc.397.1648557733360; Tue, 29
 Mar 2022 05:42:13 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:08 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-40-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 39/48] x86: kmsan: make READ_ONCE_TASK_STACK() return
 initialized values
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To avoid false positives, assume that reading from the task stack
always produces initialized values.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I9e2350bf3e88688dd83537e12a23456480141997
---
 arch/x86/include/asm/unwind.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 2a1f8734416dc..51173b19ac4d5 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -129,18 +129,19 @@ unsigned long unwind_recover_ret_addr(struct unwind_state *state,
 }
 
 /*
- * This disables KASAN checking when reading a value from another task's stack,
- * since the other task could be running on another CPU and could have poisoned
- * the stack in the meantime.
+ * This disables KASAN/KMSAN checking when reading a value from another task's
+ * stack, since the other task could be running on another CPU and could have
+ * poisoned the stack in the meantime. Frame pointers are uninitialized by
+ * default, so for KMSAN we mark the return value initialized unconditionally.
  */
-#define READ_ONCE_TASK_STACK(task, x)			\
-({							\
-	unsigned long val;				\
-	if (task == current)				\
-		val = READ_ONCE(x);			\
-	else						\
-		val = READ_ONCE_NOCHECK(x);		\
-	val;						\
+#define READ_ONCE_TASK_STACK(task, x)				\
+({								\
+	unsigned long val;					\
+	if (task == current && !IS_ENABLED(CONFIG_KMSAN))	\
+		val = READ_ONCE(x);				\
+	else							\
+		val = READ_ONCE_NOCHECK(x);			\
+	val;							\
 })
 
 static inline bool task_on_another_cpu(struct task_struct *task)
-- 
2.35.1.1021.g381101b075-goog

