Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E33516EB9
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384603AbiEBLU6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 07:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381044AbiEBLU5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 07:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00ABCB0;
        Mon,  2 May 2022 04:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F626128E;
        Mon,  2 May 2022 11:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B402EC385B2;
        Mon,  2 May 2022 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651490248;
        bh=KdTG5ILW+BimV/rUokcRVUnKrnKVJkh0mRI8hwDxv9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nY3YeUh8wq/b7ruMqOaCgr+Td8NbU3vfs7xE26erkktuhf80/mBaLpY+hFB1S/n1a
         moxQYIUGqIlPHq8GojuWdeb/EbyfandoaZzVRlhqNj3D0/gMB2o5bT40O9ooWkxAff
         9isDKWAm2SJs8bOlppVHFII36BSTNyIGAktodVcydUTvMj7+rsGt1EG7n3dJRxbCI4
         50L1yLmLXRIOp/isyK6Nf2BzD0bnXVNuKYbUUKLthwjPm8rZH08giIaKTHZI0qhEjw
         /sx622IM3TBihssx4RNtul9RKQpM65kH7IdprfeLDmwHtJd+2+aPDYhlnnStEbVMql
         XR9Tx+wFiu/hg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH 4/4] arm64: efi: enable generic EFI compressed boot
Date:   Mon,  2 May 2022 13:17:10 +0200
Message-Id: <20220502111710.4093567-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502111710.4093567-1-ardb@kernel.org>
References: <20220502111710.4093567-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; h=from:subject; bh=KdTG5ILW+BimV/rUokcRVUnKrnKVJkh0mRI8hwDxv9c=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBib721YQFXgTQ9rqQ5/5YC4MqDvd8W4LTztnbWv0qD +YGJ/PaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYm+9tQAKCRDDTyI5ktmPJK92DA Cmdai5hwUZeWh8eqa1ig9Jiloi7qFITUH0u7nxxbmrhJwnJmPgdZbQOaXbmEpPcOt77JaoihxwAbYU ee4zh+LH0b8crlPyZyMFFwNBR4RQy8jOl257Un58tUHGtvfa/zOPAWaXKI0xaoKJ2kXn7ZODrDaRIk C92VrPPu8EJKJ8jhd4ytCbKi2NECM9EIHMGkMEtC6cQAWYgsSIEIHIXkNagThjDkw5VESOUsO4KmTL MImvTIxzCloCXUaLt425tAwxS5lh6Du9BxgUnynu+r2mES5cYRyKhyRQcpkFE7xIc0t1yCwnV6gYUN kUwQ1zcyyBhd/1j4N36mYNv54zH5DRXj1bK2JHq8Od16LFoYj6k0KXk2xK9ZgMHgevcBdoo76mWt2k suAj+Ctz0MNBX9Nz0EcG2h3P5qEN/4wktE2jWF2TI/kFegCuicNU/S1nd7nZYCBvTXvL6/LFDmZQQb Fg1B+gNcUdX1awONYrDDSzR8NQ8/VYNi53yUems0BjFvE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wire up the generic EFI zboot support for arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Makefile      |  5 +++++
 arch/arm64/boot/Makefile | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2f1de88651e6..c9580f78439f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -162,6 +162,11 @@ Image: vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+ifneq ($(CONFIG_EFI_ZBOOT),)
+zImage.efi: Image
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+endif
+
 install: install-image := Image
 zinstall: install-image := Image.gz
 install zinstall:
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index ebe80faab883..81500267ab79 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -16,7 +16,7 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo
+targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo zImage.efi
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -35,3 +35,18 @@ $(obj)/Image.lzma: $(obj)/Image FORCE
 
 $(obj)/Image.lzo: $(obj)/Image FORCE
 	$(call if_changed,lzo)
+
+OBJCOPYFLAGS_Image.gz.o := -O elf64-littleaarch64 -I binary \
+			   --rename-section .data=.gzdata,load,alloc,readonly,contents
+$(obj)/Image.gz.o: $(obj)/Image.gz FORCE
+	$(call if_changed,objcopy)
+
+ZBOOT_DEPS := memcpy.o memset.o strnlen.o
+$(obj)/zImage.efi.elf: $(obj)/Image.gz.o $(addprefix $(objtree)/arch/arm64/lib/,$(ZBOOT_DEPS))
+	$(Q)$(LD) -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds \
+		-o $@ $^ $(objtree)/drivers/firmware/efi/libstub/lib.a \
+		--defsym=pe_machine_type=0xaa64
+
+$(obj)/zImage.efi: OBJCOPYFLAGS := -O binary
+$(obj)/zImage.efi: $(obj)/zImage.efi.elf FORCE
+	$(call if_changed,objcopy)
-- 
2.30.2

