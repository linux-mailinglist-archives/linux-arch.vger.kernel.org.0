Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3024C612666
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ2XSz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJ2XSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB632F008;
        Sat, 29 Oct 2022 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=es2LQZ+nRVoUgaLb53NmGXxokQxrFnpTsmJfGV37wCY=; b=LnEzB0aRSO3AFBfNlPrL2rJ1cr
        6gOEM/JPvtzfSLMg6/4R6jEUvDcdFkmaXLOLIj6/aQtv/G3DNeOQAYgaHhO3F4LkwtfLrIKCc6FWp
        4PsGQh/iBm67PGTxXoDMd1VRCf4gWpsIrU32doBkYpjdb8PIIpiEv6gyGmy32dNeDHuS8mDaJMrAE
        VWEuGgwh5JxAI5r0wYV8h4Brza3AXQFfP7zQXL09QeCyFW1Spzxng5v/vqwPtgepk3Jk803JnDZ4w
        4ItyQp2E873GmkZ3ES4oGCZwHz7S5YCdL6jpKMS53dGxvPk/Kj97AHTSlGSuCVZwyX0aXsb5HLw6z
        7BD+z8oA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6J-00FOKV-0p;
        Sat, 29 Oct 2022 23:18:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] kill coredump_params->regs
Date:   Sun, 30 Oct 2022 00:18:42 +0100
Message-Id: <20221029231850.3668437-2-viro@zeniv.linux.org.uk>
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

it's always task_pt_regs(current)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c          | 4 ++--
 fs/coredump.c            | 1 -
 include/linux/coredump.h | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 63c7ebb0da89..002fd713ac11 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2082,7 +2082,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	/* now collect the dump for the current */
 	memset(info->prstatus, 0, sizeof(*info->prstatus));
 	fill_prstatus(&info->prstatus->common, current, cprm->siginfo->si_signo);
-	elf_core_copy_regs(&info->prstatus->pr_reg, cprm->regs);
+	elf_core_copy_regs(&info->prstatus->pr_reg, task_pt_regs(current));
 
 	/* Set up header */
 	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
@@ -2109,7 +2109,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 
 	/* Try to dump the FPU. */
 	info->prstatus->pr_fpvalid =
-		elf_core_copy_task_fpregs(current, cprm->regs, info->fpu);
+		elf_core_copy_task_fpregs(current, task_pt_regs(current), info->fpu);
 	if (info->prstatus->pr_fpvalid)
 		fill_note(info->notes + info->numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*info->fpu), info->fpu);
diff --git a/fs/coredump.c b/fs/coredump.c
index b4ec1bf889f9..1a474de1e52b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -525,7 +525,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	static atomic_t core_dump_count = ATOMIC_INIT(0);
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
-		.regs = task_pt_regs(current),
 		.limit = rlimit(RLIMIT_CORE),
 		/*
 		 * We must use the same mm->flags while dumping core to avoid
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 08a1d3e7e46d..a0655d7c149c 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -18,7 +18,6 @@ struct core_vma_metadata {
 
 struct coredump_params {
 	const kernel_siginfo_t *siginfo;
-	struct pt_regs *regs;
 	struct file *file;
 	unsigned long limit;
 	unsigned long mm_flags;
-- 
2.30.2

