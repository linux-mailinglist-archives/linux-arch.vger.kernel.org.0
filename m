Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFD6890A3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBCHTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjBCHTQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:19:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBA76AF
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 23:19:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b5so4415728plz.5
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 23:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnlBvkqnb+l7IeUx8vg7gSpE5ieSkYXmCCbewvNAOcI=;
        b=AHiRLfcf8eUNQBnlAsruaF06DgmSEYeMrWMiRHEZ9X5oCS8EFKY0D1+uSzk001rKHG
         wM6Q2U10Pn14JQyW+l0O/c8z+fkwxIm/NPitBdfs40sfGlyXsENjatpI1RZhPk232lvA
         zDdUzhnba9x94swlHDb7UkVrJFnMqWpYzmGo4TPTsGtXHfXv9sfrWlf3syDxwLR5ipEX
         dFRmiJAgq8XvaTNIFp5Qu+WClm6+oFC9LekqRQUzG9QfdZgJPNJtJkIdPe1uHKJYpQRj
         YyJEeIrYiO6SEa4xtr2WXCweUe8cAWZ/KQ4ykObFGtMcv3jpBg0TZs/m6RR8iSh/nfe2
         i5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnlBvkqnb+l7IeUx8vg7gSpE5ieSkYXmCCbewvNAOcI=;
        b=c24A0LhldfNSL1oAA9N/JetNd7n+et9AqCNINYgOTfARtY/HI0I3lMdzXxj45dJExv
         rjkpYpfEKRuhgfKvPpnY5qgFuDQRFY9txAJXLQ4n3+pL5otrKgRC9aRL/QKl6rhKMvGe
         kqeSCYp59D9jhnmhFNlJm5IuxRFEcm18qKFgndGI9rZk2iI4xa7g4LDA4OMuxd5Mgf30
         j+PQ+GNUH1sYSvbA7x8ijkVzuM/O8zchGkXneSDH+kOTQXHDYL4x0ateMyVIL9D/othx
         s+NSBpfI7wHLiwJQEOl14W3ClWQpeuWg4fuMuhJtJpJm/hF7BPMF05/yke1IYotX0ZwA
         cFxA==
X-Gm-Message-State: AO0yUKVD86InmYvQ37WQkRcM/+EMePdu8STig3sVFvvU2OwH5QAG1W0c
        D0UQP38uYixOEfeIlj8c9O8=
X-Google-Smtp-Source: AK7set9/19Ishv+YbUs//IpJgvi84ti72zlNw3k1E7pi36wh6xfDzDjNIuz8qP6WMzuLeNCLPjc4Ag==
X-Received: by 2002:a05:6a20:4413:b0:be:cd2f:1951 with SMTP id ce19-20020a056a20441300b000becd2f1951mr12089686pzb.41.1675408740099;
        Thu, 02 Feb 2023 23:19:00 -0800 (PST)
Received: from bobo.ibm.com (193-116-117-77.tpgi.com.au. [193.116.117.77])
        by smtp.gmail.com with ESMTPSA id f20-20020a637554000000b004df4ba1ebfesm877558pgn.66.2023.02.02.23.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:18:59 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 1/5] kthread: simplify kthread_use_mm refcounting
Date:   Fri,  3 Feb 2023 17:18:33 +1000
Message-Id: <20230203071837.1136453-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203071837.1136453-1-npiggin@gmail.com>
References: <20230203071837.1136453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove the special case avoiding refcounting when the mm to be used is
the same as the kernel thread's active (lazy tlb) mm. kthread_use_mm()
should not be such a performance critical path that this matters much.
This simplifies a later change to lazy tlb mm refcounting.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/kthread.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..7424a1839e9a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1410,14 +1410,13 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
 
+	mmgrab(mm);
+
 	task_lock(tsk);
 	/* Hold off tlb flush IPIs while switching mm's */
 	local_irq_disable();
 	active_mm = tsk->active_mm;
-	if (active_mm != mm) {
-		mmgrab(mm);
-		tsk->active_mm = mm;
-	}
+	tsk->active_mm = mm;
 	tsk->mm = mm;
 	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
@@ -1434,12 +1433,9 @@ void kthread_use_mm(struct mm_struct *mm)
 	 * memory barrier after storing to tsk->mm, before accessing
 	 * user-space memory. A full memory barrier for membarrier
 	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
-	 * mmdrop(), or explicitly with smp_mb().
+	 * mmdrop().
 	 */
-	if (active_mm != mm)
-		mmdrop(active_mm);
-	else
-		smp_mb();
+	mmdrop(active_mm);
 }
 EXPORT_SYMBOL_GPL(kthread_use_mm);
 
-- 
2.37.2

