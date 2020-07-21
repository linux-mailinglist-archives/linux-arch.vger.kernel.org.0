Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA72B227D18
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgGUKbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgGUKam (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:42 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5837C0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 89so12894261wrr.15
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LMk4339Zjhhu0K58clMlPfJmEmRgvFiVE2OU6iIU7ro=;
        b=MwwVb4fGj4UF6WUdljPc2Yyh7/QUZ3SHJv2NwaZ4xQTH8XfmMwDR9wkH0TDBatmSkQ
         lKpbRekcC6QG1WNEDOaS8beQqoMJJSNrt8T603+xGu2Pj6OgIoowA3eWC9HjT+4rbSCP
         Xi6w/Wo454/e7IfrHEZStyPqoPdh2/dg4SGj8IdcRFL8vde9MhXZ/8UyQeSl3V37HqVT
         bDTZLEGQr+lBUHLiy/Jkkn/AeBVoZzo1/io0ZXL/6y3zs9nLoxgJzqcsZyC7W+F0BefV
         91KH6W0enHrIcuTzYuz2CEqzbNFkaw11X/zZNrsISCQYX9tOPI3aItyNNJuBjQzYLnec
         AkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LMk4339Zjhhu0K58clMlPfJmEmRgvFiVE2OU6iIU7ro=;
        b=j0i636/3T1Cc0n9wAgsYzi5on791QasH/FsBt5qZfWtvycb49HdAX2SSAEHSw2UM5V
         68e+ytBffQBpT8xkPqjYue4phajDGR98bH8Vyp9OoxcOo/k7f6YPp59aeQ6rv08Bjm9k
         FgGxxV22haRx6V7fIik8C59zjdTWz6uGW7aAAHfQfjGtHJvk8vBv9071cQBKfzlz3ZAc
         JfgOdk7oMmElHTxj9Z8E83AIt6qbPnY0QdRDDaOU2YT4YhwyPTxkd07kUF+YH++E/TyK
         ExNuSYx3KiYF2VuhZ5ERrchrLPNxx3DSuFk3M7/CbXYPXaEXsxomCbZzOyP8wBMo6Z4V
         5bOg==
X-Gm-Message-State: AOAM532Jabh7+PLuCb+48huL5i3cHRf6lNMCyLxQAMFTXbikCpeeKxG3
        ES15i0eer96COCmkunuBw6hb8jvS7A==
X-Google-Smtp-Source: ABdhPJxmyS4vwAM8i+9rhvqtd6A42ZE9DqAAf0SiBEc/vJycx4V7hZmCBcRyew9iQzlsiCxvXrQBrLErmQ==
X-Received: by 2002:a1c:cc09:: with SMTP id h9mr407498wmb.1.1595327439944;
 Tue, 21 Jul 2020 03:30:39 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:12 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-5-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 4/8] kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
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

Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks for the builtin atomics
instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
Added to this series, as it would otherwise cause patch conflicts.
---
 kernel/kcsan/core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4633baebf84e..f53524ea0292 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -892,14 +892,17 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
 		return __atomic_load_n(ptr, memorder);                                             \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
 		__atomic_store_n(ptr, v, memorder);                                                \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
@@ -908,8 +911,10 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
@@ -937,8 +942,10 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
@@ -949,8 +956,10 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
 	}                                                                                          \
-- 
2.28.0.rc0.105.gf9edc3c819-goog

