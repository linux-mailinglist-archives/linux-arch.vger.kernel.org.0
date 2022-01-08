Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4D48849B
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiAHQof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiAHQo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1B3C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7328EB80B4C
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D23C36AE3;
        Sat,  8 Jan 2022 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660266;
        bh=kZ6ewOsIspZ5UP0WmGdsulngoycAuaq8Cf8dYc4KorQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nf4/sPAbWhWP+hg5cbRtORiMTUNtDoPJgpo+XlbzmdxaiI4aDAh+gRDd3LBs3jSdB
         E7MdZorBg0nGhL7W8XdLIzZAy2wFfunrxVnHkSRweDSFloVsl1ScCKPwqR5DcJQKD+
         gg5zQ2t7i+CemQ7FNrsNzXCXMct/9u1Ds6Jg8las/6ldMd4yzif/Mtx+bzQ1uKQXT2
         cCaHUMqAAt+gmHsMOE5N2MTkHaJiWbqJC9Ck/E86LuMNDiCawfA6TK5+s1mp3qycKr
         wW/yniY7NUlNbd0jnTbgpeenJ5MSCF5ZONgKQxXWuGGX+HBjPiU6Nj3+t5XVDdQeif
         nnJfyKWsI4uGA==
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
Subject: [PATCH 08/23] membarrier: Remove redundant clear of mm->membarrier_state in exec_mmap()
Date:   Sat,  8 Jan 2022 08:43:53 -0800
Message-Id: <f7ab552d8b7f00ec33766f4bf8554c8fc67517bc.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

exec_mmap() supplies a brand-new mm from mm_alloc(), and membarrier_state
is already 0.  There's no need to clear it again.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/sched/membarrier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index eb73eeaedc7d..c38014c2ed66 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -285,7 +285,6 @@ void membarrier_exec_mmap(struct mm_struct *mm)
 	 * clearing this state.
 	 */
 	smp_mb();
-	atomic_set(&mm->membarrier_state, 0);
 	/*
 	 * Keep the runqueue membarrier_state in sync with this mm
 	 * membarrier_state.
-- 
2.33.1

