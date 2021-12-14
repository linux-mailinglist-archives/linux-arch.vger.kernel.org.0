Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C668A473B06
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhLNCz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:28 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41829 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhLNCz0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:26 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bh012823;
        Tue, 14 Dec 2021 11:54:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bh012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450447;
        bh=4XnqdxB/jmNQDTR4+enp7rYM+3kt4+2zAQ+n7Gz8fa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWWVSGX/HbTEIAfDfQ0ej8gtj8Muxol4VzrXGqAEo/zzAw+O5FFSbClXZkXkZT3VI
         IUTLI8y8djcvH7bEAz8bCU1z9FJVwbfppbNTgXmR+xM82I3qgZne/RMEalx3QS3yeL
         IQx32Slov+nbK2yInks4itIRA8Ypj+dzuftpTLkSOC+nXbQiQH6vqZvWNcjnEs2ee9
         fQdCTjnN4uzyVqZrPzTLixapN8rIG9FnNgHPuev40y68iIuZvu+lyg9Q0gxNCruQH3
         mwzicIp98dCMjzB8VeYbJsPmBD3VM17Ai2864E0ZyJ1H/ofl4dj+8uHISOy1gZiF0X
         Kb71y+GBcstEg==
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
Subject: [PATCH v2 06/11] kbuild: stop using config_filename in scripts/Makefile.modsign
Date:   Tue, 14 Dec 2021 11:53:50 +0900
Message-Id: <20211214025355.1267796-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Toward the goal of removing the config_filename macro, drop
the double-quotes and add $(srctree)/ prefix in an ad hoc way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

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

