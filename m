Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8833CAE63
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhGOVSM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOVSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 17:18:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32BFC06175F;
        Thu, 15 Jul 2021 14:15:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c17so11567114ejk.13;
        Thu, 15 Jul 2021 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MY7GzL0TTJagxyhj55uchZnvkM+R3iPX/iP1Zqm7Osw=;
        b=PuM9n6MYBfm1aFJtknucOtEaOfKFhT7rJ6prxgaTq0tMGzhCFoviRXGAqrZy2Vwfmi
         RV23t2HL4fIsxnG/IbfKlygk9jd3+dVn1PfWpuJ0EvTHWQFwkt108UBhR2OZluQlh6vh
         Z2HJ23ac+Xh/KC1s6Dq7XeutsO3x8fEMhmKsCfK6rtmbcftmuEG19n4uQTnDKtjxiV5B
         GIbQyI7as3SFztgYKnQwedqqU1AZEA23xqp/iuoeN73AJax/NWEucu0yP9QEYMW46lok
         NPIAKwOz66m1ce36uVfPjYBqV0v1Kv2Pz7lHHwqiosq8GzlOnm/alCW+70DYJ/1e7gDd
         NdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MY7GzL0TTJagxyhj55uchZnvkM+R3iPX/iP1Zqm7Osw=;
        b=nahonw7jTvU+6S3rM8KErq686d3XnhmjwIx9dXVARbgDzt6LqTMkGnJ+7w6DP0fXzA
         cxCBY029NC/OGSMu4Ts8bDh48bnN7eo14ddsDAaiV11SxHUa/QKYIcKoM2a4KcR7yF0H
         PEI6S7Q/JmBsE9oQD8/5A2beb1GmuOSf32vxIc5dY4t1WCni79AlY7AoQb0W7WlJV9Wa
         NAtxIEe0AyxYf5IYeN0HZivfpUk8MTII+XqQ0FTolmU6khddn/g3YxMrq+kkeoQxwGCW
         XTcvQVW+9nAa1IHoF/+Gkvy3ADgtIf6GBRSBCRTRCUUUzZK/ZD0AMAWc9ErV44Y5/dLr
         51LA==
X-Gm-Message-State: AOAM5306msMe53VNTwwQ2fUBolMLWpMZbGxvB1+G8d2bO+CrHOaLR5qw
        +mYtTa0h4dg3pC2LgZXpRQ==
X-Google-Smtp-Source: ABdhPJyL9295442DxPEmIT8SI9QQ0D0GD/wcPGwkJVIVtqECxQqrr393yEsK8duFbXwb3VYfVZUY5A==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr7432276ejc.459.1626383716565;
        Thu, 15 Jul 2021 14:15:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.48])
        by smtp.gmail.com with ESMTPSA id hq9sm2136434ejc.0.2021.07.15.14.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:15:16 -0700 (PDT)
Date:   Fri, 16 Jul 2021 00:15:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, masahiroy@kernel.org,
        hch@infradead.org
Subject: [PATCH -mm] fixup "Decouple build from userspace headers"
Message-ID: <YPClYgoJOTUn4V0w@localhost.localdomain>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
 <YO8ioz4sHwcUAkdt@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO8ioz4sHwcUAkdt@localhost.localdomain>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow to find SIMD headers where necessary.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	fold into decouple-build-from-userspace-headers.patch

 arch/arm64/lib/Makefile   |    2 +-
 arch/powerpc/lib/Makefile |    2 +-
 lib/raid6/Makefile        |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -8,7 +8,7 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
-CFLAGS_xor-neon.o		+= -ffreestanding
+CFLAGS_xor-neon.o		+= -ffreestanding -isystem $(shell $(CC) -print-file-name=include)
 endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -64,6 +64,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec) -isystem $(shell $(CC) -print-file-name=include)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -13,7 +13,7 @@ raid6_pq-$(CONFIG_S390) += s390vx8.o recov_s390xc.o
 hostprogs	+= mktables
 
 ifeq ($(CONFIG_ALTIVEC),y)
-altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+altivec_flags := -maltivec $(call cc-option,-mabi=altivec) -isystem $(shell $(CC) -print-file-name=include)
 
 ifdef CONFIG_CC_IS_CLANG
 # clang ppc port does not yet support -maltivec when -msoft-float is
@@ -33,7 +33,7 @@ endif
 # The GCC option -ffreestanding is required in order to compile code containing
 # ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-NEON_FLAGS := -ffreestanding
+NEON_FLAGS := -ffreestanding -isystem $(shell $(CC) -print-file-name=include)
 ifeq ($(ARCH),arm)
 NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
