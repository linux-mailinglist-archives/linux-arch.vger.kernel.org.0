Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30F221EE81
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgGNK7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNK7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 06:59:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294AC061755;
        Tue, 14 Jul 2020 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8kIpdB7MOVPeE6Mtm6qS57nGC+Nbr8eHQGmiVAURoO0=; b=Y7Egjcf3jjfOrfhxpS00WHCSu/
        7+sVXf5y3GzUV7zX3zJjYmm8deI9zyULqJUYesggLwFRaA+jOjsxongcjp8mxAoAG8K3HDdINJd6Y
        vpNJTkxpMrx1z7EoGeksBRSNefcuskiLd65m0OFcEBbp3J4vlBaubVusFTxRdWpP4YXOgd3ykjh13
        0cY6HbeK+wpHET1t/nPFQv6pVsBgQwSTNwIFtZIdVXf2LPGrbKhTmqbBUOuafwzpQ57/9MR+JyPNQ
        0TVBYyjEfWaK73wyPMWy2TfbXz1SCQ/fGAnTWWvXRC4QEQl48YTr2nCyTzsIvCCaXVmU2MEreblnJ
        eshrFJFQ==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvIem-0005up-87; Tue, 14 Jul 2020 10:59:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date:   Tue, 14 Jul 2020 12:55:00 +0200
Message-Id: <20200714105505.935079-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the uaccess_kernel helper instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da9877c..e933a43d4a69ac 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -263,7 +263,7 @@ static inline void addr_limit_user_check(void)
 		return;
 #endif
 
-	if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
+	if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
 				  "Invalid address limit on user-mode return"))
 		force_sig(SIGKILL);
 
-- 
2.26.2

