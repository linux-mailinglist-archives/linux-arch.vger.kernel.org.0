Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7925E037
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIDQw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIDQwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 12:52:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87305C061245;
        Fri,  4 Sep 2020 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RIXQEf9L32x2nCRSAR4fbxYw+icKSSPU8Vsh6D6+7r0=; b=tHDAxXNyEdd4teq8ZPKEKOmBnA
        YYJUIq9g4EGFNIpCZzHsd1Zm/wB4Kt2HspSmDncVN55P2cJX2Es91avyXMQB5v++xIX9xcpWnive4
        2k0Gq1zM3ROSL+iVl3jHpOjKaZDVkhTnzDojQeKtTd41/RbDOd4cTI3ds1OzH/wJQ4zzMRnuOFSbT
        W0XivN61DeVjt5tiUx7FWPj3cCk8bbNIy3y+Xzn3GoHrHKh4YPghyJ2MBd7PkOzYk6oyeLpR3Db0d
        mqw91PoEU5QwiZnY0EIW1ubw5qviT7oiFDS6VffbPaKzfY1XWXqSdQBSJMR0b2njIF1endMcxHU5B
        RHdws6TQ==;
Received: from [2001:4bb8:184:af1:704:22b1:700d:1395] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEwo-00012l-6Z; Fri, 04 Sep 2020 16:52:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/8] uaccess: provide a generic TASK_SIZE_MAX definition
Date:   Fri,  4 Sep 2020 18:52:10 +0200
Message-Id: <20200904165216.1799796-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904165216.1799796-1-hch@lst.de>
References: <20200904165216.1799796-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define TASK_SIZE_MAX as TASK_SIZE if not otherwise defined.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 70073c802b48ed..d0e43761c708d8 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -31,6 +31,10 @@ typedef struct {
 	/* empty dummy */
 } mm_segment_t;
 
+#ifndef TASK_SIZE_MAX
+#define TASK_SIZE_MAX			TASK_SIZE
+#endif
+
 #define uaccess_kernel()		(false)
 #define user_addr_max()			(TASK_SIZE_MAX)
 
-- 
2.28.0

