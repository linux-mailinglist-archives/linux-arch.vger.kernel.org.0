Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC875471CC2
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhLLTkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Dec 2021 14:40:25 -0500
Received: from condef-02.nifty.com ([202.248.20.67]:47572 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLLTkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Dec 2021 14:40:25 -0500
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-02.nifty.com with ESMTP id 1BCJV2fH007580
        for <linux-arch@vger.kernel.org>; Mon, 13 Dec 2021 04:31:02 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1BCJTqAq000552;
        Mon, 13 Dec 2021 04:29:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BCJTqAq000552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639337398;
        bh=dXJ5mfAIqX0Sipt1rQOsNcO/w8adqP6cEUdSZbCHVb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdQDR0edTY1JlXNZtIoadXIzkXDHYSArwEe0K3xZfYaIPJJWfHKddWqkcYCGqjERf
         5+Css6dlmWJSrFDZ3UkZSjI265HXZW1bucL5n9SPNt/VmGU+IviR8x7yPX0eXYW1bm
         fbF5F6r74/vdo5Ig4AW9gIKwgY/ZKooWGu5SBfdjbUtQtWoftmOpQiHAPLKasuqTn3
         q2aR2TfR4p0r+/B5PNDnkWbGL/XpkF08apognTczTLkMbdumaLMOnHtP/ohKdRMmsF
         0LP+ExABLjyYFUUqxQao8oqb/WMM1MmbQXE+8TzFoH+KvfWxcD9hnirsghvYjbyzy4
         73KRYTubBs+aw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 06/10] kbuild: stop using config_filename in scripts/Makefile.modsign
Date:   Mon, 13 Dec 2021 04:29:37 +0900
Message-Id: <20211212192941.1149247-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212192941.1149247-1-masahiroy@kernel.org>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Toward the goal of removing the config_filename macro, drop
the double-quotes and add $(srctree)/ prefix in an ad hoc way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modinst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ff9b09e4cfca..df7e3d578ef5 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -66,9 +66,10 @@ endif
 # Don't stop modules_install even if we can't sign external modules.
 #
 ifeq ($(CONFIG_MODULE_SIG_ALL),y)
+CONFIG_MODULE_SIG_KEY := $(CONFIG_MODULE_SIG_KEY:"%"=%)
+sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
 quiet_cmd_sign = SIGN    $@
-$(eval $(call config_filename,MODULE_SIG_KEY))
-      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY) certs/signing_key.x509 $@ \
+      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(sig-key) certs/signing_key.x509 $@ \
                  $(if $(KBUILD_EXTMOD),|| true)
 else
 quiet_cmd_sign :=
-- 
2.32.0

