Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F082DDAD99
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbfJQM5L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 08:57:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfJQM5K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 08:57:10 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhClw-1hqziJ1rz0-00eQ5y; Thu, 17 Oct 2019 14:56:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
Date:   Thu, 17 Oct 2019 14:56:37 +0200
Message-Id: <20191017125637.1041949-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Czm+j4Qx9u60fcIzRMo5dzW7C58j3QTyd5yhwT2ZMI2TPb2DoFQ
 h1hWeFV8d8WmSZiQEzOkyvJdNREKg3eRIy+j1vBXESh/tUUUCn1H1uaXxLfwzZxSn61OSBU
 NbZDei4/dYnB1a5v7+ufaMK/24NToAdLSqSK/DowMD/tVi7brDV6ZF1x1fJaJoR8BclFDsc
 dcrlR+ArOr+Izuk9YdJlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:exrxfkGhDxI=:QmYePaw7I/ZWwhaWX9Ptvt
 GIjoN1wJQsz9nXb6xX2O3Mru0plQWd6DqV7flgRBTqOqFQNZFtJ1dXkmSNe0QWMtBwUFD7zVr
 +KBCGnxUdb4sWmMIFXGh1eWyg2uYt3VD2xbXyFk9SauOPJDj5oKmWx5znu25fM7AU7J0lGR6D
 ZTZVfnmXGQro0S9HPRGpSs2tgAjyfaVv/Gt5dAJDPPqIwiFEHFpMmRyzU5s9BsXBAdUGDoKlI
 RkNKwQ/AhKg/ki1ItpZP8whG3+5WCqZYBvfVaCQxvHwSgBVVgVr9NjSOauspcLJnStAhYoafA
 uSC/njx0lOYid1ewWxgood4roMSICoFO3k1xmiAZRhb9mDjBi/WxX4JBgd2ub4/Wgb/8eHzFk
 Yx6G2f6GAkvR5Gr5DsCpgF/s+8HOYuLlyAtH0fl0DvD7uDgtwiL5QyKvflO87z5z4+ukc8UWe
 1+GfMPSWYntseAORadBmn1tgwEXQJBCmYLWeNiDGdLuvm3kWLR1Biu1B4vAEOLteHQzPTU9xL
 HjwzQPYM2ymieeOcBSP+Za/hzIbJHpkhV3P6rqDWgXC3mF/x/EiOigKxTqC+mGUPJzQEaJO6Y
 lnVlrZOb4FgWULc7lNywbP/C7kPOX82PdGfmSPAoSfg/563w8jvEBTiCe/nxSzA9jRjc+GL/5
 JoX0D232/nxA+a6CbERm+V9yJAzr/zBDUY+Q16Gb13FilVCkoHYHJHxPUWlRiypPcPNgp0r52
 su8iR2AyPr2J2/mkjIkNctTlINzwNo/yqBvpGSwVuUR4WvcGYplWjqP2zXExWuNTOfWLLDMgz
 mm6CjfA7RyKFlG/9MC1yJ1Z5QqC0oxiPXqp31C2yJ10sdM8V9M+Hgisau8hay8heTnAILYfbd
 V3lQp3IoKusr/8BzjvzA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Any variable intialized statically to a gnu89 compound literal
like

static struct foo x = (struct foo){};

causes a build failure in --std=gnu99 with gcc-4.9 or earlier.
Later gcc versions and clang accept it as an extension the
same was with --std=gnu89.

Change enough of the kernel to allow building a 'defconfig'
kernel on x86 and arm, by turning the compound literals into
struct initializers. As many compound literals are defined
in macros, that means we now need two versions of them --
one with the cast for use in assignments, and one without
the cast as a struct initializer.

A lot of this does make the code uglier, and more changes
are needed to fix the rest of the kernel, but this should
give an overview of what is still needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile                                      |  2 +-
 arch/x86/boot/compressed/acpi.c               |  4 +-
 arch/x86/entry/vsyscall/vsyscall_64.c         |  2 +-
 arch/x86/include/asm/pgtable_types.h          | 59 +++++++++++--------
 arch/x86/include/asm/processor.h              |  4 +-
 arch/x86/include/asm/uaccess.h                |  3 +-
 arch/x86/mm/pat_rbtree.c                      |  2 +-
 arch/x86/platform/efi/quirks.c                |  9 ++-
 block/partitions/efi.c                        |  4 +-
 drivers/acpi/numa.c                           |  2 +-
 drivers/firmware/efi/efi.c                    |  4 +-
 drivers/firmware/efi/libstub/fdt.c            |  2 +-
 drivers/firmware/efi/libstub/tpm.c            |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  2 +-
 drivers/input/mouse/elantech.c                | 22 +++----
 .../broadcom/brcm80211/brcmfmac/firmware.c    |  2 +-
 drivers/soc/tegra/pmc.c                       |  8 +--
 fs/proc/root.c                                |  2 +-
 include/linux/capability.h                    | 17 ++++--
 include/linux/cpumask.h                       |  8 +--
 include/linux/efi.h                           |  2 +-
 include/linux/futex.h                         |  2 +-
 include/linux/jump_label.h                    |  4 +-
 include/linux/nodemask.h                      | 20 ++++---
 include/linux/property.h                      | 10 ++--
 include/linux/rbtree.h                        |  7 ++-
 include/linux/rwlock.h                        |  2 +-
 include/linux/rwlock_types.h                  |  4 +-
 include/linux/sched/signal.h                  |  2 +-
 include/linux/spinlock.h                      |  2 +-
 include/linux/spinlock_types.h                |  4 +-
 include/linux/uidgid.h                        | 13 +++-
 include/uapi/linux/uuid.h                     |  8 ++-
 init/init_task.c                              |  4 +-
 kernel/audit.c                                |  2 +-
 kernel/capability.c                           |  2 +-
 kernel/cred.c                                 | 24 ++++----
 kernel/events/uprobes.c                       |  2 +-
 kernel/futex.c                                |  2 +-
 kernel/power/swap.c                           |  2 +-
 kernel/trace/trace_clock.c                    |  2 +-
 kernel/umh.c                                  |  4 +-
 kernel/user.c                                 |  6 +-
 mm/backing-dev.c                              |  2 +-
 mm/init-mm.c                                  |  2 +-
 mm/page_alloc.c                               |  2 +-
 mm/vmalloc.c                                  |  4 +-
 net/core/fib_rules.c                          |  4 +-
 net/rds/cong.c                                |  2 +-
 security/integrity/iint.c                     |  2 +-
 security/keys/process_keys.c                  |  2 +-
 51 files changed, 169 insertions(+), 141 deletions(-)

diff --git a/Makefile b/Makefile
index e7b2b44e0666..ec2d9e911ec6 100644
--- a/Makefile
+++ b/Makefile
@@ -459,7 +459,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Wno-format-security \
-		   -std=gnu89
+		   -std=gnu99
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 149795c369f2..dc57644f2aaa 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -79,9 +79,9 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
 			table = tbl->table;
 		}
 
-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
+		if (!(efi_guidcmp(guid, (guid_t)ACPI_TABLE_GUID)))
 			rsdp_addr = table;
-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
+		else if (!(efi_guidcmp(guid, (guid_t)ACPI_20_TABLE_GUID)))
 			return table;
 	}
 #endif
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 76e62bcb8d87..eecd6f066b17 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -308,7 +308,7 @@ static const struct vm_operations_struct gate_vma_ops = {
 static struct vm_area_struct gate_vma __ro_after_init = {
 	.vm_start	= VSYSCALL_ADDR,
 	.vm_end		= VSYSCALL_ADDR + PAGE_SIZE,
-	.vm_page_prot	= PAGE_READONLY_EXEC,
+	.vm_page_prot	= { __PAGE_READONLY_EXEC },
 	.vm_flags	= VM_READ | VM_EXEC,
 	.vm_ops		= &gate_vma_ops,
 };
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b5e49e6bac63..2544a73605cc 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -150,21 +150,28 @@ enum page_cache_mode {
 #define _PAGE_NOCACHE		(cachemode2protval(_PAGE_CACHE_MODE_UC))
 #define _PAGE_CACHE_WP		(cachemode2protval(_PAGE_CACHE_MODE_WP))
 
-#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | \
+#define __PAGE_NONE		(_PAGE_PROTNONE | _PAGE_ACCESSED)
+#define PAGE_NONE		__pgprot(__PAGE_NONE)
+#define __PAGE_SHARED		(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | \
 				 _PAGE_ACCESSED | _PAGE_NX)
+#define PAGE_SHARED		__pgprot(__PAGE_SHARED)
 
-#define PAGE_SHARED_EXEC	__pgprot(_PAGE_PRESENT | _PAGE_RW |	\
+#define __PAGE_SHARED_EXEC	(_PAGE_PRESENT | _PAGE_RW |	\
 					 _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_COPY_NOEXEC	__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
+#define PAGE_SHARED_EXEC	__pgprot(__PAGE_SHARED_EXEC)
+#define __PAGE_COPY_NOEXEC	(_PAGE_PRESENT | _PAGE_USER |	\
 					 _PAGE_ACCESSED | _PAGE_NX)
-#define PAGE_COPY_EXEC		__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
+#define __PAGE_COPY_EXEC	(_PAGE_PRESENT | _PAGE_USER |	\
 					 _PAGE_ACCESSED)
-#define PAGE_COPY		PAGE_COPY_NOEXEC
-#define PAGE_READONLY		__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
+#define PAGE_COPY_EXEC		__pgprot(__PAGE_COPY_EXEC)
+
+#define __PAGE_COPY		__PAGE_COPY_NOEXEC
+#define PAGE_COPY		__pgprot(__PAGE_COPY)
+#define __PAGE_READONLY		(_PAGE_PRESENT | _PAGE_USER |	\
 					 _PAGE_ACCESSED | _PAGE_NX)
-#define PAGE_READONLY_EXEC	__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
-					 _PAGE_ACCESSED)
+#define PAGE_READONLY		__pgprot(__PAGE_READONLY)
+#define __PAGE_READONLY_EXEC	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
+#define PAGE_READONLY_EXEC	__pgprot(__PAGE_READONLY_EXEC)
 
 #define __PAGE_KERNEL_EXEC						\
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_GLOBAL)
@@ -214,23 +221,23 @@ enum page_cache_mode {
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_EXEC
-#define __P101	PAGE_READONLY_EXEC
-#define __P110	PAGE_COPY_EXEC
-#define __P111	PAGE_COPY_EXEC
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_EXEC
-#define __S101	PAGE_READONLY_EXEC
-#define __S110	PAGE_SHARED_EXEC
-#define __S111	PAGE_SHARED_EXEC
+#define __P000	{__PAGE_NONE}
+#define __P001	{__PAGE_READONLY}
+#define __P010	{__PAGE_COPY}
+#define __P011	{__PAGE_COPY}
+#define __P100	{__PAGE_READONLY_EXEC}
+#define __P101	{__PAGE_READONLY_EXEC}
+#define __P110	{__PAGE_COPY_EXEC}
+#define __P111	{__PAGE_COPY_EXEC}
+
+#define __S000	{__PAGE_NONE}
+#define __S001	{__PAGE_READONLY}
+#define __S010	{__PAGE_SHARED}
+#define __S011	{__PAGE_SHARED}
+#define __S100	{__PAGE_READONLY_EXEC}
+#define __S101	{__PAGE_READONLY_EXEC}
+#define __S110	{__PAGE_SHARED_EXEC}
+#define __S111	{__PAGE_SHARED_EXEC}
 
 /*
  * early identity mapping  pte attrib macros.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6e0a3b43d027..0be68f3dbdf1 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -842,7 +842,7 @@ static inline void spin_lock_prefetch(const void *x)
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
 	.io_bitmap_ptr		= NULL,					  \
-	.addr_limit		= KERNEL_DS,				  \
+	.addr_limit		= {__KERNEL_ADDR_LIMIT},		  \
 }
 
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
@@ -887,7 +887,7 @@ static inline void spin_lock_prefetch(const void *x)
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
 #define INIT_THREAD  {						\
-	.addr_limit		= KERNEL_DS,			\
+	.addr_limit		= {__KERNEL_ADDR_LIMIT},	\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 61d93f062a36..30b0cc30847d 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -22,7 +22,8 @@
 
 #define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
 
-#define KERNEL_DS	MAKE_MM_SEG(-1UL)
+#define __KERNEL_ADDR_LIMIT (-1UL)
+#define KERNEL_DS	MAKE_MM_SEG(__KERNEL_ADDR_LIMIT)
 #define USER_DS 	MAKE_MM_SEG(TASK_SIZE_MAX)
 
 #define get_fs()	(current->thread.addr_limit)
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index 65ebe4b88f7c..70bcb2239728 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -34,7 +34,7 @@
  * memtype_lock protects the rbtree.
  */
 
-static struct rb_root memtype_rbroot = RB_ROOT;
+static struct rb_root memtype_rbroot = __RB_ROOT;
 
 static int is_node_overlap(struct memtype *node, u64 start, u64 end)
 {
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd679cea9..5c98747f7ef3 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -20,8 +20,7 @@
 
 #define EFI_MIN_RESERVE 5120
 
-#define EFI_DUMMY_GUID \
-	EFI_GUID(0x4424ac57, 0xbe4b, 0x47dd, 0x9e, 0x97, 0xed, 0x50, 0xf0, 0x9f, 0x92, 0xa9)
+static guid_t efi_dummy_guid = EFI_GUID(0x4424ac57, 0xbe4b, 0x47dd, 0x9e, 0x97, 0xed, 0x50, 0xf0, 0x9f, 0x92, 0xa9);
 
 #define QUARK_CSH_SIGNATURE		0x5f435348	/* _CSH */
 #define QUARK_SECURITY_HEADER_SIZE	0x400
@@ -107,7 +106,7 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
 void efi_delete_dummy_variable(void)
 {
 	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
-				     &EFI_DUMMY_GUID,
+				     &efi_dummy_guid,
 				     EFI_VARIABLE_NON_VOLATILE |
 				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
 				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
@@ -184,7 +183,7 @@ efi_status_t efi_query_variable_store(u32 attributes, unsigned long size,
 			return EFI_OUT_OF_RESOURCES;
 
 		status = efi.set_variable((efi_char16_t *)efi_dummy_name,
-					  &EFI_DUMMY_GUID,
+					  &efi_dummy_guid,
 					  EFI_VARIABLE_NON_VOLATILE |
 					  EFI_VARIABLE_BOOTSERVICE_ACCESS |
 					  EFI_VARIABLE_RUNTIME_ACCESS,
@@ -545,7 +544,7 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 
 		guid = ((efi_config_table_64_t *)p)->guid;
 
-		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
+		if (!efi_guidcmp(guid, (guid_t)SMBIOS_TABLE_GUID))
 			((efi_config_table_64_t *)p)->table = data->smbios;
 		p += sz;
 	}
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index db2fef7dfc47..8d9ab8403749 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -462,7 +462,7 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 static inline int
 is_pte_valid(const gpt_entry *pte, const u64 lastlba)
 {
-	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
+	if ((!efi_guidcmp(pte->partition_type_guid, (guid_t)NULL_GUID)) ||
 	    le64_to_cpu(pte->starting_lba) > lastlba         ||
 	    le64_to_cpu(pte->ending_lba)   > lastlba)
 		return 0;
@@ -704,7 +704,7 @@ int efi_partition(struct parsed_partitions *state)
 		put_partition(state, i+1, start * ssz, size * ssz);
 
 		/* If this is a RAID volume, tell md */
-		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
+		if (!efi_guidcmp(ptes[i].partition_type_guid, (guid_t)PARTITION_LINUX_RAID_GUID))
 			state->parts[i + 1].flags = ADDPART_FLAG_RAID;
 
 		info = &state->parts[i + 1].info;
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index eadbf90e65d1..80272352ebea 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -18,7 +18,7 @@
 #include <linux/nodemask.h>
 #include <linux/topology.h>
 
-static nodemask_t nodes_found_map = NODE_MASK_NONE;
+static nodemask_t nodes_found_map = __NODE_MASK_NONE;
 
 /* maps to convert between proximity domain and logical node ID */
 static int pxm_to_node_map[MAX_PXM_DOMAINS]
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8d3e778e988b..47cb499054d7 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -57,7 +57,7 @@ struct efi __read_mostly efi = {
 EXPORT_SYMBOL(efi);
 
 struct mm_struct efi_mm = {
-	.mm_rb			= RB_ROOT,
+	.mm_rb			= __RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
 	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
@@ -484,7 +484,7 @@ static __init int match_config_table(efi_guid_t *guid,
 	int i;
 
 	if (table_types) {
-		for (i = 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++) {
+		for (i = 0; efi_guidcmp(table_types[i].guid, (guid_t)NULL_GUID); i++) {
 			if (!efi_guidcmp(*guid, table_types[i].guid)) {
 				*(table_types[i].ptr) = table;
 				if (table_types[i].name)
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0bf0190917e0..adcf3c40240b 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -365,7 +365,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 {
 	void *fdt;
 
-	fdt = get_efi_config_table(sys_table, DEVICE_TREE_GUID);
+	fdt = get_efi_config_table(sys_table, (guid_t)DEVICE_TREE_GUID);
 
 	if (!fdt)
 		return NULL;
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index eb9af83e4d59..6bfe812c2ef8 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -141,7 +141,7 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 	 * final events structure, and if so how much space they take up
 	 */
 	final_events_table = get_efi_config_table(sys_table_arg,
-						LINUX_EFI_TPM_FINAL_LOG_GUID);
+						(guid_t)LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c7441fb8313e..d120202bd405 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -61,7 +61,7 @@ struct adreno_rev {
 };
 
 #define ADRENO_REV(core, major, minor, patchid) \
-	((struct adreno_rev){ core, major, minor, patchid })
+	{ core, major, minor, patchid }
 
 struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 04fe43440a3c..9625f9e0a4d1 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1792,36 +1792,36 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 
 	smbus_board.properties = i2c_props;
 
-	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-size-x",
+	i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("touchscreen-size-x",
 						   info->x_max + 1);
-	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-size-y",
+	i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("touchscreen-size-y",
 						   info->y_max + 1);
-	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-min-x",
+	i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("touchscreen-min-x",
 						   info->x_min);
-	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-min-y",
+	i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("touchscreen-min-y",
 						   info->y_min);
 	if (info->x_res)
-		i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-x-mm",
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("touchscreen-x-mm",
 						      (info->x_max + 1) / info->x_res);
 	if (info->y_res)
-		i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-y-mm",
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("touchscreen-y-mm",
 						      (info->y_max + 1) / info->y_res);
 
 	if (info->has_trackpoint)
-		i2c_props[idx++] = PROPERTY_ENTRY_BOOL("elan,trackpoint");
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_BOOL("elan,trackpoint");
 
 	if (info->has_middle_button)
-		i2c_props[idx++] = PROPERTY_ENTRY_BOOL("elan,middle-button");
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_BOOL("elan,middle-button");
 
 	if (info->x_traces)
-		i2c_props[idx++] = PROPERTY_ENTRY_U32("elan,x_traces",
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("elan,x_traces",
 						      info->x_traces);
 	if (info->y_traces)
-		i2c_props[idx++] = PROPERTY_ENTRY_U32("elan,y_traces",
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_U32("elan,y_traces",
 						      info->y_traces);
 
 	if (elantech_is_buttonpad(info))
-		i2c_props[idx++] = PROPERTY_ENTRY_BOOL("elan,clickpad");
+		i2c_props[idx++] = (struct property_entry)PROPERTY_ENTRY_BOOL("elan,clickpad");
 
 	return psmouse_smbus_init(psmouse, &smbus_board, NULL, 0, false,
 				  leave_breadcrumbs);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 3aed4c4b887a..97fef627c2fb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -472,7 +472,7 @@ static u8 *brcmf_fw_nvram_from_efi(size_t *data_len_ret)
 		return NULL;
 
 	memcpy(&nvram_efivar->var.VariableName, name, sizeof(name));
-	nvram_efivar->var.VendorGuid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61,
+	nvram_efivar->var.VendorGuid = (guid_t)EFI_GUID(0x74b00bd9, 0x805a, 0x4d61,
 						0xb5, 0x1f, 0x43, 0x26,
 						0x81, 0x23, 0xd1, 0x13);
 
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 9f9c1c677cf4..6f98a13c361b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2378,18 +2378,18 @@ static const u8 tegra124_cpu_powergates[] = {
 };
 
 #define TEGRA_IO_PAD(_id, _dpd, _voltage, _name)	\
-	((struct tegra_io_pad_soc) {			\
+	{						\
 		.id	= (_id),			\
 		.dpd	= (_dpd),			\
 		.voltage = (_voltage),			\
 		.name	= (_name),			\
-	})
+	}
 
 #define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
-	((struct pinctrl_pin_desc) {			\
+	{						\
 		.number = (_id),			\
 		.name	= (_name)			\
-	})
+	}
 
 #define TEGRA124_IO_PAD_TABLE(_pad)					\
 	/* .id                          .dpd    .voltage  .name	*/	\
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 0b7c8dffc9ae..8824414d8f7b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -294,7 +294,7 @@ struct proc_dir_entry proc_root = {
 	.proc_iops	= &proc_root_inode_operations, 
 	.proc_fops	= &proc_root_operations,
 	.parent		= &proc_root,
-	.subdir		= RB_ROOT,
+	.subdir		= __RB_ROOT,
 	.name		= "/proc",
 };
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index ecce0f43c73a..7e405382f0ee 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -82,14 +82,19 @@ extern const kernel_cap_t __cap_init_eff_set;
 #define CAP_LAST_U32			((_KERNEL_CAPABILITY_U32S) - 1)
 #define CAP_LAST_U32_VALID_MASK		(CAP_TO_MASK(CAP_LAST_CAP + 1) -1)
 
-# define CAP_EMPTY_SET    ((kernel_cap_t){{ 0, 0 }})
-# define CAP_FULL_SET     ((kernel_cap_t){{ ~0, CAP_LAST_U32_VALID_MASK }})
-# define CAP_FS_SET       ((kernel_cap_t){{ CAP_FS_MASK_B0 \
+# define __CAP_EMPTY_SET    {{ 0, 0 }}
+# define __CAP_FULL_SET     {{ ~0, CAP_LAST_U32_VALID_MASK }}
+# define __CAP_FS_SET       {{ CAP_FS_MASK_B0 \
 				    | CAP_TO_MASK(CAP_LINUX_IMMUTABLE), \
-				    CAP_FS_MASK_B1 } })
-# define CAP_NFSD_SET     ((kernel_cap_t){{ CAP_FS_MASK_B0 \
+				    CAP_FS_MASK_B1 } }
+# define __CAP_NFSD_SET     {{ CAP_FS_MASK_B0 \
 				    | CAP_TO_MASK(CAP_SYS_RESOURCE), \
-				    CAP_FS_MASK_B1 } })
+				    CAP_FS_MASK_B1 } }
+
+# define CAP_EMPTY_SET    ((kernel_cap_t)__CAP_EMPTY_SET)
+# define CAP_FULL_SET     ((kernel_cap_t)__CAP_FULL_SET)
+# define CAP_FS_SET       ((kernel_cap_t)__CAP_FS_SET)
+# define CAP_NFSD_SET     ((kernel_cap_t)__CAP_NFSD_SET)
 
 #endif /* _KERNEL_CAPABILITY_U32S != 2 */
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 78a73eba64dd..c843d273f2ac 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -919,24 +919,24 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_MASK_ALL							\
-(cpumask_t) { {								\
+{ {								\
 	[BITS_TO_LONGS(NR_CPUS)-1] = BITMAP_LAST_WORD_MASK(NR_CPUS)	\
 } }
 #else
 #define CPU_MASK_ALL							\
-(cpumask_t) { {								\
+{ {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-2] = ~0UL,			\
 	[BITS_TO_LONGS(NR_CPUS)-1] = BITMAP_LAST_WORD_MASK(NR_CPUS)	\
 } }
 #endif /* NR_CPUS > BITS_PER_LONG */
 
 #define CPU_MASK_NONE							\
-(cpumask_t) { {								\
+{ {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
 } }
 
 #define CPU_MASK_CPU0							\
-(cpumask_t) { {								\
+{ {								\
 	[0] =  1UL							\
 } }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd3837022307..a0f42c62d283 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -64,7 +64,7 @@ typedef void *efi_handle_t;
 typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
-	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
+	__GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
 
 /*
  * Generic EFI table header
diff --git a/include/linux/futex.h b/include/linux/futex.h
index ccaef0097785..f60697001f62 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -45,7 +45,7 @@ union futex_key {
 	} both;
 };
 
-#define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = NULL } }
+#define FUTEX_KEY_INIT { .both = { .ptr = NULL } }
 
 #ifdef CONFIG_FUTEX
 extern void exit_robust_list(struct task_struct *curr);
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3526c0aee954..7787b2650916 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -351,8 +351,8 @@ struct static_key_false {
 	struct static_key key;
 };
 
-#define STATIC_KEY_TRUE_INIT  (struct static_key_true) { .key = STATIC_KEY_INIT_TRUE,  }
-#define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
+#define STATIC_KEY_TRUE_INIT  { .key = STATIC_KEY_INIT_TRUE,  }
+#define STATIC_KEY_FALSE_INIT { .key = STATIC_KEY_INIT_FALSE, }
 
 #define DEFINE_STATIC_KEY_TRUE(name)	\
 	struct static_key_true name = STATIC_KEY_TRUE_INIT
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 27e7fa36f707..4eb6e645458d 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -306,25 +306,27 @@ static inline int __first_unset_node(const nodemask_t *maskp)
 
 #if MAX_NUMNODES <= BITS_PER_LONG
 
-#define NODE_MASK_ALL							\
-((nodemask_t) { {							\
+#define __NODE_MASK_ALL							\
+{ {							\
 	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODE_MASK_LAST_WORD		\
-} })
+} }
 
 #else
 
-#define NODE_MASK_ALL							\
-((nodemask_t) { {							\
+#define __NODE_MASK_ALL							\
+{ {							\
 	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-2] = ~0UL,			\
 	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODE_MASK_LAST_WORD		\
-} })
+} }
 
 #endif
+#define NODE_MASK_ALL (((nodemask_t)__MODE_MASK_ALL)
 
-#define NODE_MASK_NONE							\
-((nodemask_t) { {							\
+#define __NODE_MASK_NONE						\
+{ {							\
 	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-1] =  0UL			\
-} })
+} }
+#define NODE_MASK_NONE ((nodemask_t)__NODE_MASK_NONE)
 
 #define nodes_addr(src) ((src).bits)
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 9b3d4ca3a73a..7c615b8061fc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -258,7 +258,7 @@ struct property_entry {
  */
 
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _Type_, _val_)	\
-(struct property_entry) {						\
+{						\
 	.name = _name_,							\
 	.length = ARRAY_SIZE(_val_) * sizeof(_type_),			\
 	.is_array = true,						\
@@ -276,7 +276,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, U64, _val_)
 
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-(struct property_entry) {					\
+{								\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array = true,					\
@@ -285,7 +285,7 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
-(struct property_entry) {					\
+{								\
 	.name = _name_,						\
 	.length = sizeof(_type_),				\
 	.type = DEV_PROP_##_Type_,				\
@@ -302,7 +302,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
 
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-(struct property_entry) {				\
+{							\
 	.name = _name_,					\
 	.length = sizeof(const char *),			\
 	.type = DEV_PROP_STRING,			\
@@ -310,7 +310,7 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
-(struct property_entry) {			\
+{						\
 	.name = _name_,				\
 }
 
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 1fd61a9af45c..203019a9d7e7 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -34,7 +34,9 @@ struct rb_root {
 
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
-#define RB_ROOT	(struct rb_root) { NULL, }
+#define __RB_ROOT { NULL, }
+#define RB_ROOT	(struct rb_root) __RB_ROOT
+#define DEFINE_RB_ROOT(name) struct rb_root name = __RB_ROOT
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
@@ -127,7 +129,8 @@ struct rb_root_cached {
 	struct rb_node *rb_leftmost;
 };
 
-#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+#define __RB_ROOT_CACHED { {NULL, }, NULL }
+#define RB_ROOT_CACHED (struct rb_root_cached)__RB_ROOT_CACHED
 
 /* Same as rb_first(), but O(1) */
 #define rb_first_cached(root) (root)->rb_leftmost
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 3dcd617e65ae..665bbe362eaf 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -25,7 +25,7 @@ do {								\
 } while (0)
 #else
 # define rwlock_init(lock)					\
-	do { *(lock) = __RW_LOCK_UNLOCKED(lock); } while (0)
+	do { *(lock) = (rwlock_t)__RW_LOCK_UNLOCKED(lock); } while (0)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 857a72ceb794..a2873d685061 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -29,14 +29,14 @@ typedef struct {
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define __RW_LOCK_UNLOCKED(lockname)					\
-	(rwlock_t)	{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
+			{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
 				.magic = RWLOCK_MAGIC,			\
 				.owner = SPINLOCK_OWNER_INIT,		\
 				.owner_cpu = -1,			\
 				RW_DEP_MAP_INIT(lockname) }
 #else
 #define __RW_LOCK_UNLOCKED(lockname) \
-	(rwlock_t)	{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
+			{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
 				RW_DEP_MAP_INIT(lockname) }
 #endif
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 88050259c466..4067f176c4fd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -49,7 +49,7 @@ struct task_cputime_atomic {
 };
 
 #define INIT_CPUTIME_ATOMIC \
-	(struct task_cputime_atomic) {				\
+	{				\
 		.utime = ATOMIC64_INIT(0),			\
 		.stime = ATOMIC64_INIT(0),			\
 		.sum_exec_runtime = ATOMIC64_INIT(0),		\
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 031ce8617df8..c869279b0deb 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -103,7 +103,7 @@ do {								\
 
 #else
 # define raw_spin_lock_init(lock)				\
-	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
+	do { *(lock) = (raw_spinlock_t) __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
 #endif
 
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 24b4e6f2c1a2..71822cdaf829 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -54,7 +54,7 @@ typedef struct raw_spinlock {
 	SPIN_DEP_MAP_INIT(lockname) }
 
 #define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
+	__RAW_SPIN_LOCK_INITIALIZER(lockname)
 
 #define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
 
@@ -76,7 +76,7 @@ typedef struct spinlock {
 	{ { .rlock = __RAW_SPIN_LOCK_INITIALIZER(lockname) } }
 
 #define __SPIN_LOCK_UNLOCKED(lockname) \
-	(spinlock_t ) __SPIN_LOCK_INITIALIZER(lockname)
+	__SPIN_LOCK_INITIALIZER(lockname)
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
 
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index b0542cd11aeb..1c89f44e8eb2 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -27,8 +27,11 @@ typedef struct {
 	gid_t val;
 } kgid_t;
 
-#define KUIDT_INIT(value) (kuid_t){ value }
-#define KGIDT_INIT(value) (kgid_t){ value }
+#define __KUIDT_INIT(value) { value }
+#define __KGIDT_INIT(value) { value }
+
+#define KUIDT_INIT(value) (kuid_t)__KUIDT_INIT(value)
+#define KGIDT_INIT(value) (kgid_t)__KGIDT_INIT(value)
 
 #ifdef CONFIG_MULTIUSER
 static inline uid_t __kuid_val(kuid_t uid)
@@ -52,6 +55,12 @@ static inline gid_t __kgid_val(kgid_t gid)
 }
 #endif
 
+#define __GLOBAL_ROOT_UID __KUIDT_INIT(0)
+#define __GLOBAL_ROOT_GID __KGIDT_INIT(0)
+
+#define __INVALID_UID __KUIDT_INIT(-1)
+#define __INVALID_GID __KGIDT_INIT(-1)
+
 #define GLOBAL_ROOT_UID KUIDT_INIT(0)
 #define GLOBAL_ROOT_GID KGIDT_INIT(0)
 
diff --git a/include/uapi/linux/uuid.h b/include/uapi/linux/uuid.h
index e5a7eecef7c3..d141ceef3dcb 100644
--- a/include/uapi/linux/uuid.h
+++ b/include/uapi/linux/uuid.h
@@ -24,12 +24,14 @@ typedef struct {
 	__u8 b[16];
 } guid_t;
 
-#define GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
-((guid_t)								\
+#define __GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
 {{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
    (b) & 0xff, ((b) >> 8) & 0xff,					\
    (c) & 0xff, ((c) >> 8) & 0xff,					\
-   (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }})
+   (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }}
+
+#define GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
+	__GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
 
 /* backwards compatibility, don't use in new code */
 typedef guid_t uuid_le;
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5eab7b..d02ec9aedb31 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -122,7 +122,7 @@ struct task_struct init_task
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
 #ifdef CONFIG_AUDIT
-	.loginuid	= INVALID_UID,
+	.loginuid	= __INVALID_UID,
 	.sessionid	= AUDIT_SID_UNSET,
 #endif
 #ifdef CONFIG_PERF_EVENTS
@@ -144,7 +144,7 @@ struct task_struct init_task
 	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
 #endif
 #ifdef CONFIG_RT_MUTEXES
-	.pi_waiters	= RB_ROOT_CACHED,
+	.pi_waiters	= __RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
 #endif
 	INIT_PREV_CPUTIME(init_task)
diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..dae3da7961db 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -122,7 +122,7 @@ static u32	audit_backlog_limit = 64;
 static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 
 /* The identity of the user shutting down the audit system. */
-kuid_t		audit_sig_uid = INVALID_UID;
+kuid_t		audit_sig_uid = __INVALID_UID;
 pid_t		audit_sig_pid = -1;
 u32		audit_sig_sid = 0;
 
diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..862cd27578b2 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -24,7 +24,7 @@
  * Leveraged for setting/resetting capabilities
  */
 
-const kernel_cap_t __cap_empty_set = CAP_EMPTY_SET;
+const kernel_cap_t __cap_empty_set = __CAP_EMPTY_SET;
 EXPORT_SYMBOL(__cap_empty_set);
 
 int file_caps_enabled = 1;
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..67fd8a3d5600 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -44,19 +44,19 @@ struct cred init_cred = {
 	.subscribers		= ATOMIC_INIT(2),
 	.magic			= CRED_MAGIC,
 #endif
-	.uid			= GLOBAL_ROOT_UID,
-	.gid			= GLOBAL_ROOT_GID,
-	.suid			= GLOBAL_ROOT_UID,
-	.sgid			= GLOBAL_ROOT_GID,
-	.euid			= GLOBAL_ROOT_UID,
-	.egid			= GLOBAL_ROOT_GID,
-	.fsuid			= GLOBAL_ROOT_UID,
-	.fsgid			= GLOBAL_ROOT_GID,
+	.uid			= __GLOBAL_ROOT_UID,
+	.gid			= __GLOBAL_ROOT_GID,
+	.suid			= __GLOBAL_ROOT_UID,
+	.sgid			= __GLOBAL_ROOT_GID,
+	.euid			= __GLOBAL_ROOT_UID,
+	.egid			= __GLOBAL_ROOT_GID,
+	.fsuid			= __GLOBAL_ROOT_UID,
+	.fsgid			= __GLOBAL_ROOT_GID,
 	.securebits		= SECUREBITS_DEFAULT,
-	.cap_inheritable	= CAP_EMPTY_SET,
-	.cap_permitted		= CAP_FULL_SET,
-	.cap_effective		= CAP_FULL_SET,
-	.cap_bset		= CAP_FULL_SET,
+	.cap_inheritable	= __CAP_EMPTY_SET,
+	.cap_permitted		= __CAP_FULL_SET,
+	.cap_effective		= __CAP_FULL_SET,
+	.cap_bset		= __CAP_FULL_SET,
 	.user			= INIT_USER,
 	.user_ns		= &init_user_ns,
 	.group_info		= &init_groups,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 94d38a39d72e..39dec5776d26 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -33,7 +33,7 @@
 #define UINSNS_PER_PAGE			(PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
 #define MAX_UPROBE_XOL_SLOTS		UINSNS_PER_PAGE
 
-static struct rb_root uprobes_tree = RB_ROOT;
+static DEFINE_RB_ROOT(uprobes_tree);
 /*
  * allows us to skip the uprobe_mmap if there are no uprobe events active
  * at this time.  Probably a fine grained per inode count is better?
diff --git a/kernel/futex.c b/kernel/futex.c
index b11c6562941d..17b5d6895e75 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -817,7 +817,7 @@ static int refill_pi_state_cache(void)
 	/* pi_mutex gets initialized later */
 	pi_state->owner = NULL;
 	refcount_set(&pi_state->refcount, 1);
-	pi_state->key = FUTEX_KEY_INIT;
+	pi_state->key = (union futex_key)FUTEX_KEY_INIT;
 
 	current->pi_state_cache = pi_state;
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ca0fcb5ced71..dcb6b5a572d1 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -125,7 +125,7 @@ struct swsusp_extent {
 	unsigned long end;
 };
 
-static struct rb_root swsusp_extents = RB_ROOT;
+static DEFINE_RB_ROOT(swsusp_extents);
 
 static int swsusp_extents_insert(unsigned long swap_offset)
 {
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index aaf6793ededa..5e05ee2190d4 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -88,7 +88,7 @@ static struct {
 	arch_spinlock_t lock;
 } trace_clock_struct ____cacheline_aligned_in_smp =
 	{
-		.lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,
+		.lock = __ARCH_SPIN_LOCK_UNLOCKED,
 	};
 
 u64 notrace trace_clock_global(void)
diff --git a/kernel/umh.c b/kernel/umh.c
index 7f255b5a8845..80a9103dba23 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -34,8 +34,8 @@
 #define CAP_BSET	(void *)1
 #define CAP_PI		(void *)2
 
-static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
-static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
+static kernel_cap_t usermodehelper_bset = __CAP_FULL_SET;
+static kernel_cap_t usermodehelper_inheritable = __CAP_FULL_SET;
 static DEFINE_SPINLOCK(umh_sysctl_lock);
 static DECLARE_RWSEM(umhelper_sem);
 static LIST_HEAD(umh_list);
diff --git a/kernel/user.c b/kernel/user.c
index 5235d7f49982..55dbedc46932 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -56,8 +56,8 @@ struct user_namespace init_user_ns = {
 		},
 	},
 	.count = ATOMIC_INIT(3),
-	.owner = GLOBAL_ROOT_UID,
-	.group = GLOBAL_ROOT_GID,
+	.owner = __GLOBAL_ROOT_UID,
+	.group = __GLOBAL_ROOT_GID,
 	.ns.inum = PROC_USER_INIT_INO,
 #ifdef CONFIG_USER_NS
 	.ns.ops = &userns_operations,
@@ -101,7 +101,7 @@ struct user_struct root_user = {
 	.processes	= ATOMIC_INIT(1),
 	.sigpending	= ATOMIC_INIT(0),
 	.locked_shm     = 0,
-	.uid		= GLOBAL_ROOT_UID,
+	.uid		= __GLOBAL_ROOT_UID,
 	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
 };
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d9daa3e422d0..c09799876add 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -28,7 +28,7 @@ static struct class *bdi_class;
  */
 DEFINE_SPINLOCK(bdi_lock);
 static u64 bdi_id_cursor;
-static struct rb_root bdi_tree = RB_ROOT;
+static DEFINE_RB_ROOT(bdi_tree);
 LIST_HEAD(bdi_list);
 
 /* bdi_wq serves all asynchronous writeback tasks */
diff --git a/mm/init-mm.c b/mm/init-mm.c
index fb1e15028ef0..944a5c0eb3ec 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -26,7 +26,7 @@
  * and size this cpu_bitmask to NR_CPUS.
  */
 struct mm_struct init_mm = {
-	.mm_rb		= RB_ROOT,
+	.mm_rb		= __RB_ROOT,
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0b2e0306720..ccbd0daed88f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -115,7 +115,7 @@ EXPORT_SYMBOL(latent_entropy);
  * Array of node states.
  */
 nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
-	[N_POSSIBLE] = NODE_MASK_ALL,
+	[N_POSSIBLE] = __NODE_MASK_ALL,
 	[N_ONLINE] = { { [0] = 1UL } },
 #ifndef CONFIG_NUMA
 	[N_NORMAL_MEMORY] = { { [0] = 1UL } },
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a3c70e275f4e..f19b508a5af3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -334,7 +334,7 @@ static DEFINE_SPINLOCK(vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
 static LLIST_HEAD(vmap_purge_list);
-static struct rb_root vmap_area_root = RB_ROOT;
+static DEFINE_RB_ROOT(vmap_area_root);
 static bool vmap_initialized __read_mostly;
 
 /*
@@ -361,7 +361,7 @@ static LIST_HEAD(free_vmap_area_list);
  * of its sub-tree, right or left. Therefore it is possible to
  * find a lowest match of free area.
  */
-static struct rb_root free_vmap_area_root = RB_ROOT;
+static DEFINE_RB_ROOT(free_vmap_area_root);
 
 /*
  * Preload a CPU with one object for "no edge" split case. The
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index dd220ce7ca7a..1d9788f74e9d 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -16,8 +16,8 @@
 #include <net/ip_tunnels.h>
 
 static const struct fib_kuid_range fib_kuid_range_unset = {
-	KUIDT_INIT(0),
-	KUIDT_INIT(~0),
+	__KUIDT_INIT(0),
+	__KUIDT_INIT(~0),
 };
 
 bool fib_rule_matchall(const struct fib_rule *rule)
diff --git a/net/rds/cong.c b/net/rds/cong.c
index ccdff09a79c8..7769a667842e 100644
--- a/net/rds/cong.c
+++ b/net/rds/cong.c
@@ -99,7 +99,7 @@ static DEFINE_RWLOCK(rds_cong_monitor_lock);
  *  lock masks interrupts.
  */
 static DEFINE_SPINLOCK(rds_cong_lock);
-static struct rb_root rds_cong_tree = RB_ROOT;
+static DEFINE_RB_ROOT(rds_cong_tree);
 
 static struct rds_cong_map *rds_cong_tree_walk(const struct in6_addr *addr,
 					       struct rds_cong_map *insert)
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index e12c4900510f..115d89f0adcc 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -21,7 +21,7 @@
 #include <linux/lsm_hooks.h>
 #include "integrity.h"
 
-static struct rb_root integrity_iint_tree = RB_ROOT;
+static DEFINE_RB_ROOT(integrity_iint_tree);
 static DEFINE_RWLOCK(integrity_iint_lock);
 static struct kmem_cache *iint_cache __read_mostly;
 
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 09541de31f2f..4979c104926f 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -29,7 +29,7 @@ struct key_user root_key_user = {
 	.lock		= __SPIN_LOCK_UNLOCKED(root_key_user.lock),
 	.nkeys		= ATOMIC_INIT(2),
 	.nikeys		= ATOMIC_INIT(2),
-	.uid		= GLOBAL_ROOT_UID,
+	.uid		= __GLOBAL_ROOT_UID,
 };
 
 /*
-- 
2.20.0

