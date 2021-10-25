Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBB439962
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 16:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhJYO5g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhJYO5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 10:57:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87CC061767;
        Mon, 25 Oct 2021 07:55:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d15so11894358qkj.10;
        Mon, 25 Oct 2021 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqvCQyF+52E6KJJKufgbT4SskUQqYbfvsh29IZP+z8I=;
        b=nodvupGgz9qPuN9uhiEORh2z/+VOY4X/tflLMzdKMJdfqKW3XWsmIpqniJlHPTB3hb
         nTGNHf7HHWT3qMFigMFH84X1hRhPcKg/pcEjztpoWf3nTzgOei2Sf93cemgMMu7dvD0m
         RV6R3yASZmg2im5oAl93tYyQj9gqUMBwb2bnrjVVdvbBdaLa6YOW8htgW90DaurFBaXm
         VbXkyMyr7gahsVUo5HDSxOX3J53O+EmA+9rsm6Rzp6Yr7m7NZyOjxYCZJtneo5fnUDCv
         SsRrsU9toNWFflxkl3Rp9XFIcuk1EE7h2E8tZPxODKQGmrvzHJP4s2s9+Qc3P11BpvlM
         4CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqvCQyF+52E6KJJKufgbT4SskUQqYbfvsh29IZP+z8I=;
        b=RLU0yXQwNs3hoUSsJqOapTjy/+ed/8y51sl4u2fdRWXH3Do+3IFENLobdy/Ltez8pp
         0rswS7LjdCfU6nTYvUvPtE+OJv5DY+MNq4xSm9qxMU2AV/VxnidQLrWsGAxT08CdRPCy
         dW7hVdKp/B4ABRagH0dt6A6m2JHN3of+jBo11c/2YE1kmb09WhPDgYlSkjjRC4NNhCnC
         jY3AdIMYclXb+LQmJWNrVWZC4yw2ZtZIrIYlzJHoi5V+XSEMvrVv5cx7K5KeBzBcDW3/
         LU1ErY8th5dj5uoXidbvo2UerTT181EgEzskJUX5FCpoHBMEaPlH+rHcKyPUO3GokswU
         jLpQ==
X-Gm-Message-State: AOAM532NSsad2YPURpogSTGyHBvG23wStE8Nc6whoY7LWNpNnRSb4GXL
        GJrcvL6J4J8qK9YoXAvASoI=
X-Google-Smtp-Source: ABdhPJwthUzBRCQ3zu35Kzx4vAb1en7RhM5Q8FtX61ADwmy2bky284/sj7sGU1+/E3hngJt5KO/6nA==
X-Received: by 2002:a05:620a:404f:: with SMTP id i15mr13717485qko.460.1635173709402;
        Mon, 25 Oct 2021 07:55:09 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b71sm8764035qkg.131.2021.10.25.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:55:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4E60F27C0054;
        Mon, 25 Oct 2021 10:55:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Oct 2021 10:55:07 -0400
X-ME-Sender: <xms:SsV2YY-XnLCc7U_uszFb7w4oeBdg3nkgxwnCGMnVmIan-UbCt07e5Q>
    <xme:SsV2YQseoeQ1PdOi1JYU4rRGUWFBopsmYEScunDo3wcOnOKrU2EOEec7UfxcAd78E
    6qxXfPq554wQvtCFA>
X-ME-Received: <xmr:SsV2YeAEHE2aGdtwXiX-jcCbtQ6XGivUoTiiTW-TEqQzAjF1T1rdsQ_sJTd2uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehvdevteefgfeiudettdef
    vedvvdelkeejueffffelgeeuhffhjeetkeeiueeuleenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:SsV2YYe_sgQVhFf8UBhJDbnP4I4AhxPfeIEjX1wD0A-OCN2Udl1Zow>
    <xmx:SsV2YdOa5na4gB18ZgyKxZXzvnNi33xRc3C31bwsDWgpsVRAlsvaTA>
    <xmx:SsV2YSkatASKmsQtAiOOEMf6dpD4cghDkvHg8mgCgI_3F6dKHbQdQQ>
    <xmx:S8V2Yf35d9heG6ugRQZvAseHgQIfM6bEVvVwCOU7-ZCGSpgz-YhaNGFrIYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 10:55:05 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC v2 3/3] tools/memory-model: litmus: Add two tests for unlock(A)+lock(B) ordering
Date:   Mon, 25 Oct 2021 22:54:16 +0800
Message-Id: <20211025145416.698183-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025145416.698183-1-boqun.feng@gmail.com>
References: <20211025145416.698183-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The memory model has been updated to provide a stronger ordering
guarantee for unlock(A)+lock(B) on the same CPU/thread. Therefore add
two litmus tests describing this new guarantee, these tests are simple
yet can clearly show the usage of the new guarantee, also they can serve
as the self tests for the modification in the model.

Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 ...LB+unlocklockonceonce+poacquireonce.litmus | 33 +++++++++++++++++++
 ...unlocklockonceonce+fencermbonceonce.litmus | 33 +++++++++++++++++++
 tools/memory-model/litmus-tests/README        |  8 +++++
 3 files changed, 74 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus

diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
new file mode 100644
index 000000000000..955b9c7cdc7f
--- /dev/null
+++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
@@ -0,0 +1,33 @@
+C LB+unlocklockonceonce+poacquireonce
+
+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, all accesses
+ * in the first must execute before any accesses in the second, even if
+ * the critical sections are protected by different locks.
+ *)
+
+{}
+
+P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
+{
+	int r1;
+
+	spin_lock(s);
+	r1 = READ_ONCE(*x);
+	spin_unlock(s);
+	spin_lock(t);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(t);
+}
+
+P1(int *x, int *y)
+{
+	int r2;
+
+	r2 = smp_load_acquire(y);
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r1=1 /\ 1:r2=1)
diff --git a/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
new file mode 100644
index 000000000000..2feb1398be71
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
@@ -0,0 +1,33 @@
+C MP+unlocklockonceonce+fencermbonceonce
+
+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, stores in the
+ * first must propagate to each CPU before stores in the second do, even if
+ * the critical sections are protected by different locks.
+ *)
+
+{}
+
+P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
+{
+	spin_lock(s);
+	WRITE_ONCE(*x, 1);
+	spin_unlock(s);
+	spin_lock(t);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(t);
+}
+
+P1(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	r2 = READ_ONCE(*x);
+}
+
+exists (1:r1=1 /\ 1:r2=0)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f9067fa9e..d311a0ff1ae6 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,6 +63,10 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
+LB+unlocklockonceonce+poacquireonce.litmus
+	Does a unlock+lock pair provides ordering guarantee between a
+	load and a store?
+
 MP+onceassign+derefonce.litmus
 	As below, but with rcu_assign_pointer() and an rcu_dereference().
 
@@ -90,6 +94,10 @@ MP+porevlocks.litmus
 	As below, but with the first access of the writer process
 	and the second access of reader process protected by a lock.
 
+MP+unlocklockonceonce+fencermbonceonce.litmus
+	Does a unlock+lock pair provides ordering guarantee between a
+	store and another store?
+
 MP+fencewmbonceonce+fencermbonceonce.litmus
 	Does a smp_wmb() (between the stores) and an smp_rmb() (between
 	the loads) suffice for the message-passing litmus test, where one
-- 
2.33.0

