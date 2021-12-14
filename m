Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC11473B19
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhLNCze (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:34 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41855 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhLNCz2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:28 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bd012823;
        Tue, 14 Dec 2021 11:54:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bd012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450443;
        bh=lFwAie+ACL1Bul6UeqzOBCuhJg5PqZ9pwxEdlcaA3ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+/s/E5aF1eVcsI7nt7N8I2vbUjj7JeZaVKgZ9jJFvrdJzqdv3xrrhEctuvczi1G5
         GU+lZpy/xyHqiua4aWcOUKPPNhK2p/OHkinqvnFSvTgI7tpJfENdj4gi1HK38zhRVA
         hbrvaA7nerzFZa02yz3l+yZvgvM5eFUip7Z8A8sgFIfvU/BUclyyBPlLSyelkCDtU3
         /D5kJDXhJnj1eS7kG42yEaQW98IYoNzCECvoU9QIHsCpNvXXmHbJ/YDwUkQdYYOqUA
         Ut7Ui6tMtYshCAhqIh8e54huFU5jU9RUl4n4Q7lGAus6rKA1qLrESd0NQ+Ta2fU4Xw
         Bki8XjPqm15lw==
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
Subject: [PATCH v2 02/11] certs: unify duplicated cmd_extract_certs and improve the log
Date:   Tue, 14 Dec 2021 11:53:46 +0900
Message-Id: <20211214025355.1267796-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

cmd_extract_certs is defined twice. Unify them.

The current log shows the input file $(2), which might be empty.
You cannot know what is being created from the log, "EXTRACT_CERTS".

Change the log to show the output file with better alignment.

[Before]

  EXTRACT_CERTS   certs/signing_key.pem
  CC      certs/system_keyring.o
  EXTRACT_CERTS
  AS      certs/system_certificates.o
  CC      certs/common.o
  CC      certs/blacklist.o
  EXTRACT_CERTS
  AS      certs/revocation_certificates.o

[After]

  CERT    certs/signing_key.x509
  CC      certs/system_keyring.o
  CERT    certs/x509_certificate_list
  AS      certs/system_certificates.o
  CC      certs/common.o
  CC      certs/blacklist.o
  CERT    certs/x509_revocation_list
  AS      certs/revocation_certificates.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

 certs/Makefile | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index aba9e782f940..bdddcd21cbb3 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -12,6 +12,9 @@ else
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
 endif
 
+quiet_cmd_extract_certs  = CERT    $@
+      cmd_extract_certs  = scripts/extract-cert $(2) $@
+
 ifeq ($(CONFIG_SYSTEM_TRUSTED_KEYRING),y)
 
 $(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
@@ -22,9 +25,6 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 # Cope with signing_key.x509 existing in $(srctree) not $(objtree)
 AFLAGS_system_certificates.o := -I$(srctree)
 
-quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
-      cmd_extract_certs  = scripts/extract-cert $(2) $@
-
 targets += x509_certificate_list
 $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
@@ -98,9 +98,6 @@ $(eval $(call config_filename,SYSTEM_REVOCATION_KEYS))
 
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
-quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
-      cmd_extract_certs  = scripts/extract-cert $(2) $@
-
 targets += x509_revocation_list
 $(obj)/x509_revocation_list: scripts/extract-cert $(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(SYSTEM_REVOCATION_KEYS_FILENAME) FORCE
 	$(call if_changed,extract_certs,$(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_REVOCATION_KEYS))
-- 
2.32.0

