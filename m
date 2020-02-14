Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3015D0D1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 05:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgBNEBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 23:01:53 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:36824 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgBNEBw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 23:01:52 -0500
Received: by mail-qt1-f180.google.com with SMTP id t13so6147095qto.3;
        Thu, 13 Feb 2020 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTV3aUYGRHAvDvojkNLaehN3MmapAuAB+GxM/mWblrU=;
        b=cMybwX+gK+1yi1ELxoS77Vq3b723kgG4KizyK/Fd5/sdrlp+Xh3dw3mF8HwqHWwWWE
         lwgThRTEpM5l92Hxmf/HN3UQIdPFMjtQR7ip9ztq36Lc7pCd5wtAKC9E1+ZOaYKhoTeq
         M0CwrNpm/CxU4IZnYyKCvVsDEI/k+YHLouSz2G36W9oErDS3GH39see8QSq18mLswkzu
         OQN5/yC0CvPPbkI8SiwgKhJcZWJX8+EWyqKnKGhOAwpLfZoSdxmL3yQw56hfmTr8+ttb
         5KSnGSix3h3lm1rbFoWd4fHO+30ilRWx6rommiVRvJBkFxU+VPfuIxEo+aZLb1mofKkd
         eaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTV3aUYGRHAvDvojkNLaehN3MmapAuAB+GxM/mWblrU=;
        b=BNSUSsj/Ek9M8cQmFsN+ijuhllKeuryK1GyTU3JJRtUazsfJt+/CUc4h3EeLkLBzh9
         dcywybdUM4iXTOHbx7mKdy7VWTbLRquejVD0HVmx3xER7hhd66EsK4PA10peY07xEDCJ
         MUQFbyFCQaRVqtgMarSoGPK2ULi6+3deVs83qjFxPynlExgc9rv0CniQ/o64C30+Pxxv
         k1F/RURnTxsDUQsOSrmrFKzc4bqqSfTtk5mb5yx3NDO53yfhyIYqBu9GfoZQQuIBD1YH
         jJv3RkHm76B+DjkIZU3kW9RdTrZC/7o0u1BRD32n3vYkFgmWMEhTDXKIZDNf5Fbq5WAl
         es1Q==
X-Gm-Message-State: APjAAAV4e9Z60D4ptcjOV5cbvy8JED4oo0S/OMwnCwck4tFNjAy/lpzQ
        7R/5/TaJPhyoBXeqyLerqYA=
X-Google-Smtp-Source: APXvYqxhAZW6pAqgvEmYbBuju7hh93WwEbbUue1kd/dDstT//b/64E58Hzh6S8YRRNCJd7/v3vKRJQ==
X-Received: by 2002:ac8:3aa6:: with SMTP id x35mr1093561qte.38.1581652910460;
        Thu, 13 Feb 2020 20:01:50 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t26sm2462851qkt.17.2020.02.13.20.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 20:01:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4A4422195;
        Thu, 13 Feb 2020 23:01:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 23:01:46 -0500
X-ME-Sender: <xms:qBtGXvSTdk5-85zaBhjYzvqQjvr6ikd549njdJlJvIDEQzScFLpHaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qBtGXgBvEBNA9QEUQ9-JKQE02UB5EL6FJN-lVnpQQqH4zA37dpd5Og>
    <xmx:qBtGXno3GFD_7BKgxKoo5oJxEVgUYjzJ_CyI8ATbxBI08gY2uGEe8w>
    <xmx:qBtGXmgScUnzU2TbCk5i6dFqBCkMyMwu8f4l976n2jW9kWMoIXyE9A>
    <xmx:qhtGXmP7IzJyiSO5HRzxf1ROf4Lebd24yLNZgHuBcZloLkMbuwRF5vKnoag>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 100633060C21;
        Thu, 13 Feb 2020 23:01:43 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC 3/3] tools/memory-model: Add litmus test for RMW + smp_mb__after_atomic()
Date:   Fri, 14 Feb 2020 12:01:32 +0800
Message-Id: <20200214040132.91934-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We already use a litmus test in atomic_t.txt to describe atomic RMW +
smp_mb__after_atomic() is "strong acquire" (both the read and the write
part is ordered). So make it a litmus test in memory-model litmus-tests
directory, so that people can access the litmus easily.

Additionally, change the processor numbers "P1, P2" to "P0, P1" in
atomic_t.txt for the consistency with the processor numbers in the
litmus test, which herd can handle.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/atomic_t.txt                    |  6 ++--
 ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
 tools/memory-model/litmus-tests/README        |  5 ++++
 3 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index ceb85ada378e..e3ad4e4cd9ed 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -238,14 +238,14 @@ strictly stronger than ACQUIRE. As illustrated:
   {
   }
 
-  P1(int *x, atomic_t *y)
+  P0(int *x, atomic_t *y)
   {
     r0 = READ_ONCE(*x);
     smp_rmb();
     r1 = atomic_read(y);
   }
 
-  P2(int *x, atomic_t *y)
+  P1(int *x, atomic_t *y)
   {
     atomic_inc(y);
     smp_mb__after_atomic();
@@ -260,7 +260,7 @@ This should not happen; but a hypothetical atomic_inc_acquire() --
 because it would not order the W part of the RMW against the following
 WRITE_ONCE.  Thus:
 
-  P1			P2
+  P0			P1
 
 			t = LL.acq *y (0)
 			t++;
diff --git a/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
new file mode 100644
index 000000000000..e7216cf9d92a
--- /dev/null
+++ b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
@@ -0,0 +1,29 @@
+C Atomic-RMW+mb__after_atomic-is-strong-acquire
+
+(*
+ * Result: Never
+ *
+ * Test of an atomic RMW followed by a smp_mb__after_atomic() is
+ * "strong-acquire": both the read and write part of the RMW is ordered before
+ * the subsequential memory accesses.
+ *)
+
+{
+}
+
+P0(int *x, atomic_t *y)
+{
+	r0 = READ_ONCE(*x);
+	smp_rmb();
+	r1 = atomic_read(y);
+}
+
+P1(int *x, atomic_t *y)
+{
+	atomic_inc(y);
+	smp_mb__after_atomic();
+	WRITE_ONCE(*x, 1);
+}
+
+exists
+(r0=1 /\ r1=0)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 81eeacebd160..774e10058c72 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -2,6 +2,11 @@
 LITMUS TESTS
 ============
 
+Atomic-RMW+mb__after_atomic-is-strong-acquire
+	Test of an atomic RMW followed by a smp_mb__after_atomic() is
+	"strong-acquire": both the read and write part of the RMW is ordered
+	before the subsequential memory accesses.
+
 Atomic-set-observable-to-RMW.litmus
 	Test of the result of atomic_set() must be observable to atomic RMWs.
 
-- 
2.25.0

