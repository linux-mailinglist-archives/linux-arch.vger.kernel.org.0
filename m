Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD58C473B09
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhLNCzb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:31 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41813 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhLNCz0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:26 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bf012823;
        Tue, 14 Dec 2021 11:54:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bf012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450445;
        bh=ycfN/18OUImXg3GfQ9MnYJuonV/TkQumnCQ5gyi4HgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bX8LdUwO+h/aBNVZSYWPEN3hnaK+FxGPlhv7Gt5Dnrpv7jMT1aj4e+AiKZ7PsD0PL
         XkPTxTEDNTMp0aBGeLURdgt/dRNwRqUCFwWklGbGzQ0WBwJfsg3jz94OZVCivtm93h
         vgwjEl7g1x5rMNr2TVcT3eYn3JzBb6RN5nO2S5s5iUx6Z1i8nG6dsXW8X1xTPP0LKS
         f6k2zj1ET7cWAIV+HmNi1uImCCQlxe87MYJAiIQPmozbk1u40OCPWJsFLkmCSqtdMc
         qQM9FH1Anvp+ZH+naoGwg1B8d0Ow1NGdOIMzz/QN8X5qdqRDp3spnVsxy4RGW2aqm/
         DOeQO9YdPlOYA==
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
Subject: [PATCH v2 04/11] certs: refactor file cleaning
Date:   Tue, 14 Dec 2021 11:53:48 +0900
Message-Id: <20211214025355.1267796-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'make clean' removes files listed in 'targets'. It is redundant to
specify both 'targets' and 'clean-files'.

Move 'targets' assignments out of the ifeq-conditionals so
scripts/Makefile.clean can see them.

One effective change is that certs/certs/signing_key.x509 is now
deleted by 'make clean' instead of 'make mrproper. This certificate
is embedded in the kernel. It is not used in any way by external
module builds.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

 Makefile       | 2 +-
 certs/Makefile | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 0a6ecc8bb2d2..4e8ac0730f51 100644
--- a/Makefile
+++ b/Makefile
@@ -1503,7 +1503,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  debian snap tar-install \
 		  .config .config.old .version \
 		  Module.symvers \
-		  certs/signing_key.pem certs/signing_key.x509 \
+		  certs/signing_key.pem \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
 		  *.spec
diff --git a/certs/Makefile b/certs/Makefile
index d1e0dad038ca..bb1763150547 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -22,12 +22,11 @@ $(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
 # GCC doesn't include .incbin files in -MD generated dependencies (PR#66871)
 $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 
-targets += x509_certificate_list
 $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
 endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 
-clean-files := x509_certificate_list .x509.list x509_revocation_list
+targets += x509_certificate_list
 
 ifeq ($(CONFIG_MODULE_SIG),y)
 	SIGN_KEY = y
@@ -84,18 +83,20 @@ endif
 # GCC PR#66871 again.
 $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
-targets += signing_key.x509
 $(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
 	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
 endif # CONFIG_MODULE_SIG
 
+targets += signing_key.x509
+
 ifeq ($(CONFIG_SYSTEM_REVOCATION_LIST),y)
 
 $(eval $(call config_filename,SYSTEM_REVOCATION_KEYS))
 
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
-targets += x509_revocation_list
 $(obj)/x509_revocation_list: scripts/extract-cert $(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(SYSTEM_REVOCATION_KEYS_FILENAME) FORCE
 	$(call if_changed,extract_certs,$(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_REVOCATION_KEYS))
 endif
+
+targets += x509_revocation_list
-- 
2.32.0

