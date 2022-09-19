Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD35BC124
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 03:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiISBvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 21:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISBvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 21:51:45 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 665EE17E19;
        Sun, 18 Sep 2022 18:51:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3BA9B1E80D75;
        Mon, 19 Sep 2022 09:48:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RoFwQYVJJPbZ; Mon, 19 Sep 2022 09:48:43 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 702AA1E80CAB;
        Mon, 19 Sep 2022 09:48:42 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?asm-generic:=20Remove=20unnecessary=20=E2=80=98?= =?UTF-8?q?0=E2=80=99=20values=20from=20guest=5Fid?=
Date:   Mon, 19 Sep 2022 09:51:36 +0800
Message-Id: <20220919015136.3409-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The file variable is assigned guest_id, it does not need to be initialized.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 include/asm-generic/mshyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c05d2ce9b6cd..cd5ce86c218a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -108,7 +108,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
 				       __u64 d_info2)
 {
-	__u64 guest_id = 0;
+	__u64 guest_id;
 
 	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
 	guest_id |= (d_info1 << 48);
-- 
2.18.2

