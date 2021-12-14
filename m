Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F074747BC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhLNQXA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhLNQW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:58 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA6C06173E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:58 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13420707wma.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RahC8+o5lwzgAvVh7zx+7oLLYsmuRte28muTwb6Tt+E=;
        b=kXx7p+TaPFKll9TwTsjKqgOr+UNTl28fMuejIwJkUW6waRnU3wWq6CRAGRiOmMac5D
         gTwgJsYAX2xUIUEmYzvGp2hyPCP4Wm56BgSaKglv8p253lIAFKtOY7B1DPzLwsEBSgO3
         v8bHgT4qtyZDjeAG+BxPNiXz6Qdhn2gdCfTrLJNeLq51/HcT+lJ2Ymj5ZoFxtQHe6oAH
         IP/iLEHWxBPgmzVXkPVim068SXK6M2LIzTb5O32c/PJFtTHPYZt4cKS+VoyYpNtZVNo1
         ucPlb5/R1XeuTBxqsz+siScqUDO0GJ60AvXx4VJ4v0JlBp6aMTl7d0fSj2nEnuPbOiBY
         xwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RahC8+o5lwzgAvVh7zx+7oLLYsmuRte28muTwb6Tt+E=;
        b=QEx1cbWRTV3MqF7FfB2z8Q1/8EEhjlSKV9JUNqlYZTDvb4LyDHO24FJ2P+7djAveg9
         Nr6tmP2BZRxqnFY9SewuWdgvxRoWUXCnwrjs+dTloUifo2nMqC3pzSSRIWZozyVtmICn
         CZt9mCNA6CVq7iOtELshLINoyqIRM+R/QZAWFm1BVvsukgTKL/kiFdBNVms3fZ7bb7pW
         VawlMb80LGvG4NTQJD1/GrjAdSybYy11FPGqFsR8BRm4cyObjFNFO2SOWSI0uzm+/nUQ
         qLOWYD9nIsTyeVws81d1aphHp3lVWY54ykDNB2RpcTztOehU6BtRlnEFksmGbzcZaJ4j
         wL8Q==
X-Gm-Message-State: AOAM533doOWM1hVZR1ADk2j5wLt5NtwC94Sq37CpJjUujpZZ4wTanYQF
        VeZQP8Mt4dh6h2JxlkEGlc+sjVjgYfE=
X-Google-Smtp-Source: ABdhPJyS0Vu024wH2nH284+5iPoP3BAzIuLrJ7O37SST95Qm9Dj5aepJ2oaLYM+pIKc9+sfuQR2fDWvghJc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a7b:c097:: with SMTP id r23mr46571900wmh.193.1639498976421;
 Tue, 14 Dec 2021 08:22:56 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:30 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-24-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 23/43] kmsan: make READ_ONCE_TASK_STACK() return initialized values
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
2.34.1.173.g76aa8bc2d0-goog

