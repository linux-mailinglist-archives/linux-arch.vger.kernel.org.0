Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6085E2C72B5
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgK1VuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbgK1TFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:05:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51AC061A52;
        Fri, 27 Nov 2020 22:00:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q10so6303836pfn.0;
        Fri, 27 Nov 2020 22:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zltUWle7M83ftFlMyw3AG1onuHKbL/RmBEkfbIulJ9U=;
        b=hSwn3bqTaUCxNx3v2dsK1Pnjs8byW46qJbAzVFHFFQSS7Dfneo7xmVSnIngS9jelxD
         H3FQe83aFGrtuJETRrhmrxfFn9xIF9DbglAM2XZVV+f5EtO2eW0jhrOHw00kSM3I489N
         JhABUWtKjt03rgs7dWW8OTuvR1JQ8Zbe5TOrE5ZPVux9vIrPN4Lf5WNBHZmT471xRyqg
         QrETXbZM6+R+quwpYnSvak4qUeUZkXlMErrEWqAoLIHgzZc6jugvUcdtzFe/Lqhky903
         +igdcNIj3N9GyELB9NUhYOXK1SsB5hcuje1RyVUhLoMleAbrrL/CVlrcNSgzmK6H3ovE
         +9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zltUWle7M83ftFlMyw3AG1onuHKbL/RmBEkfbIulJ9U=;
        b=cwzv3jugAfFproib3KK8NidroUFHzdJRGHlSVpG6jq9+QKEPVLyG9qTf03hhVDUMkx
         NLy0n4h5815HUkOYMBJhyE6+PusL1mvjo3NvKmaw04+KLCKEczMDwRCQiZVg0u8ypcRs
         DX1RR5fbT7y3xcknMVBrKbdr9W9w8cYlJEtlsHOD/+QdqkksY/mBUgF1EOKpP8Ru19hC
         Wd4YOROng5Lq/ZhZfpXXPxUxR9Gqkb1mDMnb6Qa3Wgxw0qxCj/330zhpYFRlKHu/5M2b
         snAPe7zs6TJp0edWfsFU9bOiA2gMdp5jhrArWeJXk9DlLsnDeI48fjzhXFwVEr7Sr0/4
         uqkQ==
X-Gm-Message-State: AOAM533ADE/Uji3B2MSAFSaVE6XQc+FFgFDbWQcnYGYx8dsHvB/OEm6+
        guJV0St/ozs+2uisH9FSgAs=
X-Google-Smtp-Source: ABdhPJyuFIxLmgXJivVCtkq3WJyGVpuxnsJU3y3Z3M0juAmuDk1j8QTXjVWKVMQ+ysmusY46zvYrDg==
X-Received: by 2002:a62:256:0:b029:18c:6905:d18d with SMTP id 83-20020a6202560000b029018c6905d18dmr10134142pfc.67.1606543215624;
        Fri, 27 Nov 2020 22:00:15 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q18sm9341455pfs.150.2020.11.27.22.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 22:00:14 -0800 (PST)
Subject: [PATCH 1/2] tools/memory-model: Remove redundant initialization in
 litmus tests
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-6-paulmck@kernel.org>
 <12e0baf4-b1c9-d674-1d4c-310e0a9b6343@gmail.com>
 <20201105225605.GQ3249@paulmck-ThinkPad-P72>
 <2acf8de5-efe9-a205-cb62-04c4774008c0@gmail.com>
 <20201127154652.GU1437@paulmck-ThinkPad-P72>
 <78e1ccaf-9d35-b2a5-1865-fb0a76b3e57e@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <d3c88682-029f-d2ff-2887-9cdacee26882@gmail.com>
Date:   Sat, 28 Nov 2020 15:00:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78e1ccaf-9d35-b2a5-1865-fb0a76b3e57e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 3a871845825d96a23d64be05b6cf6d4af2bae167 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sat, 28 Nov 2020 08:43:45 +0900
Subject: [PATCH 1/2] tools/memory-model: Remove redundant initialization in litmus tests

This is a revert of commit 1947bfcf81a9 ("tools/memory-model: Add types
to litmus tests") with conflict resolutions.

klitmus7 [1] is aware of default types of "int" and "int*".
It accepts litmus tests for herd7 without extra type info unless
non-"int" variables are referenced by an "exists", "locations",
or "filter" directive.

[1]: Tested with klitmus7 versions 7.49 or later.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 .../memory-model/litmus-tests/CoRR+poonceonce+Once.litmus  | 4 +---
 .../memory-model/litmus-tests/CoRW+poonceonce+Once.litmus  | 4 +---
 .../memory-model/litmus-tests/CoWR+poonceonce+Once.litmus  | 4 +---
 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus     | 4 +---
 .../litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus     | 5 +----
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus          | 5 +----
 .../ISA2+pooncelock+pooncelock+pombonce.litmus             | 7 +------
 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus    | 6 +-----
 ...SA2+pooncerelease+poacquirerelease+poacquireonce.litmus | 6 +-----
 .../litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus    | 5 +----
 .../litmus-tests/LB+poacquireonce+pooncerelease.litmus     | 5 +----
 tools/memory-model/litmus-tests/LB+poonceonces.litmus      | 5 +----
 .../MP+fencewmbonceonce+fencermbonceonce.litmus            | 5 +----
 .../litmus-tests/MP+onceassign+derefonce.litmus            | 4 +---
 .../litmus-tests/MP+polockmbonce+poacquiresilsil.litmus    | 5 +----
 .../litmus-tests/MP+polockonce+poacquiresilsil.litmus      | 5 +----
 tools/memory-model/litmus-tests/MP+polocks.litmus          | 6 +-----
 tools/memory-model/litmus-tests/MP+poonceonces.litmus      | 5 +----
 .../litmus-tests/MP+pooncerelease+poacquireonce.litmus     | 5 +----
 tools/memory-model/litmus-tests/MP+porevlocks.litmus       | 6 +-----
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus  | 5 +----
 tools/memory-model/litmus-tests/R+poonceonces.litmus       | 5 +----
 .../litmus-tests/S+fencewmbonceonce+poacquireonce.litmus   | 5 +----
 tools/memory-model/litmus-tests/S+poonceonces.litmus       | 5 +----
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus | 5 +----
 tools/memory-model/litmus-tests/SB+poonceonces.litmus      | 5 +----
 .../litmus-tests/SB+rfionceonce-poonceonces.litmus         | 5 +----
 .../memory-model/litmus-tests/WRC+poonceonces+Once.litmus  | 5 +----
 .../WRC+pooncerelease+fencermbonceonce+Once.litmus         | 5 +----
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus             | 7 +------
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus             | 7 +------
 ...0+pooncerelease+poacquirerelease+fencembonceonce.litmus | 6 +-----
 32 files changed, 32 insertions(+), 134 deletions(-)

diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
index 772544f03fb5..967f9f2a6226 100644
--- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoRR+poonceonce+Once
  * reads from the same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
index 5faae98f7ffb..4635739f3974 100644
--- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoRW+poonceonce+Once
  * a given variable and a later write to that same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
index 77c9cc9f8dc6..bb068c92d8da 100644
--- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
@@ -7,9 +7,7 @@ C CoWR+poonceonce+Once
  * given variable and a later read from that same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
index 85ef746f511a..0d9f0a958799 100644
--- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
+++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
@@ -7,9 +7,7 @@ C CoWW+poonceonce
  * writes to the same variable are ordered.
  *)
 
-{
-	int x;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
index 87aa900125ab..e729d2776e89 100644
--- a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -10,10 +10,7 @@ C IRIW+fencembonceonces+OnceOnce
  * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
index f84022dca555..4b54dd6a6cd9 100644
--- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
@@ -10,10 +10,7 @@ C IRIW+poonceonces+OnceOnce
  * different process?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 398f624daa77..094d58df7789 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -7,12 +7,7 @@ C ISA2+pooncelock+pooncelock+pombonce
  * (in P0() and P1()) is visible to external process P2().
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
index 212a432ba16b..b321aa6f4ea5 100644
--- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
@@ -9,11 +9,7 @@ C ISA2+poonceonces
  * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
index 7afd85672ccd..025b0462ec9b 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
@@ -11,11 +11,7 @@ C ISA2+pooncerelease+poacquirerelease+poacquireonce
  * (AKA non-rf) link, so release-acquire is all that is needed.
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
index c8a93c7ee556..4727f5aaf03b 100644
--- a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -11,10 +11,7 @@ C LB+fencembonceonce+ctrlonceonce
  * another control dependency and order would still be maintained.)
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
index 2fa029568fa1..07b9904b0e49 100644
--- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
+++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
@@ -8,10 +8,7 @@ C LB+poacquireonce+pooncerelease
  * to the other?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
index 2107306e8625..74c49cb3c37b 100644
--- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
@@ -7,10 +7,7 @@ C LB+poonceonces
  * be prevented even with no explicit ordering?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index c5c168d92973..f8ca1229857a 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -8,10 +8,7 @@ C MP+fencewmbonceonce+fencermbonceonce
  * is usually better to use smp_store_release() and smp_load_acquire().
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 20ff62649f1e..d84160b9c1ae 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,9 +10,7 @@ C MP+onceassign+derefonce
  *)
 
 {
-	int *p=y;
-	int x;
-	int y=0;
+p=y;
 }
 
 P0(int *x, int **p) // Producer
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index 153917ad5dc9..ba91cc63e148 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -10,10 +10,7 @@ C MP+polockmbonce+poacquiresilsil
  * executed before the lock was acquired (loosely speaking).
  *)
 
-{
-	spinlock_t lo;
-	int x;
-}
+{}
 
 P0(spinlock_t *lo, int *x) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index aad64397bb8c..a5ea3ed8f52e 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -10,10 +10,7 @@ C MP+polockonce+poacquiresilsil
  * speaking).
  *)
 
-{
-	spinlock_t lo;
-	int x;
-}
+{}
 
 P0(spinlock_t *lo, int *x) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 21cbca6f3be4..e6af05f70069 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -11,11 +11,7 @@ C MP+polocks
  * to see all prior accesses by those other CPUs.
  *)
 
-{
-	spinlock_t mylock;
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 9f9769d647c7..ba9c99c6cf65 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -7,10 +7,7 @@ C MP+poonceonces
  * no ordering at all?
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index cbe28e733443..f174bfe61702 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -8,10 +8,7 @@ C MP+pooncerelease+poacquireonce
  * pattern.
  *)
 
-{
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag) // Producer
 {
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 012041bd4feb..b9599141160e 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -11,11 +11,7 @@ C MP+porevlocks
  * see all prior accesses by those other CPUs.
  *)
 
-{
-	spinlock_t mylock;
-	int buf;
-	int flag;
-}
+{}
 
 P0(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
index af9463b39b4a..222a0b850b4a 100644
--- a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -9,10 +9,7 @@ C R+fencembonceonces
  * cause the resulting test to be allowed.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
index bcd5574e304a..5386f128a131 100644
--- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
@@ -8,10 +8,7 @@ C R+poonceonces
  * store propagation delays.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
index c36341d1aed6..18479823cd6c 100644
--- a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -7,10 +7,7 @@ C S+fencewmbonceonce+poacquireonce
  * store against a subsequent store?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
index 7775c23143a0..8c9c2f81a580 100644
--- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
@@ -9,10 +9,7 @@ C S+poonceonces
  * READ_ONCE(), is ordering preserved?
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
index 833cdfeb7c09..ed5fff18d223 100644
--- a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -9,10 +9,7 @@ C SB+fencembonceonces
  * suffice, but not much else.)
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
index c92211ecbfdf..10d550730b25 100644
--- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
@@ -8,10 +8,7 @@ C SB+poonceonces
  * variable that the preceding process reads.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
index 84344b455eb7..04a16603660b 100644
--- a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -6,10 +6,7 @@ C SB+rfionceonce-poonceonces
  * This litmus test demonstrates that LKMM is not fully multicopy atomic.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
index 431494708611..6a2bc12a1af1 100644
--- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
@@ -8,10 +8,7 @@ C WRC+poonceonces+Once
  * test has no ordering at all.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
index 554999c64db5..e9947250d7de 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -10,10 +10,7 @@ C WRC+pooncerelease+fencermbonceonce+Once
  * is A-cumulative in LKMM.
  *)
 
-{
-	int x;
-	int y;
-}
+{}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 265a95ffef13..415248fb6699 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -9,12 +9,7 @@ C Z6.0+pooncelock+poonceLock+pombonce
  * by CPUs not holding that lock.
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
index 0c9aea8e80df..10a2aa04cd07 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
@@ -8,12 +8,7 @@ C Z6.0+pooncelock+pooncelock+pombonce
  * seen as ordered by a third process not holding that lock.
  *)
 
-{
-	spinlock_t mylock;
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
index 661f9aaa5791..88e70b87a683 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -14,11 +14,7 @@ C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
  * involving locking.)
  *)
 
-{
-	int x;
-	int y;
-	int z;
-}
+{}
 
 P0(int *x, int *y)
 {
-- 
2.17.1


