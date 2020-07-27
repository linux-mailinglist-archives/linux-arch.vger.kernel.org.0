Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8486E22F60C
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgG0REp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 13:04:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51798 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgG0REp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 13:04:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RH1oE5167412;
        Mon, 27 Jul 2020 17:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=0MK6qZ4rmREeaZwYRzKOOUuuO9k+/vuBanKdQpkLLj0=;
 b=xMB0HfK4JVWE3/LtK1M1FsIoACvTkHyveasvbs4I6h2R8R5+Muq8BwQLHE58ukF7Lvws
 072k5QrhQxYwX53lw/viQ1GyuEDwkpJt0Om+E4vAVCy7IRrFMUdg/8l1vnmDB8PAPkb5
 7hvtDYByCv7TMfsbAA2C0cv5iOCeOyLgJ6KbyiR0j7KNw7b1VY4Cm5pNojOswbGHWijd
 SG1DlQCI1NviMPXmSP0rwZyiDVvSKlCO2yLdeiZGWG1GgbUmk7ybiKcAvKQ6CU3lUcmo
 o/lnwUaMEZE1xcnpvQbVMKmLCIkROOa3CcLQkl0RQql3BPP1daqZIAwKIIOBsG/Yre7/ Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jas6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:04:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgWR5055581;
        Mon, 27 Jul 2020 17:02:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 32hu5r9fb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:14 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGuWGj111604;
        Mon, 27 Jul 2020 17:02:13 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by userp3020.oracle.com with ESMTP id 32hu5r9f7r-4;
        Mon, 27 Jul 2020 17:02:13 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH 3/5] mm: introduce VM_EXEC_KEEP
Date:   Mon, 27 Jul 2020 10:11:25 -0700
Message-Id: <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=2 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270117
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A vma with the VM_EXEC_KEEP flag is preserved across exec.  For anonymous
vmas only.  For safety, overlap with fixed address VMAs created in the new
mm during exec (e.g. the stack and elf load segments) is not permitted and
will cause the exec to fail.
(We are studying how to guarantee there are no conflicts. Comments welcome.)

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/Kconfig   |  1 +
 fs/exec.c          | 20 ++++++++++++++++++++
 include/linux/mm.h |  5 +++++
 kernel/fork.c      |  2 +-
 mm/mmap.c          | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 883da0abf779..fc36eb2f45c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,6 +30,7 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
+	select ARCH_USES_HIGH_VMA_FLAGS
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/fs/exec.c b/fs/exec.c
index 262112e5f9f8..1de09c4eef00 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1069,6 +1069,20 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 EXPORT_SYMBOL(read_code);
 #endif
 
+static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
+{
+	struct vm_area_struct *vma;
+	int ret;
+
+	for (vma = old_mm->mmap; vma; vma = vma->vm_next)
+		if (vma->vm_flags & VM_EXEC_KEEP) {
+			ret = vma_dup(vma, new_mm);
+			if (ret)
+				return ret;
+		}
+	return 0;
+}
+
 /*
  * Maps the mm_struct mm into the current task struct.
  * On success, this function returns with the mutex
@@ -1104,6 +1118,12 @@ static int exec_mmap(struct mm_struct *mm)
 			mutex_unlock(&tsk->signal->exec_update_mutex);
 			return -EINTR;
 		}
+		ret = vma_dup_some(old_mm, mm);
+		if (ret) {
+			mmap_read_unlock(old_mm);
+			mutex_unlock(&tsk->signal->exec_update_mutex);
+			return ret;
+		}
 	}
 
 	task_lock(tsk);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..1c538ba77f33 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -295,11 +295,15 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_EXEC_KEEP	BIT(VM_HIGH_ARCH_BIT_5)	/* preserve VMA across exec */
+#else
+#define VM_EXEC_KEEP	VM_NONE
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -2534,6 +2538,7 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+extern int vma_dup(struct vm_area_struct *vma, struct mm_struct *mm);
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/kernel/fork.c b/kernel/fork.c
index efc5493203ae..15ead613714f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -564,7 +564,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->anon_vma = NULL;
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
-		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
+		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT | VM_EXEC_KEEP);
 		file = tmp->vm_file;
 		if (file) {
 			struct inode *inode = file_inode(file);
diff --git a/mm/mmap.c b/mm/mmap.c
index 59a4682ebf3f..be2ff53743c3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3279,6 +3279,53 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return NULL;
 }
 
+int vma_dup(struct vm_area_struct *old_vma, struct mm_struct *mm)
+{
+	unsigned long npages;
+	struct mm_struct *old_mm = old_vma->vm_mm;
+	struct vm_area_struct *vma;
+	int ret = -ENOMEM;
+
+	if (WARN_ON(old_vma->vm_file || old_vma->vm_ops))
+		return -EINVAL;
+
+	vma = find_vma(mm, old_vma->vm_start);
+	if (vma && vma->vm_start < old_vma->vm_end)
+		return -EEXIST;
+
+	npages = vma_pages(old_vma);
+	mm->total_vm += npages;
+
+	vma = vm_area_dup(old_vma);
+	if (!vma)
+		goto fail_nomem;
+
+	ret = vma_dup_policy(old_vma, vma);
+	if (ret)
+		goto fail_nomem_policy;
+
+	vma->vm_mm = mm;
+	ret = anon_vma_fork(vma, old_vma);
+	if (ret)
+		goto fail_nomem_anon_vma_fork;
+
+	vma->vm_flags &= ~(VM_LOCKED|VM_UFFD_MISSING|VM_UFFD_WP|VM_EXEC_KEEP);
+	vma->vm_next = vma->vm_prev = NULL;
+	vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+	if (is_vm_hugetlb_page(vma))
+		reset_vma_resv_huge_pages(vma);
+	__insert_vm_struct(mm, vma);
+	ret = copy_page_range(mm, old_mm, old_vma);
+	return ret;
+
+fail_nomem_anon_vma_fork:
+	mpol_put(vma_policy(vma));
+fail_nomem_policy:
+	vm_area_free(vma);
+fail_nomem:
+	return -ENOMEM;
+}
+
 /*
  * Return true if the calling process may expand its vm space by the passed
  * number of pages
-- 
1.8.3.1

