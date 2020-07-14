Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1921EEA8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGNLD4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNLDz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 07:03:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7777FC061755;
        Tue, 14 Jul 2020 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wO7HFuaPN2PyMlA7RlKTUtBx6uiRejKmUIauiPOSfj0=; b=OSM7z2FkP6QewfE+zQd32Z1KZs
        BFOZmnnBZ7z/1DApnT2fqXZYMia6JVDaAPU57gBg3Z7JSAYi7AOSp62k8IiTrOlQhKLE5qBjJBpjO
        CuHkmT3M/idtb1smuV+rFuSdAAjHnMPtR1FF2l1JlPxF3MbxJOlIRldz+CiHJ7y0nbhFw6489mFqo
        9y+HuQwsBQ53C6cHfxDiG+VK1XSoLo1b4EM5BtkFBoq6yt+wCdYAg4NVmknaO4zsyrZPliZpLbmyR
        7i/+PTU+mu9c7dK5zBZZQJX7gnicSDG/QxuBvnO7FUGoR/sc9rNgbA7kaMaw0vjuiF2w+aV+dDcVg
        l8d0oSQA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvIj0-0006Al-CC; Tue, 14 Jul 2020 11:03:50 +0000
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
Date:   Tue, 14 Jul 2020 12:55:02 +0200
Message-Id: <20200714105505.935079-4-hch@lst.de>
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

