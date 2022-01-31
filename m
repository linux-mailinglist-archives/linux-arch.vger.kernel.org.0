Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45F4A3DE5
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 07:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357777AbiAaGty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 01:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347924AbiAaGtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 01:49:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B4DC061714;
        Sun, 30 Jan 2022 22:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+0c6MseXPX7zRtfUKiUXoXASKsSqROUYFWkyRGrgS/E=; b=Jv/vd++uBZChNfqPCVfg8xLcXx
        ilLxoHcqoh+UEMk5nTsj7jkROaP7qoB7t3eWk5M1gnSi0iGEjEBv6fAtkMlFWWfI5EcGOW2JBynN5
        sB2x0m538o9zqZNL/1JeoPD/7GWB+9PtKbh9A5GtJ8JgRwMzDcmBrPbmVQYIpbO3Od0Yho7r4aeim
        a2E6nX1NbmJ6lokqxwpnZdeiNAwxSP0xnb8l5W/HPrAvcu+ctzf7A+4u+qDMDy1Gi4dEv8j6PhrM8
        1Fn1hNtAk3BOs1wfpn/Fiotcw5TCsqkcyHn78CRUCXr8vG8sriKztZ3TXAcr0Y8qK7eu5x28WUS2/
        Coaon7uQ==;
Received: from [2001:4bb8:191:327d:13f5:1d0a:e266:6974] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEQVP-008AUe-Oz; Mon, 31 Jan 2022 06:49:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64 define
Date:   Mon, 31 Jan 2022 07:49:29 +0100
Message-Id: <20220131064933.3780271-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131064933.3780271-1-hch@lst.de>
References: <20220131064933.3780271-1-hch@lst.de>
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

