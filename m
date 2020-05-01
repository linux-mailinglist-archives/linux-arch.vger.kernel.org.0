Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407251C10F6
	for <lists+linux-arch@lfdr.de>; Fri,  1 May 2020 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEAKjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 May 2020 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728545AbgEAKjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2020 06:39:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C80C08E859;
        Fri,  1 May 2020 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X1Y0Wt6aI8L3G9yDhhqkxUs7nTDNlMdgsRMLyS3/fVY=; b=mxvBVDR55vQ4J21c+gDS/xpNzV
        sT7KKju9wOmEwkosAuvSu1RzF28PY8SZnV3gQDUL29bTu7M5rV8xSRWfJk2HhpgwdgSVnHx8KsUMK
        ePujyWpjogMkD+Xgn4pMxqIsvyz1qbekXEn+mut0d+BPpxHrDkT0/RufZXNSmG8NQr6839+SH7SsP
        ZAvEpbonz8NqI56mVD7E1Ho/DGrldcoyRI6zrl3jSyuq0K0HUJvCGpa2arFIA2yzuGk8tVLFSIE6/
        tdWFGiGlxABYKj9dOd5hO449FSA5xXFzxyeUBxZ0X8i4K90DRVOoRy7tLo2MCvsebczn9zrGyXv4v
        svQwlDZg==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUT4X-0005Ty-G6; Fri, 01 May 2020 10:39:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: remove an empty ifdef block from signal.h
Date:   Fri,  1 May 2020 12:39:02 +0200
Message-Id: <20200501103902.2620910-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/signal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/signal.h b/include/asm-generic/signal.h
index c53984fa97614..663dd6d0795dc 100644
--- a/include/asm-generic/signal.h
+++ b/include/asm-generic/signal.h
@@ -5,8 +5,6 @@
 #include <uapi/asm-generic/signal.h>
 
 #ifndef __ASSEMBLY__
-#ifdef SA_RESTORER
-#endif
 
 #include <asm/sigcontext.h>
 #undef __HAVE_ARCH_SIG_BITOPS
-- 
2.26.2

