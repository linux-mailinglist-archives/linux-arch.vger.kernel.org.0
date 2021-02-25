Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0A325304
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBYQFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 11:05:16 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53228 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhBYQFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 11:05:00 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 11PG2sqI028425;
        Fri, 26 Feb 2021 01:02:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11PG2sqI028425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614268976;
        bh=rqTCXbAIKtjWiyJJOQQ8P1erPfZijzq85UeCJgSaFeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=namUn3zFc4hj18tNupcZPnd//LKVnFHGYRmCfEj4pxcbT+pB1/WP+lnnDsFsr86GY
         tLCuzzOOJdlOdU9vV2SnMfYmCHRZCchh/xb84WS2OZApKqZ18y/SCcnxFdwnFCalYm
         QJe2iDk0ti+FeazoFJnIzLqjiOKQVmE74EPrd4MeptrIQwBS1PfHdAaHXxmjTGEcyP
         LcgehKNvKgSPYgcMjQiJ2RGFunJC7RV7bOWXgNfIRVw8XDt6YWIn1hnxCOHfljrUIX
         sXctTqFRFYdJr+31k8LQ+63sZe9vhYip1e0UMywl7m/SuwiUoCTeLRcA66tOTGcxXY
         MP6uu6BNq8g2w==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/4] export.h: make __ksymtab_strings per-symbol section
Date:   Fri, 26 Feb 2021 01:02:44 +0900
Message-Id: <20210225160247.2959903-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210225160247.2959903-1-masahiroy@kernel.org>
References: <20210225160247.2959903-1-masahiroy@kernel.org>
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
Of course, SORT is unneeded here, though.

This keeps the string unification introduced by commit ce2b617ce8cb
("export.h: reduce __ksymtab_strings string duplication by using "MS"
section flags").

For example, the empty namespaces share the same address.

  $ nm -n
  [ snip ]
  ffffffff8233b53a r __kstrtabns_IO_APIC_get_PCI_irq_vector
  ffffffff8233b53a r __kstrtabns_I_BDEV
  ffffffff8233b53a r __kstrtabns_LZ4_decompress_fast
  ffffffff8233b53a r __kstrtabns_LZ4_decompress_fast_continue
  ffffffff8233b53a r __kstrtabns_LZ4_decompress_fast_usingDict
  ffffffff8233b53a r __kstrtabns_LZ4_decompress_safe
  ffffffff8233b53a r __kstrtabns_LZ4_decompress_safe_continue
    ...

I confirmed no size change in vmlinux.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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
index c54adce8f6f6..5a2b31890bb8 100644
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

