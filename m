Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD936AB22F
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCEU5C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCEU45 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:56:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524411968C;
        Sun,  5 Mar 2023 12:56:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so30722950edb.9;
        Sun, 05 Mar 2023 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVG2kgy9F760CmPn8vSVrkbNIw0KpbygTeYMJL/3wHc=;
        b=asi5utLdWW1N1er0bksuBA8v5b1amWbTv0KOBvgiy8Iq2U+koWsRhR6IqIsB96ZzFo
         RMdO6VENOxHuzI8q6i57ivzsrmds+Qydp0zIcueL5R8/WPuPDj9jwqzGDYz4blWiwMSf
         /W0Z5E6D9C9cNRhuSPhtp98V3I7py6Lt7d3OmAEFtC0xVTDC5m4jYRUFC88j+LQU2U/b
         /rY2VlSnb0DKov6ld71YIylJ++dgLrjqmYWE382OJOZPVSfs/nR5zWbNwRgfUBiF/lnX
         uTxnaw9+jBV/4QcQgK2Dgh2w2pTgCVdFrY9WfPDrzRcXWeoA8lOM2hU2keXlcv7RSB4Q
         ijnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVG2kgy9F760CmPn8vSVrkbNIw0KpbygTeYMJL/3wHc=;
        b=icGJtAhT3UQxBx5e4Kc1/Gh76wpcLXbyjniS7wyv5YNKeGxsC+WpzYRpEWFYsdfOYI
         4UlVL9LAiXN7ePoeY4Ckq6h9PBKB922bgUdLKSOvD+xzqwbns5lATDw3cR20czOTkUWW
         Oa0Y3xxygiGyYjqJrzFMmEyNc+0h9FNCDKcWfl7G2H2I6MJ728ElsR8ZgBujYjCxVa26
         Y10MBLUzI4wpcaUQD/NjfqVI/UpX8Sc+/67jTkFeY/lbJFJkGY0c3vMv2RTPri1en4Ry
         PjUxD5Q1LrDo3MxTuYZvSK2qq2mbQDWuhmBS71+pjWmJ5u02fTwpu0IWr8Q0XvojD24i
         701g==
X-Gm-Message-State: AO0yUKUxF01fpOrmQVsNVJnnVCpHHoPhAZfshrD4gYkvYbLtIN7bA9kX
        0aG9+3qwY7Z1gBa3Hn2zeMBBlH0ff0J4tu+x
X-Google-Smtp-Source: AK7set+RJQKs9QlFP/fuW0+0r4cthBgsbcujjamf/UFg8WkoC4IrOQHMZQcJaAn7QEfYYDX6cVoXeg==
X-Received: by 2002:a17:907:3f18:b0:8f6:5a70:cccc with SMTP id hq24-20020a1709073f1800b008f65a70ccccmr11620167ejc.66.1678049814399;
        Sun, 05 Mar 2023 12:56:54 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:56:54 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg() fallbacks
Date:   Sun,  5 Mar 2023 21:56:19 +0100
Message-Id: <20230305205628.27385-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.

Fixes: 29f006fdefe6 ("asm-generic/atomic: Add try_cmpxchg() fallbacks")
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 18 +++++++++---------
 scripts/atomic/gen-atomic-fallback.sh       |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 77bc5522e61c..19debd501ee7 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -87,7 +87,7 @@
 #ifndef arch_try_cmpxchg
 #define arch_try_cmpxchg(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -98,7 +98,7 @@
 #ifndef arch_try_cmpxchg_acquire
 #define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -109,7 +109,7 @@
 #ifndef arch_try_cmpxchg_release
 #define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -120,7 +120,7 @@
 #ifndef arch_try_cmpxchg_relaxed
 #define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -157,7 +157,7 @@
 #ifndef arch_try_cmpxchg64
 #define arch_try_cmpxchg64(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -168,7 +168,7 @@
 #ifndef arch_try_cmpxchg64_acquire
 #define arch_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -179,7 +179,7 @@
 #ifndef arch_try_cmpxchg64_release
 #define arch_try_cmpxchg64_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -190,7 +190,7 @@
 #ifndef arch_try_cmpxchg64_relaxed
 #define arch_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -2456,4 +2456,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// b5e87bdd5ede61470c29f7a7e4de781af3770f09
+// 1b4d4c82ae653389cd1538d5b07170267d9b3837
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 3a07695e3c89..39f447161108 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -171,7 +171,7 @@ cat <<EOF
 #ifndef arch_try_${cmpxchg}${order}
 #define arch_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
 ({ \\
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \\
 	___r = arch_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
-- 
2.39.2

