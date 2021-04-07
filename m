Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C087356354
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbhDGFfv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348829AbhDGFfh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 416E7613B8;
        Wed,  7 Apr 2021 05:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773727;
        bh=gUfBIHZtK9czx4c8L8i0ymGf3DhRbtRfeKd479UX8fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibLV/n5vAHDZRJvDQHX7RgLM4ew5c/ZrSO1wzDqbuZphb3nI33/j7EPJC4xyFEVN+
         DUPfUM49m8h5XewWYBhtt0LrZacAnaFAoKekLUMkyNlz4TS63H09TIS2FjhJItprDo
         CK1WFmX6h1jXjVzC0z0rNw/hBNZOQzt1koQdF4kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 13/20] kbuild: nds32: convert to use the common install scripts
Date:   Wed,  7 Apr 2021 07:34:12 +0200
Message-Id: <20210407053419.449796-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It seems that no one ever checked in the nds32 install script so trying
to build a nds32 kernel would never quite work properly as 'make
install' would fail to run.

Fix that up by having nds32 call the common install.sh script.

Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/boot/Makefile b/arch/nds32/boot/Makefile
index c4cc0c2689f7..8371e02f6091 100644
--- a/arch/nds32/boot/Makefile
+++ b/arch/nds32/boot/Makefile
@@ -8,9 +8,9 @@ $(obj)/Image.gz: $(obj)/Image FORCE
 	$(call if_changed,gzip)
 
 install: $(obj)/Image
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
 zinstall: $(obj)/Image.gz
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
 	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
-- 
2.31.1

