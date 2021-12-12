Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC0471CB9
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 20:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhLLTiW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Dec 2021 14:38:22 -0500
Received: from condef-07.nifty.com ([202.248.20.72]:16817 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLLTiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Dec 2021 14:38:22 -0500
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-07.nifty.com with ESMTP id 1BCJV2GI020483
        for <linux-arch@vger.kernel.org>; Mon, 13 Dec 2021 04:31:02 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1BCJTqAm000552;
        Mon, 13 Dec 2021 04:29:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BCJTqAm000552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639337394;
        bh=xb7oyAf8Ib4Y3ctlH08YMqAlm2BtbVnTSVrol3O+E94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gs4Nl5JRr7kyUpP+r/oG/PkYEUNIwGEBjVwJZzLlUDDPVA4HK1+g9+16iYZIeow88
         GPJtbwQljYiKzWmSmdvH9aOP2S6aZ6PU+ltyYHICo7hDschwaUhAYQUo4sVBbApzBz
         1MYuIwCN/Gbg2PgcymPk+xqQTim0zAk1ctz3Iy9+wf8XRULdwhSRFeKaFdBSDEAWhl
         4RA1H0VFNQ3BypKHVxXtQUGX3BERSP9zyxVdkngP4SSXF8AT7BIQiCnJXjB6W1kvhv
         aieJgm1Uqf35eax/3mxz6eJG8TQDugbSeiZwAnjSFaZNjTT4XjPhUyNnljhCRkR+PT
         VV0buQM+tUV2w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 02/10] certs: unify duplicated cmd_extract_certs and improve the log
Date:   Mon, 13 Dec 2021 04:29:33 +0900
Message-Id: <20211212192941.1149247-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212192941.1149247-1-masahiroy@kernel.org>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
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
---

 certs/Makefile | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index 97fd6cc02972..945e53d90d38 100644
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

