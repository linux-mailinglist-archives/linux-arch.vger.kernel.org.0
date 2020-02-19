Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D56163D04
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 07:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSG0r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 01:26:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46149 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgBSG0o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 01:26:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so21530749qkh.13;
        Tue, 18 Feb 2020 22:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSVXe85di4uctFtWBVBwJQVGLp4RQYE6apzrP4URRsk=;
        b=IiJLW7y5wNw7wkLqB6I5LL/YXpwfrvt6lwt3pgz5RzFlK2FZSO8IvJI7uF/6rc+Wlv
         zKaK+JmjAg0U/Gx+H3k2BCCgtNzRomEc7LS8zTdTdVCmk8x3mtH8pHxc8FU4Ilv69XKd
         d+OLiVHTHx5xGV5ffMjYD4SJQbMjz7AAl8M44IMq9BUk0di9lT3oNYdIhBSThPTbPQ2V
         2uZy5Gi1E5acdskS/8DYh49DwOLw4WMgeIRBHwfkT56PDaCSaRkSQi8UHTf7I8KvNrPd
         fSLxozJ40K0/kBoz3mjmY4EZX0KtseL8HEcgmxRIJoYmcLr9yZIYcpUWh8DBqSCwEbqJ
         tHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSVXe85di4uctFtWBVBwJQVGLp4RQYE6apzrP4URRsk=;
        b=TZMEzBgjkd3rsAtNSJ7ktoZ5dZpEOKWbiQ9EzbJ2bIz9cVaz8ckn0dlI8D5X5jL1pe
         FLUJKzPuPljrH3xl5Nh16w3CAjR+XV0qq0XDngwW+fv0q+kiRstuB/dSpJAmrquURVrI
         +DpqIgPeqS2FiTv1uPBDR6fXR0Al0j13V5MtJ/tZTEVu/F/dVhuW73Mz+TqvBJHgFzdF
         cOoEc53QawwhHvwNL8D9bbKNxiquDbuIQCjRwV6CqLMd7boGpErGKxjCJ6RbLs4JnQYU
         7yaILhM9tcW35K8XGDgoB/3QWN3OMLjvG71WnL8zHeqOGllfdnAfKsc/1ffcYvAb1+ZF
         DupA==
X-Gm-Message-State: APjAAAUxQ4bGnTE5ANV5SvbJwNxz2vCQvvweJx8XTbX05Bo0guJojwse
        P1Rrd80DVPFQkVgVUZrzxMI=
X-Google-Smtp-Source: APXvYqwcVO05hpERKNCrE3msyG3eeB3Wb41Y7vt6Ofo/6uP+NB8LnFOnT2JcQ3/wFa143ALTay8ldg==
X-Received: by 2002:a37:a8f:: with SMTP id 137mr665848qkk.435.1582093602787;
        Tue, 18 Feb 2020 22:26:42 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j4sm525607qkk.84.2020.02.18.22.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:26:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4F2DB22200;
        Wed, 19 Feb 2020 01:26:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Feb 2020 01:26:40 -0500
X-ME-Sender: <xms:INVMXqt6Y-22WRHsTIIPo5OArUvxWR2uLQDEHdnLFucv1FjqicPlXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:INVMXmMlaiKFR0HMvBZlxk1iL8xB2UQvLra8LvWjAgXGbCq14QBK_A>
    <xmx:INVMXunpbNbgNMii4i4o3FUqs_SUEf2NAu0OBA_gQUdOz4Xv-skPJQ>
    <xmx:INVMXp4b1Do5AcWIACP4njFyJC1pohwSJVWs2RuvA51sAcOkp4KFYw>
    <xmx:INVMXhOAPIodZiAMyA0VJj5uy5zSgV86pqxT4IF6CPH6EiTTOSFdZOPGJxU>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1DC83060F09;
        Wed, 19 Feb 2020 01:26:39 -0500 (EST)
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
Subject: [RFC v2 4/4] Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
Date:   Wed, 19 Feb 2020 14:26:27 +0800
Message-Id: <20200219062627.104736-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219062627.104736-1-boqun.feng@gmail.com>
References: <20200219062627.104736-1-boqun.feng@gmail.com>
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
index d30cb3d87375..a455328443eb 100644
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

