Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56F473B03
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhLNCz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:29 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41827 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhLNCz0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:26 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bi012823;
        Tue, 14 Dec 2021 11:54:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bi012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450448;
        bh=30IqlpIC5GLWBsrKPT7oz+p6+AmM0HnlncKcSJNr3OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VO8TXRFmlTKxZrvs7iDP+9+UdT8EfWMKeXN/MyXBbmYghyXzYcZJ4dAkBHh0B01dQ
         PZXnAKCrTmfqbOSoir0LT6Q7mmtO4qF5/PGANzEyNwGn7yb6FU1wA2H5Opf+etdUao
         LjF0WDCRiYIJ+K0Akr9IutVJ4LYBcqH0wY+PWLPmeFmCmDwZmL8H9KEmtxgorn1uxx
         R2xilBUwqdDYS7DytvSRqIMGw+DnbNixScZj+gd0Fz4emL411ePlXdzeIyIqDfZ8Qk
         I+2xYfp+KZlYG1eqO2068s8GpXtfHPyje5lLZSwOUdvXm3cFQKiyw23fjeOHnnbG+4
         lujeiM34+H1EQ==
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
Subject: [PATCH v2 07/11] certs: simplify $(srctree)/ handling and remove config_filename macro
Date:   Tue, 14 Dec 2021 11:53:51 +0900
Message-Id: <20211214025355.1267796-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The complex macro, config_filename, was introduced to do:

 [1] drop double-quotes from the string value
 [2] add $(srctree)/ prefix in case the file is not found in $(objtree)
 [3] escape spaces and more

[1] will be more generally handled by Kconfig later.

As for [2], Kbuild uses VPATH to search for files in $(objtree),
$(srctree) in this order. GNU Make can natively handle it.

As for [3], converting $(space) to $(space_escape) back and forth looks
questionable to me. It is well-known that GNU Make cannot handle file
paths with spaces in the first place.

Instead of using the complex macro, use $< so it will be expanded to
the file path of the key.

Remove config_filename, finally.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 certs/Makefile         | 32 ++++++++++++----------------
 scripts/Kbuild.include | 47 ------------------------------------------
 2 files changed, 13 insertions(+), 66 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index c3c8da03b04b..69c1404152ef 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -15,15 +15,12 @@ endif
 quiet_cmd_extract_certs  = CERT    $@
       cmd_extract_certs  = scripts/extract-cert $(2) $@
 
-ifeq ($(CONFIG_SYSTEM_TRUSTED_KEYRING),y)
-
-$(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
-
 $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 
-$(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
-	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
-endif # CONFIG_SYSTEM_TRUSTED_KEYRING
+CONFIG_SYSTEM_TRUSTED_KEYS := $(CONFIG_SYSTEM_TRUSTED_KEYS:"%"=%)
+
+$(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) scripts/extract-cert FORCE
+	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""))
 
 targets += x509_certificate_list
 
@@ -72,29 +69,26 @@ $(obj)/x509.genkey:
 
 endif # CONFIG_MODULE_SIG_KEY
 
-$(eval $(call config_filename,MODULE_SIG_KEY))
+CONFIG_MODULE_SIG_KEY := $(CONFIG_MODULE_SIG_KEY:"%"=%)
 
 # If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
-ifeq ($(patsubst pkcs11:%,%,$(firstword $(MODULE_SIG_KEY_FILENAME))),$(firstword $(MODULE_SIG_KEY_FILENAME)))
-X509_DEP := $(MODULE_SIG_KEY_SRCPREFIX)$(MODULE_SIG_KEY_FILENAME)
+ifneq ($(filter-out pkcs11:%, %(CONFIG_MODULE_SIG_KEY)),)
+X509_DEP := $(CONFIG_MODULE_SIG_KEY)
 endif
 
 $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
-$(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
-	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
+$(obj)/signing_key.x509: $(X509_DEP) scripts/extract-cert FORCE
+	$(call if_changed,extract_certs,$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)))
 endif # CONFIG_MODULE_SIG
 
 targets += signing_key.x509
 
-ifeq ($(CONFIG_SYSTEM_REVOCATION_LIST),y)
-
-$(eval $(call config_filename,SYSTEM_REVOCATION_KEYS))
-
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
-$(obj)/x509_revocation_list: scripts/extract-cert $(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(SYSTEM_REVOCATION_KEYS_FILENAME) FORCE
-	$(call if_changed,extract_certs,$(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_REVOCATION_KEYS))
-endif
+CONFIG_SYSTEM_REVOCATION_KEYS := $(CONFIG_SYSTEM_REVOCATION_KEYS:"%"=%)
+
+$(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) scripts/extract-cert FORCE
+	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_REVOCATION_KEYS),$<,""))
 
 targets += x509_revocation_list
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cdec22088423..3514c2149e9d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -195,53 +195,6 @@ why =                                                                        \
 echo-why = $(call escsq, $(strip $(why)))
 endif
 
-###############################################################################
-#
-# When a Kconfig string contains a filename, it is suitable for
-# passing to shell commands. It is surrounded by double-quotes, and
-# any double-quotes or backslashes within it are escaped by
-# backslashes.
-#
-# This is no use for dependencies or $(wildcard). We need to strip the
-# surrounding quotes and the escaping from quotes and backslashes, and
-# we *do* need to escape any spaces in the string. So, for example:
-#
-# Usage: $(eval $(call config_filename,FOO))
-#
-# Defines FOO_FILENAME based on the contents of the CONFIG_FOO option,
-# transformed as described above to be suitable for use within the
-# makefile.
-#
-# Also, if the filename is a relative filename and exists in the source
-# tree but not the build tree, define FOO_SRCPREFIX as $(srctree)/ to
-# be prefixed to *both* command invocation and dependencies.
-#
-# Note: We also print the filenames in the quiet_cmd_foo text, and
-# perhaps ought to have a version specially escaped for that purpose.
-# But it's only cosmetic, and $(patsubst "%",%,$(CONFIG_FOO)) is good
-# enough.  It'll strip the quotes in the common case where there's no
-# space and it's a simple filename, and it'll retain the quotes when
-# there's a space. There are some esoteric cases in which it'll print
-# the wrong thing, but we don't really care. The actual dependencies
-# and commands *do* get it right, with various combinations of single
-# and double quotes, backslashes and spaces in the filenames.
-#
-###############################################################################
-#
-define config_filename
-ifneq ($$(CONFIG_$(1)),"")
-$(1)_FILENAME := $$(subst \\,\,$$(subst \$$(quote),$$(quote),$$(subst $$(space_escape),\$$(space),$$(patsubst "%",%,$$(subst $$(space),$$(space_escape),$$(CONFIG_$(1)))))))
-ifneq ($$(patsubst /%,%,$$(firstword $$($(1)_FILENAME))),$$(firstword $$($(1)_FILENAME)))
-else
-ifeq ($$(wildcard $$($(1)_FILENAME)),)
-ifneq ($$(wildcard $$(srctree)/$$($(1)_FILENAME)),)
-$(1)_SRCPREFIX := $(srctree)/
-endif
-endif
-endif
-endif
-endef
-#
 ###############################################################################
 
 # delete partially updated (i.e. corrupted) files on error
-- 
2.32.0

