Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669A7170D52
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 01:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgB0AlQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 19:41:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33975 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgB0AlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:41:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id 11so1555594qkd.1;
        Wed, 26 Feb 2020 16:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3HEBkdj4Q66EXmD0o3ypRhrbhQ6fBEZAkU7EgqNosg=;
        b=RakaVhNzgtHMPpokLjqKcfDVurEggH0qrsV8wfwIBVs9U162kFOjdZ9ekNAGC9tDo1
         TUwFdQA73K51P5P+lyJU7hvY63wnpUelc3S+gOVSyPOlpdjd0o2a+p53/hxesbEjcfg9
         ONLYiRw4QeVOLPsqaUzEqh55qJl0iffRLoZYTkqP6uA+rjn6Wb4O6bxNdHAHJvfGP/Gc
         yeeC65TzfOgJKa65c6ToAO/xzRsRiBvr21vDYN7NZvYcJF3U83RWqkP06bxuDrDC0PMk
         2Qu78Ce3VfBKLwspagi8KLKZGVd49tIalnT0JyRnHEgU9ZgJKJtrQjy2ehEEdrPW1aoT
         MMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3HEBkdj4Q66EXmD0o3ypRhrbhQ6fBEZAkU7EgqNosg=;
        b=kLHLIQOxNo2Z3SSArmFT2/V0E7yCE6JUF7xXoW687Me8gggHC4dlcKh/pacn2hQNwp
         6C8uN0HETJRqDrxRWsoF+g++YrMRm/izvxpDY0fgatC0ycI+/CHCjZflkyxg2/GnnZP5
         yC21FBI6Jh0w36Gi1vi3d1h1j6FWXy9GSWq0degoMV+mr2myTDQM0mTnlNrHyUoT8X33
         KpmAmDoFcmEUEqgNQUlrH2CWpZhjkdAFqXuLO/REVY93OlYEAi5FVARIny8BJkw9welb
         lLikB6zpnFytN9Rtb4MKp2v9UNYDeU/kzrIrQv/kHYyvClRt38gF0O8n7q6g6/ZFIStQ
         8DzA==
X-Gm-Message-State: APjAAAVKMiCCmoDSN6xPSuGcrvhr+dCkpQyzjQTE+b6jaLbSO9U0rI/N
        a4wlA4cBZsSmTjhmZFckZls=
X-Google-Smtp-Source: APXvYqwTTmlkFACCr8vHN1s/N5ZBb9BGDnZblhRg9JKyox1p153Fhbk36g0ReVVDWKYswgCiQQCnLw==
X-Received: by 2002:a05:620a:146c:: with SMTP id j12mr2393530qkl.373.1582764071450;
        Wed, 26 Feb 2020 16:41:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p126sm2123428qkd.108.2020.02.26.16.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 16:41:10 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0C11E21F82;
        Wed, 26 Feb 2020 19:41:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 19:41:10 -0500
X-ME-Sender: <xms:JRBXXh5DyWiPoMuCUn6EwUm-a0h3iP6wKDm98j33ip_s37vYTflHRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:JRBXXvceNw-SMc0sno7XAyYxIV7jlrBsFd9qK2taxfY_dmfV2rQchQ>
    <xmx:JRBXXpon2xG-kz4rqH7OeBSzYSk4lsY0kHHJ8KmVjPhlfc-YlKzQXg>
    <xmx:JRBXXj1NFWrKTW41mwpGaxXl1SevgIZKOHN-fmsEAw7PTMVpCqXKiw>
    <xmx:JhBXXgyVOFMzGJqDZa1ulpUqLK8E12hMjYaOW2PX-l3m49yafdx6TbshTPM>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EC5730610DB;
        Wed, 26 Feb 2020 19:41:09 -0500 (EST)
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
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 5/5] Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
Date:   Thu, 27 Feb 2020 08:40:49 +0800
Message-Id: <20200227004049.6853-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
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
---
 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 Documentation/atomic-tests/README             |  5 +++
 Documentation/atomic_t.txt                    | 10 +++---
 3 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus

diff --git a/Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus b/Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
new file mode 100644
index 000000000000..9a8e31a44b28
--- /dev/null
+++ b/Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
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
diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
index a1b72410b539..714cf93816ea 100644
--- a/Documentation/atomic-tests/README
+++ b/Documentation/atomic-tests/README
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
-- 
2.25.0

