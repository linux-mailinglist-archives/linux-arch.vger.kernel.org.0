Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E3706C41
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjEQPKV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 11:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjEQPKT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 11:10:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F835A5;
        Wed, 17 May 2023 08:10:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9659c5b14d8so136119366b.3;
        Wed, 17 May 2023 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684336200; x=1686928200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RbHR3p/aSwGiwoZdp2CXqzfCqmJLbldvSD60wsj1Fzs=;
        b=jHNY7YUQq7T5u7nBwuVtfqJOHyeYlzKXv+ooTfcFyKORavnxs8v9xgsa5X09yq5+oF
         0yJlPl+gNCXgkVEEA1lmjzsnM+FeXzZ8RMTq9UXaZF514rYjhkALhBPZh//eg3CdVYoD
         sDDShdi+8y6B/+2XvFQHvkJP4AyFxtpr1Wpp+YEymFNole9yPq8mWDQoEo2dZJ0+8PEY
         p4ayoD9o/wofATVFsQeMUNH2yNnSPfZqRQTwK7fmnyLjmL1O8g3m1SymuPfIlS1ae7d6
         KlIampzTO1eXgcl9QqAkTW4Q3njVKtnTadDUUhwiTF7CPE5yx1JgyREVP2ueLR2R+NCL
         zAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336200; x=1686928200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbHR3p/aSwGiwoZdp2CXqzfCqmJLbldvSD60wsj1Fzs=;
        b=D45EqTWkh863VhYWGpsu2+VHKeQNxmiflzHIvnsLSDrheXVNj8sgFmSj3jqE00XCcb
         bGfGrfkTIiS8OmgTiLWnDgs8CodCDhYmSmoV4CJZ9hLmJP599SqNiwKRwJdr5rj0KScV
         9gNVvVL4tQU/R+2XGNyKltXzAAGs2UrHnU5d1uSMnv6Xp0OYhRPTIr8KI85897z9DPR/
         18jQoHFBL8mPrYfvG3aIxvP4GmgSaEjp2xTSegDFVSYQoDaUfJTkx6Iz2NVsR0HZrl/2
         alHAe3FmF1i58f1+K+jLmhqxBzB6nNbCxzqirA+xWy/n23TvJygYCLAjucI6U3/PORMZ
         RvnA==
X-Gm-Message-State: AC+VfDy+nCXjg8HTtaH0D2pvurovIUE4QEmt7VRfa2hpqThZ/JPoy9Tp
        TU5P0exifsRyBncM9HhRuCk=
X-Google-Smtp-Source: ACHHUZ4sorPC+/RpGxDAM+RiswTD01mb/F0FjwwmcxR8Y5NPGoupZIgsSlQwp8ACSQZXGcUniFMyXg==
X-Received: by 2002:a17:907:948e:b0:96a:ec5c:685b with SMTP id dm14-20020a170907948e00b0096aec5c685bmr12951001ejc.29.1684336199815;
        Wed, 17 May 2023 08:09:59 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906845a00b00965cd15c9bbsm12413901ejy.62.2023.05.17.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:09:59 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] locking/arch: Avoid variable shadowing in local_try_cmpxchg()
Date:   Wed, 17 May 2023 17:09:40 +0200
Message-Id: <20230517150940.172430-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.40.1
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
internal temporary variables named __old or _old. Uglify equally
named variable in local_try_cmpxchg() with additional underscore
to avoid variable shadowing warning.

Fixes: d994f2c8e241 ("locking/arch: Wire up local_try_cmpxchg()")
Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Closes: https://lore.kernel.org/lkml/CAFGhKbyxtuk=LoW-E3yLXgcmR93m+Dfo5-u9oQA_YC5Fcy_t9g@mail.gmail.com/
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
index 83e995b30e47..4c6e4ed23433 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -63,8 +63,8 @@ static inline long local_cmpxchg(local_t *l, long old, long new)
 
 static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	typeof(l->a.counter) *___old = (typeof(l->a.counter) *) old;
+	return try_cmpxchg_local(&l->a.counter, ___old, new);
 }
 
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 5daf6fe8e3e9..de276e2ebb64 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -101,8 +101,8 @@ static __inline__ long local_cmpxchg(local_t *l, long old, long new)
 
 static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	typeof(l->a.counter) *___old = (typeof(l->a.counter) *) old;
+	return try_cmpxchg_local(&l->a.counter, ___old, new);
 }
 
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 56d4ef604b91..36cf5ca83ccb 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -127,8 +127,8 @@ static inline long local_cmpxchg(local_t *l, long old, long new)
 
 static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	typeof(l->a.counter) *___old = (typeof(l->a.counter) *) old;
+	return try_cmpxchg_local(&l->a.counter, ___old, new);
 }
 
 /* Always has a lock prefix */
-- 
2.40.1

