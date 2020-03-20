Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7178A18C7BD
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 07:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgCTG4E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 02:56:04 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39108 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTG4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 02:56:04 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so2427868qvf.6
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZktbxS0i0oIpqeQrOD+jHQIgM5+6wOIwrhIyNa/H6M=;
        b=OGS30BXKvOOsiK6bD9IHOQ/GNBieNsiIIavZuTQRPmaN+dLmHB72W7AG9FSAKiF68g
         QRPpdBrWYryk/9Q4y39ZNGQ9DEhRzN2NNMESkxWC+20ZItrbfMAM4eIWJclNOKm1WtD8
         MbAR5IBjM8/daadm5FSS1NRGtu7/JG+3gQ9w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZktbxS0i0oIpqeQrOD+jHQIgM5+6wOIwrhIyNa/H6M=;
        b=Jf5gAYnqeOjiv53sFlfQxp3zhRj+/el2HOje2BBs+4q2qSt47Y418gF43eQECM3reI
         PMBlmNNO+LYeIraEM2MOPcrYK3/v8Y6JhfyqipFGzwA59ki/q9+51/kLdeyaXcdYYaL0
         P0EB9A9r78CdcjWB6a2GY4fZFrQgAwzyyM+NCuni3X9DaKdawuQqFBurcMMEqlr/QWBc
         GqpIPGhITtreK/Tw3jBofu/n+WZiADk236ncbgVY0DQpVoo4Y7hUVHREPshdmIGtt5hM
         /ki87PKPhCB9skwJU2lZK9txFbEDuGMRqoVU93UW+DZG0PyhHU/lRlBrgTxDxHMKJ9Vj
         c22A==
X-Gm-Message-State: ANhLgQ2VJbRez3UBZGnn/lVxkftoWQEbr9HkZY/CGsg+iqdZTmj6fgPn
        eaPHyIlhf6+ahSBOCC10WMXV2Q==
X-Google-Smtp-Source: ADFU+vsBfhVA6txgEV2FXFv04i7OnbCf4MVeIQfB2DE8puxWcSZZqD9MC2EXp6EPoVIRkmczAddJfg==
X-Received: by 2002:a0c:eeca:: with SMTP id h10mr6656674qvs.206.1584687361491;
        Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m15sm419985qkk.26.2020.03.19.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where reader stores
Date:   Fri, 20 Mar 2020 02:55:51 -0400
Message-Id: <20200320065552.253696-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds an example for the important RCU grace period guarantee, which
shows an RCU reader can never span a grace period.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus

diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
new file mode 100644
index 0000000000000..73557772e2a32
--- /dev/null
+++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
@@ -0,0 +1,37 @@
+C RCU+sync+read
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that after a grace period, an RCU updater always
+ * sees all stores done in prior RCU read-side critical sections. Such
+ * read-side critical sections would have ended before the grace period ended.
+ *
+ * This guarantee also implies, an RCU reader can never span a grace period and
+ * is an important RCU grace period memory ordering guarantee.
+ *)
+
+{
+x = 0;
+y = 0;
+}
+
+P0(int *x, int *y)
+{
+	rcu_read_lock();
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*x);
+	synchronize_rcu();
+	r1 = READ_ONCE(*y);
+}
+
+exists (1:r0=1 /\ 1:r1=0)
-- 
2.25.1.696.g5e7596f4ac-goog

