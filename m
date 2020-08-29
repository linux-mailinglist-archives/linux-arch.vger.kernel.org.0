Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960882567B4
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH2ND2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 09:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgH2NCu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:02:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D222076D;
        Sat, 29 Aug 2020 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706161;
        bh=w9gK3vfNWub0gKn2f1AbBtHLMsVqdA5lIAUDVNwM+Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0Tvi3WgdeocwLMk+CjQf2J9AFI1F/4NRiwsa3xvyg4YBg+GJBRDiGm8AMVgiIuI/
         bwJD/UEtMTbauxLLS/sLboKyoXW/fEQkdn0DnmpbsycQ3s+jaToPxvQQNsqGLW983o
         /VAGhhUXuzFnQXA+BFebq7mv3PvCIEU0mZJ5aERQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 14/21] kprobes: Remove NMI context check
Date:   Sat, 29 Aug 2020 22:02:36 +0900
Message-Id: <159870615628.1229682.6087311596892125907.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159870598914.1229682.15230803449082078353.stgit@devnote2>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
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
index a0afaa79024e..211138225fa5 100644
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
@@ -2035,17 +2038,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
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

