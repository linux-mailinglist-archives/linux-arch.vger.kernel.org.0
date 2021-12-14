Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA54747BA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhLNQW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhLNQWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D45C061574
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso37550616ybd.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xrXvVkI6r4Vmn+7KKReTw1DvnU9RNEXMh/9+RUR+L9Y=;
        b=Sf/NXwY0Sja8M/PzUs1W+sY8VyA/Djybj8zo8xITaOYjOmAxm2jPwF1T6L9fwmnneP
         IPag0hEreQOp5npdzJEAderB2zK/8azetsweUYqaC2pZWtDo8K6FwZJl7uwJ1gYr9tQS
         QCLJNL5Nzb8WvzGLA1v5Risf+XOONz0kc7aMiFz7INAy72z3Yz+SfoeKd39ntJ1lnynL
         VveKA/P4j1Cqgoi/v1qwzegffbhOteL0iqZW34xOZYPFV7AGuzwyOTrZaf5WBnl/IsMX
         vHItLWbetXCgCXXM6PkvNRzL3C1XS63MTy0t4Kh7hY7rJ9tzmp71ZeQq4IwZAVp0zBrH
         F8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xrXvVkI6r4Vmn+7KKReTw1DvnU9RNEXMh/9+RUR+L9Y=;
        b=nNROVurE9rsg2vxdPZe9Xjf8Jy92bVA2CePvkP9IKqx5Dm/NHC1fqcbf5lCY7h5BNt
         cGzMtMEUJLz+24EqlzY7pjdi39xrRaF2iXgIjzkwgZASTckIUuDdcZN5uQNbhxYJED5g
         3Hs71LAxSGAJZU+a5XbgegLNbpus+cdCJD4YboDzVYS/fwx3Nb1iHNWdgObm/WlrYEyq
         R75cMeGJ2sTa8N+RvGONYz/D4AVUhHSAZWVM2aBmW3kVKFV/iaA5XHkRK7oSks/U0uWH
         J2TXazqHG7PeLhlX1eOLun/HDlbwQyiuXPl1EZ/4ZCuJc2shWIv4Csqpul7vJGLmi9iQ
         7dmA==
X-Gm-Message-State: AOAM533j2lCdAm0D02Ld/VZ2XlwXE4SjjO5SdmlOQlAJkey30FViULGV
        5EBZXVA0m8VjyLYQ9va/n/347szGNko=
X-Google-Smtp-Source: ABdhPJxaoBdLntARzlcI6TdYmeYb+XZlVtgE1jknLgRjufiSnIl0WbIGjxFSocuh1vUQ39TfRs9x7ezE8HA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a25:acc3:: with SMTP id x3mr6310ybd.332.1639498973606;
 Tue, 14 Dec 2021 08:22:53 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:29 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-23-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 22/43] kmsan: initialize the output of READ_ONCE_NOCHECK()
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

READ_ONCE_NOCHECK() is already used by KASAN to ignore memory accesses
from e.g. stack unwinders.
Define READ_ONCE_NOCHECK() for KMSAN so that it returns initialized
values. This helps defeat false positives from leftover stack contents.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I07499eb3e8e59c0ad2fd486cedc932d958b37afd
---
 include/asm-generic/rwonce.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e9824..7cf993af8e1ea 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -25,6 +25,7 @@
 #include <linux/compiler_types.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
+#include <linux/kmsan-checks.h>
 
 /*
  * Yes, this permits 64-bit accesses on 32-bit architectures. These will
@@ -69,14 +70,14 @@ unsigned long __read_once_word_nocheck(const void *addr)
 
 /*
  * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
- * word from memory atomically but without telling KASAN/KCSAN. This is
+ * word from memory atomically but without telling KASAN/KCSAN/KMSAN. This is
  * usually used by unwinding code when walking the stack of a running process.
  */
 #define READ_ONCE_NOCHECK(x)						\
 ({									\
 	compiletime_assert(sizeof(x) == sizeof(unsigned long),		\
 		"Unsupported access size for READ_ONCE_NOCHECK().");	\
-	(typeof(x))__read_once_word_nocheck(&(x));			\
+	kmsan_init((typeof(x))__read_once_word_nocheck(&(x)));		\
 })
 
 static __no_kasan_or_inline
-- 
2.34.1.173.g76aa8bc2d0-goog

