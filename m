Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20348254A8E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgH0QVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgH0QVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DCC061264;
        Thu, 27 Aug 2020 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CA2LQBV3qCg6kIH7wqA7nexZ0XEQZOH6C+KSSjM5Pyc=; b=YsdlAZrww5XuIhxYUmnVkQFRh+
        FnZV15nwR3QW0N+is51bG5riqHNv+pduSKbUKJokyFRjLRHZoSxulIZe/0+X4RPoRMZbHDQHJZ7ke
        0HTF+6zKl7DsGvqmlfNvMtlYuHHdP13V9kZ0u3HFK9vpHgfi/MJalVz57WWiRac8UmQgLd6hjXzMy
        oU1SJvmRWfU1+wpGHof/BRwhLmh5rY/Ddy9ee3mfMRXElFw39tFADwAM895ezqfiQrUYqz5LYkP3U
        2+qY3815giREXHTBn5+Qnc3OxxZERZ0G3U7TFvlFOuH3/9SGYpKgqYkEDaTLGZxP7JOODEaEJG23n
        yt8Bw5hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe4-0001WN-IV; Thu, 27 Aug 2020 16:21:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3CF83077B1;
        Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7305D203C0774; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.241309505@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 1/7] llist: Add nonatomic __llist_add()
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/i915/i915_request.c |    6 ------
 include/linux/llist.h               |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -357,12 +357,6 @@ void i915_request_retire_upto(struct i91
 	} while (i915_request_retire(tmp) && tmp != rq);
 }
 
-static void __llist_add(struct llist_node *node, struct llist_head *head)
-{
-	node->next = head->first;
-	head->first = node;
-}
-
 static struct i915_request * const *
 __engine_active(struct intel_engine_cs *engine)
 {
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -197,6 +197,16 @@ static inline struct llist_node *llist_n
 extern bool llist_add_batch(struct llist_node *new_first,
 			    struct llist_node *new_last,
 			    struct llist_head *head);
+
+static inline bool __llist_add_batch(struct llist_node *new_first,
+				     struct llist_node *new_last,
+				     struct llist_head *head)
+{
+	new_last->next = head->first;
+	head->first = new_first;
+	return new_last->next == NULL;
+}
+
 /**
  * llist_add - add a new entry
  * @new:	new entry to be added
@@ -209,6 +219,11 @@ static inline bool llist_add(struct llis
 	return llist_add_batch(new, new, head);
 }
 
+static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
+{
+	return __llist_add_batch(new, new, head);
+}
+
 /**
  * llist_del_all - delete all entries from lock-less list
  * @head:	the head of lock-less list to delete all entries


