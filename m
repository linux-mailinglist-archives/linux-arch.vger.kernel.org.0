Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CB21B73E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJN5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgGJN5Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 09:57:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B2C08C5CE;
        Fri, 10 Jul 2020 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wO7HFuaPN2PyMlA7RlKTUtBx6uiRejKmUIauiPOSfj0=; b=cv3jH/vtZlc/ML2fxsYRAYqXGH
        P8dOkM/Mm5j0Wk4GJa+qtPG0nOl2arz/2zKTw0DpRG3wSaqeyq46kc1z7pFXRNPUZ5pJhWbC0UpJu
        5BaEXWl2zAetFkRM5Zl64v+mtVSd9L6TM4nbXTvbJbDBMm/Vku8UATetBrBlA+i6WiccbwgHLrrj+
        tvBieq6TCyI9JNQNp0lAVZoie1NoqiYdx+1GInnGncgzA7oZMRgDeIRP9VFHMXHYRvnnC2NQ/QJRG
        Gl/21alzsn9LgtYk9NeCS5ZcLFICRVqMIn11R/Xjpk2jaj8qFnJr8cQcGaBdxRX2//TCH1j9jCpVg
        hhU5tFoQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttWY-0004gn-Qf; Fri, 10 Jul 2020 13:57:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] riscv: include <asm/pgtable.h> in <asm/uaccess.h>
Date:   Fri, 10 Jul 2020 15:57:03 +0200
Message-Id: <20200710135706.537715-4-hch@lst.de>
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

To ensure TASK_SIZE is defined for USER_DS.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 8ce9d607b53dce..22de922d6ecb2f 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_RISCV_UACCESS_H
 #define _ASM_RISCV_UACCESS_H
 
+#include <asm/pgtable.h>		/* for TASK_SIZE */
+
 /*
  * User space memory access functions
  */
-- 
2.26.2

