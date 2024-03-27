Return-Path: <linux-arch+bounces-3236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D325A88EFB7
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AE1C3247D
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA1153823;
	Wed, 27 Mar 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OKzKygYe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A35152DEB
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569730; cv=none; b=FbXyheAOnLp3VlrRTWoijoiff4vJtLGaRtnMF9RCkF0QbWjMxxR7C8G7LPp8Adkro2gtB/A6/YexPauIBNyUfdc1UGFsDx6zZmGpF7iT2Z5BSzuUXZ/7pLRjN6SbEL+RGnI8Wvs7auBUj4cj4i0jU4uo6CLqU8oGehUuv/miE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569730; c=relaxed/simple;
	bh=eMQmSUo52FJHLb7k7DMqQqQuHAf5Jw+iP3bS7rkuvng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9TGRkz7FIPONFg5n7LBRtYOJhaTsgRpUcubbieCA2kjZ5n507UvK+Eu20gsY+00viuMdPeHWs+M93tMfDSlzdag+qfmh3zsZ4s0E2MHOoWpqn5o6rYuLnn494ACR4FLE1FPa2/TeFZwjvY5EKIGALwrd4gseGgPvdZvJxFV7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OKzKygYe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0000cdf99so2221205ad.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569728; x=1712174528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZE0ell9od5iMx/niXSnkXHAkP7o0Zji40W4vIuo5Ic=;
        b=OKzKygYegNbmEQD5aMUgi2tWep4dZZG+qAFSnCTVndshzdKHdHTIdFzyAXzjjMiV/1
         HFF64Y3/BMC8y8+zErHCdtAtHGgPgrt3IkrHypOctEA6c/dL2twxqPEY98LPy2fT1DoT
         f+BKb0/RtR6VmgHRmfaF6XvVYS/Dwc21r/Na6S31UfY8ETlOTLia4dc6dzfX8NfCxhql
         91Bz+4UtHuytJwdM+pHpdAPy5MDideO41J0P+ALC/irJpOVskgJJa+HW6/zkOP2F9YlO
         vKItmU90lldmZ0vTnvm2QLiwoffPRlz+OLVG0yOJf+0YipXL7w9ICxtMkhTfe4fpH4WK
         Wgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569728; x=1712174528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZE0ell9od5iMx/niXSnkXHAkP7o0Zji40W4vIuo5Ic=;
        b=CArk3MVw0tcRSqob2YIziwjf+KpuIwTbbZM46g0zJ9TctMfSER5mkYxjzbDBQs+72u
         POF+L36l1Lrs8uxEBGQpAJ9GOQp8XkHLauCz1yKtWR48H/ZXHlsVxfDXsTgUHJ5BICcB
         THNfbeooWSXDwS7OxO/TMmQ0jyL8AaPTQFTEO4cfL9O12tIWyWEEmBqHqNjhXNaRNgEg
         hrs2dTVi+6F3Yki5RTOkLJXwch48So8ipa7mnYDwIgV525HcPXJhNCHGMkK7V6uom3NZ
         0Jws1GxslkVEqim8AGRw3HA5K9LHIXe5Beh+YYnfRI2psaOWUIv2EbprnrYjSQ9DOe9S
         YIcw==
X-Forwarded-Encrypted: i=1; AJvYcCUFAj/5GjgawB0jNMhtvfs5YZGa5yH+nX/PuYh73vUDlcu5x6wwXkrIF7Dzc+J+XvKm0ZzxpWBAtAoiQXUujSSsnmryxLgMdRF9yA==
X-Gm-Message-State: AOJu0Yy4IOY4ntKozidu/m5EQE86b0n+OGvUQ9IXI2RtX09iYvGXpQr/
	gYPaOssaPLqayNk+WmbAOnrk77A1Wv8yrVOBDcoON5CZLA5vh9Crz8kZL6HuIEc=
X-Google-Smtp-Source: AGHT+IGM9v2q1Bg0jHlsJFItc73WPBzqi9soPcoc57OB2ZggdclEbNRISa4ohk9keY4487ms+Vhuaw==
X-Received: by 2002:a17:902:d4d0:b0:1de:fbc2:99f0 with SMTP id o16-20020a170902d4d000b001defbc299f0mr957547plg.2.1711569728307;
        Wed, 27 Mar 2024 13:02:08 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:07 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	WANG Xuerui <git@xen0n.name>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v3 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:38 -0700
Message-ID: <20240327200157.1097089-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Acked-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Rebase on v6.9-rc1

 arch/loongarch/Kconfig           | 1 +
 arch/loongarch/Makefile          | 5 ++++-
 arch/loongarch/include/asm/fpu.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..2266c6c41c38 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -18,6 +18,7 @@ config LOONGARCH
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index df6caf79537a..efb5440a43ec 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -26,6 +26,9 @@ endif
 32bit-emul		= elf32loongarch
 64bit-emul		= elf64loongarch
 
+CC_FLAGS_FPU		:= -mfpu=64
+CC_FLAGS_NO_FPU		:= -msoft-float
+
 ifdef CONFIG_UNWINDER_ORC
 orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
 orc_hash_sh := $(srctree)/scripts/orc_hash.sh
@@ -59,7 +62,7 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -pipe -msoft-float
+cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
 LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index c2d8962fda00..3177674228f8 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -21,6 +21,7 @@
 
 struct sigcontext;
 
+#define kernel_fpu_available() cpu_has_fpu
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 
-- 
2.43.1


