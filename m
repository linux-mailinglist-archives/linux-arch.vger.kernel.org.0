Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAA363FD4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhDSKr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 06:47:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56735 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237658AbhDSKr6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 06:47:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FP3Rb2KYszB09b4;
        Mon, 19 Apr 2021 12:47:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7eereoURzSwB; Mon, 19 Apr 2021 12:47:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FP3Rb1LMMzB09Zy;
        Mon, 19 Apr 2021 12:47:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B25E8B7BB;
        Mon, 19 Apr 2021 12:47:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fFkYOwiTbh2u; Mon, 19 Apr 2021 12:47:27 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C7E458B7B4;
        Mon, 19 Apr 2021 12:47:27 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C1075679FC; Mon, 19 Apr 2021 10:47:27 +0000 (UTC)
Message-Id: <c56ce1f5c3c75adc9811b1a5f9c410fa74183a8d.1618828806.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618828806.git.christophe.leroy@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/4] powerpc/mm: Properly coalesce pages in ptdump
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        dja@axtens.net
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Mon, 19 Apr 2021 10:47:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit aaa229529244 ("powerpc/mm: Add physical address to Linux page
table dump") changed range coalescing to only combine ranges that are
both virtually and physically contiguous, in order to avoid erroneous
combination of unrelated mappings in IOREMAP space.

But in the VMALLOC space, mappings almost never have contiguous
physical pages, so the commit mentionned above leads to dumping one
line per page for vmalloc mappings.

Taking into account the vmalloc always leave a gap between two areas,
we never have two mappings dumped as a single combination even if they
have the exact same flags. The only space that may have encountered
such an issue was the early IOREMAP which is not using vmalloc engine.
But previous commits added gaps between early IO mappings, so it is
not an issue anymore.

That commit created some difficulties with KASAN mappings, see
commit cabe8138b23c ("powerpc: dump as a single line areas mapping a
single physical page.") and with huge page, see
commit b00ff6d8c1c3 ("powerpc/ptdump: Properly handle non standard
page size").

So, almost revert commit aaa229529244 to properly coalesce pages
mapped with the same flags as before, only keep the display of the
first physical address of the range, as it can be usefull especially
for IO mappings.

It brings back powerpc at the same level as other architectures and
simplifies the conversion to GENERIC PTDUMP.

With the patch:

---[ kasan shadow mem start ]---
0xf8000000-0xf8ffffff  0x07000000        16M   huge        rw       present           dirty  accessed
0xf9000000-0xf91fffff  0x01434000         2M               r        present                  accessed
0xf9200000-0xf95affff  0x02104000      3776K               rw       present           dirty  accessed
0xfef5c000-0xfeffffff  0x01434000       656K               r        present                  accessed
---[ kasan shadow mem end ]---

Before:

---[ kasan shadow mem start ]---
0xf8000000-0xf8ffffff  0x07000000        16M   huge        rw       present           dirty  accessed
0xf9000000-0xf91fffff  0x01434000        16K               r        present                  accessed
0xf9200000-0xf9203fff  0x02104000        16K               rw       present           dirty  accessed
0xf9204000-0xf9207fff  0x0213c000        16K               rw       present           dirty  accessed
0xf9208000-0xf920bfff  0x02174000        16K               rw       present           dirty  accessed
0xf920c000-0xf920ffff  0x02188000        16K               rw       present           dirty  accessed
0xf9210000-0xf9213fff  0x021dc000        16K               rw       present           dirty  accessed
0xf9214000-0xf9217fff  0x02220000        16K               rw       present           dirty  accessed
0xf9218000-0xf921bfff  0x023c0000        16K               rw       present           dirty  accessed
0xf921c000-0xf921ffff  0x023d4000        16K               rw       present           dirty  accessed
0xf9220000-0xf9227fff  0x023ec000        32K               rw       present           dirty  accessed
...
0xf93b8000-0xf93e3fff  0x02614000       176K               rw       present           dirty  accessed
0xf93e4000-0xf94c3fff  0x027c0000       896K               rw       present           dirty  accessed
0xf94c4000-0xf94c7fff  0x0236c000        16K               rw       present           dirty  accessed
0xf94c8000-0xf94cbfff  0x041f0000        16K               rw       present           dirty  accessed
0xf94cc000-0xf94cffff  0x029c0000        16K               rw       present           dirty  accessed
0xf94d0000-0xf94d3fff  0x041ec000        16K               rw       present           dirty  accessed
0xf94d4000-0xf94d7fff  0x0407c000        16K               rw       present           dirty  accessed
0xf94d8000-0xf94f7fff  0x041c0000       128K               rw       present           dirty  accessed
...
0xf95ac000-0xf95affff  0x042b0000        16K               rw       present           dirty  accessed
0xfef5c000-0xfeffffff  0x01434000        16K               r        present                  accessed
---[ kasan shadow mem end ]---

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/ptdump/ptdump.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index aca354fb670b..5062c58b1e5b 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -58,8 +58,6 @@ struct pg_state {
 	const struct addr_marker *marker;
 	unsigned long start_address;
 	unsigned long start_pa;
-	unsigned long last_pa;
-	unsigned long page_size;
 	unsigned int level;
 	u64 current_flags;
 	bool check_wx;
@@ -163,8 +161,6 @@ static void dump_flag_info(struct pg_state *st, const struct flag_info
 
 static void dump_addr(struct pg_state *st, unsigned long addr)
 {
-	unsigned long delta;
-
 #ifdef CONFIG_PPC64
 #define REG		"0x%016lx"
 #else
@@ -172,14 +168,8 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 #endif
 
 	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
-	if (st->start_pa == st->last_pa && st->start_address + st->page_size != addr) {
-		pt_dump_seq_printf(st->seq, "[" REG "]", st->start_pa);
-		delta = st->page_size >> 10;
-	} else {
-		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
-		delta = (addr - st->start_address) >> 10;
-	}
-	pt_dump_size(st->seq, delta);
+	pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
+	pt_dump_size(st->seq, (addr - st->start_address) >> 10);
 }
 
 static void note_prot_wx(struct pg_state *st, unsigned long addr)
@@ -208,7 +198,6 @@ static void note_page_update_state(struct pg_state *st, unsigned long addr,
 	st->current_flags = flag;
 	st->start_address = addr;
 	st->start_pa = pa;
-	st->page_size = page_size;
 
 	while (addr >= st->marker[1].start_address) {
 		st->marker++;
@@ -220,7 +209,6 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	       unsigned int level, u64 val, unsigned long page_size)
 {
 	u64 flag = val & pg_level[level].mask;
-	u64 pa = val & PTE_RPN_MASK;
 
 	/* At first no level is set */
 	if (!st->level) {
@@ -232,12 +220,9 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	 *   - we change levels in the tree.
 	 *   - the address is in a different section of memory and is thus
 	 *   used for a different purpose, regardless of the flags.
-	 *   - the pa of this page is not adjacent to the last inspected page
 	 */
 	} else if (flag != st->current_flags || level != st->level ||
-		   addr >= st->marker[1].start_address ||
-		   (pa != st->last_pa + st->page_size &&
-		    (pa != st->start_pa || st->start_pa != st->last_pa))) {
+		   addr >= st->marker[1].start_address) {
 
 		/* Check the PTE flags */
 		if (st->current_flags) {
@@ -259,7 +244,6 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		 */
 		note_page_update_state(st, addr, level, val, page_size);
 	}
-	st->last_pa = pa;
 }
 
 static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
-- 
2.25.0

