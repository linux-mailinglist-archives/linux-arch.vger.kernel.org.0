Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930844884A5
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiAHQom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50682 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiAHQoj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E43F860DD7
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9E7C36AE3;
        Sat,  8 Jan 2022 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660278;
        bh=9J/1QKkNyuJOe05xU7vGzx3mhn6KDpei2w55Hnz/oT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuXs+Y6u3LWdS8m9HaS3ErgC6rn96YsFIWADrWq0raX8asAen+3bktbjqpqKONCiR
         B7W82gDbT0uZ090lAVwVhIVT9464iiazwOXTfAvs0tiIvL4QYr5G7FgwEQwCO03kDa
         cmHRsIlwrqIH5GaNrp6J3sX6gjKiU3mvA21NKNPW6KELcsdtJb/C+1Zer4ZDFtuB33
         H5gx1/gRGV+FQdnaVoWdjbMEjcD0/MN4sdcznzXTAVwK11055fWS0b2Yv3YUPbS2lO
         5+u0OWrOhBnfT1axklI1TvLdlxrjXkZ2Mus4954aj0Pcm/yG7bm8bnSyHdhk8I9ovJ
         CuFDP2/cXQ7jg==
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
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 19/23] x86/efi: Make efi_enter/leave_mm use the temporary_mm machinery
Date:   Sat,  8 Jan 2022 08:44:04 -0800
Message-Id: <3efc4cfd1d7c45a32752ced389d6666be15cde56.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This should be considerably more robust.  It's also necessary for optimized
for_each_possible_lazymm_cpu() on x86 -- without this patch, EFI calls in
lazy context would remove the lazy mm from mm_cpumask().

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 7515e78ef898..b9a571904363 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -54,7 +54,7 @@
  * 0xffff_ffff_0000_0000 and limit EFI VA mapping space to 64G.
  */
 static u64 efi_va = EFI_VA_START;
-static struct mm_struct *efi_prev_mm;
+static temp_mm_state_t efi_temp_mm_state;
 
 /*
  * We need our own copy of the higher levels of the page tables
@@ -461,15 +461,12 @@ void __init efi_dump_pagetable(void)
  */
 void efi_enter_mm(void)
 {
-	efi_prev_mm = current->active_mm;
-	current->active_mm = &efi_mm;
-	switch_mm(efi_prev_mm, &efi_mm, NULL);
+	efi_temp_mm_state = use_temporary_mm(&efi_mm);
 }
 
 void efi_leave_mm(void)
 {
-	current->active_mm = efi_prev_mm;
-	switch_mm(&efi_mm, efi_prev_mm, NULL);
+	unuse_temporary_mm(efi_temp_mm_state);
 }
 
 static DEFINE_SPINLOCK(efi_runtime_lock);
-- 
2.33.1

