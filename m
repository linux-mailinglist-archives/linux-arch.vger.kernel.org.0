Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BF9B567
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389440AbfHWRYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 13:24:34 -0400
Received: from foss.arm.com ([217.140.110.172]:37614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389289AbfHWRY3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 13:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB43C1570;
        Fri, 23 Aug 2019 10:24:28 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 720F33F246;
        Fri, 23 Aug 2019 10:24:27 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Date:   Fri, 23 Aug 2019 18:23:40 +0100
Message-Id: <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ELF program properties will needed for detecting whether to enable
optional architecture or ABI features for a new ELF process.

For now, there are no generic properties that we care about, so do
nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.

Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
phdrs entry (if any), and notify each property to the arch code.

For now, the added code is not used.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v1:

 * Fix stupid typo in IS_ENABLED().

 * Fix premature dereference of possibly-NULL phdr in
   parse_elf_properties().

 * Demote BUG_ON() to WARN_ON(), and add comments to explain why they
   should never fire.

   These are only for development and should probably go away before
   merge.

 * Enforce that there are no duplicate properties and that the
   properties are sorted on pr_type.

   This is not strictly necessary for kernel safety or for correct
   handling of valid ELF files, but may help flag up binaries from duff
   linkers which we would otherwise silently execute.

 * Shuffle parse_elf_properties() logic to move as many checks as
   possible into parse_elf_property().  This keeps most checks in the
   same function as the code that relies on them, and simplifies the
   outer parsing loop.

   parse_elf_properties's cursor is now just a byte offset into the
   note, which makes comparisons more straightfward and reduces the
   amount of pointer casting a bit.
---
 fs/binfmt_elf.c          | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c   |   4 ++
 include/linux/elf.h      |  19 ++++++++
 include/uapi/linux/elf.h |   4 ++
 4 files changed, 151 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d4e11b2..d6541e8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -39,12 +39,18 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
 #include <linux/cred.h>
 #include <linux/dax.h>
 #include <linux/uaccess.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
+#ifndef ELF_COMPAT
+#define ELF_COMPAT 0
+#endif
+
 #ifndef user_long_t
 #define user_long_t long
 #endif
@@ -690,6 +696,108 @@ static unsigned long randomize_stack_top(unsigned long stack_top)
 #endif
 }
 
+static int parse_elf_property(const char *data, size_t *off, size_t datasz,
+			      struct arch_elf_state *arch,
+			      bool have_prev_type, u32 *prev_type)
+{
+	size_t size, step;
+	const struct gnu_property *pr;
+	int ret;
+
+	if (*off == datasz)
+		return -ENOENT;
+
+	if (WARN_ON(*off > datasz || *off % elf_gnu_property_align))
+		return -EIO;
+
+	size = datasz - *off;
+	if (size < sizeof(*pr))
+		return -EIO;
+
+	pr = (const struct gnu_property *)(data + *off);
+	if (pr->pr_datasz > size - sizeof(*pr))
+		return -EIO;
+
+	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
+	if (step > size)
+		return -EIO;
+
+	/* Properties are supposed to be unique and sorted on pr_type: */
+	if (have_prev_type && pr->pr_type <= *prev_type)
+		return -EIO;
+	*prev_type = pr->pr_type;
+
+	ret = arch_parse_elf_property(pr->pr_type,
+				      data + *off + sizeof(*pr),
+				      pr->pr_datasz, ELF_COMPAT, arch);
+	if (ret)
+		return ret;
+
+	*off += step;
+	return 0;
+}
+
+#define NOTE_DATA_SZ SZ_1K
+#define GNU_PROPERTY_TYPE_0_NAME "GNU"
+#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
+
+static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
+				struct arch_elf_state *arch)
+{
+	union {
+		struct elf_note nhdr;
+		char data[NOTE_DATA_SZ];
+	} note;
+	loff_t pos;
+	ssize_t n;
+	size_t off, datasz;
+	int ret;
+	bool have_prev_type;
+	u32 prev_type;
+
+	if (!IS_ENABLED(CONFIG_ARCH_USE_GNU_PROPERTY) || !phdr)
+		return 0;
+
+	/* load_elf_binary() shouldn't call us unless this is true... */
+	if (WARN_ON(phdr->p_type != PT_GNU_PROPERTY))
+		return -EIO;
+
+	/* If the properties are crazy large, that's too bad (for now): */
+	if (phdr->p_filesz > sizeof(note))
+		return -ENOEXEC;
+
+	pos = phdr->p_offset;
+	n = kernel_read(f, &note, phdr->p_filesz, &pos);
+
+	BUILD_BUG_ON(sizeof(note) < sizeof(note.nhdr) + NOTE_NAME_SZ);
+	if (n < 0 || n < sizeof(note.nhdr) + NOTE_NAME_SZ)
+		return -EIO;
+
+	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
+	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
+	    strncmp(note.data + sizeof(note.nhdr),
+		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
+		return -EIO;
+
+	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
+		       elf_gnu_property_align);
+	if (off > n)
+		return -EIO;
+
+	if (note.nhdr.n_descsz > n - off)
+		return -EIO;
+	datasz = off + note.nhdr.n_descsz;
+
+	have_prev_type = false;
+	do {
+		ret = parse_elf_property(note.data, &off, datasz, arch,
+					 have_prev_type, &prev_type);
+		have_prev_type = true;
+	} while (!ret);
+
+	return ret == -ENOENT ? 0 : ret;
+}
+
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
@@ -697,6 +805,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	int load_addr_set = 0;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
+	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -744,6 +853,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		char *elf_interpreter;
 		loff_t pos;
 
+		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
+			elf_property_phdata = elf_ppnt;
+			continue;
+		}
+
 		if (elf_ppnt->p_type != PT_INTERP)
 			continue;
 
@@ -839,9 +953,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			goto out_free_dentry;
 
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
+		elf_property_phdata = NULL;
 		elf_ppnt = interp_elf_phdata;
 		for (i = 0; i < loc->interp_elf_ex.e_phnum; i++, elf_ppnt++)
 			switch (elf_ppnt->p_type) {
+			case PT_GNU_PROPERTY:
+				elf_property_phdata = elf_ppnt;
+				break;
+
 			case PT_LOPROC ... PT_HIPROC:
 				retval = arch_elf_pt_proc(&loc->interp_elf_ex,
 							  elf_ppnt, interpreter,
@@ -852,6 +971,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 	}
 
+	retval = parse_elf_properties(interpreter ?: bprm->file,
+				      elf_property_phdata, &arch_state);
+	if (retval)
+		goto out_free_dentry;
+
 	/*
 	 * Allow arch code to reject the ELF at this point, whilst it's
 	 * still possible to return an error to the code that invoked
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index b7f9ffa..f9ee476 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -17,6 +17,8 @@
 #include <linux/elfcore-compat.h>
 #include <linux/time.h>
 
+#define ELF_COMPAT	1
+
 /*
  * Rename the basic ELF layout types to refer to the 32-bit class of files.
  */
@@ -28,11 +30,13 @@
 #undef	elf_shdr
 #undef	elf_note
 #undef	elf_addr_t
+#undef	elf_gnu_property_align
 #define elfhdr		elf32_hdr
 #define elf_phdr	elf32_phdr
 #define elf_shdr	elf32_shdr
 #define elf_note	elf32_note
 #define elf_addr_t	Elf32_Addr
+#define elf_gnu_property_align	elf32_gnu_property_align
 
 /*
  * Some data types as stored in coredump.
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 4485499..d9779c0 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -22,6 +22,9 @@
 	SET_PERSONALITY(ex)
 #endif
 
+#define elf32_gnu_property_align	4
+#define elf64_gnu_property_align	8
+
 #if ELF_CLASS == ELFCLASS32
 
 extern Elf32_Dyn _DYNAMIC [];
@@ -32,6 +35,7 @@ extern Elf32_Dyn _DYNAMIC [];
 #define elf_addr_t	Elf32_Off
 #define Elf_Half	Elf32_Half
 #define Elf_Word	Elf32_Word
+#define elf_gnu_property_align	elf32_gnu_property_align
 
 #else
 
@@ -43,6 +47,7 @@ extern Elf64_Dyn _DYNAMIC [];
 #define elf_addr_t	Elf64_Off
 #define Elf_Half	Elf64_Half
 #define Elf_Word	Elf64_Word
+#define elf_gnu_property_align	elf64_gnu_property_align
 
 #endif
 
@@ -64,4 +69,18 @@ struct gnu_property {
   __u32 pr_datasz;
 };
 
+struct arch_elf_state;
+
+#ifndef CONFIG_ARCH_USE_GNU_PROPERTY
+static inline int arch_parse_elf_property(u32 type, const void *data,
+					  size_t datasz, bool compat,
+					  struct arch_elf_state *arch)
+{
+	return 0;
+}
+#else
+extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
+				   bool compat, struct arch_elf_state *arch);
+#endif
+
 #endif /* _LINUX_ELF_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c377314..20900f4 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -368,6 +368,7 @@ typedef struct elf64_shdr {
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
+ * The note name for all these is "LINUX".
  */
 #define NT_PRSTATUS	1
 #define NT_PRFPREG	2
@@ -430,6 +431,9 @@ typedef struct elf64_shdr {
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
 
+/* Note types with note name "GNU" */
+#define NT_GNU_PROPERTY_TYPE_0	5
+
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
   Elf32_Word	n_namesz;	/* Name size */
-- 
2.1.4

