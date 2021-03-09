Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E564F332A22
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCIPSx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 10:18:53 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31185 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhCIPS1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 10:18:27 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 129FHiTg030658;
        Wed, 10 Mar 2021 00:17:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 129FHiTg030658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615303068;
        bh=r71y+AUxa/wzY3HGAOw/Hv/yHZgfi9z2nUjKyYbaVPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMkdLWh09zNrqCExiZIrv2+lAjaz1szHIzNg9/P1CO9bSo+j7dkJMWRIBYTFGFeGm
         qHKYGyY34FJ7TRep/rJ14p5DXgyWSQC6ZSwepbsuoEmmhDbTEKNAz4yh6zIFUOu9h3
         tkEB6MAkPz/OezTrodwJObCLE9qxo+/1jNKWn2UgkjhUlIh4iwLcBIzOX33cq/U2Nd
         ZOfKT8fGYy2SAd9YxogBXawByyIqPb3FtWXmvjToiohKCKghEA4Sj7Qae+kK+3U6d5
         9QJifDrC3u4TLGOYEyAfxZMtuhHuwLdLYsKo9u0pH+WWBgWbxkTzZN2bROoXy2rhhF
         74ZvJW1JbCzjA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 4/4] kbuild: remove guarding from TRIM_UNUSED_KSYMS
Date:   Wed, 10 Mar 2021 00:17:37 +0900
Message-Id: <20210309151737.345722-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210309151737.345722-1-masahiroy@kernel.org>
References: <20210309151737.345722-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that the build time cost of this option is unnoticeable level,
revert the following two:

  a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some guarding")
  5cf0fd591f2e ("Kbuild: disable TRIM_UNUSED_KSYMS option")

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 init/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 22946fe5ded9..0cbdc20b9322 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2265,8 +2265,7 @@ config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	  If unsure, say N.
 
 config TRIM_UNUSED_KSYMS
-	bool "Trim unused exported kernel symbols" if EXPERT
-	depends on !COMPILE_TEST
+	bool "Trim unused exported kernel symbols"
 	help
 	  The kernel and some modules make many symbols available for
 	  other modules to use via EXPORT_SYMBOL() and variants. Depending
-- 
2.27.0

