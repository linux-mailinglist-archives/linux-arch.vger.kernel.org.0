Return-Path: <linux-arch+bounces-3585-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DBD8A1BF2
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C287B1C2188A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138BD13AD09;
	Thu, 11 Apr 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnrlFS/9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7C13AA47;
	Thu, 11 Apr 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851570; cv=none; b=shvxiAgTXkRnXfsSRCbYax58AGS5EmdZX/Jiyf2H+LfrvTMFVQR+HGYDAA+vq9UvNH2VcvOBkEbUGyGjpP6lQsH7K9cGkSmXcubzzaTJulrjczbcPRceLxIqM/zY46MuXIvPzfyyqc+GmGKqlPyMjgifrApoP3kM8rv2ZjOWCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851570; c=relaxed/simple;
	bh=+blYsU+yhHAK3ZWSR/4vIF4tppBrgYZyNx/i+3pCeM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCfXfvsa2KhRT75x9hv6RfxgIU6q7L9NGhNaODzSYXPvDvM5DFaosvpbllLXOFGl8Gze6Ao256DKzg3Y2H/Z60pxGdRJYI285zxlak70N8VTG47SnGIOahrbAwccqucZR9gc04fnvV0EXnVvraw4lg/atOfgeIHEtSOqUzbUF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnrlFS/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4568C113CD;
	Thu, 11 Apr 2024 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851569;
	bh=+blYsU+yhHAK3ZWSR/4vIF4tppBrgYZyNx/i+3pCeM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnrlFS/9iawvR+8bxHsr0M/9FPe5IQYw7I6C8K+CutHZsK/WxpkdBuz8ri/GGmuzl
	 r+YEuwwyYjVOMT6kHDRhLZHoWkCWbfKD1DUY/DQfdhUA3AliFnvkr79QIUHmsvn+Xh
	 8nQ2Zf21W2ZTSIBApvBf5palrBojvjhjJN+vNV+WOBp209WK4NciwA1uCxRhQWtp/l
	 dk8faa1HtHFiDzAnDJrLHODKg4hNxxZO15Z6AeQHYQzGk2/htmQdZY7Lw8whK5MsKr
	 Hh7c30KTH5SVkSL94fhMmpH3MZ1m8TvZt5cNCyQpbBzxG9VGORMa3Cth0VaWEvMTUH
	 uU+b9ZYvJFIwA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [RFC PATCH 3/7] module: prepare to handle ROX allocations for text
Date: Thu, 11 Apr 2024 19:05:22 +0300
Message-ID: <20240411160526.2093408-4-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160526.2093408-1-rppt@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

In order to support ROX allocations for module text, it is necessary to
handle modifications to the code, such as relocations and alternatives
patching, without write access to that memory.

One option is to use text patching, but this would make module loading
extremely slow and will expose executable code that is not finally formed.

A better way is to have memory allocated with ROX permissions contain
invalid instructions and keep a writable, but not executable copy of the
module text. The relocations and alternative patches would be done on the
writable copy using the addresses of the ROX memory.
Once the module is completely ready, the updated text will be copied to ROX
memory using text patching in one go and the writable copy will be freed.

Add support for that to module initialization code and provide necessary
interfaces in execmem.
---
 include/linux/execmem.h    | 23 +++++++++++++
 include/linux/module.h     | 11 ++++++
 kernel/module/main.c       | 70 ++++++++++++++++++++++++++++++++++----
 kernel/module/strict_rwx.c |  3 ++
 mm/execmem.c               | 11 ++++++
 5 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index ffd0d12feef5..9d22999dbd7d 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -46,9 +46,11 @@ enum execmem_type {
 /**
  * enum execmem_range_flags - options for executable memory allocations
  * @EXECMEM_KASAN_SHADOW:	allocate kasan shadow
+ * @EXECMEM_READ_ONLY:		allocated memory should be mapped as read only
  */
 enum execmem_range_flags {
 	EXECMEM_KASAN_SHADOW	= (1 << 0),
+	EXECMEM_ROX_CACHE	= (1 << 1),
 };
 
 /**
@@ -123,6 +125,27 @@ void *execmem_alloc(enum execmem_type type, size_t size);
  */
 void execmem_free(void *ptr);
 
+/**
+ * execmem_update_copy - copy an update to executable memory
+ * @dst:  destination address to update
+ * @src:  source address containing the data
+ * @size: how many bytes of memory shold be copied
+ *
+ * Copy @size bytes from @src to @dst using text poking if the memory at
+ * @dst is read-only.
+ *
+ * Return: a pointer to @dst or NULL on error
+ */
+void *execmem_update_copy(void *dst, const void *src, size_t size);
+
+/**
+ * execmem_is_rox - check if execmem is read-only
+ * @type - the execmem type to check
+ *
+ * Return: %true if the @type is read-only, %false if it's writable
+ */
+bool execmem_is_rox(enum execmem_type type);
+
 #ifdef CONFIG_ARCH_WANTS_EXECMEM_EARLY
 void execmem_early_init(void);
 #else
diff --git a/include/linux/module.h b/include/linux/module.h
index 1153b0d99a80..3df3202680a2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -361,6 +361,8 @@ enum mod_mem_type {
 
 struct module_memory {
 	void *base;
+	void *rw_copy;
+	bool is_rox;
 	unsigned int size;
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
@@ -368,6 +370,15 @@ struct module_memory {
 #endif
 };
 
+#ifdef CONFIG_MODULES
+unsigned long module_writable_offset(struct module *mod, void *loc);
+#else
+static inline unsigned long module_writable_offset(struct module *mod, void *loc)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 /* Only touch one cacheline for common rbtree-for-core-layout case. */
 #define __module_memory_align ____cacheline_aligned
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 91e185607d4b..f83fbb9c95ee 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1188,6 +1188,21 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
+unsigned long module_writable_offset(struct module *mod, void *loc)
+{
+	if (!mod)
+		return 0;
+
+	for_class_mod_mem_type(type, text) {
+		struct module_memory *mem = &mod->mem[type];
+
+		if (loc >= mem->base && loc < mem->base + mem->size)
+			return (unsigned long)(mem->rw_copy - mem->base);
+	}
+
+	return 0;
+}
+
 static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 {
 	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
@@ -1205,6 +1220,23 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	if (!ptr)
 		return -ENOMEM;
 
+	mod->mem[type].base = ptr;
+
+	if (execmem_is_rox(execmem_type)) {
+		ptr = vzalloc(size);
+
+		if (!ptr) {
+			execmem_free(mod->mem[type].base);
+			return -ENOMEM;
+		}
+
+		mod->mem[type].rw_copy = ptr;
+		mod->mem[type].is_rox = true;
+	} else {
+		mod->mem[type].rw_copy = mod->mem[type].base;
+		memset(mod->mem[type].base, 0, size);
+	}
+
 	/*
 	 * The pointer to these blocks of memory are stored on the module
 	 * structure and we keep that around so long as the module is
@@ -1218,15 +1250,16 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	 */
 	kmemleak_not_leak(ptr);
 
-	memset(ptr, 0, size);
-	mod->mem[type].base = ptr;
-
 	return 0;
 }
 
 static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
-	void *ptr = mod->mem[type].base;
+	struct module_memory *mem = &mod->mem[type];
+	void *ptr = mem->base;
+
+	if (mem->is_rox)
+		vfree(mem->rw_copy);
 
 	execmem_free(ptr);
 }
@@ -2237,6 +2270,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
 			mod->mem[type].base = NULL;
+			mod->mem[type].rw_copy = NULL;
 			continue;
 		}
 
@@ -2253,11 +2287,14 @@ static int move_module(struct module *mod, struct load_info *info)
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
 		enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
+		unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
+		unsigned long addr;
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
 
-		dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
+		addr = (unsigned long)mod->mem[type].base + offset;
+		dest = mod->mem[type].rw_copy + offset;
 
 		if (shdr->sh_type != SHT_NOBITS) {
 			/*
@@ -2279,7 +2316,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		 * users of info can keep taking advantage and using the newly
 		 * minted official memory area.
 		 */
-		shdr->sh_addr = (unsigned long)dest;
+		shdr->sh_addr = addr;
 		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
 			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
 	}
@@ -2429,6 +2466,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 
 static int post_relocation(struct module *mod, const struct load_info *info)
 {
+	int ret;
+
 	/* Sort exception table now relocations are done. */
 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
 
@@ -2440,7 +2479,24 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	add_kallsyms(mod, info);
 
 	/* Arch-specific module finalizing. */
-	return module_finalize(info->hdr, info->sechdrs, mod);
+	ret = module_finalize(info->hdr, info->sechdrs, mod);
+	if (ret)
+		return ret;
+
+	for_each_mod_mem_type(type) {
+		struct module_memory *mem = &mod->mem[type];
+
+		if (mem->is_rox) {
+			if (!execmem_update_copy(mem->base, mem->rw_copy,
+						 mem->size))
+				return -ENOMEM;
+
+			vfree(mem->rw_copy);
+			mem->rw_copy = NULL;
+		}
+	}
+
+	return 0;
 }
 
 /* Call module constructors. */
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index c45caa4690e5..239e5013359d 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -34,6 +34,9 @@ int module_enable_text_rox(const struct module *mod)
 	for_class_mod_mem_type(type, text) {
 		int ret;
 
+		if (mod->mem[type].is_rox)
+			continue;
+
 		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 			ret = module_set_memory(mod, type, set_memory_rox);
 		else
diff --git a/mm/execmem.c b/mm/execmem.c
index aabc0afabdbc..c920d2b5a721 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -4,6 +4,7 @@
 #include <linux/vmalloc.h>
 #include <linux/execmem.h>
 #include <linux/moduleloader.h>
+#include <linux/text-patching.h>
 
 static struct execmem_info *execmem_info __ro_after_init;
 static struct execmem_info default_execmem_info __ro_after_init;
@@ -63,6 +64,16 @@ void execmem_free(void *ptr)
 	vfree(ptr);
 }
 
+void *execmem_update_copy(void *dst, const void *src, size_t size)
+{
+	return text_poke_copy(dst, src, size);
+}
+
+bool execmem_is_rox(enum execmem_type type)
+{
+	return !!(execmem_info->ranges[type].flags & EXECMEM_ROX_CACHE);
+}
+
 static bool execmem_validate(struct execmem_info *info)
 {
 	struct execmem_range *r = &info->ranges[EXECMEM_DEFAULT];
-- 
2.43.0


