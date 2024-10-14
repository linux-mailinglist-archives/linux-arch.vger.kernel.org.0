Return-Path: <linux-arch+bounces-8111-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C229699D85E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A6C283005
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191C1D2B3D;
	Mon, 14 Oct 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCk+1f8z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70511D1E62
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938219; cv=none; b=Vi/wcRFgNFxBWHtyn2UuyXe50tr7Id1q87UEW2wFayJlYWadtWlg2GhJlA+pw2Wjc/EnKIl3a3wwWk2XP28xLTG3fLwWnLQCnbcCwKkuilv7x2LD0YzKN0oNjitblp9kuhr+6ybtcGLe5Y4TmkQ9fvuv8g7w2Aqb8cdHvC46tyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938219; c=relaxed/simple;
	bh=mT/WeQdX90ZMvRZEhMfvV+ENRkOm1JHryBCb4xMzGtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5XCLGMbb46nmO2M9fP2NMhb0VjsVJ8ifnCHi5MEUg7980tfBqhTFJu8pUfh1TmEoP0wgxMf4WmIwN1IpgUcML04EmcYb0iOWJK+aZeGsZCxT0LiM8VzEmtD3SpHj74fWIIiV8lrnDs7VsNsySrbcKaSiHvlL7lo1HeP2lwBkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCk+1f8z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2e5e376fcso90156597b3.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938217; x=1729543017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOvroPog9pmluzu4zs2xrkfEGIpV84j+wuh+gRgw5PA=;
        b=mCk+1f8zQO9+k6aUmyMjqS2QB3wHdPTfqwgpNwRFPOptphQ0YXYcRFFB49BsL8M2XQ
         jUFhf3Xh0QIdoUlPUJc4RBVxFbJCYcT1be/E4j4DzD2flsxUCmcyu0NaKBs6Xrj9yLTm
         /wipIFCSeeSKShzz7szeaX+GQk0j77nrI+VXDe6QGyUJtYvUGBCu++ic/vGAypphkM6B
         5u0pRWcHeNFpu6PvZNGSa0r5T8b0NiJgbYu/ADNVSqUqcePpxx0vxo5e3OxAyV3M2gBf
         1UFVVYZ2qe+3QCp2N9mFy15a8t5ROBhV2RYHjfNS4QHE0F5sTk5gGIR7RLzS4ua6XhLT
         IKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938217; x=1729543017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOvroPog9pmluzu4zs2xrkfEGIpV84j+wuh+gRgw5PA=;
        b=OmjCEDw9WMOBPD9uiGJnbYgmFi2lf1mNLPuus8UFVEV2JX2GsUl33fSdg3VuHpTVN5
         uHNP9gIEsiTyKJvNxS/VkzNz5ych2L9XWeCZ4M9aXXUN1Fr7clabPAIw1jHo5LhyET4S
         STE21KHvQHT3+w+nj+CbE7fubmkYS7ggQVLTp8YlXR3zaXP0iI3xwP5cvy5vHu00zWIz
         OSTtfljHojslVR7xDWfhLgSF4MTuJ+meFEATg/j/+JI23s/6kds7jakzgYvHremAudyN
         85jTtxQuQLBxc7SvKpfslirZaYX/xvchWFuGPPEfhuynNYUSFXetNPPhDe078JvvgGDk
         KoHg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ftAEFCUj3KM2TsciYjgqmZTL+/VxSmRk8kDnebhARn8bf9QzDK9FSX21x4FmE/6F0Rpe2lTM+6Cj@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJobSqqTFnUYb7CwS6VCUt/PC8VzRRR6aKSeHSNCXJwpFXcqZ
	vCBNPpAryqdED8+Wqo7KjmKGHaGdpkqEHOB8+ND1WMlOxwgNFndVgLvciDRHjk69Yp0aMyd+v5H
	zRA==
X-Google-Smtp-Source: AGHT+IHN+F4HHrAed80eKaPYhTH0JCc5Mv3vEPFTteI9kO52+1hB5IgMv4halrrXePZu5DiEH+LMAHeUbpw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:915:bdd7:e08a:7997])
 (user=surenb job=sendgmr) by 2002:a05:690c:c09:b0:6e3:1702:b3e6 with SMTP id
 00721157ae682-6e347b368d2mr1991517b3.4.1728938216731; Mon, 14 Oct 2024
 13:36:56 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:36:44 -0700
In-Reply-To: <20241014203646.1952505-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014203646.1952505-4-surenb@google.com>
Subject: [PATCH v3 3/5] alloc_tag: populate memory for module tags as needed
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

The memory reserved for module tags does not need to be backed by
physical pages until there are tags to store there. Change the way
we reserve this memory to allocate only virtual area for the tags
and populate it with physical pages as needed when we load a module.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/execmem.h | 11 ++++++
 include/linux/vmalloc.h |  9 +++++
 lib/alloc_tag.c         | 84 +++++++++++++++++++++++++++++++++--------
 mm/execmem.c            | 16 ++++++++
 mm/vmalloc.c            |  4 +-
 5 files changed, 106 insertions(+), 18 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 7436aa547818..a159a073270a 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -127,6 +127,17 @@ void *execmem_alloc(enum execmem_type type, size_t size);
  */
 void execmem_free(void *ptr);
 
+/**
+ * execmem_vmap - create virtual mapping for executable memory
+ * @type: type of the allocation
+ * @size: size of the virtual mapping in bytes
+ *
+ * Maps virtually contiguous area that can be populated with executable code.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+struct vm_struct *execmem_vmap(enum execmem_type type, size_t size);
+
 /**
  * execmem_update_copy - copy an update to executable memory
  * @dst:  destination address to update
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 9a012cd4fad2..9d64cc6f24d1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -202,6 +202,9 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
 
+int vmap_pages_range(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift);
+
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
  * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
@@ -239,6 +242,12 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
 					const void *caller);
+struct vm_struct *__get_vm_area_node(unsigned long size,
+				     unsigned long align, unsigned long shift,
+				     unsigned long flags, unsigned long start,
+				     unsigned long end, int node, gfp_t gfp_mask,
+				     const void *caller);
+
 void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index b10e7f17eeda..648f32d52b8d 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -8,6 +8,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 
 static struct codetag_type *alloc_tag_cttype;
 
@@ -153,6 +154,7 @@ static void __init procfs_init(void)
 #ifdef CONFIG_MODULES
 
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
+static struct vm_struct *vm_module_tags;
 /* A dummy object used to indicate an unloaded module */
 static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
@@ -195,6 +197,25 @@ static void clean_unused_module_areas_locked(void)
 	}
 }
 
+static int vm_module_tags_grow(unsigned long addr, unsigned long bytes)
+{
+	struct page **next_page = vm_module_tags->pages + vm_module_tags->nr_pages;
+	unsigned long more_pages = ALIGN(bytes, PAGE_SIZE) >> PAGE_SHIFT;
+	unsigned long nr;
+
+	nr = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
+					 NUMA_NO_NODE, more_pages, next_page);
+	if (nr != more_pages)
+		return -ENOMEM;
+
+	vm_module_tags->nr_pages += nr;
+	if (vmap_pages_range(addr, addr + (nr << PAGE_SHIFT),
+			     PAGE_KERNEL, next_page, PAGE_SHIFT) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void *reserve_module_tags(struct module *mod, unsigned long size,
 				 unsigned int prepend, unsigned long align)
 {
@@ -202,7 +223,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
 	bool cleanup_done = false;
 	unsigned long offset;
-	void *ret;
+	void *ret = NULL;
 
 	/* If no tags return NULL */
 	if (size < sizeof(struct alloc_tag))
@@ -239,7 +260,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		goto repeat;
 	} else {
 		ret = ERR_PTR(-ENOMEM);
-		goto out;
+		goto unlock;
 	}
 
 found:
@@ -254,7 +275,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		mas_store(&mas, &prepend_mod);
 		if (mas_is_err(&mas)) {
 			ret = ERR_PTR(xa_err(mas.node));
-			goto out;
+			goto unlock;
 		}
 		mas.index = offset;
 		mas.last = offset + size - 1;
@@ -263,7 +284,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 			ret = ERR_PTR(xa_err(mas.node));
 			mas.index = pad_start;
 			mas_erase(&mas);
-			goto out;
+			goto unlock;
 		}
 
 	} else {
@@ -271,18 +292,33 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		mas_store(&mas, mod);
 		if (mas_is_err(&mas)) {
 			ret = ERR_PTR(xa_err(mas.node));
-			goto out;
+			goto unlock;
 		}
 	}
+unlock:
+	mas_unlock(&mas);
+	if (IS_ERR(ret))
+		return ret;
 
-	if (module_tags.size < offset + size)
-		module_tags.size = offset + size;
+	if (module_tags.size < offset + size) {
+		unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
 
-	ret = (struct alloc_tag *)(module_tags.start_addr + offset);
-out:
-	mas_unlock(&mas);
+		module_tags.size = offset + size;
+		if (phys_size < module_tags.size) {
+			int grow_res;
+
+			grow_res = vm_module_tags_grow(module_tags.start_addr + phys_size,
+						       module_tags.size - phys_size);
+			if (grow_res) {
+				static_branch_disable(&mem_alloc_profiling_key);
+				pr_warn("Failed to allocate tags memory for module %s. Memory profiling is disabled!\n",
+					mod->name);
+				return ERR_PTR(grow_res);
+			}
+		}
+	}
 
-	return ret;
+	return (struct alloc_tag *)(module_tags.start_addr + offset);
 }
 
 static void release_module_tags(struct module *mod, bool unused)
@@ -351,12 +387,23 @@ static void replace_module(struct module *mod, struct module *new_mod)
 
 static int __init alloc_mod_tags_mem(void)
 {
-	/* Allocate space to copy allocation tags */
-	module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
-							      MODULE_ALLOC_TAG_VMAP_SIZE);
-	if (!module_tags.start_addr)
+	/* Map space to copy allocation tags */
+	vm_module_tags = execmem_vmap(EXECMEM_MODULE_DATA, MODULE_ALLOC_TAG_VMAP_SIZE);
+	if (!vm_module_tags) {
+		pr_err("Failed to map %lu bytes for module allocation tags\n",
+			MODULE_ALLOC_TAG_VMAP_SIZE);
+		module_tags.start_addr = 0;
 		return -ENOMEM;
+	}
 
+	vm_module_tags->pages = kmalloc_array(get_vm_area_size(vm_module_tags) >> PAGE_SHIFT,
+					sizeof(struct page *), GFP_KERNEL | __GFP_ZERO);
+	if (!vm_module_tags->pages) {
+		free_vm_area(vm_module_tags);
+		return -ENOMEM;
+	}
+
+	module_tags.start_addr = (unsigned long)vm_module_tags->addr;
 	module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
 
 	return 0;
@@ -364,8 +411,13 @@ static int __init alloc_mod_tags_mem(void)
 
 static void __init free_mod_tags_mem(void)
 {
-	execmem_free((void *)module_tags.start_addr);
+	int i;
+
 	module_tags.start_addr = 0;
+	for (i = 0; i < vm_module_tags->nr_pages; i++)
+		__free_page(vm_module_tags->pages[i]);
+	kfree(vm_module_tags->pages);
+	free_vm_area(vm_module_tags);
 }
 
 #else /* CONFIG_MODULES */
diff --git a/mm/execmem.c b/mm/execmem.c
index 97706d8ed720..eb346f4eaaff 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -366,6 +366,22 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
+struct vm_struct *execmem_vmap(enum execmem_type type, size_t size)
+{
+	struct execmem_range *range = &execmem_info->ranges[type];
+	struct vm_struct *area;
+
+	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
+				  range->start, range->end, NUMA_NO_NODE,
+				  GFP_KERNEL, __builtin_return_address(0));
+	if (!area && range->fallback_start)
+		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
+					  range->fallback_start, range->fallback_end,
+					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
+
+	return area;
+}
+
 void *execmem_update_copy(void *dst, const void *src, size_t size)
 {
 	return text_poke_copy(dst, src, size);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74c0a5eae210..7ed39d104201 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -653,7 +653,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-static int vmap_pages_range(unsigned long addr, unsigned long end,
+int vmap_pages_range(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	int err;
@@ -3106,7 +3106,7 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 	vm->flags &= ~VM_UNINITIALIZED;
 }
 
-static struct vm_struct *__get_vm_area_node(unsigned long size,
+struct vm_struct *__get_vm_area_node(unsigned long size,
 		unsigned long align, unsigned long shift, unsigned long flags,
 		unsigned long start, unsigned long end, int node,
 		gfp_t gfp_mask, const void *caller)
-- 
2.47.0.rc1.288.g06298d1525-goog


