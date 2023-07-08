Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAF74BCF3
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jul 2023 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGHJBO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jul 2023 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHJBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jul 2023 05:01:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7631723;
        Sat,  8 Jul 2023 02:01:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992acf67388so308664766b.1;
        Sat, 08 Jul 2023 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688806870; x=1691398870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsGY/iGtzaIgMwA9b3Ok3/pViuvT9eB2lCiEe6DAXmw=;
        b=ZC9DXKQ4BCjmzF3p8pBZiMSzsDXlNUajNpgzbgfdEtdK3LaC1ilz7ERZEOO3wEXYtO
         nedwYopczXsFZFxEDFH56U4HhmY5nnWxnzRiWbwLKPslIkGvcrut7zp8pUyBFf1lId5n
         t+Sy72MHM4qeyZXeDmnZQiqzMVSqYXjlzIHl1tha3BDw4CVjC4BknFu1dC03RFTVkiTs
         KqunWm00CvMHfOH655Q3VrboGu0bCWdEfUt4tqQ7Mlrf8rdHcpA+7iVyQv+orO/BOef6
         ZFNyvFHHjxsMWN6gG5EXxKEDP4L3QsRDvTWrnbUSFuGPHmIuWV1piHPT+lOx9nbeoLla
         d20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688806870; x=1691398870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsGY/iGtzaIgMwA9b3Ok3/pViuvT9eB2lCiEe6DAXmw=;
        b=TLLGtG6TKlXAfecn4KZQ5gLROpWGt1BEN0KBzKHUmUi0v12TDIrOEinO6HPMJIODFL
         U1cTYqCPvgFXJpYzqSGWQSsvbNPvzbQ0z71le217omS2Umf1U22jnshgXyeEmwmN2Ysw
         jzCqjRapERz8z+o5ctUH0X+3Rpf5nJ6lVhL8GuNIYKH7/YdZVrLZhSd4cHtdtb8S7EtW
         ULXpt02K5qz+UAp52FT4TBk4NT7/cHhl2FXs7FWh0JjRtbeTrAQic+A7B5jLPN1k/rzy
         C2FOTgOsCkGojpforOyiZLwtn1xBbns0X0LelZQlBDJ+MCaabxNtBprHIoCPg6mksSk6
         qkTw==
X-Gm-Message-State: ABy/qLY1YLWQRIa0FezQ5blGh7rBXEN+1wGdWXdkiFjNUj7ABAAKB0zC
        Hpw2Sh88zpW0Cc4jxVTZ0jM=
X-Google-Smtp-Source: APBJJlGWA9cXPwJQzLfRKpd7yjMu6208psGsPf4ABVaoF4bcrbXZqLcg/CAKOOeOxS8x9SRa1CJCVQ==
X-Received: by 2002:a17:906:3c46:b0:98d:d6b2:3377 with SMTP id i6-20020a1709063c4600b0098dd6b23377mr5344497ejg.30.1688806870400;
        Sat, 08 Jul 2023 02:01:10 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090613ca00b00992ae4cf3c1sm3204313ejc.186.2023.07.08.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 02:01:09 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] locking/arch: Avoid variable shadowing in local_try_cmpxchg()
Date:   Sat,  8 Jul 2023 11:00:36 +0200
Message-ID: <20230708090048.63046-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Several architectures define arch_try_local_cmpxchg macro using
internal temporary variables named ___old, __old or _old. Remove
temporary varible in local_try_cmpxchg to avoid variable shadowing.

No functional change intended.

Fixes: d994f2c8e241 ("locking/arch: Wire up local_try_cmpxchg()")
Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Closes: https://lore.kernel.org/lkml/CAFGhKbyxtuk=LoW-E3yLXgcmR93m+Dfo5-u9oQA_YC5Fcy_t9g@mail.gmail.com/
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jun Yi <yijun@loongson.cn>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/loongarch/include/asm/local.h | 4 ++--
 arch/mips/include/asm/local.h      | 4 ++--
 arch/x86/include/asm/local.h       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 83e995b30e47..c49675852bdc 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -63,8 +63,8 @@ static inline long local_cmpxchg(local_t *l, long old, long new)
 
 static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	return try_cmpxchg_local(&l->a.counter,
+				 (typeof(l->a.counter) *) old, new);
 }
 
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 5daf6fe8e3e9..e6ae3df0349d 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -101,8 +101,8 @@ static __inline__ long local_cmpxchg(local_t *l, long old, long new)
 
 static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	return try_cmpxchg_local(&l->a.counter,
+				 (typeof(l->a.counter) *) old, new);
 }
 
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 56d4ef604b91..635132a12778 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -127,8 +127,8 @@ static inline long local_cmpxchg(local_t *l, long old, long new)
 
 static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	return try_cmpxchg_local(&l->a.counter,
+				 (typeof(l->a.counter) *) old, new);
 }
 
 /* Always has a lock prefix */
-- 
2.41.0

