Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441C06FF3FF
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbjEKOXq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbjEKOXh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 10:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDA83DD;
        Thu, 11 May 2023 07:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2098610A2;
        Thu, 11 May 2023 14:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6235C433D2;
        Thu, 11 May 2023 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683815004;
        bh=XDpfU4QGkxHCk0PcVXqfWjLiQT8efnUkxx2g6qxryQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQiuEKd25qGNxzMC/VzrANFNkwAxyE7/iChs3QZIM0Bl4Uf4R84Ga0Dk42m888RVb
         fZ5NEuJv2QYk/nbcRcn0laW4g0chl+t0F6Ys/PVmoOzQFtoKnV8Cwq2Hnz1p/qyEdN
         3VslTOtUm1M6/+smqskiwzYeuZtAeIFuxw5iJK6IfppnovvZMeSW+/RWvMFQmkKWsA
         QFVLYHSkX3p/xZVTibvWsP7LuGrv+ede51WSunQKrRYZ12ZZ1TEAs9KJkoCICil8WS
         NsAELJWQYEM/WSNI8mrXsecWykxDQQlRdYYIWKMGZ/9YsQWUpbJ9GfilidJPpuTkBl
         wkEaw9Qq3jlYw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 3/4] vmlinux.lds.h: use correct .init.data.* section name
Date:   Thu, 11 May 2023 22:12:10 +0800
Message-Id: <20230511141211.2418-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511141211.2418-1-jszhang@kernel.org>
References: <20230511141211.2418-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

