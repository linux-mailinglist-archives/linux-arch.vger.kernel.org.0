Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB58322BE74
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgGXHAk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 03:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgGXHAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 03:00:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B2C0619E4
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k75so9279483ybf.19
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=exjoV/J3QIlZtyiULDQJFxa/y5F8DBbC61V96IvJHj0=;
        b=Mmh2Mf3qHUOuy8eXKOYTiPh6vb93RN+wecn2vV/u6zFddlr6vz9bN5kOKUiri7yOh2
         1896t51EtovsfkIEKPQV41bWfidSxvayY8PvL4Q59YAL/qdQ3bmPpe/Kp2rnAf2ThrD/
         aJITzBcYr85ihHIGkTdiQHA4qHqnktG7N6to1AnOr5SQyD8hJ3GiAC7GEp82MVUCD6C8
         9byF3eBGDOe5SMj0Qf8WbbQmJFlU6CtgjnhuBes4oZcvG+MJtxtkYocfznIGSyNEv7JD
         6UXlNRpxLmY9bY1rfWs7ItnfkFtfmnrj2G6T7qVsyykmokdT3NgzwUUnQvssX2TaxKJz
         7Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=exjoV/J3QIlZtyiULDQJFxa/y5F8DBbC61V96IvJHj0=;
        b=Uv7+VLJRm0TuwIWFZmgvs2eI9sQe1HoE1vTvrkYyQIv0BuvFTTgir6+f8Eqs65/hw4
         C3eNJdPoQKcirIXdcankFYqaWBZDaR2c8TmT4vEJCRgfgguZXXb+DP5N74x+vwUwwSN0
         ZIJqEUBqKN8u4f4OYHl9ztyC0BqaeK1RsH92lid2V5gOpZskOrQ0llyOG2nt3qT8J1n0
         gWZMY4zozct4pbh362OHIMp0jTrEj/bi7g88Pg+4wPR2DzNHKWuN4+Uj1c57/w3i52rp
         Tgp+P/QMZWm1wPDCnf0sZDt6HaX8GM1RgtE4OL329aqixE/3OIgZARIsZBhDWoB9Ccky
         1pFw==
X-Gm-Message-State: AOAM530IfobZfonYILjR+ZO+fKy05l84iY5WmbGYd8sWiQ/Napb87rVe
        AGlW3QQ6n/lkMUCtrfOb+1NXsjSjxA==
X-Google-Smtp-Source: ABdhPJzFQ7drXC3Zymk1HSiBzLPuR2JrwD8P5jtaLjgCUJ7OyiCpkZu7On5nca4wHIjy8q46ZT+rhlRRyQ==
X-Received: by 2002:a25:ca8d:: with SMTP id a135mr12598725ybg.459.1595574039087;
 Fri, 24 Jul 2020 00:00:39 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:07 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-Id: <20200724070008.1389205-8-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 7/8] asm-generic/bitops: Use instrument_read_write() where appropriate
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the new instrument_read_write() where appropriate.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/bitops/instrumented-atomic.h     | 6 +++---
 include/asm-generic/bitops/instrumented-lock.h       | 2 +-
 include/asm-generic/bitops/instrumented-non-atomic.h | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index fb2cb33a4013..81915dcd4b4e 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -67,7 +67,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -80,7 +80,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -93,7 +93,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index b9bec468ae03..75ef606f7145 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -52,7 +52,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 20f788a25ef9..f86234c7c10c 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -68,7 +68,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +82,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +96,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

