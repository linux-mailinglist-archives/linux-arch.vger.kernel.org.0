Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F20510469
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353302AbiDZQva (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353355AbiDZQu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:59 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E94833C
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:57 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id ee56-20020a056402293800b00425b0f5b9c6so7562932edb.9
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fx98fFr6n4NVKGBzav2AZaWX3VRzhlrRB+7m3pCHiSE=;
        b=XHfBp7Cl9xVO2N8a97yhZbWVDGYXssOGKoCjey19oDLs3NuPvKFqJlX77OVyMj94Gt
         2jjyaOrHBMMVqPlV8iHx1esMbi+0FDIhnzF7Cykz5C7cq/uxOyLSo3F2oQbehHxHtWWq
         J0Gr9w+xpCyeNSmgjOjL6MaF2r1Jb+P68Kxo24lt3IECVMYNwPiYSWt8f1OWxVrhhtpd
         NO15cOsJnLjPuQEWdNOcUO0Xa9QVwX7bjyI3Sb7JSEshKJQJE+Pg0L1D80PFDwJ2uTlH
         nrRZFhYPzn8Skr3KSaxneh2u7R3qXEV++ExcIhKQSHekMMa2AQX+GQFmuIwyxjASi21j
         HPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fx98fFr6n4NVKGBzav2AZaWX3VRzhlrRB+7m3pCHiSE=;
        b=lJIfVmZX2vV/dETVV/nlrAT8itEyIGEEZU4M5RjJutnvqM/X1ok1XI7H1VbfktIHrC
         OYnxvndATsiYDOt52GRmIxtJseul2eHeQlYAtedkuebcxz6YQM5brGKjTF+lE2i69Ha7
         qeE9ep7ejZmXYXVOqbElut+s/brK4V844+VUakxAZwKMfv5GBjYHKuxHCveAT69UKn6D
         eru4nbvDkaEG27wbwHZvPvU9L5edcAsnN42wslg0neWCwW0Ya5z5C4UDiJCeRhJKYvCp
         vWEJvT/Q7Yht4o+d9CZMxBZNNjEdK3/EHxeKksANc7C2nZQNQZoZJIQJMRgTdcNoukg4
         HHtQ==
X-Gm-Message-State: AOAM531Ib/pT+VIEuLSgCpgIRaejKUKWei4rjK4myD1ss+w9/ujrj8+z
        J3ut+dLzxVg/y4N+dIb/RIiug1MLIuI=
X-Google-Smtp-Source: ABdhPJz3WWkOPsikmC1Af3Hb7X8sg1uvJjDWagM85J5s9I3Wdek2Bn8waW8w9Db/kDe/JuhNTPmAIxhWeNI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:34d2:b0:423:e6c4:3e9 with SMTP id
 w18-20020a05640234d200b00423e6c403e9mr26328332edc.372.1650991556120; Tue, 26
 Apr 2022 09:45:56 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:06 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-38-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 37/46] x86: kmsan: make READ_ONCE_TASK_STACK() return
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

To avoid false positives, assume that reading from the task stack
always produces initialized values.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I9e2350bf3e88688dd83537e12a23456480141997
---
 arch/x86/include/asm/unwind.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 7cede4dc21f00..87acc90875b74 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -128,18 +128,19 @@ unsigned long unwind_recover_ret_addr(struct unwind_state *state,
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
2.36.0.rc2.479.g8af0fa9b8e-goog

