Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0B193614
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 03:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCZCky (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 22:40:54 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37428 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgCZCky (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 22:40:54 -0400
Received: by mail-qv1-f66.google.com with SMTP id n1so2243620qvz.4;
        Wed, 25 Mar 2020 19:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDkP0xS8y57msegU04s88KpDDAiPZL218+4rLGcZdeE=;
        b=GD5Re1YPr+bT+fcFm1zknxALyyjys58Bfjg8guvY8KpiMqK4sWykpsOrcorynIZdsM
         S7Eny9aic6xx2cFO2yNpQyu4xbO96/JhBHR4vRhC3/L97qxkbfmhcPcjjdFAGSV28xQf
         yl4wro+zivt1SoZrIp7OSFGXkty+gk4GwLRva/wM7BpKNS+QD1OpJFbAyXOWm3FvyFQ8
         ozq0KM7WcDXbuUM+uPM6xCZI+IMQqDZXS11VYFK68h0pxh1FSUPLW+SodxgaRk7hrVIh
         Oskh9gOD0fTo7g28uaAd31Rzbwc6vPAHK23HNGi4Lqyw92+qaw6WI13EHGwDbISQW5tc
         tI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDkP0xS8y57msegU04s88KpDDAiPZL218+4rLGcZdeE=;
        b=Mi2Cjvpae0uBtP5v8XSP+J9st1m24wJ/xbLEN17p+AOGLrhs0urDwufKVcwRm8G18D
         Uvu8Rxjyxt6xr42FpW9juCo5lRlujSr+rRfOGJTbOXLIkmzwHbEF7nQsGQgdU1LkuB2n
         q2Jd92UuKzsAGwmNGAJk6cTE+Pfhkwx1CGteHsLv5NgnRSWdxOoNbv4XPrcHCQJCCk4I
         G22W1PmkTbE/3COq+RWcZ1OWFQJfkWiMJy2Q/vp2hZTWvt1Cy040e7G+1I1wNjk514vl
         t6QjIFzSMRXpK1fwtofamSoyN86EnP0btK0Tfrrj6bUxoUTxZytolrir7HYqBHQAJL70
         VnJQ==
X-Gm-Message-State: ANhLgQ3xPsIi4Q8jdWASfaW98CStmMa2Nvo0J2W05qQI0JtSv2Tqta8Y
        sUpbr2T3aig/j2O9khMV+Rg=
X-Google-Smtp-Source: ADFU+vvrGMv+AfF6WJTwqJcQtFoJ6xDjfC6ceKdmKfmw0s/38JFkENT0B6/d8W+L5TuJO7hFILvHYg==
X-Received: by 2002:ad4:5427:: with SMTP id g7mr6131032qvt.23.1585190452760;
        Wed, 25 Mar 2020 19:40:52 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c27sm552831qkk.0.2020.03.25.19.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:40:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8026027C0054;
        Wed, 25 Mar 2020 22:40:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 22:40:51 -0400
X-ME-Sender: <xms:MxZ8XjKkQy2hzboiBz1t4UPlja2i28B7fMebjELNaJ8fPJ5ZOnInkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:MxZ8XrbKjmaN807oQyJUe3d9gcBkm8U3E_7slKuJOsjCU-9mLBhoEA>
    <xmx:MxZ8XmvAXmpz1i-jxlQ4fNXdbTRA3KC5yBSJDrhES_ZSO1VkXXbvlw>
    <xmx:MxZ8XgsZ26YoqoIEzowpo7SR8ZxZBhXePWuNc7yy985_EENwSkguUg>
    <xmx:MxZ8XpNUUKpHrbznJ05LDG3R5z0wf1dDYc8jHSJ70HRbUrGz79fyRPoOpvc>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED0223067F8B;
        Wed, 25 Mar 2020 22:40:50 -0400 (EDT)
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
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 4/4] Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()
Date:   Thu, 26 Mar 2020 10:40:22 +0800
Message-Id: <20200326024022.7566-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326024022.7566-1-boqun.feng@gmail.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We already use a litmus test in atomic_t.txt to describe atomic RMW +
smp_mb__after_atomic() is stronger than acquire (both the read and the
write parts are ordered). So make it a litmus test in atomic-tests
directory, so that people can access the litmus easily.

Additionally, change the processor numbers "P1, P2" to "P0, P1" in
atomic_t.txt for the consistency with the processor numbers in the
litmus test, which herd can handle.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
 Documentation/atomic_t.txt                    | 10 +++---
 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 Documentation/litmus-tests/atomic/README      |  5 +++
 3 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 67d1d99f8589..0f1fdedf36bb 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -233,19 +233,19 @@ as well. Similarly, something like:
 is an ACQUIRE pattern (though very much not typical), but again the barrier is
 strictly stronger than ACQUIRE. As illustrated:
 
-  C strong-acquire
+  C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
 
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
@@ -253,14 +253,14 @@ strictly stronger than ACQUIRE. As illustrated:
   }
 
   exists
-  (r0=1 /\ r1=0)
+  (0:r0=1 /\ 0:r1=0)
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
 because it would not order the W part of the RMW against the following
 WRITE_ONCE.  Thus:
 
-  P1			P2
+  P0			P1
 
 			t = LL.acq *y (0)
 			t++;
diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
new file mode 100644
index 000000000000..9a8e31a44b28
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
@@ -0,0 +1,32 @@
+C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
+
+(*
+ * Result: Never
+ *
+ * Test that an atomic RMW followed by a smp_mb__after_atomic() is
+ * stronger than a normal acquire: both the read and write parts of
+ * the RMW are ordered before the subsequential memory accesses.
+ *)
+
+{
+}
+
+P0(int *x, atomic_t *y)
+{
+	int r0;
+	int r1;
+
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
+(0:r0=1 /\ 0:r1=0)
diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
index a1b72410b539..714cf93816ea 100644
--- a/Documentation/litmus-tests/atomic/README
+++ b/Documentation/litmus-tests/atomic/README
@@ -7,5 +7,10 @@ tools/memory-model/README.
 LITMUS TESTS
 ============
 
+Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
+	Test that an atomic RMW followed by a smp_mb__after_atomic() is
+	stronger than a normal acquire: both the read and write parts of
+	the RMW are ordered before the subsequential memory accesses.
+
 Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 	Test that atomic_set() cannot break the atomicity of atomic RMWs.
-- 
2.25.1

