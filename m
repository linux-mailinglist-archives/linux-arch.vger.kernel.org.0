Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3393F25F2D5
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 07:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIGF6h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 01:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgIGF6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B6C061574;
        Sun,  6 Sep 2020 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RIXQEf9L32x2nCRSAR4fbxYw+icKSSPU8Vsh6D6+7r0=; b=R30FrVFADjC0p5xwxfRVo7qWUc
        A6fGogfRR1wSmWR8BWODbMpvolShmup7QRuYeheM/53AjXSfeVkelsss28CshU3tYcaueE/X21iBc
        LA+l+fzgY3ekJqqRd8lwP2rPma62noqvJWnzsjA4HNwbDM2IJmkCjuMuqAy7BYfxAAoJP7EGt4V1u
        Y7S0Tga/jW7kgxEGPrGCqkIapN1mEnNn025KP1hOR1gnErfrRfBYkXDXgse9Z5JV1A/MZtFe0TBMz
        Xw1dLV0uDQAZb9g41DpupXmJsfTQYRRNODKXN7prVkJ3TBW4BV4MmSUjjn53ReJWfK6lNAVCLtaJl
        AVZVnHqg==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAe-00034c-3z; Mon, 07 Sep 2020 05:58:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/8] uaccess: provide a generic TASK_SIZE_MAX definition
Date:   Mon,  7 Sep 2020 07:58:18 +0200
Message-Id: <20200907055825.1917151-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
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

