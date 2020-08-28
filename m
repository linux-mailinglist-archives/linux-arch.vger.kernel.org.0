Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B6255A26
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgH1Maq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 08:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbgH1M3v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 08:29:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5F12086A;
        Fri, 28 Aug 2020 12:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598617789;
        bh=JCO/lXzUYdFJWlKazCE1J0QbFO+BF8f1YZINWJLpv0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYr3eXjYnGs59WVQsPiU2JU2fTihwh1eB9pwsba1cCkRmVzTHjwZ8+A/CLiwtbKxL
         7xU3517WjfWK9PRUS/Kay+BDI8mPXl0d5zpaPX+xZ4JMJ+7jX1SLd3W1vCkglBERV0
         3rIRI09gr0GA2he8l52TCYT1RDB4Vod8E9nradno=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v4 17/23] llist: Add nonatomic __llist_add()
Date:   Fri, 28 Aug 2020 21:29:44 +0900
Message-Id: <159861778403.992023.16294174469836026964.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159861759775.992023.12553306821235086809.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/i915/i915_request.c |    6 ------
 include/linux/llist.h               |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 0b2fe55e6194..0e851b925c8c 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -357,12 +357,6 @@ void i915_request_retire_upto(struct i915_request *rq)
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
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2e9c7215882b..c17893dcc591 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -197,6 +197,16 @@ static inline struct llist_node *llist_next(struct llist_node *node)
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
@@ -209,6 +219,11 @@ static inline bool llist_add(struct llist_node *new, struct llist_head *head)
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

