Return-Path: <linux-arch+bounces-3570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2C8A1B7E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E521C21EFA
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78712BE86;
	Thu, 11 Apr 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1GXndAQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A5128829;
	Thu, 11 Apr 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851348; cv=none; b=Ow52S9f5G5OPhNczI65c+6S1R6Lakq3/YpVl8yU3s75cTqilE/7R+19r4pZDPczk1WliBALYTWd0SpnECI76OYPler+2+hJdEbahh8D7/SnJnK5VkFwlui41sdsOg0xdPgxmXo9IRS9siwp805O7oIjTIfzG+g/TE85hvuqg8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851348; c=relaxed/simple;
	bh=et4MgsnYGm8cVKv9jXBAzJOVzMpXCbC7LVUAQwPu1L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz7U329hJLbgOYSXKNmzf7IyO6s2TwQopip+iB0vLch+rmlkJeAc81/IxUj/gllEreebqD26sP+95LRL1fTguwf5T92uMeFFJmKQyKj6vbSRs+NKiaHiMlMOm2QPgGlKoPgLLE4f8bvQ5dI5Dpk1K7svEwpGLQBbGtuhEArG4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1GXndAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818CFC2BD10;
	Thu, 11 Apr 2024 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851347;
	bh=et4MgsnYGm8cVKv9jXBAzJOVzMpXCbC7LVUAQwPu1L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1GXndAQP3oIWJF2kKyNlpiiJSFO7nmNgf4MIU0ERGhKxhpSGaH9nxwDuLhsV3Xqy
	 oWFbKUT/il9FmwUQEyH0r/e2BlemPH7VRA1ywsfVtoDfKNcIa4f2do77HzqxqdrG6t
	 QlP+gFMeCVi6VrLKqby9Dn5q7YBcfKh9PkLfkItK2qs1Sx2MUlI4qvR4Q73oKj8gOV
	 YIq1zu3Q38f4fDlPFB+klMICo31RMpMdTnPu5jG0/g9T75phgJPr5vjbKe2lBvj3yQ
	 QDLR8IEPEAv5EEBMbPsUOffQmtDM0+zqars1F9uzRfdyUjJWSeVO38WX+SrdXXfWIy
	 bNoL6A2CTDgVQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 04/15] module: make module_memory_{alloc,free} more self-contained
Date: Thu, 11 Apr 2024 19:00:40 +0300
Message-ID: <20240411160051.2093261-5-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160051.2093261-1-rppt@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Move the logic related to the memory allocation and freeing into
module_memory_alloc() and module_memory_free().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 kernel/module/main.c | 64 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e1e8a7a9d6c1..5b82b069e0d3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1203,15 +1203,44 @@ static bool mod_mem_use_vmalloc(enum mod_mem_type type)
 		mod_mem_type_is_core_data(type);
 }
 
-static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
+static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 {
+	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
+	void *ptr;
+
+	mod->mem[type].size = size;
+
 	if (mod_mem_use_vmalloc(type))
-		return vzalloc(size);
-	return module_alloc(size);
+		ptr = vmalloc(size);
+	else
+		ptr = module_alloc(size);
+
+	if (!ptr)
+		return -ENOMEM;
+
+	/*
+	 * The pointer to these blocks of memory are stored on the module
+	 * structure and we keep that around so long as the module is
+	 * around. We only free that memory when we unload the module.
+	 * Just mark them as not being a leak then. The .init* ELF
+	 * sections *do* get freed after boot so we *could* treat them
+	 * slightly differently with kmemleak_ignore() and only grey
+	 * them out as they work as typical memory allocations which
+	 * *do* eventually get freed, but let's just keep things simple
+	 * and avoid *any* false positives.
+	 */
+	kmemleak_not_leak(ptr);
+
+	memset(ptr, 0, size);
+	mod->mem[type].base = ptr;
+
+	return 0;
 }
 
-static void module_memory_free(void *ptr, enum mod_mem_type type)
+static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
+	void *ptr = mod->mem[type].base;
+
 	if (mod_mem_use_vmalloc(type))
 		vfree(ptr);
 	else
@@ -1229,12 +1258,12 @@ static void free_mod_mem(struct module *mod)
 		/* Free lock-classes; relies on the preceding sync_rcu(). */
 		lockdep_free_key_range(mod_mem->base, mod_mem->size);
 		if (mod_mem->size)
-			module_memory_free(mod_mem->base, type);
+			module_memory_free(mod, type);
 	}
 
 	/* MOD_DATA hosts mod, so free it at last */
 	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
-	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA);
+	module_memory_free(mod, MOD_DATA);
 }
 
 /* Free a module, remove from lists, etc. */
@@ -2225,7 +2254,6 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 static int move_module(struct module *mod, struct load_info *info)
 {
 	int i;
-	void *ptr;
 	enum mod_mem_type t = 0;
 	int ret = -ENOMEM;
 
@@ -2234,26 +2262,12 @@ static int move_module(struct module *mod, struct load_info *info)
 			mod->mem[type].base = NULL;
 			continue;
 		}
-		mod->mem[type].size = PAGE_ALIGN(mod->mem[type].size);
-		ptr = module_memory_alloc(mod->mem[type].size, type);
-		/*
-                 * The pointer to these blocks of memory are stored on the module
-                 * structure and we keep that around so long as the module is
-                 * around. We only free that memory when we unload the module.
-                 * Just mark them as not being a leak then. The .init* ELF
-                 * sections *do* get freed after boot so we *could* treat them
-                 * slightly differently with kmemleak_ignore() and only grey
-                 * them out as they work as typical memory allocations which
-                 * *do* eventually get freed, but let's just keep things simple
-                 * and avoid *any* false positives.
-		 */
-		kmemleak_not_leak(ptr);
-		if (!ptr) {
+
+		ret = module_memory_alloc(mod, type);
+		if (ret) {
 			t = type;
 			goto out_enomem;
 		}
-		memset(ptr, 0, mod->mem[type].size);
-		mod->mem[type].base = ptr;
 	}
 
 	/* Transfer each section which specifies SHF_ALLOC */
@@ -2296,7 +2310,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	return 0;
 out_enomem:
 	for (t--; t >= 0; t--)
-		module_memory_free(mod->mem[t].base, t);
+		module_memory_free(mod, t);
 	return ret;
 }
 
-- 
2.43.0


