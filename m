Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0349959BCF7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiHVJi6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 05:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiHVJi5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 05:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7C11400D
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661161135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zfpY3ryladZYLXHgzfscfqjYbCZN7BmzG+/csBCpaf0=;
        b=QCHThwmL+b654gaFWwuPU0jKnNy5CSvG3T4EUV26WKf8XGfPMCZyZodx7CMbDBLEwdiUPK
        1UPtNylrkriWHsm/NW3BQi9NJPU9BncEtn3X+2zjNRAaT6KzV4LzR8rSvoQEHAE7PQLwkm
        Ff/9dT7FsQI9c2Qf3k6RyVgdzSKHZ0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-H8i-0JuyPRi0A0xPOS7Glw-1; Mon, 22 Aug 2022 05:38:52 -0400
X-MC-Unique: H8i-0JuyPRi0A0xPOS7Glw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F19BC8037AF;
        Mon, 22 Aug 2022 09:38:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB8871121314;
        Mon, 22 Aug 2022 09:38:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27M9cp1c032579;
        Mon, 22 Aug 2022 05:38:51 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27M9colo032575;
        Mon, 22 Aug 2022 05:38:50 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 22 Aug 2022 05:38:50 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alan Stern <stern@rowland.harvard.edu>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] wait_on_bit: add an acquire memory barrier
Message-ID: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi

I'd like to ask what do you think about this patch? Do you want to commit 
it - or do you think that the barrier should be added to the callers of 
wait_on_bit?

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

There are several places in the kernel where wait_on_bit is not followed
by a memory barrier (for example, in drivers/md/dm-bufio.c:new_read). On
architectures with weak memory ordering, it may happen that memory
accesses that follow wait_on_bit are reordered before wait_on_bit and they
may return invalid data.

Fix this class of bugs by adding an acquire memory barrier to wait_on_bit,
wait_on_bit_io, wait_on_bit_timeout and wait_on_bit_action. The code that
uses these functions should clear the bit using the function
clear_bit_unlock.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 include/linux/wait_bit.h |   16 ++++++++++++----
 kernel/sched/wait_bit.c  |    2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6/include/linux/wait_bit.h
===================================================================
--- linux-2.6.orig/include/linux/wait_bit.h	2022-08-20 14:33:44.000000000 +0200
+++ linux-2.6/include/linux/wait_bit.h	2022-08-20 15:41:43.000000000 +0200
@@ -71,8 +71,10 @@ static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_acquire__after_ctrl_dep();	/* should pair with clear_bit_unlock */
 		return 0;
+	}
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait,
 				       mode);
@@ -96,8 +98,10 @@ static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_acquire__after_ctrl_dep();	/* should pair with clear_bit_unlock */
 		return 0;
+	}
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait_io,
 				       mode);
@@ -123,8 +127,10 @@ wait_on_bit_timeout(unsigned long *word,
 		    unsigned long timeout)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_acquire__after_ctrl_dep();	/* should pair with clear_bit_unlock */
 		return 0;
+	}
 	return out_of_line_wait_on_bit_timeout(word, bit,
 					       bit_wait_timeout,
 					       mode, timeout);
@@ -151,8 +157,10 @@ wait_on_bit_action(unsigned long *word,
 		   unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit(bit, word)) {
+		smp_acquire__after_ctrl_dep();	/* should pair with clear_bit_unlock */
 		return 0;
+	}
 	return out_of_line_wait_on_bit(word, bit, action, mode);
 }
 
Index: linux-2.6/kernel/sched/wait_bit.c
===================================================================
--- linux-2.6.orig/kernel/sched/wait_bit.c	2022-08-20 14:33:44.000000000 +0200
+++ linux-2.6/kernel/sched/wait_bit.c	2022-08-20 15:41:39.000000000 +0200
@@ -49,6 +49,8 @@ __wait_on_bit(struct wait_queue_head *wq
 			ret = (*action)(&wbq_entry->key, mode);
 	} while (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
 
+	smp_acquire__after_ctrl_dep();	/* should pair with clear_bit_unlock */
+
 	finish_wait(wq_head, &wbq_entry->wq_entry);
 
 	return ret;

