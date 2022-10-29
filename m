Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74E612668
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJ2XS5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJ2XSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5BB2F00D;
        Sat, 29 Oct 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MQOuXgEd4uijladGhvf42ViTnATMp5s51KNIKFeH+uw=; b=uRfPySHb4xVQmQ1rA28MZQ3S9b
        d/25b4ehxWwsFjmU1ZCeQjljNYhdwuJHQmFqFrPVtCdCkmC5Fv1xMg/fGw6NXGfi92bewhpfVFSxN
        UHtTN332gAocwbX5+sQkAHscJNBQX7Bw8KFizNBcbC+IENqCVMwwaET1nSOyv+FYfjBrWO++VTbLi
        EFyOu0fMD0G9/BvcEJ6vZQRtWAnHV7oEF9qn+MI8SqAoifjYC/ZEHLM5ceWYwZ8YqNIqJyYdXHLYZ
        BPu9H+MnQT9xWs2mhqAX52f04PlTWl+vSFMfOLH2byDL25q+4k3wxe03HfksQ6T/ctXA7jK6NG10G
        vYysDuwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6J-00FOKj-2W;
        Sat, 29 Oct 2022 23:18:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] [elf][regset] simplify thread list handling in fill_note_info()
Date:   Sun, 30 Oct 2022 00:18:45 +0100
Message-Id: <20221029231850.3668437-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
References: <Y120X8dWqe15FPPG@ZenIV>
 <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

fill_note_info() iterates through the list of threads collected in
mm->core_state->dumper, allocating a struct elf_thread_core_info
instance for each and linking those into a list.

We need the entry corresponding to current to be first in the
resulting list, so the logics for list insertion is
	if it's for current or list is empty
		insert in the head
	else
		insert after the first element

However, in mm->core_state->dumper the entry for current is guaranteed
to be the first one.  Which means that both parts of condition will
be true on the first iteration and neither will be true on all subsequent
ones.

Taking the first iteration out of the loop simplifies things nicely...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 4190dafd2ec4..e990075fb43d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1866,7 +1866,14 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	/*
 	 * Allocate a structure for each thread.
 	 */
-	for (ct = &dump_task->signal->core_state->dumper; ct; ct = ct->next) {
+	info->thread = kzalloc(offsetof(struct elf_thread_core_info,
+				     notes[info->thread_notes]),
+			    GFP_KERNEL);
+	if (unlikely(!info->thread))
+		return 0;
+
+	info->thread->task = dump_task;
+	for (ct = dump_task->signal->core_state->dumper.next; ct; ct = ct->next) {
 		t = kzalloc(offsetof(struct elf_thread_core_info,
 				     notes[info->thread_notes]),
 			    GFP_KERNEL);
@@ -1874,17 +1881,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 			return 0;
 
 		t->task = ct->task;
-		if (ct->task == dump_task || !info->thread) {
-			t->next = info->thread;
-			info->thread = t;
-		} else {
-			/*
-			 * Make sure to keep the original task at
-			 * the head of the list.
-			 */
-			t->next = info->thread->next;
-			info->thread->next = t;
-		}
+		t->next = info->thread->next;
+		info->thread->next = t;
 	}
 
 	/*
-- 
2.30.2

