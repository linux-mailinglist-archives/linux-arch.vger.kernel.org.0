Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461A9332A2E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhCIPSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 10:18:54 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31186 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhCIPS1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 10:18:27 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 129FHiTd030658;
        Wed, 10 Mar 2021 00:17:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 129FHiTd030658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615303066;
        bh=aiZL314cCgH6pTtZI6W6PU8ZHJmV18CncdIR5eQC6Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sra+heZ7kORAq5P/K68lyyqZQjtoJfrhauSin9UyhFdvCwa+Uv+t+axs0pFsLm5b8
         bGh6VqJWglTUDo8HgAm9AMN35eaiJPZmszccabI85+EkaolmClebLvyp6iyzk0H04b
         JZmGNVBXzibKH7jPIXFuupNDA8tnAu44RbGZVw+83cRKNwR5cEn7m6vH6vBTvyuAWQ
         h7pv8AQXjKYKzRQu6JP0O40PQTnmvGc2Xba8MUdrR0PiQD3bs4L5R5ktP9XLTS5CL0
         BTHP0VaZP+2/MBfOmaoIgPJovzKqwumhLP7V00BoUPQgDMiMeEd+p7IuDsXVxfafHL
         DKU9LJGq/aHTA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/4] export.h: make __ksymtab_strings per-symbol section
Date:   Wed, 10 Mar 2021 00:17:34 +0900
Message-Id: <20210309151737.345722-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210309151737.345722-1-masahiroy@kernel.org>
References: <20210309151737.345722-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The export symbol tables are placed on own sections (__ksymtab*+<sym>)
and sorted by SORT (an alias of SORT_BY_NAME) because the module
subsystem uses the binary search for symbol resolution.

We did not have a good reason to do so for __ksymtab_strings, but
now I have.

To make CONFIG_TRIM_UNUSED_KSYMS work in one-pass, the linker needs
to trim unused strings of symbols and namespaces. To allow per-symbol
keep/drop choice, __ksymtab_strings must be placed on own sections.

This keeps the string unification introduced by commit ce2b617ce8cb
("export.h: reduce __ksymtab_strings string duplication by using "MS"
section flags").

For example, the empty namespaces share the same address.

  $ nm -n vmlinux
  [ snip ]
  ffffffff8233b6aa r __kstrtabns_IO_APIC_get_PCI_irq_vector
  ffffffff8233b6aa r __kstrtabns_I_BDEV
  ffffffff8233b6aa r __kstrtabns_LZ4_decompress_fast
  ffffffff8233b6aa r __kstrtabns_LZ4_decompress_fast_continue
  ffffffff8233b6aa r __kstrtabns_LZ4_decompress_fast_usingDict
    ...

I confirmed no size change in vmlinux.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 include/asm-generic/export.h      | 2 +-
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/export.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 07a36a874dca..e847f1fde367 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -39,7 +39,7 @@
 __ksymtab_\name:
 	__put \val, __kstrtab_\name
 	.previous
-	.section __ksymtab_strings,"aMS",%progbits,1
+	.section __ksymtab_strings+\name,"aMS",%progbits,1
 __kstrtab_\name:
 	.asciz "\name"
 	.previous
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0331d5d49551..6ce6dcabdccf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -513,7 +513,7 @@
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
-		*(__ksymtab_strings)					\
+		*(__ksymtab_strings+*)					\
 	}								\
 									\
 	/* __*init sections */						\
diff --git a/include/linux/export.h b/include/linux/export.h
index 6271a5d9c988..01e6ab19b226 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -99,7 +99,7 @@ struct kernel_symbol {
 	extern const char __kstrtab_##sym[];					\
 	extern const char __kstrtabns_##sym[];					\
 	__CRC_SYMBOL(sym, sec);							\
-	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1	\n"	\
+	asm("	.section \"__ksymtab_strings+" #sym "\",\"aMS\",%progbits,1\n"	\
 	    "__kstrtab_" #sym ":					\n"	\
 	    "	.asciz 	\"" #sym "\"					\n"	\
 	    "__kstrtabns_" #sym ":					\n"	\
-- 
2.27.0

