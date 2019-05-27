Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4D2AE7A
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2019 08:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfE0GRz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 May 2019 02:17:55 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:23122 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbfE0GRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2019 02:17:55 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x4R6CN2l059743;
        Mon, 27 May 2019 14:12:23 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 27 May 2019
 14:17:40 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, <greentime@andestech.com>,
        <green.hu@gmail.com>, <deanbo422@gmail.com>
CC:     <vincentc@andestech.com>
Subject: [PATCH v2 3/3] math-emu: Use statement expressions to fix Wshift-count-overflow warning
Date:   Mon, 27 May 2019 14:17:21 +0800
Message-ID: <1558937841-4222-4-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558937841-4222-1-git-send-email-vincentc@andestech.com>
References: <1558937841-4222-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x4R6CN2l059743
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To avoid "shift count >= width of type" warning, using statement
expressions to implement the conditional controlling before constant shift

The modification in op-2.h is taken from the glibc
commit 'sysdeps/unix/sysv/lin ("fe0b1e854ad32")'.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 Changes in v2
 - This is an new patch to fix Wshift-count-overflow warning

 include/math-emu/op-2.h      |   17 +++++++----------
 include/math-emu/op-common.h |   11 ++++++-----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/math-emu/op-2.h b/include/math-emu/op-2.h
index 13a374f..244522b 100644
--- a/include/math-emu/op-2.h
+++ b/include/math-emu/op-2.h
@@ -567,16 +567,13 @@
  */
 
 #define _FP_FRAC_ASSEMBLE_2(r, X, rsize)	\
-  do {						\
-    if (rsize <= _FP_W_TYPE_SIZE)		\
-      r = X##_f0;				\
-    else					\
-      {						\
-	r = X##_f1;				\
-	r <<= _FP_W_TYPE_SIZE;			\
-	r += X##_f0;				\
-      }						\
-  } while (0)
+	(void) (((rsize) <= _FP_W_TYPE_SIZE)	\
+		? ({ (r) = X##_f0; })		\
+		: ({				\
+		     (r) = X##_f1;		\
+		     (r) <<= _FP_W_TYPE_SIZE;	\
+		     (r) += X##_f0;		\
+		    }))
 
 #define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)				\
   do {									\
diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 6bdf8c6..f37d128 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -795,11 +795,12 @@
 	  ur_ = (unsigned rtype) -r;					\
 	else								\
 	  ur_ = (unsigned rtype) r;					\
-	if (rsize <= _FP_W_TYPE_SIZE)					\
-	  __FP_CLZ(X##_e, ur_);						\
-	else								\
-	  __FP_CLZ_2(X##_e, (_FP_W_TYPE)(ur_ >> _FP_W_TYPE_SIZE), 	\
-		     (_FP_W_TYPE)ur_);					\
+	(void) (((rsize) <= _FP_W_TYPE_SIZE)				\
+		? ({ __FP_CLZ(X##_e, ur_); })				\
+		: ({							\
+		     __FP_CLZ_2(X##_e, (_FP_W_TYPE)(ur_ >> _FP_W_TYPE_SIZE),  \
+							    (_FP_W_TYPE)ur_); \
+		  }));							\
 	if (rsize < _FP_W_TYPE_SIZE)					\
 		X##_e -= (_FP_W_TYPE_SIZE - rsize);			\
 	X##_e = rsize - X##_e - 1;					\
-- 
1.7.1

