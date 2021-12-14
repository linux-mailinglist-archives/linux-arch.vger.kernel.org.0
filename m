Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A526D473B11
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbhLNCze (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:34 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41846 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhLNCz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:27 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bl012823;
        Tue, 14 Dec 2021 11:54:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bl012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450450;
        bh=CTygUjJA1h3CqGPioCmYHYypWW1IAIFm8zAYLRIwBG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTA2qyKVFbfzPkPVBVH3djKHBYCAREWVDKNjU/RIH8hfFYdPp6e5kj5um4FL3RLyL
         sxhb6xMn4FM92gAj1UJjtzbv8cGg3gAMvJYOhcVCGiVlrewjqpKROZoih/mCOs8Wd7
         7RW4pPaA++BVxBwUe9+sFxN7pp6jiut1z2zTIBl2BIrIcPhLobibN0FUMfdGx9r725
         7V7lJs69gpVASCkqAUezXRmPeApweWdthltDWbIM6h2Jwk1xXHSj2O5o07p2VLlbYO
         uPteVf46ZTo3BqZH1GJCu/Uwg29zWXI762O1w0Y/1/Rum+pC7ADQvuBrfPJIzLIWBW
         ii9CZ7MDahNOA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 10/11] certs: move scripts/extract-cert to certs/
Date:   Tue, 14 Dec 2021 11:53:54 +0900
Message-Id: <20211214025355.1267796-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

extract-cert is only used in certs/Makefile.

Move it there and build extract-cert on demand.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - new patch

 MAINTAINERS                       |  1 -
 certs/.gitignore                  |  1 +
 certs/Makefile                    | 13 +++++++++----
 {scripts => certs}/extract-cert.c |  2 +-
 scripts/.gitignore                |  1 -
 scripts/Makefile                  | 11 ++---------
 scripts/remove-stale-files        |  2 ++
 7 files changed, 15 insertions(+), 16 deletions(-)
 rename {scripts => certs}/extract-cert.c (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d..f321ddbb1ab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4410,7 +4410,6 @@ L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
-F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
 
 CFAG12864B LCD DRIVER
diff --git a/certs/.gitignore b/certs/.gitignore
index 8c3763f80be3..9e42fe3e02f5 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+/extract-cert
 /x509_certificate_list
 /x509_revocation_list
diff --git a/certs/Makefile b/certs/Makefile
index 7b48445d71f6..f7041c29a2e0 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -13,11 +13,11 @@ obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
 endif
 
 quiet_cmd_extract_certs  = CERT    $@
-      cmd_extract_certs  = scripts/extract-cert $(2) $@
+      cmd_extract_certs  = $(obj)/extract-cert $(2) $@
 
 $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 
-$(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) scripts/extract-cert FORCE
+$(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
 	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""))
 
 targets += x509_certificate_list
@@ -74,7 +74,7 @@ endif
 
 $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
-$(obj)/signing_key.x509: $(X509_DEP) scripts/extract-cert FORCE
+$(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
 	$(call if_changed,extract_certs,$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)))
 endif # CONFIG_MODULE_SIG
 
@@ -82,7 +82,12 @@ targets += signing_key.x509
 
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
-$(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) scripts/extract-cert FORCE
+$(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cert FORCE
 	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_REVOCATION_KEYS),$<,""))
 
 targets += x509_revocation_list
+
+hostprogs := extract-cert
+
+HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
diff --git a/scripts/extract-cert.c b/certs/extract-cert.c
similarity index 98%
rename from scripts/extract-cert.c
rename to certs/extract-cert.c
index 3bc48c726c41..f7ef7862f207 100644
--- a/scripts/extract-cert.c
+++ b/certs/extract-cert.c
@@ -29,7 +29,7 @@ static __attribute__((noreturn))
 void format(void)
 {
 	fprintf(stderr,
-		"Usage: scripts/extract-cert <source> <dest>\n");
+		"Usage: extract-cert <source> <dest>\n");
 	exit(2);
 }
 
diff --git a/scripts/.gitignore b/scripts/.gitignore
index e83c620ef52c..eed308bef604 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /asn1_compiler
 /bin2c
-/extract-cert
 /insert-sys-cert
 /kallsyms
 /module.lds
diff --git a/scripts/Makefile b/scripts/Makefile
index 9adb6d247818..e198b22dc476 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -3,25 +3,18 @@
 # scripts contains sources for various helper programs used throughout
 # the kernel for the build process.
 
-CRYPTO_LIBS = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
-CRYPTO_CFLAGS = $(shell pkg-config --cflags libcrypto 2> /dev/null)
-
 hostprogs-always-$(CONFIG_BUILD_BIN2C)			+= bin2c
 hostprogs-always-$(CONFIG_KALLSYMS)			+= kallsyms
 hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
-hostprogs-always-$(CONFIG_SYSTEM_TRUSTED_KEYRING)	+= extract-cert
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
-hostprogs-always-$(CONFIG_SYSTEM_REVOCATION_LIST)	+= extract-cert
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-HOSTCFLAGS_sign-file.o = $(CRYPTO_CFLAGS)
-HOSTLDLIBS_sign-file = $(CRYPTO_LIBS)
-HOSTCFLAGS_extract-cert.o = $(CRYPTO_CFLAGS)
-HOSTLDLIBS_extract-cert = $(CRYPTO_LIBS)
+HOSTCFLAGS_sign-file.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
 
 ifdef CONFIG_UNWINDER_ORC
 ifeq ($(ARCH),x86_64)
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index 0114c41e6938..dd230792056a 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -34,3 +34,5 @@ if [ -n "${building_out_of_srctree}" ]; then
 		rm -f arch/mips/boot/compressed/${f}
 	done
 fi
+
+rm -f scripts/extract-cert
-- 
2.32.0

