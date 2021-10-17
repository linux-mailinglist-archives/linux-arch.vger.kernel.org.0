Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA29F430B4B
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhJQRvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhJQRvT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 13:51:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73AC06161C;
        Sun, 17 Oct 2021 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KSSBKqPE3IR7lwQZjR+3a0AghrBfpGBz1s5IaeJer1M=; b=bVy3pr3xTSQHsfPAJrByY4p9Ok
        645Hpz9DerbKwzp633yp1zVs6gJ4MQUDZ9m6nRMhpP76+XaKTXkIrUapoK9DzYDB0GQ+AcS3zRZmF
        pWwQ7NMKsHBlMPUpEEvtiGH+7UGOrOnPAB9oTF9aF57DMMQ7GSePlJBpq5DqD74HJEOWt6NE5ysHQ
        XfQVMBc6xI0P3PtaiHd5hOk1UxnpBH1GMYAp1v6aiCcTkdAAdCj8A3eSFAD3ZCg1srMj4089t/ruo
        mZr8jtGemH7fWw192MW33qkRk0UgwOPhBoS+ob3RCd9ChA9mDlzyuY6KEBMeH7JrHwgu1vwDx/ue3
        lBSATOzA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcAHR-00D6Qz-Ro; Sun, 17 Oct 2021 17:49:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for CONFIG_BUG not set
Date:   Sun, 17 Oct 2021 10:49:05 -0700
Message-Id: <20211017174905.18943-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When CONFIG_BUG is not set/enabled, there is a warning
on ARCH=m68k, gcc version 11.1.0-nolibc from Arnd's crosstools:

../fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
../fs/afs/dir.c:51:1: error: no return statement in function returning non-void [-Werror=return-type]

Adding "unreachable()" in the BUG() macro silences the warning.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 include/asm-generic/bug.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211015.orig/include/asm-generic/bug.h
+++ linux-next-20211015/include/asm-generic/bug.h
@@ -154,7 +154,7 @@ void __warn(const char *file, int line,
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {unreachable();} while (1)
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
