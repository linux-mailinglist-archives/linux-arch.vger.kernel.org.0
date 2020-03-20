Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC34A18C7BA
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 07:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgCTG4B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 02:56:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37770 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTG4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 02:56:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id z25so5865150qkj.4
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7qI0J6UdPPMxMo89bJspgFfE6kReY5LFKqgcFnVjEE=;
        b=M8wPPWkw74OJ30O2RObg0NV3Uqad/cBAquf9jWLlhnwkQWlKMsX15vW5/llQc7ZVma
         kPOuv5pWfIfh9QqyZlJXrNJB4Ux8KA/twWx2iH39XKFkgXxG/T5IhWKyDHPbqnw2gSVe
         p1+JNPzVnbVxNJz2extJx7+1rarPEomTnUDRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7qI0J6UdPPMxMo89bJspgFfE6kReY5LFKqgcFnVjEE=;
        b=KQQEuQQsK0Wf2UOz2O2kcJw6ls0m9wYmGfufmcdrBWE+JFYJZFR9WNOe8tpL3IBrYl
         /TxwNddkfYZI8S/IlXY2GIv0xlAzDeXYCvUPln4mHEsVaxlJt00NAz0BBqQL8hcLXekF
         MmqxMcolcF0AbZl2+rdhZtc5Azo4cc07aEWq3A8fLu7hUEax1dw+7FL0ONZCU4thCu0x
         iAjN7/Q6dWBMPEBmNC9FwICMkFzoEpLOafOkZ7QdEy5CFexpoUE3bP8i2WhKz6epGcDu
         +KJbCuyAQ/XAGEf3lNq8bm5BhaybpUTA0KQl+ki51RpU9yNMboyNfYWIVNDZw4rhwAkF
         wLOA==
X-Gm-Message-State: ANhLgQ3POAJcNgX2T6VF3OhA9p3bZI1m7NkDddhzFt1fPBKe2EbdjfO8
        7WhcaOYYJl3xEtw/1RLYJ0ayzg==
X-Google-Smtp-Source: ADFU+vvbBbRAvpvItKU3CDLenRkmMnn64zsTki3i6k9ySmu292eqsPkuvXJtQLwlXVDMfaaK0W5jlQ==
X-Received: by 2002:a37:6556:: with SMTP id z83mr6558870qkb.381.1584687360401;
        Thu, 19 Mar 2020 23:56:00 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m15sm419985qkk.26.2020.03.19.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:55:59 -0700 (PDT)
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
Subject: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where updater frees object
Date:   Fri, 20 Mar 2020 02:55:50 -0400
Message-Id: <20200320065552.253696-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
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
 .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus

diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
new file mode 100644
index 0000000000000..c4682502dd296
--- /dev/null
+++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
@@ -0,0 +1,40 @@
+C RCU+sync+free
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that an RCU reader can never see a write after
+ * the grace period, if it saw writes that happen before the grace period. This
+ * is a typical pattern of RCU usage, where the write before the grace period
+ * assigns a pointer, and the writes after destroy the object that the pointer
+ * points to.
+ *
+ * This guarantee also implies, an RCU reader can never span a grace period and
+ * is an important RCU grace period memory ordering guarantee.
+ *)
+
+{
+x = 1;
+y = x;
+z = 1;
+}
+
+P0(int *x, int *z, int **y)
+{
+	int r0;
+	int r1;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*y);
+	r1 = READ_ONCE(*r0);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *z, int **y)
+{
+	rcu_assign_pointer(*y, z);
+	synchronize_rcu();
+	WRITE_ONCE(*x, 0);
+}
+
+exists (0:r0=x /\ 0:r1=0)
-- 
2.25.1.696.g5e7596f4ac-goog

