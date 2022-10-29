Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9846E61266F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJ2XTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJ2XSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2142F020;
        Sat, 29 Oct 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xI+3eNRMEcjT5yLalmW9Eq0QkXwupoDkPKtfFg3luGc=; b=gKFfTYlU51KF5YtQEtQ0dEFQTA
        +xcas8ghNfqRamQ2+3u17/YMNNAlTFxK6D9ZF4w3eLrf0UR+/447ZYCfj5Tqfq3IAU9JTApjr5DyJ
        fedu4EN+Zcgy940D/yJry5yEIG6NZt+LTIv7HolMtvScKay/B7hTV9EzAUpejFaOfg2VqAIV6DbHq
        1041LPD1JJEsZwpJm2DB+2XJGNaBqinqHQzGNH2Yh0JOlMj83/p/ocXnWYw29S7qRd/o1lJ+tvrMs
        9QdJnGL/jYl7YU5MkIT+0QnPpfNDgJqUKLZomEesRy1sNdP6owaBM+DXcp//swhi/JzagI0Q19J9x
        HIKkieoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6K-00FOL4-1b;
        Sat, 29 Oct 2022 23:18:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] [elf] unify regset and non-regset cases
Date:   Sun, 30 Oct 2022 00:18:49 +0100
Message-Id: <20221029231850.3668437-9-viro@zeniv.linux.org.uk>
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

The only real difference is in filling per-thread notes - getting
the values of registers.   And this is the only part that is worth
an ifdef - we don't need to duplicate the logics regarding gathering
threads, filling other notes, etc.

It would've been hard to do back when regset-based variant had been
introduced, mostly due to sharing bits and pieces of helpers with
aout coredumps.  As the result, too much had been duplicated and
the copies had drifted away since then.  Now it can be done cleanly...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c | 230 ++++++++----------------------------------------
 1 file changed, 38 insertions(+), 192 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index cb95e842c50f..3758a617c9d8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1723,7 +1723,6 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 	return 0;
 }
 
-#ifdef CORE_DUMP_USE_REGSET
 #include <linux/regset.h>
 
 struct elf_thread_core_info {
@@ -1744,6 +1743,7 @@ struct elf_note_info {
 	int thread_notes;
 };
 
+#ifdef CORE_DUMP_USE_REGSET
 /*
  * When a regset has a writeback hook, we call it on each thread before
  * dumping user memory.  On register window machines, this makes sure the
@@ -1823,13 +1823,41 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 
 	return 1;
 }
+#else
+static int fill_thread_core_info(struct elf_thread_core_info *t,
+				 const struct user_regset_view *view,
+				 long signr, struct elf_note_info *info)
+{
+	struct task_struct *p = t->task;
+	elf_fpregset_t *fpu;
+
+	fill_prstatus(&t->prstatus.common, p, signr);
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
+	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+		  &(t->prstatus));
+	info->size += notesize(&t->notes[0]);
+
+	fpu = kzalloc(sizeof(elf_fpregset_t), GFP_KERNEL);
+	if (!fpu || !elf_core_copy_task_fpregs(p, fpu)) {
+		kfree(fpu);
+		return 1;
+	}
+
+	t->prstatus.pr_fpvalid = 1;
+	fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
+	info->size += notesize(&t->notes[1]);
+
+	return 1;
+}
+#endif
 
 static int fill_note_info(struct elfhdr *elf, int phdrs,
 			  struct elf_note_info *info,
 			  struct coredump_params *cprm)
 {
 	struct task_struct *dump_task = current;
-	const struct user_regset_view *view = task_user_regset_view(dump_task);
+	const struct user_regset_view *view;
 	struct elf_thread_core_info *t;
 	struct elf_prpsinfo *psinfo;
 	struct core_thread *ct;
@@ -1839,6 +1867,9 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		return 0;
 	fill_note(&info->psinfo, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 
+#ifdef CORE_DUMP_USE_REGSET
+	view = task_user_regset_view(dump_task);
+
 	/*
 	 * Figure out how many notes we're going to need for each thread.
 	 */
@@ -1862,6 +1893,11 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	 */
 	fill_elf_header(elf, phdrs,
 			view->e_machine, view->e_flags);
+#else
+	view = NULL;
+	info->thread_notes = 2;
+	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
+#endif
 
 	/*
 	 * Allocate a structure for each thread.
@@ -1969,196 +2005,6 @@ static void free_note_info(struct elf_note_info *info)
 	kvfree(info->files.data);
 }
 
-#else
-
-/* Here is the structure in which status of each thread is captured. */
-struct elf_thread_status
-{
-	struct list_head list;
-	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
-	elf_fpregset_t fpu;		/* NT_PRFPREG */
-	struct task_struct *thread;
-	struct memelfnote notes[3];
-	int num_notes;
-};
-
-/*
- * In order to add the specific thread information for the elf file format,
- * we need to keep a linked list of every threads pr_status and then create
- * a single section for them in the final core file.
- */
-static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
-{
-	int sz = 0;
-	struct task_struct *p = t->thread;
-	t->num_notes = 0;
-
-	fill_prstatus(&t->prstatus.common, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
-	
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
-		  &(t->prstatus));
-	t->num_notes++;
-	sz += notesize(&t->notes[0]);
-
-	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, &t->fpu))) {
-		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
-			  &(t->fpu));
-		t->num_notes++;
-		sz += notesize(&t->notes[1]);
-	}
-	return sz;
-}
-
-struct elf_note_info {
-	struct memelfnote *notes;
-	struct memelfnote *notes_files;
-	struct elf_prstatus *prstatus;	/* NT_PRSTATUS */
-	struct elf_prpsinfo *psinfo;	/* NT_PRPSINFO */
-	struct list_head thread_list;
-	elf_fpregset_t *fpu;
-	user_siginfo_t csigdata;
-	int thread_status_size;
-	int numnote;
-};
-
-static int elf_note_info_init(struct elf_note_info *info)
-{
-	memset(info, 0, sizeof(*info));
-	INIT_LIST_HEAD(&info->thread_list);
-
-	/* Allocate space for ELF notes */
-	info->notes = kmalloc_array(8, sizeof(struct memelfnote), GFP_KERNEL);
-	if (!info->notes)
-		return 0;
-	info->psinfo = kmalloc(sizeof(*info->psinfo), GFP_KERNEL);
-	if (!info->psinfo)
-		return 0;
-	info->prstatus = kmalloc(sizeof(*info->prstatus), GFP_KERNEL);
-	if (!info->prstatus)
-		return 0;
-	info->fpu = kmalloc(sizeof(*info->fpu), GFP_KERNEL);
-	if (!info->fpu)
-		return 0;
-	return 1;
-}
-
-static int fill_note_info(struct elfhdr *elf, int phdrs,
-			  struct elf_note_info *info,
-			  struct coredump_params *cprm)
-{
-	struct core_thread *ct;
-	struct elf_thread_status *ets;
-
-	if (!elf_note_info_init(info))
-		return 0;
-
-	for (ct = current->signal->core_state->dumper.next;
-					ct; ct = ct->next) {
-		ets = kzalloc(sizeof(*ets), GFP_KERNEL);
-		if (!ets)
-			return 0;
-
-		ets->thread = ct->task;
-		list_add(&ets->list, &info->thread_list);
-	}
-
-	list_for_each_entry(ets, &info->thread_list, list) {
-		int sz;
-
-		sz = elf_dump_thread_status(cprm->siginfo->si_signo, ets);
-		info->thread_status_size += sz;
-	}
-	/* now collect the dump for the current */
-	memset(info->prstatus, 0, sizeof(*info->prstatus));
-	fill_prstatus(&info->prstatus->common, current, cprm->siginfo->si_signo);
-	elf_core_copy_task_regs(current, &info->prstatus->pr_reg);
-
-	/* Set up header */
-	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
-
-	/*
-	 * Set up the notes in similar form to SVR4 core dumps made
-	 * with info from their /proc.
-	 */
-
-	fill_note(info->notes + 0, "CORE", NT_PRSTATUS,
-		  sizeof(*info->prstatus), info->prstatus);
-	fill_psinfo(info->psinfo, current->group_leader, current->mm);
-	fill_note(info->notes + 1, "CORE", NT_PRPSINFO,
-		  sizeof(*info->psinfo), info->psinfo);
-
-	fill_siginfo_note(info->notes + 2, &info->csigdata, cprm->siginfo);
-	fill_auxv_note(info->notes + 3, current->mm);
-	info->numnote = 4;
-
-	if (fill_files_note(info->notes + info->numnote, cprm) == 0) {
-		info->notes_files = info->notes + info->numnote;
-		info->numnote++;
-	}
-
-	/* Try to dump the FPU. */
-	info->prstatus->pr_fpvalid =
-		elf_core_copy_task_fpregs(current, info->fpu);
-	if (info->prstatus->pr_fpvalid)
-		fill_note(info->notes + info->numnote++,
-			  "CORE", NT_PRFPREG, sizeof(*info->fpu), info->fpu);
-	return 1;
-}
-
-static size_t get_note_info_size(struct elf_note_info *info)
-{
-	int sz = 0;
-	int i;
-
-	for (i = 0; i < info->numnote; i++)
-		sz += notesize(info->notes + i);
-
-	sz += info->thread_status_size;
-
-	return sz;
-}
-
-static int write_note_info(struct elf_note_info *info,
-			   struct coredump_params *cprm)
-{
-	struct elf_thread_status *ets;
-	int i;
-
-	for (i = 0; i < info->numnote; i++)
-		if (!writenote(info->notes + i, cprm))
-			return 0;
-
-	/* write out the thread status notes section */
-	list_for_each_entry(ets, &info->thread_list, list) {
-		for (i = 0; i < ets->num_notes; i++)
-			if (!writenote(&ets->notes[i], cprm))
-				return 0;
-	}
-
-	return 1;
-}
-
-static void free_note_info(struct elf_note_info *info)
-{
-	while (!list_empty(&info->thread_list)) {
-		struct list_head *tmp = info->thread_list.next;
-		list_del(tmp);
-		kfree(list_entry(tmp, struct elf_thread_status, list));
-	}
-
-	/* Free data possibly allocated by fill_files_note(): */
-	if (info->notes_files)
-		kvfree(info->notes_files->data);
-
-	kfree(info->prstatus);
-	kfree(info->psinfo);
-	kfree(info->notes);
-	kfree(info->fpu);
-}
-
-#endif
-
 static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 			     elf_addr_t e_shoff, int segs)
 {
-- 
2.30.2

