Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F62488494
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiAHQoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33418 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiAHQoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE538B8075E
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E76AC36AE3;
        Sat,  8 Jan 2022 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660260;
        bh=bUrRFZAr479LQP/6WPwNI+9QSQKTdrq6o7ocsecDxbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZ333cMtnVBA70AW2odanHwWzISHcbq2v8sHljXikH2mkdQZhlc9Ej6nG9o6YiAGU
         JAMax/oSICJXzkPkJkuLtc+lJpSFR/2IJ8d2CxOZ5yDhFB4iL16bCvdurC3VmLS8p0
         XdRjpXEIJcrn7YP5BfOvRkEIK+ZwGDlLSRR8mPRAQUjlWfwMfBhz+/6dl7q6A2supO
         teM2enjF/rxtXkArCAH64SyMEzGfoqitT7V3KfrpNbbcjQz3B/hvJX+vBCmUW3zdvT
         uNVP5rvUGXLYhJaRgFM1pEHYiruMtHIx7LEotVnN3xVRE/aq/dSs1skvVkCzrJ3OwX
         tjaFoWDe+Q3Hg==
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
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 03/23] membarrier: Remove membarrier_arch_switch_mm() prototype in core code
Date:   Sat,  8 Jan 2022 08:43:48 -0800
Message-Id: <651efcf54f1d16467b12077b5366dfce587191d3.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

membarrier_arch_switch_mm()'s sole implementation and caller are in
arch/powerpc.  Having a fallback implementation in include/linux is
confusing -- remove it.

It's still mentioned in a comment, but a subsequent patch will remove
it.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/sched/mm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c256a7fc0423..0df706c099e5 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -350,13 +350,6 @@ extern void membarrier_exec_mmap(struct mm_struct *mm);
 extern void membarrier_update_current_mm(struct mm_struct *next_mm);
 
 #else
-#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
-static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
-					     struct mm_struct *next,
-					     struct task_struct *tsk)
-{
-}
-#endif
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
-- 
2.33.1

