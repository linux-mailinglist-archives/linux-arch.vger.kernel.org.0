Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAD70E3D7
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjEWRG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjEWRGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 13:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE17DD;
        Tue, 23 May 2023 10:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C77C634C3;
        Tue, 23 May 2023 17:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DAFC4339C;
        Tue, 23 May 2023 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861580;
        bh=XDpfU4QGkxHCk0PcVXqfWjLiQT8efnUkxx2g6qxryQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekUkv+8Udgo0rQGikUzgVt1U+8VG4DYIqET6gmM4S7k9goJGn3cE6EIVMWx3nHzXX
         yBXZL/2rbnb2TMN2LJSbanLZck5wX+V8ygTKDIsZ+gxcaADr23j0vJlC2BY2vnfTDZ
         TZU8C+c9+M24vwOjravcJ8o3dk+YCUMk+Sqf7N+Bud9SE7IPtJrIoGHtUIbgtb3dwS
         1BIos3/riAF8xW30yQ+SBN3Twvf4DDzykyhu6HoyL3/zpF90sp/6cCdeXI5ZG0/8DQ
         1NI+5pZPAcfFAOsHiy2qs0k0ZFXtXkbymsvFmGP9I6UTbPYChQmMEc/Ep1tRlqv4MD
         xC48ZkFtW+JUg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 3/4] vmlinux.lds.h: use correct .init.data.* section name
Date:   Wed, 24 May 2023 00:55:01 +0800
Message-Id: <20230523165502.2592-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523165502.2592-1-jszhang@kernel.org>
References: <20230523165502.2592-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If building with -fdata-sections on riscv, LD_ORPHAN_WARN will warn
similar as below:

riscv64-linux-gnu-ld: warning: orphan section `.init.data.efi_loglevel'
from `./drivers/firmware/efi/libstub/printk.stub.o' being placed in
section `.init.data.efi_loglevel'

I believe this is caused by a a typo:
init.data.* should be .init.data.*

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..371026ca7221 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -688,7 +688,7 @@
 /* init and exit section handling */
 #define INIT_DATA							\
 	KEEP(*(SORT(___kentry+*)))					\
-	*(.init.data init.data.*)					\
+	*(.init.data .init.data.*)					\
 	MEM_DISCARD(init.data*)						\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
-- 
2.40.1

