Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A22EFE37
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 07:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbhAIG4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 01:56:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10566 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIG4u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 01:56:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DCW1X01XRzMDyv
        for <linux-arch@vger.kernel.org>; Sat,  9 Jan 2021 14:54:56 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 9 Jan 2021 14:56:01 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <arnd@arndb.de>, <yangerkun@huawei.com>
CC:     <linux-arch@vger.kernel.org>
Subject: [PATCH 1/2] syscalls: add comments show the define file for aio
Date:   Sat, 9 Jan 2021 14:58:27 +0800
Message-ID: <20210109065828.1528262-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

fs/aio.c define the syscalls for aio.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 include/uapi/asm-generic/unistd.h       | 1 +
 tools/include/uapi/asm-generic/unistd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 728752917785..84022c87ed49 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -30,6 +30,7 @@
 #define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
 #endif
 
+/* fs/aio.c */
 #define __NR_io_setup 0
 __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 1
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 728752917785..84022c87ed49 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -30,6 +30,7 @@
 #define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
 #endif
 
+/* fs/aio.c */
 #define __NR_io_setup 0
 __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 1
-- 
2.25.4

