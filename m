Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1B21EEC3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 13:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGNLKe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 07:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNLKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 07:10:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AFEC061755;
        Tue, 14 Jul 2020 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aA679qIodiBpC5vbULiwbVKx3fOumlOYyYuEKhecoTI=; b=I23oUhorQvkUc3pKxqW65dWZKi
        2fvnRyOEcYQiwRX71KaxF5fb1WDG9GhMZ0whjJ4vniWBpxRO+H4GEqTsMWqFwK88N8jITuk5W5dzq
        964ngvwoNriO55HokZ0KVUAATgpYwv7/l2gjlugolwHLuVj7WlJlE//60NlcNcyzqauvWByDcKjSJ
        7Fv51WGpAXn+LU5rCKIO7zOLWNs/SrNcTp5pWrbsbYxma8sEaB72+1iDJlLGTd2VnQ97nIKoe1xMK
        eTx5w1U1nwg7BYSroNLCMEwFnKIR79GysRyZxtpMg5ya2xRvud3GD+pkGvH1WKaGvX+CzkoWoN/aS
        XwKN5xUQ==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvIpP-0006Ta-Mr; Tue, 14 Jul 2020 11:10:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] exec: use force_uaccess_begin during exec and exit
Date:   Tue, 14 Jul 2020 12:55:05 +0200
Message-Id: <20200714105505.935079-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Both exec and exit want to ensure that the uaccess routines actually do
access user pointers.  Use the newly added force_uaccess_begin helper
instead of an open coded set_fs for that to prepare for kernel builds
where set_fs() does not exist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c     | 7 ++++++-
 kernel/exit.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a7032784..769af470b69124 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1380,7 +1380,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
 
-	set_fs(USER_DS);
+	/*
+	 * Ensure that the uaccess routines can actually operate on userspace
+	 * pointers:
+	 */
+	force_uaccess_begin();
+
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f2810338..17d486a20f0dc6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -731,7 +731,7 @@ void __noreturn do_exit(long code)
 	 * mm_release()->clear_child_tid() from writing to a user-controlled
 	 * kernel address.
 	 */
-	set_fs(USER_DS);
+	force_uaccess_begin();
 
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
-- 
2.26.2

