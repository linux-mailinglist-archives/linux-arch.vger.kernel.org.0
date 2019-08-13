Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABA78C2A3
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfHMVDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:03:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:16076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfHMVDF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901511"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:03:03 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
Date:   Tue, 13 Aug 2019 13:52:20 -0700
Message-Id: <20190813205225.12032-23-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates features the executable file
can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
GNU_PROPERTY_X86_FEATURE_1_SHSTK.

With this patch, if an arch needs to setup features from ELF properties,
it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and specific
arch_parse_property() and arch_setup_property().

For example, for X86_64:

int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
{
	int r;
	uint32_t property;

	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
			     &property);
	...
}

This patch is derived from code provided by H.J. Lu <hjl.tools@gmail.com>.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 fs/Kconfig.binfmt        |   3 +
 fs/Makefile              |   1 +
 fs/binfmt_elf.c          |  20 +++++
 fs/gnu_property.c        | 178 +++++++++++++++++++++++++++++++++++++++
 include/linux/elf.h      |  11 +++
 include/uapi/linux/elf.h |  14 +++
 6 files changed, 227 insertions(+)
 create mode 100644 fs/gnu_property.c

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..d2cfe0729a73 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
 config ARCH_BINFMT_ELF_STATE
 	bool
 
+config ARCH_USE_GNU_PROPERTY
+	bool
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
diff --git a/fs/Makefile b/fs/Makefile
index d60089fd689b..939b1eb7e8cc 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
+obj-$(CONFIG_ARCH_USE_GNU_PROPERTY) += gnu_property.o
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d4e11b2e04f6..a4e87fcb10a8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -852,6 +852,21 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 	}
 
+	if (interpreter) {
+		retval = arch_parse_property(&loc->interp_elf_ex,
+					     interp_elf_phdata,
+					     interpreter, true,
+					     &arch_state);
+	} else {
+		retval = arch_parse_property(&loc->elf_ex,
+					     elf_phdata,
+					     bprm->file, false,
+					     &arch_state);
+	}
+
+	if (retval)
+		goto out_free_dentry;
+
 	/*
 	 * Allow arch code to reject the ELF at this point, whilst it's
 	 * still possible to return an error to the code that invoked
@@ -1080,6 +1095,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_dentry;
 	}
 
+	retval = arch_setup_property(&arch_state);
+
+	if (retval < 0)
+		goto out_free_dentry;
+
 	if (interpreter) {
 		unsigned long interp_map_addr = 0;
 
diff --git a/fs/gnu_property.c b/fs/gnu_property.c
new file mode 100644
index 000000000000..b22b43f4d6a0
--- /dev/null
+++ b/fs/gnu_property.c
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Extract an ELF file's .note.gnu.property.
+ *
+ * The path from the ELF header to .note.gnu.property is:
+ *	elfhdr->elf_phdr->elf_note.
+ *
+ * .note.gnu.property layout:
+ *
+ *	struct elf_note {
+ *		u32 n_namesz; --> sizeof(n_name[]); always (4)
+ *		u32 n_ndescsz;--> sizeof(property[])
+ *		u32 n_type;   --> always NT_GNU_PROPERTY_TYPE_0 (5)
+ *	};
+ *	char n_name[4]; --> always 'GNU\0'
+ *
+ *	struct {
+ *		struct gnu_property {
+ *			u32 pr_type;
+ *			u32 pr_datasz;
+ *		};
+ *		u8 pr_data[pr_datasz];
+ *	}[];
+ */
+
+#include <linux/elf.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/compat.h>
+
+/*
+ * Search a note's payload for 'pr_type'.
+ */
+static int check_note_payload(void *buf, unsigned long len, u32 pr_type,
+			      u32 *property)
+{
+	u32 pr_type_max = 0;
+
+	*property = 0;
+
+	while (len > 0) {
+		struct gnu_property *pr = buf;
+		unsigned long pr_len;
+
+		if (sizeof(*pr) > len)
+			return 0;
+
+		pr_len = sizeof(*pr) + pr->pr_datasz;
+
+		if (pr_len > len)
+			return -ENOEXEC;
+
+		/* property types are in ascending order */
+		if ((pr_type_max != 0) && (pr->pr_type > pr_type_max))
+			return 0;
+
+		if (pr->pr_type > pr_type)
+			return 0;
+
+		if ((pr->pr_type == pr_type) &&
+		    (pr->pr_datasz >= sizeof(u32))) {
+			*property = *(u32 *)(buf + sizeof(*pr));
+			return 0;
+		}
+
+		if (pr->pr_type > pr_type_max)
+			pr_type_max = pr->pr_type;
+
+		buf += pr_len;
+		len -= pr_len;
+	}
+
+	return 0;
+}
+
+/*
+ * Look at an ELF file's NT_GNU_PROPERTY for the property of pr_type.
+ *
+ * Input:
+ *	buf: the buffer containing the whole note.
+ *	len: size of buf.
+ *	align: alignment of the note's payload.
+ *	pr_type: the property type.
+ *
+ * Output:
+ *	The property found.
+ *
+ * Return:
+ *	Zero or error.
+ */
+static int check_note(void *buf, unsigned long len, int align,
+			  u32 pr_type, u32 *property)
+{
+	struct elf_note *n = buf;
+	char *note_name = buf + sizeof(*n);
+	unsigned long payload_offset;
+	unsigned long payload_len;
+
+	if (len < sizeof(*n) + 4)
+		return -ENOEXEC;
+
+	if ((n->n_namesz != 4) || strncmp("GNU", note_name, 3))
+		return -ENOEXEC;
+
+	payload_offset = round_up(sizeof(*n) + n->n_namesz, align);
+	payload_len = n->n_descsz;
+
+	if (payload_offset + payload_len > len)
+		return -ENOEXEC;
+
+	buf += payload_offset;
+	len -= payload_offset;
+
+	return check_note_payload(buf, len, pr_type, property);
+}
+
+#define find_note(phdr, nr_phdrs, align, pos, len) { \
+	int cnt; \
+	\
+	for (cnt = 0; cnt < nr_phdrs; cnt++) { \
+		if ((phdr)[cnt].p_align != align) \
+			continue; \
+		if ((phdr)[cnt].p_type == PT_GNU_PROPERTY) { \
+			pos = (phdr)[cnt].p_offset; \
+			len = (phdr)[cnt].p_filesz; \
+		} \
+	} \
+}
+
+int get_gnu_property(void *ehdr, void *phdr, struct file *file,
+		     u32 pr_type, u32 *property)
+{
+	Elf64_Ehdr *ehdr64 = ehdr;
+	Elf32_Ehdr *ehdr32 = ehdr;
+	void *buf;
+	int align;
+	loff_t pos = 0;
+	unsigned long len = 0;
+	int err = 0;
+
+	/*
+	 * Find PT_GNU_PROPERTY from ELF program headers.
+	 */
+	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {
+		align = 8;
+		find_note((Elf64_Phdr *)phdr, ehdr64->e_phnum, align, pos, len);
+	} else if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
+		align = 4;
+		find_note((Elf32_Phdr *)phdr, ehdr32->e_phnum, align, pos, len);
+	}
+
+	/*
+	 * Read in the whole note.  PT_GNU_PROPERTY
+	 * is not expected to be larger than a page.
+	 */
+	if (len == 0)
+		return 0;
+
+	if (len > PAGE_SIZE)
+		return -ENOEXEC;
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	err = kernel_read(file, buf, len, &pos);
+	if (err < len) {
+		if (err >= 0)
+			err = -EIO;
+		goto out;
+	}
+
+	err = check_note(buf, len, align, pr_type, property);
+out:
+	kfree(buf);
+	return err;
+}
diff --git a/include/linux/elf.h b/include/linux/elf.h
index e3649b3e970e..c86cbfd17382 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -56,4 +56,15 @@ static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) {
 extern int elf_coredump_extra_notes_size(void);
 extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
 #endif
+
+#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
+extern int arch_parse_property(void *ehdr, void *phdr, struct file *f,
+			       bool inter, struct arch_elf_state *state);
+extern int arch_setup_property(struct arch_elf_state *state);
+extern int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
+			    u32 pr_type, u32 *feature);
+#else
+#define arch_parse_property(ehdr, phdr, file, inter, state) (0)
+#define arch_setup_property(state) (0)
+#endif
 #endif /* _LINUX_ELF_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4290fe..530ce08467c2 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -36,6 +36,7 @@ typedef __s64	Elf64_Sxword;
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
+#define PT_GNU_PROPERTY		0x6474e553
 
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 
@@ -443,4 +444,17 @@ typedef struct elf64_note {
   Elf64_Word n_type;	/* Content type */
 } Elf64_Nhdr;
 
+/* NT_GNU_PROPERTY_TYPE_0 header */
+struct gnu_property {
+  __u32 pr_type;
+  __u32 pr_datasz;
+};
+
+/* .note.gnu.property types */
+#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
+
+/* Bits of GNU_PROPERTY_X86_FEATURE_1_AND */
+#define GNU_PROPERTY_X86_FEATURE_1_IBT		0x00000001
+#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	0x00000002
+
 #endif /* _UAPI_LINUX_ELF_H */
-- 
2.17.1

