Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74A48849C
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiAHQof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50354 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiAHQo3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E021060DEC
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2958AC36AED;
        Sat,  8 Jan 2022 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660268;
        bh=VqXWDLIfda9ix4PWEeLYbN3dci4eLEKG08Nxx9ltxEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V06V1fGQjBCtMex/IKqEz4AHKdynLFyK3aQUjFL0aKgqnf1YsnJ1zg2qxfMeCD8ug
         0JPMCzf64J/EySSFm6y+aFNu7gDoWMJchLOwmCYqRoNo3aHS0KvE4lp3+kCLKvScl7
         9bH6pg+3W/7DM458zXR4DeDoYsnMrmy5BqAxl5Js80ikuPr52CTsxL9522fwgpupws
         0f2kEsr8yvkLXVFi0xkE2KF+X7ASPKnrk04DnPaZTObMEI8pzPa3b87vvn93oosNSI
         /evFyjTSD3kaPNgHHtReWbZze8AejSQJ0m7GmeOnmIT/LwfvwYQ0DeGbS6Iwbt34A4
         dhWglnickt2dw==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 10/23] x86/events, x86/insn-eval: Remove incorrect active_mm references
Date:   Sat,  8 Jan 2022 08:43:55 -0800
Message-Id: <d456e7da9dbd271aacd14812d4b9b74e7d7edd52.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When decoding an instruction or handling a perf event that references an
LDT segment, if we don't have a valid user context, trying to access the
LDT by any means other than SLDT is racy.  Certainly, using
current->active_mm is wrong, as active_mm can point to a real user mm when
CR3 and LDTR no longer reference that mm.

Clean up the code.  If nmi_uaccess_okay() says we don't have a valid
context, just fail.  Otherwise use current->mm.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/events/core.c   |  9 ++++++++-
 arch/x86/lib/insn-eval.c | 13 ++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6dfa8ddaa60f..930082f0eba5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2800,8 +2800,15 @@ static unsigned long get_segment_base(unsigned int segment)
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 		struct ldt_struct *ldt;
 
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return 0;
+
 		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = READ_ONCE(current->active_mm->context.ldt);
+		ldt = smp_load_acquire(&current->mm->context.ldt);
 		if (!ldt || idx >= ldt->nr_entries)
 			return 0;
 
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index a1d24fdc07cf..87a85a9dcdc4 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -609,14 +609,21 @@ static bool get_desc(struct desc_struct *out, unsigned short sel)
 		/* Bits [15:3] contain the index of the desired entry. */
 		sel >>= 3;
 
-		mutex_lock(&current->active_mm->context.lock);
-		ldt = current->active_mm->context.ldt;
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return false;
+
+		mutex_lock(&current->mm->context.lock);
+		ldt = current->mm->context.ldt;
 		if (ldt && sel < ldt->nr_entries) {
 			*out = ldt->entries[sel];
 			success = true;
 		}
 
-		mutex_unlock(&current->active_mm->context.lock);
+		mutex_unlock(&current->mm->context.lock);
 
 		return success;
 	}
-- 
2.33.1

