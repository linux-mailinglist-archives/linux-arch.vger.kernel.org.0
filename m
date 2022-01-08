Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FA48849F
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiAHQoi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiAHQoe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33404C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF3C2B80B45
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F0DC36AED;
        Sat,  8 Jan 2022 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660271;
        bh=rqABZliQOnPw5+mRwJyiDUUR6g4Y/aDsdVsBAqWYhN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNMg1GzMBirsWhPfcJt1VS301owi+7JZLVLHidbemWtEDnzBUeY3M57pY4xDlXxvJ
         jAZyEHz6Nfysn9TMOIt9eFhF5NissZryhOyD2fYqHo5bJPiFOXFH0+yBIWFKVD7+qU
         sIM2nEPPYJgDNxeIYejHjq4i+TacBOY563IE6FYmIGA7kYDAwcmtIrYNCiIUS+IyEh
         3oU7c1dDNyrd1gHCnyl6y9k5ASLzmcLy1HQIDCW4NVDlQGfcq+pdDyMkU3UY/haVLp
         AN77MSHH/JA4rLDvCP3U51/Vecf7iWcX32o+xIfYXJ1gMyw13FlZFBTQdRaxVV7NSn
         CYdwqtRUYX/eQ==
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
Subject: [PATCH 13/23] exec: Remove unnecessary vmacache_seqnum clear in exec_mmap()
Date:   Sat,  8 Jan 2022 08:43:58 -0800
Message-Id: <28ff7966573c7830f6bc296c1a1fc9a4c7072dc0.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

exec_mmap() activates a brand new mm, so vmacache_seqnum is already 0.
Stop zeroing it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 325dab98bc51..2afa7b0c75f2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1024,7 +1024,6 @@ static int exec_mmap(struct mm_struct *mm)
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
 	membarrier_finish_switch_mm(mm);
-	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
-- 
2.33.1

