Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C3608543
	for <lists+linux-arch@lfdr.de>; Sat, 22 Oct 2022 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJVGs2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Oct 2022 02:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiJVGs1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Oct 2022 02:48:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C35D888;
        Fri, 21 Oct 2022 23:48:25 -0700 (PDT)
X-QQ-mid: bizesmtp66t1666421292te8r12sd
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:48:11 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: HHPuPN/BfjVKu/qy7U1mWM9vuS+Xl3Jr1dlbAy+dIOjToMdyjIkFvg9I9EXE8
        wYp0H1HiUGCEJreFifzt7K/EDigVqYcknl0MxwzKNBkwbrqrg0OqsqzJxBqF75vheytsahK
        PbL4Nrjlwa5CEQb+7k36h0wSKzuTn20paHarQn1m2qUhmmMSUhe08Zd2AZ5zUJdkKdstuIz
        Afc+wqqiK0WElvrvwUgZFxxcZKKvXnFBA9bNBhUqpfxxxiEhJgWW80Epf4VadKvy8kK7Ypx
        dSRQowz37E4uJJTKxKRhvAa2E2nBr2yvrpuCqNQsU3PzbvtdckkzdMRwo1SclOB23YL5bBj
        7TvxSuL7JfRaD/DXdkR5usz3kcbxsqZYYmaCf3BurnHR/ujFKk=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] uapi/asm-generic: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:48:05 +0800
Message-Id: <20221022064805.37541-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index f13d37b60775..974629ba0c5a 100644
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

