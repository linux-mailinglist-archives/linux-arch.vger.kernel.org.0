Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886748A97B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 09:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbiAKIf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 03:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348968AbiAKIfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 03:35:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F72C061751;
        Tue, 11 Jan 2022 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+0c6MseXPX7zRtfUKiUXoXASKsSqROUYFWkyRGrgS/E=; b=k+z4UCTmXBgFK382dQDwr3z2t6
        kVefYkgvQp9eCA/CLiLCIrHBfw+PwMZAKdwFhPwN9ah2qsJAWtBmHuCNulfrdPe4aiBAie9ToSvlo
        FlGdVO8ZBi+zFHSXuB3RSv1ZZQ0KbrHdGGonk7JWce5iq3TV5OpysFc2rOf+YpceQZP9S0+QJyD3x
        +O/wDVGaV3SIiYOCFXy0HSr2UD9eB2djs4YBV2YFQUddvn/tzeRATyuMcX28UoYSh6y98mf1Jsmpp
        K35fG3pM90lgaTLPjRQlgA+riGmgHbQy5JRMDoAT+XDSvuyYccO1nbJfd64HZ73mQHmRPvIgvPRMc
        Qdgwt52A==;
Received: from [2001:4bb8:18c:6af6:82da:93cd:da5b:aa3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Cci-00FKq3-QZ; Tue, 11 Jan 2022 08:35:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64 define
Date:   Tue, 11 Jan 2022 09:35:11 +0100
Message-Id: <20220111083515.502308-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
References: <20220111083515.502308-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/asm-generic/fcntl.h       | 2 --
 tools/include/uapi/asm-generic/fcntl.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index ecd0f5bdfc1d6..caa482e3b01af 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -207,7 +207,6 @@ struct flock {
 };
 #endif
 
-#ifndef HAVE_ARCH_STRUCT_FLOCK64
 #ifndef __ARCH_FLOCK64_PAD
 #define __ARCH_FLOCK64_PAD
 #endif
@@ -220,6 +219,5 @@ struct flock64 {
 	__kernel_pid_t  l_pid;
 	__ARCH_FLOCK64_PAD
 };
-#endif
 
 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index ac190958c9814..4a49d33ca4d55 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -202,7 +202,6 @@ struct flock {
 };
 #endif
 
-#ifndef HAVE_ARCH_STRUCT_FLOCK64
 #ifndef __ARCH_FLOCK64_PAD
 #define __ARCH_FLOCK64_PAD
 #endif
@@ -215,6 +214,5 @@ struct flock64 {
 	__kernel_pid_t  l_pid;
 	__ARCH_FLOCK64_PAD
 };
-#endif
 
 #endif /* _ASM_GENERIC_FCNTL_H */
-- 
2.30.2

