Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF4471CC0
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 20:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhLLTkB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Dec 2021 14:40:01 -0500
Received: from condef-01.nifty.com ([202.248.20.66]:36764 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLLTkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Dec 2021 14:40:00 -0500
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-01.nifty.com with ESMTP id 1BCJV37U028651
        for <linux-arch@vger.kernel.org>; Mon, 13 Dec 2021 04:31:03 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1BCJTqAo000552;
        Mon, 13 Dec 2021 04:29:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BCJTqAo000552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639337396;
        bh=2g0tBurhBmvuApdFMavEEHFbPrAFXCWxdFQ5K1KWeCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qb36dAb7EH/VE+6ua4zaAYZfs3QbELmdy8H9Who9cyvYp0dxwf6pQeARSebHzS1+o
         fvwS45+mYGRWfOnZaU3BSMf4jtW4jkQtNjzUokl6RwRvrbQB4dU7+Ut7f1ttsyX8BX
         bijuc5IsNTHq7r00VBTcsGt3jmZbGfDhA3NLYB+lyedrBtXHNsbQkmx0GNAGDEmCwo
         RjreLSkQyx1diS2grHcjknTnXANOIz18qjxxleeph3MO6vZzs7SYCt0Y6tsa35m6Jd
         6E9nBp4Wg2XRiePtkDNC3f65pGzU/OfkQ6RvoXUDCivpq3A6k9FtoodfaIUITpZv1W
         gnR6vmJI9lD4A==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 04/10] certs: refactor file cleaning
Date:   Mon, 13 Dec 2021 04:29:35 +0900
Message-Id: <20211212192941.1149247-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212192941.1149247-1-masahiroy@kernel.org>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
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
---

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
index e7d6ee183496..0dc523e8ca7c 100644
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

