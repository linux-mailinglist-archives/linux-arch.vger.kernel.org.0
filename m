Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6C473B00
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhLNCzZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:25 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41811 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLNCzZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:25 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bc012823;
        Tue, 14 Dec 2021 11:54:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bc012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450442;
        bh=LGynaWzvzbJKWj82OApHAklbGHeVobCQAmfnlsI/HGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACTz+RJ/Fx/9ZbT5HV9NlfphtPCmqQSCoyAcBn5hZBMbbhV4yk9inMq8oDaDFe+3U
         MEvzzBMiv0gRDHhU5C6JPUugNeDX78A5mM1bRnbME2qyrCH8ZVwtU33gIhBvS4cXRE
         2LhiVmDgzHXlZb5hGmz8kK20C8b6P8pchl0u/HekhKCr3skejW5iWXQxN96BeWZ8sv
         uBjXoPMWzyYmV9Vr+aMRPiArtr66qfj1tvTMik0MaP59y9/q3Qg+9lW4MKTY4v+L49
         nQDmr+MYJyII2vF29uE1FC/wHJQqeviBUM+jx9U09n0E7LwRJqFpzJTGOjwfWbFFR3
         Nm7OlpOk3dZBA==
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
Subject: [PATCH v2 01/11] certs: use $< and $@ to simplify the key generation rule
Date:   Tue, 14 Dec 2021 11:53:45 +0900
Message-Id: <20211214025355.1267796-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Do not repeat $(obj)/x509.genkey or $(obj)/signing_key.pem

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

Changes in v2:
  - Use $< instead of x509.genkey

 certs/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index a702b70f3cb9..aba9e782f940 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -60,9 +60,8 @@ keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_c
 
 quiet_cmd_gen_key = GENKEY  $@
       cmd_gen_key = openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
-		-batch -x509 -config $(obj)/x509.genkey \
-		-outform PEM -out $(obj)/signing_key.pem \
-		-keyout $(obj)/signing_key.pem $(keytype-y) 2>&1
+		-batch -x509 -config $< \
+		-outform PEM -out $@ -keyout $@ $(keytype-y) 2>&1
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
 	$(call if_changed,gen_key)
-- 
2.32.0

