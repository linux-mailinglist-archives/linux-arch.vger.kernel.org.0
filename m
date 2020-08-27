Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6A25446E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 13:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgH0Ljw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 07:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgH0Lib (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 07:38:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA5222CB1;
        Thu, 27 Aug 2020 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598528264;
        bh=OxjpBA84KDi5ZWWyg3y0i/wou8N/yNawXlcHxpgAmK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyaNvZ+ZBRKlwzei3uUjiA1wRVxBbBADTab/rAYQVbxyvtQ87IcTxr8UKJjjhOqgI
         GRl/0l2KQXScHbEdqTjwL91JBnaoCdlv6pll6d7qPHVn9M8xpNlwHVP5qr/1a2V6Vw
         ynDcWUjkgMGxyW9TKQek5DDzZeB4Unnlm9FttT1Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 14/15] kprobes: Remove NMI context check
Date:   Thu, 27 Aug 2020 20:37:38 +0900
Message-Id: <159852825822.707944.12873921829000019667.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159852811819.707944.12798182250041968537.stgit@devnote2>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the commit 9b38cc704e84 ("kretprobe: Prevent triggering
kretprobe from within kprobe_flush_task") sets a dummy current
kprobe in the trampoline handler by kprobe_busy_begin/end(),
it is not possible to run a kretprobe pre handler in kretprobe
trampoline handler context even with the NMI. If the NMI interrupts
a kretprobe_trampoline_handler() and it hits a kretprobe, the
2nd kretprobe will detect recursion correctly and it will be
skipped.
This means we have almost no double-lock issue on kretprobes by NMI.

The last one point is in cleanup_rp_inst() which also takes
kretprobe_table_lock without setting up current kprobes.
So adding kprobe_busy_begin/end() there allows us to remove
in_nmi() check.

The above commit applies kprobe_busy_begin/end() on x86, but
now all arch implementation are unified to generic one, we can
safely remove the in_nmi() check from arch independent code.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cbd2ad1af7b7..311033e4b8e4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1359,7 +1359,8 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 	struct hlist_node *next;
 	struct hlist_head *head;
 
-	/* No race here */
+	/* To avoid recursive kretprobe by NMI, set kprobe busy here */
+	kprobe_busy_begin();
 	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
 		kretprobe_table_lock(hash, &flags);
 		head = &kretprobe_inst_table[hash];
@@ -1369,6 +1370,8 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 		}
 		kretprobe_table_unlock(hash, &flags);
 	}
+	kprobe_busy_end();
+
 	free_rp_inst(rp);
 }
 NOKPROBE_SYMBOL(cleanup_rp_inst);
@@ -2038,17 +2041,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	unsigned long hash, flags = 0;
 	struct kretprobe_instance *ri;
 
-	/*
-	 * To avoid deadlocks, prohibit return probing in NMI contexts,
-	 * just skip the probe and increase the (inexact) 'nmissed'
-	 * statistical counter, so that the user is informed that
-	 * something happened:
-	 */
-	if (unlikely(in_nmi())) {
-		rp->nmissed++;
-		return 0;
-	}
-
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
 	hash = hash_ptr(current, KPROBE_HASH_BITS);
 	raw_spin_lock_irqsave(&rp->lock, flags);

