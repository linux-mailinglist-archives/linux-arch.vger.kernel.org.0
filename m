Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7801537A6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 19:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBESVK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 13:21:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:20934 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgBESUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="279447839"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2020 10:20:29 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 22/27] ELF: Add ELF program property parsing support
Date:   Wed,  5 Feb 2020 10:19:30 -0800
Message-Id: <20200205181935.3712-23-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

ELF program properties will be needed for detecting whether to
enable optional architecture or ABI features for a new ELF process.

For now, there are no generic properties that we care about, so do
nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.

Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
phdrs entry (if any), and notify each property to the arch code.

For now, the added code is not used.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 fs/binfmt_elf.c          | 127 +++++++++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c   |   4 ++
 include/linux/elf.h      |  19 ++++++
 include/uapi/linux/elf.h |   4 ++
 4 files changed, 154 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ecd8d2698515..054446f93442 100644
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
@@ -678,6 +684,111 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
  * libraries.  There is no binary dependent code anywhere else.
  */
 
+static int parse_elf_property(const char *data, size_t *off, size_t datasz,
+			      struct arch_elf_state *arch,
+			      bool have_prev_type, u32 *prev_type)
+{
+	size_t o, step;
+	const struct gnu_property *pr;
+	int ret;
+
+	if (*off == datasz)
+		return -ENOENT;
+
+	if (WARN_ON(*off > datasz || *off % ELF_GNU_PROPERTY_ALIGN))
+		return -EIO;
+	o = *off;
+	datasz -= *off;
+
+	if (datasz < sizeof(*pr))
+		return -EIO;
+	pr = (const struct gnu_property *)(data + o);
+	o += sizeof(*pr);
+	datasz -= sizeof(*pr);
+
+	if (pr->pr_datasz > datasz)
+		return -EIO;
+
+	WARN_ON(o % ELF_GNU_PROPERTY_ALIGN);
+	step = round_up(pr->pr_datasz, ELF_GNU_PROPERTY_ALIGN);
+	if (step > datasz)
+		return -EIO;
+
+	/* Properties are supposed to be unique and sorted on pr_type: */
+	if (have_prev_type && pr->pr_type <= *prev_type)
+		return -EIO;
+	*prev_type = pr->pr_type;
+
+	ret = arch_parse_elf_property(pr->pr_type, data + o,
+				      pr->pr_datasz, ELF_COMPAT, arch);
+	if (ret)
+		return ret;
+
+	*off = o + step;
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
+		       ELF_GNU_PROPERTY_ALIGN);
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
@@ -685,6 +796,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	int load_addr_set = 0;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
+	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -731,6 +843,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
 
+		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
+			elf_property_phdata = elf_ppnt;
+			continue;
+		}
+
 		if (elf_ppnt->p_type != PT_INTERP)
 			continue;
 
@@ -818,9 +935,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -831,6 +953,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
index aaad4ca1217e..13a087bc816b 100644
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
+#undef	ELF_GNU_PROPERTY_ALIGN
 #define elfhdr		elf32_hdr
 #define elf_phdr	elf32_phdr
 #define elf_shdr	elf32_shdr
 #define elf_note	elf32_note
 #define elf_addr_t	Elf32_Addr
+#define ELF_GNU_PROPERTY_ALIGN	ELF32_GNU_PROPERTY_ALIGN
 
 /*
  * Some data types as stored in coredump.
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 459cddcceaac..7bdc6da160c7 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -22,6 +22,9 @@
 	SET_PERSONALITY(ex)
 #endif
 
+#define ELF32_GNU_PROPERTY_ALIGN	4
+#define ELF64_GNU_PROPERTY_ALIGN	8
+
 #if ELF_CLASS == ELFCLASS32
 
 extern Elf32_Dyn _DYNAMIC [];
@@ -32,6 +35,7 @@ extern Elf32_Dyn _DYNAMIC [];
 #define elf_addr_t	Elf32_Off
 #define Elf_Half	Elf32_Half
 #define Elf_Word	Elf32_Word
+#define ELF_GNU_PROPERTY_ALIGN	ELF32_GNU_PROPERTY_ALIGN
 
 #else
 
@@ -43,6 +47,7 @@ extern Elf64_Dyn _DYNAMIC [];
 #define elf_addr_t	Elf64_Off
 #define Elf_Half	Elf64_Half
 #define Elf_Word	Elf64_Word
+#define ELF_GNU_PROPERTY_ALIGN	ELF64_GNU_PROPERTY_ALIGN
 
 #endif
 
@@ -64,4 +69,18 @@ struct gnu_property {
 	u32 pr_datasz;
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
index 61251ecabdd7..518651708d8f 100644
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
2.21.0

