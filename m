Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A988C58FE07
	for <lists+linux-arch@lfdr.de>; Thu, 11 Aug 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiHKOFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Aug 2022 10:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHKOFg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2022 10:05:36 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88C21E3E;
        Thu, 11 Aug 2022 07:05:23 -0700 (PDT)
X-QQ-mid: bizesmtp64t1660226714tdjkbypj
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 22:05:13 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: zT6n3Y95oi2bJ2cV8O8p5Fu39YyqVDKNpofRSVfJ8PiO0SuaUD3s0YmXR749P
        CRyHroIabqwFE/AuxQ7OuvxWVWyR0ld3yzGEz9400XgI1bMxVnlhkf3plWxu4I4vRU9/b/H
        bYQK18mXcHVa8NZ+PEH33sSP2K4yTbXz1mK3QAMi7Yg/MoAuHpMAvvViQZrtuGVZbyRAiEx
        iScHS9ChuwPFDIG2iuUFldfiNvy4oZ/4NcCvNmK+v1TrbafIF6+EhWLOun9uC3Q9axTrVOR
        U5DSuYNb3LXIg6SX+W9wEZ0G+pPYZDi+YD6ghvW3pTXYiAX/cUTheqs/fVcdE/sTZ91fX17
        MGZAZL3aTGbhCaT5sipQZ5KweodIN8MsbSPZSf8hKWlWD5TaR6JhXswLXrLeslmXAS9/CH3
        5LH0n8VYrcE=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] uapi: Fix comment typo
Date:   Thu, 11 Aug 2022 22:04:52 +0800
Message-Id: <20220811140452.33299-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..b02c8e0f4057 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -143,7 +143,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.36.1

