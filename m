Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED5813D10A
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 01:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgAPAV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 19:21:28 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58916 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgAPAV2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 19:21:28 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F5564070F;
        Thu, 16 Jan 2020 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579134087; bh=2QRPZlUmPMVnUxkrOMmW/dmjBL5xHEJTZroz7aCHYDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Odv047ZpM5euFeHCEiCsWsNDvJZiylISOtDuFISKUcwjrnwcf/LAwpqVPDhcKbhot
         OETgHA3iK15nzCOHthNKRS/pH/LW12mwbL4CiE7XfdgtBcIwBDZoqNl2ABVH9ei71k
         AKNyzazvUrwk3Votu625wgKWczHGyH3DMAQDC73+vZw7BGiqAY0ThCHk1snRB4ogMh
         Sh+25mtnYtW03Ugl8BoXTG3rx4zq9ivsTxCzc9WjD25o1I2Oh2iy27vGbAHKBmxcBr
         JkRIw0cqViHXe/kQAGdqaUH9BgxFh3tJhOJLTIPuf+23YoyhkIBgB128vxE+6dMs0/
         sYTDwelsA/B5Q==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.20])
        by mailhost.synopsys.com (Postfix) with ESMTP id A6F56A0061;
        Thu, 16 Jan 2020 00:21:26 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 1/2] asm-generic/uaccess: don't define inline functions if noinline lib/* in use
Date:   Wed, 15 Jan 2020 16:21:23 -0800
Message-Id: <20200116002124.17988-2-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116002124.17988-1-vgupta@synopsys.com>
References: <20200116002124.17988-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are 2 generic varaints of strncpy_from_user() / strnlen_user()
 (1). inline version in asm-generic/uaccess.h
 (2). optimized word-at-a-time version in lib/*

This patch disables #1 if #2 selected. This allows arches to continue
reusing asm-generic/uaccess.h for rest of code

This came up when switching ARC to generic word-at-a-time interface

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index e935318804f8..2ea7f4e0e60e 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -212,6 +212,7 @@ static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
 
 extern int __get_user_bad(void) __attribute__((noreturn));
 
+#ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
 /*
  * Copy a null terminated string from userspace.
  */
@@ -234,7 +235,11 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 		return -EFAULT;
 	return __strncpy_from_user(dst, src, count);
 }
+#else
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+#endif
 
+#ifndef CONFIG_GENERIC_STRNLEN_USER
 /*
  * Return the size of a string (including the ending 0)
  *
@@ -255,6 +260,9 @@ static inline long strnlen_user(const char __user *src, long n)
 		return 0;
 	return __strnlen_user(src, n);
 }
+#else
+extern __must_check long strnlen_user(const char __user *str, long n);
+#endif
 
 /*
  * Zero Userspace
-- 
2.20.1

