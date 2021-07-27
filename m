Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8405C3D6E9F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhG0GDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0GDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:03:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395FC061757;
        Mon, 26 Jul 2021 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iOFMfubZNap8awOdEeuB+1FnsFdyWL++zNMgqZMjxF4=; b=EE3116pW/ZHDPtIu3qDf41HBYY
        FM1h6w0lGS5hR20ymFRp8+II4vtz6h1rmMOZNlfErtIdeBvb/oPG44XSrpAkC+qapz6QrTJCEvAm1
        MZp7LcMfaeb8HnfEiwT5Lq+uZmlc7UCoZpM37rQDaFBKdyYdiG0xQ/z0dTqca35oPiyHqDS9m86Mf
        s+7YlHRXNCu0qzQyK1sflfAYiEmSaOOArrx+dT5T9SylGjrBMZkW0an+ieci9UUu3AoXSXqFH70A7
        NzTS+NeWDqYH1rBzP4+4yN/vDJk30A4LjL9MKLseW5GMeoxAVVVhVLz+2VD4rMJiEUoozwhn4tkLN
        Z1PuNM5w==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8G6e-00EiKC-9G; Tue, 27 Jul 2021 05:59:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 01/15] MIPS: don't include <linux/genhd.h> in <asm/mach-rc32434/rb.h>
Date:   Tue, 27 Jul 2021 07:56:32 +0200
Message-Id: <20210727055646.118787-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is no need to include genhd.h from a random arch header, and not
doing so prevents the possibility for nasty include loops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/mips/include/asm/mach-rc32434/rb.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/rb.h b/arch/mips/include/asm/mach-rc32434/rb.h
index d502673a4f6c..34d179ca020b 100644
--- a/arch/mips/include/asm/mach-rc32434/rb.h
+++ b/arch/mips/include/asm/mach-rc32434/rb.h
@@ -7,8 +7,6 @@
 #ifndef __ASM_RC32434_RB_H
 #define __ASM_RC32434_RB_H
 
-#include <linux/genhd.h>
-
 #define REGBASE		0x18000000
 #define IDT434_REG_BASE ((volatile void *) KSEG1ADDR(REGBASE))
 #define UART0BASE	0x58000
-- 
2.30.2

