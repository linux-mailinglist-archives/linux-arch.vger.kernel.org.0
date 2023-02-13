Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0863693BF3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 02:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBMBzb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 20:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMBza (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 20:55:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D2EF93
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 17:55:29 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g18so12386168qtb.6
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 17:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfWgFky8Oo0dLRgocQgSyLFVq1vdjV8IYOHij7ANhkk=;
        b=V3s3hHtb0C0w6Op4gMTtToGItfVkMz1GV1YRSAVo92QOgpk7wvHN2zcilMgF4sGWFM
         hOb/28Kf14srY+IPR4svTMsgyt0CIbmWlQQ9DNT9OUi6mu09O2/jFaKumSu8NxW7A/SX
         eeuA7pwAgJyeV5Ff514T4HO9DMuAjBeHHzZQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfWgFky8Oo0dLRgocQgSyLFVq1vdjV8IYOHij7ANhkk=;
        b=fg5MMUn1mHEoAxXAs7JsyiPHm/Svn8dtJaHH0UgsUE4QUSVApIVXgsXvh6ig/Y2NIk
         gnH5tpFy58gkGcLGtVhQc+cWnNUJ3cXqWzhb/AjlwiJYUXW2ULw84QI55niBk5F+qFqe
         Yuy8egF1BTJpID6Kq5BuKUfd6BfVD/pG0e/D8wAkJqewX0mV8Ob/I9uPP50wHxXA6zKt
         E0LpyZhLaehzbIrpGDuCuK8PTeLBFD2Y4N+zVr+vNUEU5Kip0tIy8WGjz3AtJDI6ORng
         eh/JyCc9CHX5LtFNvC2HR2MIDvcshfLw7tDE0A/KYzI0Aa6D3MAcYPIvN0fTiU6kOfYe
         /UgQ==
X-Gm-Message-State: AO0yUKXvV7FMIsB8XhM+LM9dK/vhldhPZMwiu7KrdE30md34SXSeg/XZ
        ABXBTVJVTDlMVnv2J5H3doNzMQ==
X-Google-Smtp-Source: AK7set//NThWoUxiYJfrMFfd1jUGZhNb5mwxEiepweZLewVjNk7yyKmBtLsETVxMEQGplAQfaE+YRA==
X-Received: by 2002:ac8:4e88:0:b0:3b8:8756:6de8 with SMTP id 8-20020ac84e88000000b003b887566de8mr38308317qtp.67.1676253328375;
        Sun, 12 Feb 2023 17:55:28 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id p18-20020ac84092000000b003a7eb5baf3csm8354975qtl.69.2023.02.12.17.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 17:55:27 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] tools/memory-model: Add details about SRCU read-side critical sections
Date:   Mon, 13 Feb 2023 01:55:06 +0000
Message-Id: <20230213015506.778246-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add details about SRCU read-side critical sections and how they are
modeled.

Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 .../Documentation/explanation.txt             | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 8e7085238470..5f486d39fe10 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory Consistency Model
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
   22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
-  23. LOCKING
-  24. PLAIN ACCESSES AND DATA RACES
-  25. ODDS AND ENDS
+  23. SRCU READ-SIDE CRITICAL SECTIONS
+  24. LOCKING
+  25. PLAIN ACCESSES AND DATA RACES
+  26. ODDS AND ENDS
 
 
 
@@ -1858,6 +1859,54 @@ links having the same SRCU domain with proper nesting); the details
 are relatively unimportant.
 
 
+SRCU READ-SIDE CRITICAL SECTIONS
+--------------------------------
+An SRCU read-side section is modeled with the srcu-rscs relation and
+is different from rcu-rscs in the following respects:
+
+1. SRCU read-side sections are associated with a specific domain and
+are independent of ones in different domains. Each domain has their
+own independent grace-periods.
+
+2. Partitially overlapping SRCU read-side sections cannot fuse. It is
+possible that among 2 partitally overlapping readers, the one that
+starts earlier, starts before a GP started and the later reader starts
+after the same GP started. These 2 readers are to be treated as
+different srcu-rscs even for the same SRCU domain.
+
+3. The srcu_down_read() and srcu_up_read() primitives permit an SRCU
+read-side lock to be acquired on one CPU and released another. While
+this is also true about preemptible RCU, the LKMM does not model
+preemption.  So unlike SRCU, RCU readers are still modeled and
+expected to be locked and unlocked on the same CPU in litmus tests.
+
+To make it easy to model SRCU readers in LKMM with the above 3
+properties, an SRCU lock operation is modeled as a load annotated with
+'srcu-lock' and an SRCU unlock operation is modeled as a store
+annotated with 'srcu-unlock'. This load and store takes the memory
+address of an srcu_struct as an input, and the value returned is the
+SRCU index (value). Thus LKMM creates a data-dependency between them
+by virtue of the load and store memory accesses before performed on
+the same srcu_struct:  R[srcu-lock] ->data W[srcu-unlock].
+This data dependency becomes: R[srcu-lock] ->srcu-rscs W[srcu-unlock].
+
+It is also possible that the data loaded from the R[srcu-lock] is
+stored back into a memory location, and loaded on the same or even
+another CPU, before doing an unlock.
+This becomes:
+  R[srcu-lock] ->data W[once] ->rf R[once] ->data W[srcu-unlock]
+
+The model also treats this chaining of ->data and ->rf relations as:
+  R[srcu-lock] ->srcu-rscs W[srcu-unlock] by the model.
+
+Care must be taken that:
+  R[srcu-lock] ->data W[srcu-unlock] ->rf R[srcu-lock] is not
+considered as a part of the above ->data and ->rf chain, which happens
+because of one reader unlocking and another locking right after it.
+The model excludes these ->rf relations when building the ->srcu-rscs
+relation.
+
+
 LOCKING
 -------
 
-- 
2.39.1.581.gbfd45094c4-goog

