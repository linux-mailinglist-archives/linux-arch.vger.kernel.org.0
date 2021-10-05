Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3398442240B
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhJELBi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhJELBg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:01:36 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42905C061745
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 03:59:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id gg11-20020a056214252b00b00382e4692e72so4958483qvb.13
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AjGY1e3Ekh8sgb5t91HD4gatgCiWO+4KwBntiL6GjSk=;
        b=ZQrlEFr3YQ/+5PCz0GS+jbo9xkwwJ4ivZGR3ebnyZMr1Colxs8QWGY8hV8W0xas9h8
         WQDJHHdrEq5JlXN+biRpbf/mNFhbe0EZYmp07Lz+GO2Twg5RZqkzCZ+c6tIb5zySPIrS
         RZPc9ZskueXz5HUDsfa/9PliBmLVxfNeVgKm0vIEqszSW1eiYiAsiaCRVOgI/dEGiL8F
         4iK80wkLYccMV8XGWfh8qATkpPJZeqX7jiaF62slW9X7FXWbGQTnMxTWZcIEY65ZPz30
         eBCmrzlZNBW4aHKmRxfWl+NQW5TnCqFPyFTeQdKYp7F4rbep0fiXyyZh/qmOU7JRRIdF
         flew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AjGY1e3Ekh8sgb5t91HD4gatgCiWO+4KwBntiL6GjSk=;
        b=vIyC7Mey/U7MyPX7WgiCUcIy6dhKp+POoUfoEhveSAxtD9CpUeIj7TpzHAv185cdjk
         Prx4e6aHoHhELjd7HjDHnBtIsfSoRq6af5LPvqKjaygehWjAVAEsRR42pBUDKyL305Zw
         Z7FZuggpw89XFVOBH8XaX5C9p+yeLSUs0OOmgwdbaCjYRj1V7MD3KCLGFAEk+VO9k2P8
         Fhq+LfcOsorp436r6LrvnV5Gor6XyHdKjvUBJEFYkGGScliqaTIzRpB88YNytG1SRKQd
         5KuEAYt4MnQH0K//1h1wBeoESYgr/vqzOL1aGUgXpnDunaKAiCJn0RCqF8BFSrQaUx3A
         43qg==
X-Gm-Message-State: AOAM531PxEjzcgd9N+VYyKOKaxQACqmTxrsYPs9mdeP1Z28L/Xxp2zaT
        2Q4sTMxeq/CP/3OEHX3j+SMLlDyIfw==
X-Google-Smtp-Source: ABdhPJzVQKEkM4YizKAEiyMCskUOEb29axZkvKzwcJos1d/EXkam0bxDbBYGbv8vlgaFMr4sViAX3Sa3dQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:a4d:: with SMTP id
 ee13mr23024272qvb.6.1633431585442; Tue, 05 Oct 2021 03:59:45 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:43 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-2-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 01/23] kcsan: Refactor reading of instrumented memory
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

Factor out the switch statement reading instrumented memory into a
helper read_instrumented_memory().

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 51 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4b84c8e7884b..6bfd3040f46b 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -325,6 +325,21 @@ static void delay_access(int type)
 	udelay(delay);
 }
 
+/*
+ * Reads the instrumented memory for value change detection; value change
+ * detection is currently done for accesses up to a size of 8 bytes.
+ */
+static __always_inline u64 read_instrumented_memory(const volatile void *ptr, size_t size)
+{
+	switch (size) {
+	case 1:  return READ_ONCE(*(const u8 *)ptr);
+	case 2:  return READ_ONCE(*(const u16 *)ptr);
+	case 4:  return READ_ONCE(*(const u32 *)ptr);
+	case 8:  return READ_ONCE(*(const u64 *)ptr);
+	default: return 0; /* Ignore; we do not diff the values. */
+	}
+}
+
 void kcsan_save_irqtrace(struct task_struct *task)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -482,23 +497,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
-	old = 0;
-	switch (size) {
-	case 1:
-		old = READ_ONCE(*(const u8 *)ptr);
-		break;
-	case 2:
-		old = READ_ONCE(*(const u16 *)ptr);
-		break;
-	case 4:
-		old = READ_ONCE(*(const u32 *)ptr);
-		break;
-	case 8:
-		old = READ_ONCE(*(const u64 *)ptr);
-		break;
-	default:
-		break; /* ignore; we do not diff the values */
-	}
+	old = read_instrumented_memory(ptr, size);
 
 	/*
 	 * Delay this thread, to increase probability of observing a racy
@@ -511,23 +510,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	 * racy access.
 	 */
 	access_mask = ctx->access_mask;
-	new = 0;
-	switch (size) {
-	case 1:
-		new = READ_ONCE(*(const u8 *)ptr);
-		break;
-	case 2:
-		new = READ_ONCE(*(const u16 *)ptr);
-		break;
-	case 4:
-		new = READ_ONCE(*(const u32 *)ptr);
-		break;
-	case 8:
-		new = READ_ONCE(*(const u64 *)ptr);
-		break;
-	default:
-		break; /* ignore; we do not diff the values */
-	}
+	new = read_instrumented_memory(ptr, size);
 
 	diff = old ^ new;
 	if (access_mask)
-- 
2.33.0.800.g4c38ced690-goog

