Return-Path: <linux-arch+bounces-4181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F28BC0F4
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA991C20E23
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE22C1A7;
	Sun,  5 May 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl5iD4lu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482D2B9BE;
	Sun,  5 May 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714919242; cv=none; b=bxmndyHTrf3mxQB3fcgCn1ieCPLwSfl+3zEJuaHs1/vUJ5e0Z75NV8WKBo3ujiA3n1tHMdCsNeffaRUxpetJSkhQAfaSGcfS5DZt++lmPrm+ckdcBxGzKTbifzOC020jrUiMYbn3x3CoddFId5mADXHdFC/Flc+0760+C0T7XUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714919242; c=relaxed/simple;
	bh=vbQmVIViLlnHnV/HmsoDNHPWB+6N7x9rENWps4lsXos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2NJ53JSlLFptUgFr7UcRYFOHBd+sLXSZToN0sekbPiKA3lgcGo63FZqTf4++J7dVelLttkvJ7zQUNlsdvzo2hcZTD0HyEYf7OLJGUWC+rGfPw73oDeziFLWg1GWCH8TF6nmOyvtSMqtsUimURMddkO4FkLQJP6DfN0eNqucp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl5iD4lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D95EC4AF67;
	Sun,  5 May 2024 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714919241;
	bh=vbQmVIViLlnHnV/HmsoDNHPWB+6N7x9rENWps4lsXos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xl5iD4lueG8tIPXrO/gEXU39XDfM3YC/JMMh3852CFxF2oYh+paX9vBtiDNHobolr
	 fT4G8IF9fkbLUdGv2ikdeuc6+J2xDFH0KR/VTbUG+Hv/QdKrBr+pSDv9DFzfUPP2I3
	 bP2It0ZiWqKrpaFsBerSAvvYt92y2em8jZ93u0QN8uW5A3MxYvy1JsUox9JZRQ11j8
	 hWmui1dlwkA0uUH0DLGz65sT+kLHQX0p9W2t3k9zMl14nQC7TMegAfhWBFTdDhkJMw
	 rp4g/OdSjIa699sH+T7Z+caC4c3erFuVC8VvAkXFGQHM++7hzBOqRdtcFRKejSaFcx
	 8h5mYj3Qiu98Q==
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
	Liviu Dudau <liviu@dudau.co.uk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
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
Subject: [PATCH v8 05/17] module: make module_memory_{alloc,free} more self-contained
Date: Sun,  5 May 2024 17:25:48 +0300
Message-ID: <20240505142600.2322517-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505142600.2322517-1-rppt@kernel.org>
References: <20240505142600.2322517-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Move the logic related to the memory allocation and freeing into
module_memory_alloc() and module_memory_free().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


