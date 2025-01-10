Return-Path: <linux-arch+bounces-9693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195EA09B3F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48D63A889B
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B545225A4C;
	Fri, 10 Jan 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDkGrgTK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311A224899
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534503; cv=none; b=uCb4BP3nPd8BaNrSYnPrXGPl84e2h9M4R3Bb+LJY957cA3jGhJetgUXxFbzM1IJnxU45JKG3/9Jurt6OBy0wuwwDzHTWzDEam9BV7WhotjFddokcQc7pzDYJJP+GBK1D4nROAJdl8ePtV5hA26atAlxsW9j0rQC8hcVeFeBUgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534503; c=relaxed/simple;
	bh=SZWSB4xfWiJGdbbRiBIwnZ68GYA4NlfRz2uMWEeyAjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNFVmmmH1tonCSIn71mrfRrqWZG1H3QBblBLZU8j/Zsl/PGvrTSSdJ6vRf7uIXvcUQmWB8wKDiyxHb9CUVELJreXIYctFn0eyCVhgbn9wYADJi/ORn0WJWoDavr2c5exg8KFULvZAYmqFJw1nTyJlfYvEVkh/Xe/fNxrptf/+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDkGrgTK; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3862b364578so1612480f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534480; x=1737139280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw/CnxStV8mvixiIOCl4TLOf7+c8cjSAdFrfDhkuuHg=;
        b=iDkGrgTKHVUa34+ZKmxOSc0xwlurss6RE8/r+LqYpqitJzMkpPySm7IZKpZHys9em2
         pnj9244eqbH46mK1dAP3AIse9cR2NBErzZbkf2d9DcAGpNvZh7PiY4LCjtICGW9V/YRP
         cJYr7hXel2n3RMuEQzGuA8h9TVs/fkUzZenWMztEJLjyxdwVOR7EjfUkybgTay/Xb+uk
         Y/Tst3A3W6yIWuUi3EA2NI4A8NYG4KT/8HSFxSt79sr41pHhJciLC7MjYC3EhXz+on3e
         fMuQWtQINtB6NLiLlGtQ9U3H3PCaK7LP5AhdGJvCvg46xw9SQTssN/MolzzES9pFiX54
         /Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534480; x=1737139280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw/CnxStV8mvixiIOCl4TLOf7+c8cjSAdFrfDhkuuHg=;
        b=CZ+8EOumNxBrLshByK+WVMR2aALkQOmbdac0x9w8YXKzvKkR1sHALuEX05dxIMWTCB
         U/5k/OqqesIE9hqhGZVknFrUEn9MI9zgwM3Vbpda2kltXnrh1wYfRoMubV58DzARk0w9
         j+osDENgYDEiQOY4WmhIPzciGS0Y/15bnpti1CHUf8+X7Vvmg1oiaRb0neEvvSh1CKPZ
         UVp7l1zbcVL4PjAJanoeCEONORHgXgtSfiioCzLUqvJL08oFWTAV+yJHbXd5za8eRWRO
         zoetYgWtX55e5kOqAziv+XLTDUsWNVgxhllxDp0280/hSbvlYbXDfQl01U+JK1YqfWfK
         8llw==
X-Forwarded-Encrypted: i=1; AJvYcCUY2wkS9iJ10YpEA+hmTemIk7YPrjKHUyhCfuiTDY8DElqqPe2kyK4JmZMe3Bbi9XdW+Z4KNweglBJr@vger.kernel.org
X-Gm-Message-State: AOJu0YxqY3BA0NK/26nsw+UO6L3+AtLUjbpY1BCCg2hiSM/vbp8tpQo5
	GILJ3SjS9XMsq+1fvigL3ljYVOIkGG/7QZlxN6w+pGmHOeU8gTXtiYxpOuJVrV+8J7xpa1yu6gG
	Fgfn0987WVA==
X-Google-Smtp-Source: AGHT+IEfIL+1aAzwB4pbtK9eyCgzXtWnxn8Tg5skOTY2l9Jdg/lcArfVr7lNF3vncmrBkENqt6o7go6KThD7+Q==
X-Received: from wmqe1.prod.google.com ([2002:a05:600c:4e41:b0:434:a050:ddcf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1547:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38a8b0b7fd0mr6975597f8f.4.1736534479521;
 Fri, 10 Jan 2025 10:41:19 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:41 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-15-8419288bc805@google.com>
Subject: [PATCH TEMP WORKAROUND RFC v2 15/29] mm: asi: Workaround missing
 partial-unmap support
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This is a hack, no need to review it carefully. asi_unmap() doesn't
currently work unless it corresponds exactly to an asi_map() of the
exact same region.

This is mostly harmless (it's only a functional problem if you wanna
touch those pages from the ASI critical section) but it's messy. For
now, working around the only practical case that appears by moving the
asi_map call up the call stack in the page allocator, to the place where
we know the actual size the mapping is supposed to end up at.

This just removes the main case where that happens. Later, a proper
solution for partial unmaps will be needed.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e98fdfbadddb1f7d71e9e050b63255b2008d167..f96e95032450be90b6567f67915b0b941fc431d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4604,22 +4604,20 @@ void __init page_alloc_init_asi(void)
 	}
 }
 
-static int asi_map_alloced_pages(struct page *page, uint order, gfp_t gfp_mask)
+static int asi_map_alloced_pages(struct page *page, size_t size, gfp_t gfp_mask)
 {
 
 	if (!static_asi_enabled())
 		return 0;
 
 	if (!(gfp_mask & __GFP_SENSITIVE)) {
-		int err = asi_map_gfp(
-			ASI_GLOBAL_NONSENSITIVE, page_to_virt(page),
-			PAGE_SIZE * (1 << order), gfp_mask);
+		int err = asi_map_gfp(ASI_GLOBAL_NONSENSITIVE, page_to_virt(page), size, gfp_mask);
 		uint i;
 
 		if (err)
 			return err;
 
-		for (i = 0; i < (1 << order); i++)
+		for (i = 0; i < (size >> PAGE_SHIFT); i++)
 			__SetPageGlobalNonSensitive(page + i);
 	}
 
@@ -4629,7 +4627,7 @@ static int asi_map_alloced_pages(struct page *page, uint order, gfp_t gfp_mask)
 #else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 static inline
-int asi_map_alloced_pages(struct page *pages, uint order, gfp_t gfp_mask)
+int asi_map_alloced_pages(struct page *pages, size_t size, gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -4896,7 +4894,7 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 
-	if (page && unlikely(asi_map_alloced_pages(page, order, gfp))) {
+	if (page && unlikely(asi_map_alloced_pages(page, PAGE_SIZE << order, gfp))) {
 		__free_pages(page, order);
 		page = NULL;
 	}
@@ -5118,12 +5116,13 @@ void page_frag_free(void *addr)
 }
 EXPORT_SYMBOL(page_frag_free);
 
-static void *make_alloc_exact(unsigned long addr, unsigned int order,
-		size_t size)
+static void *finish_exact_alloc(unsigned long addr, unsigned int order,
+		size_t size, gfp_t gfp_mask)
 {
 	if (addr) {
 		unsigned long nr = DIV_ROUND_UP(size, PAGE_SIZE);
 		struct page *page = virt_to_page((void *)addr);
+		struct page *first = page;
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
@@ -5132,9 +5131,22 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		while (page < --last)
 			set_page_refcounted(last);
 
-		last = page + (1UL << order);
+		last = page + (1 << order);
 		for (page += nr; page < last; page++)
 			__free_pages_ok(page, 0, FPI_TO_TAIL);
+
+		/*
+		 * ASI doesn't support partially undoing calls to asi_map, so
+		 * we can only safely free sub-allocations if they were made
+		 * with __GFP_SENSITIVE in the first place. Users of this need
+		 * to map with forced __GFP_SENSITIVE and then here we'll make a
+		 * second asi_map_alloced_pages() call to do any mapping that's
+		 * necessary, but with the exact size.
+		 */
+		if (unlikely(asi_map_alloced_pages(first, nr << PAGE_SHIFT, gfp_mask))) {
+			free_pages_exact(first, size);
+			return NULL;
+		}
 	}
 	return (void *)addr;
 }
@@ -5162,8 +5174,8 @@ void *alloc_pages_exact_noprof(size_t size, gfp_t gfp_mask)
 	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
 		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
-	addr = get_free_pages_noprof(gfp_mask, order);
-	return make_alloc_exact(addr, order, size);
+	addr = get_free_pages_noprof(gfp_mask | __GFP_SENSITIVE, order);
+	return finish_exact_alloc(addr, order, size, gfp_mask);
 }
 EXPORT_SYMBOL(alloc_pages_exact_noprof);
 
@@ -5187,10 +5199,10 @@ void * __meminit alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_ma
 	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
 		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
 
-	p = alloc_pages_node_noprof(nid, gfp_mask, order);
+	p = alloc_pages_node_noprof(nid, gfp_mask | __GFP_SENSITIVE, order);
 	if (!p)
 		return NULL;
-	return make_alloc_exact((unsigned long)page_address(p), order, size);
+	return finish_exact_alloc((unsigned long)page_address(p), order, size, gfp_mask);
 }
 
 /**

-- 
2.47.1.613.gc27f4b7a9f-goog


