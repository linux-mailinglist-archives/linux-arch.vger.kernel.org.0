Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0061266D
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJ2XS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ2XSy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:54 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5732F017;
        Sat, 29 Oct 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PY6K0u6K9Ph9XRzxm95fUlkPKQwm8X+pvKXLRTI6xiA=; b=BcXy8FxurNa6IK04pLSW0RBqOi
        4AhXdIB6xLnpCzUv+wuv/9O3HFbsxCRhepGijOCy1L4lAZ6Fw2XLnEWUjCmsyPRAJDRYXpQ8aWzmH
        LLnzjClcXCdE4BnEO0/01zczVnNzREvIygtOSn1rk/MNRfdU92tWV9BXWgdm4bDsj5zCwN2AQCrel
        qqmmquOPlgzt33rz/++A+e6N1ugsT/GDAZZtnYAwoEDaJylRKMow4q0FGW2U9Wze9AjeBU9C8DEUS
        vc/FWZ51tSYc70O7XDLJ+BPzTfH5Ta+DeDuw4AUv1BOdk7R+TRXqd1dVGNF3Bm0qWH+UZKme40Thn
        gRLBDPpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6K-00FOKt-0K;
        Sat, 29 Oct 2022 23:18:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] [elf][non-regset] uninline elf_core_copy_task_fpregs() (and lose pt_regs argument)
Date:   Sun, 30 Oct 2022 00:18:47 +0100
Message-Id: <20221029231850.3668437-7-viro@zeniv.linux.org.uk>
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

Don't bother with pointless macros - we are not sharing it with aout coredumps
anymore.  Just convert the underlying functions to the same arguments (nobody
uses regs, actually) and call them elf_core_copy_task_fpregs().  And unexport
the entire bunch, while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/elf.h     |  6 ------
 arch/alpha/kernel/process.c      |  8 +++-----
 arch/csky/kernel/process.c       |  3 +--
 arch/m68k/kernel/process.c       |  3 +--
 arch/microblaze/kernel/process.c |  2 +-
 arch/um/kernel/process.c         |  2 +-
 arch/x86/um/asm/elf.h            |  4 ----
 fs/binfmt_elf.c                  |  5 ++---
 include/linux/elfcore.h          | 11 +----------
 9 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
index 8049997fa372..e6da23f1da83 100644
--- a/arch/alpha/include/asm/elf.h
+++ b/arch/alpha/include/asm/elf.h
@@ -120,12 +120,6 @@ extern int dump_elf_task(elf_greg_t *dest, struct task_struct *task);
 #define ELF_CORE_COPY_TASK_REGS(TASK, DEST) \
 	dump_elf_task(*(DEST), TASK)
 
-/* Similar, but for the FP registers.  */
-
-extern int dump_elf_task_fp(elf_fpreg_t *dest, struct task_struct *task);
-#define ELF_CORE_COPY_FPREGS(TASK, DEST) \
-	dump_elf_task_fp(*(DEST), TASK)
-
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports.  This is trivial on Alpha, 
    but not so on other machines. */
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index dbf1bc5e2ad2..65fdae9e48f3 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -333,14 +333,12 @@ dump_elf_task(elf_greg_t *dest, struct task_struct *task)
 }
 EXPORT_SYMBOL(dump_elf_task);
 
-int
-dump_elf_task_fp(elf_fpreg_t *dest, struct task_struct *task)
+int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
-	struct switch_stack *sw = (struct switch_stack *)task_pt_regs(task) - 1;
-	memcpy(dest, sw->fp, 32 * 8);
+	struct switch_stack *sw = (struct switch_stack *)task_pt_regs(t) - 1;
+	memcpy(fpu, sw->fp, 32 * 8);
 	return 1;
 }
-EXPORT_SYMBOL(dump_elf_task_fp);
 
 /*
  * Return saved PC of a blocked thread.  This assumes the frame
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index eedddb155669..99767587db17 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -69,12 +69,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 }
 
 /* Fill in the fpu structure for a core dump.  */
-int dump_fpu(struct pt_regs *regs, struct user_fp *fpu)
+int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	memcpy(fpu, &current->thread.user_fp, sizeof(*fpu));
 	return 1;
 }
-EXPORT_SYMBOL(dump_fpu);
 
 int dump_task_regs(struct task_struct *tsk, elf_gregset_t *pr_regs)
 {
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 2cb4a61bcfac..38ea940bccea 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -213,7 +213,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 }
 
 /* Fill in the fpu structure for a core dump.  */
-int dump_fpu (struct pt_regs *regs, struct user_m68kfp_struct *fpu)
+int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	if (FPU_IS_EMU) {
 		int i;
@@ -262,7 +262,6 @@ int dump_fpu (struct pt_regs *regs, struct user_m68kfp_struct *fpu)
 
 	return 1;
 }
-EXPORT_SYMBOL(dump_fpu);
 
 unsigned long __get_wchan(struct task_struct *p)
 {
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 3c6241bcaea8..1f802aab2b96 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -133,7 +133,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long usp)
 /*
  * Set up a thread for executing a new program
  */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
+int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	return 0; /* MicroBlaze has no separate FPU registers */
 }
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 010bc422a09d..8058f2ccca67 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -393,7 +393,7 @@ unsigned long __get_wchan(struct task_struct *p)
 	return 0;
 }
 
-int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
+int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
 
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index dcaf3b38a9e0..6523eb7c3bd1 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -201,10 +201,6 @@ typedef struct user_i387_struct elf_fpregset_t;
 
 struct task_struct;
 
-extern int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
-
-#define ELF_CORE_COPY_FPREGS(t, fpu) elf_core_copy_fpregs(t, fpu)
-
 #define ELF_EXEC_PAGESIZE 4096
 
 #define ELF_ET_DYN_BASE (TASK_SIZE / 3 * 2)
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e990075fb43d..c3c5bd48361e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2001,8 +2001,7 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 	t->num_notes++;
 	sz += notesize(&t->notes[0]);
 
-	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL,
-								&t->fpu))) {
+	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, &t->fpu))) {
 		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
 			  &(t->fpu));
 		t->num_notes++;
@@ -2100,7 +2099,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 
 	/* Try to dump the FPU. */
 	info->prstatus->pr_fpvalid =
-		elf_core_copy_task_fpregs(current, task_pt_regs(current), info->fpu);
+		elf_core_copy_task_fpregs(current, info->fpu);
 	if (info->prstatus->pr_fpvalid)
 		fill_note(info->notes + info->numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*info->fpu), info->fpu);
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index fcf58e16d1e3..9ec81290e3c8 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -94,16 +94,7 @@ static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t*
 	return 0;
 }
 
-extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
-
-static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_regs *regs, elf_fpregset_t *fpu)
-{
-#ifdef ELF_CORE_COPY_FPREGS
-	return ELF_CORE_COPY_FPREGS(t, fpu);
-#else
-	return dump_fpu(regs, fpu);
-#endif
-}
+int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
 
 #ifdef CONFIG_ARCH_BINFMT_ELF_EXTRA_PHDRS
 /*
-- 
2.30.2

