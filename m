Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD421B74B
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJN5n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 09:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJN5O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 09:57:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9ADC08C5CE;
        Fri, 10 Jul 2020 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wVXOB0bwTse/Sz4zv+YiEUb+RJzy2LQixEil7fBzx3k=; b=FwiKwS4KtMrB3DtxFidvXGvg0I
        r21BX3mpVgWXJKfxFomXL6ipq2kN7zleUIZLHIAbMnMpLdQtb/DSzVlrlmPGjkDSwQYb/Ilbvhs/2
        WziOZM487LBn6WlXuxadZhfCkIqsQNlqGNj7vbNwzJUph3scHCDLYUbjGg4Uv08dLpkQWrzop/Pwk
        wbZahGTPC78QyBsCk0xmnF74kxhkVEMKVN6MX34XcylMWuz0HlrCWPJjzzX12YFH9pgOnzty9K42A
        1yG3wZji4FLx4YXEHKmUfdEJY5VvA6Lvoyj5W+B3LlgBQiop3s3LgBEMAibpXcCDxk66G2yZLOfm5
        /DeL8dzQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttWX-0004gf-LT; Fri, 10 Jul 2020 13:57:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nds32: use uaccess_kernel in show_regs
Date:   Fri, 10 Jul 2020 15:57:02 +0200
Message-Id: <20200710135706.537715-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
References: <20200710135706.537715-1-hch@lst.de>
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
 arch/nds32/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 9712fd474f2ca3..f06265949ec28b 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -121,7 +121,7 @@ void show_regs(struct pt_regs *regs)
 		regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->uregs[0]);
 	pr_info("  IRQs o%s  Segment %s\n",
 		interrupts_enabled(regs) ? "n" : "ff",
-		segment_eq(get_fs(), KERNEL_DS)? "kernel" : "user");
+		uaccess_kernel() ? "kernel" : "user");
 }
 
 EXPORT_SYMBOL(show_regs);
-- 
2.26.2

