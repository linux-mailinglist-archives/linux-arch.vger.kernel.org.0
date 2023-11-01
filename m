Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2F7DD992
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 01:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjKAATb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 20:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbjKAAT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 20:19:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B5103
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e22a4004so4250596b6e.3
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698797956; x=1699402756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQiMVqLfKSm2SPHj3fibpAHrdOwMRzTeJGJGgNTSklM=;
        b=m9KZf+0QkuRGXoWIBiP5ml5yTNdfZnFikvthO9hESEkNnyE/lZDiLePMDqgcrKpnvY
         0hsUejul3dMxckzbt7yIi2BrL0VA51/jo930rmpA/ucQ6liYX/NjeTZOZhJkwVc8Jg1h
         p6jrpJygf8iPz3xmsn3h/WwycCyMvgA4q7eiH/Rvti5xmpn4fECaqyvMUs+kU8jQgMff
         F3mIUPXpB3WhqkKbz3oCpWGCOkSgt22O/dteIUPI3jWR7DAifxheccFNDBpH0N9dKe0K
         53nxeHTrCK4BhFznTuMyh+6oGq2/ngORhW8tP/UEXAXDcqhqufnpDNWFPf8PHvgQrwq2
         42xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797956; x=1699402756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQiMVqLfKSm2SPHj3fibpAHrdOwMRzTeJGJGgNTSklM=;
        b=iB0fbTDNuthRg7ZEvmkOi1CMAgfTqfS5B9nWiqBTLGjoc/RgU5MzhllXV//pIqEKBH
         3BIvD9jSEFpcS/JefTad6dbNmhuUMt6wA48DL6PhU9TZNzF44+DnuvoyBjnFika1ssai
         ckCv4fcvsIr2SPkDlAjOqG81iOwzsRSZM5Q4ENXOERW9HLLYb3WjkpeIU+l65mSjuNyD
         ekcM6Zak+Ca1/5bSHCiqh0uG430jHcr17IXeZF5jw49Elng7YbEy9hxxXR3xYeRhQI9V
         ukWlQKOq51SUmgLLpyYTKa121D7RIUfCAGVmpQ5Csi7mVFELbpTMEaYKyiDo+75VxE0V
         qlXw==
X-Gm-Message-State: AOJu0YzQJl9KesWQ4a1H1CbNj9mShV8cTvpsIY6Mgy/hpTYHatr0unHk
        O4eLoCSEl2WTTvojEXH7EqrddA==
X-Google-Smtp-Source: AGHT+IEOIphgHopSaOezNjvNbxVt55HKh/ZZeJDTGvr+F5Y5GPo7Vs6YnLAUsVLHbt4aHfaTzbXzug==
X-Received: by 2002:a05:6808:17a6:b0:3ae:12f6:ac51 with SMTP id bg38-20020a05680817a600b003ae12f6ac51mr18396885oib.41.1698797955745;
        Tue, 31 Oct 2023 17:19:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n21-20020aca2415000000b003af638fd8e4sm65309oic.55.2023.10.31.17.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:19:15 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 31 Oct 2023 17:18:55 -0700
Subject: [PATCH v9 5/5] riscv: Test checksum functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-optimize_checksum-v9-5-ea018e69b229@rivosinc.com>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
In-Reply-To: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add Kconfig support for riscv specific testing modules. This was created
to supplement lib/checksum_kunit.c, and add tests for ip_fast_csum and
csum_ipv6_magic.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.debug              |   1 +
 arch/riscv/lib/Kconfig.debug          |  31 ++++
 arch/riscv/lib/Makefile               |   2 +
 arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++
 4 files changed, 364 insertions(+)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index e69de29bb2d1..53a84ec4f91f 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -0,0 +1 @@
+source "arch/riscv/lib/Kconfig.debug"
diff --git a/arch/riscv/lib/Kconfig.debug b/arch/riscv/lib/Kconfig.debug
new file mode 100644
index 000000000000..fc7da3b107ad
--- /dev/null
+++ b/arch/riscv/lib/Kconfig.debug
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "riscv lib Testing and Coverage"
+
+menuconfig RUNTIME_LIB_TESTING_MENU
+	bool "Runtime Lib Testing"
+	def_bool y
+	help
+	  Enable riscv runtime lib testing.
+
+if RUNTIME_LIB_TESTING_MENU
+
+config RISCV_CHECKSUM_KUNIT
+	tristate "KUnit test riscv checksum functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the checksum functions at boot.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
+endif # RUNTIME_LIB_TESTING_MENU
+
+endmenu # "riscv lib Testing and Coverage"
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 2aa1a4ad361f..1535a8c81430 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -12,3 +12,5 @@ lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_RISCV_CHECKSUM_KUNIT) += riscv_checksum_kunit.o
diff --git a/arch/riscv/lib/riscv_checksum_kunit.c b/arch/riscv/lib/riscv_checksum_kunit.c
new file mode 100644
index 000000000000..27f0e465447f
--- /dev/null
+++ b/arch/riscv/lib/riscv_checksum_kunit.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test cases for checksum
+ */
+
+#include <linux/in6.h>
+
+#include <kunit/test.h>
+#include <net/checksum.h>
+#include <net/ip6_checksum.h>
+
+#define CHECK_EQ(lhs, rhs) KUNIT_ASSERT_EQ(test, lhs, rhs)
+
+static const u8 random_buf[] = {
+	0x3d, 0xf9, 0x6f, 0x81, 0x84, 0x11, 0xb8, 0x03, 0x8f, 0x00, 0x1e, 0xfd,
+	0xc6, 0x77, 0xf7, 0x72, 0xde, 0x16, 0xe2, 0xf7, 0xf8, 0x81, 0x4b, 0x3e,
+	0x36, 0x57, 0x9c, 0x10, 0x4e, 0x53, 0x44, 0x94, 0x5e, 0x6c, 0x5b, 0xde,
+	0x98, 0x8a, 0xc5, 0x0a, 0x5d, 0x24, 0x38, 0x4c, 0x50, 0xef, 0x20, 0xe8,
+	0x14, 0x4e, 0x8d, 0x3e, 0x80, 0x9a, 0xd9, 0xf1, 0xb5, 0x2d, 0x27, 0x6d,
+	0xb4, 0x99, 0x9b, 0x10, 0xf7, 0x12, 0x14, 0xff, 0xe8, 0xe1, 0xd5, 0x1a,
+	0x96, 0x86, 0x6a, 0xb3, 0xde, 0x10, 0xf3, 0xa5, 0x08, 0xbd, 0x74, 0x27,
+	0x5a, 0x72, 0x4f, 0x5a, 0xd3, 0x4b, 0xbb, 0x73, 0xe3, 0x71, 0xd1, 0x1d,
+	0x8c, 0xb3, 0x69, 0xd9, 0x3c, 0xda, 0x58, 0x73, 0x86, 0x19, 0xd1, 0xf9,
+	0x58, 0xee, 0x4a, 0x39, 0xf9, 0x43, 0x38, 0x22, 0x8a, 0x6f, 0xee, 0xb5,
+	0x7a, 0x31, 0x52, 0x32, 0x80, 0xf1, 0x70, 0x60, 0x7c, 0x0a, 0xa6, 0x54,
+	0x08, 0x11, 0x99, 0xa1, 0x4b, 0x58, 0xc1, 0xbe, 0x6d, 0x5e, 0xd1, 0x32,
+	0x79, 0xcf, 0xaf, 0x7c, 0x52, 0x6f, 0x26, 0xc4, 0xa8, 0x1d, 0x67, 0x04,
+	0x2f, 0xb8, 0x10, 0x9d, 0x97, 0x2f, 0xe3, 0xa1, 0xf7, 0x88, 0xa4, 0xab,
+	0xd9, 0x22, 0xaa, 0x8d, 0x11, 0x3b, 0x27, 0x34, 0x31, 0xd6, 0x44, 0xeb,
+	0x9f, 0x4c, 0x22, 0x29, 0xea, 0x83, 0xa4, 0x6b, 0x48, 0x7a, 0xe7, 0x4c,
+	0x84, 0x5b, 0x24, 0xbe, 0x1e, 0x1f, 0xf6, 0xc7, 0x9e, 0xd4, 0xc1, 0x52,
+	0x23, 0x18, 0xaa, 0xfe, 0x72, 0x63, 0x7f, 0x2f, 0xcd, 0xda, 0x0e, 0x39,
+	0x09, 0xbb, 0x84, 0x24, 0xa4, 0xa9, 0x2f, 0x01, 0x55, 0xfa, 0xb4, 0xa7,
+	0x0c, 0x9c, 0xb0, 0x22, 0x71, 0x85, 0x91, 0x62, 0x97, 0xdc, 0x8d, 0xaf
+};
+
+static const __sum16 expected_csum_ipv6_magic[] = {
+	0xf45f, 0x1b52, 0xa787, 0x5002, 0x562d, 0x2aed, 0x54b4, 0xc018, 0xfdc9,
+	0xae5a, 0xa9d1, 0x79e1, 0x12c6, 0xa262, 0x1290, 0x7632, 0x85d,	0xfa1c,
+	0xbe47, 0x304b, 0x506e, 0x4dd0, 0x1ce7, 0x49f5, 0x4c39, 0xa900, 0x16d6,
+	0x4c3d, 0xf8b7, 0x71ab, 0x9109, 0x992b, 0x19a9, 0x8b0f, 0xff9c, 0x3113,
+	0x152f, 0xcffc, 0xb3af, 0xfb87, 0x7015, 0x2005, 0x2fa5, 0x4c99, 0xd8fe,
+	0xffb5, 0x4610, 0xe437, 0xa888, 0x49b0, 0x8705, 0xabfa, 0x2ed2, 0x8788,
+	0xdff8, 0x662f, 0x3ac0, 0xf00c, 0x863a, 0xce3f, 0xfe40, 0x38e0, 0xb0a9,
+	0x181,	0xee1d, 0x707a, 0x922,	0xd470, 0x3fad, 0x6b7b, 0x3945, 0x8991,
+	0x3ffb, 0xc8c5, 0xfae1, 0x59cb, 0xfc51, 0x6954, 0x8955, 0x49d3, 0xc582,
+	0x61bd, 0xe5a4, 0xaf1d, 0xa2d0, 0xb02b, 0xbf1e, 0x20ac, 0xd5d4, 0x2450,
+	0xc454, 0x6a16, 0x4f9c, 0xeecf, 0xb7de, 0x9f27, 0x99fe, 0xb715, 0xfdc0,
+	0xc6a2, 0xbb1a, 0xf0c2, 0xbb01, 0x8f53, 0xad2f, 0x9bf7, 0x9f3,	0x87ca,
+	0xb445, 0xc220, 0x8b20, 0xd65a, 0xba07, 0x6b33, 0x4139, 0xbeef, 0x673a,
+	0xbab8, 0xa929, 0x54cf, 0x2a18, 0xbbd1, 0x2d8,	0x2269, 0xa025, 0xeece,
+	0x64a6, 0x5b74, 0x5ef7, 0xbaf5, 0x26e9, 0x2009, 0xabc0, 0x97a1, 0x41f,
+	0xe0a7, 0x6d8b, 0x2845, 0x374a, 0x76e0, 0x7303, 0x1384, 0x854e, 0xcfac,
+	0xc102, 0xc7f1, 0x479d, 0x9d8b, 0xd587, 0xc173, 0xb00c, 0xc4d1, 0xe8ed,
+	0x51d2, 0x48d4, 0xd9eb, 0x6744, 0xcaf,	0xf785, 0xe8dc, 0x9034, 0x7413,
+	0x26ce, 0x3b4b, 0xbf9,	0xba2a, 0xe9d8, 0x89de, 0x5150, 0x28ef, 0xbefb,
+	0xb67f, 0xee07, 0x1c10, 0x2534, 0x78ce, 0xfc75, 0x7a6d, 0x5cdd, 0x7edb,
+	0xf3ad, 0xd7bf, 0x3b1,	0xc411, 0xacfc, 0xe3b5, 0xca9d, 0x174e, 0x893b,
+	0x442c, 0x4dec, 0x827d, 0x5783, 0x2dac, 0x7d26, 0x3530, 0xb0db, 0x11bc,
+	0xb2ac, 0x4462
+};
+
+static const __sum16 expected_fast_csum[] = {
+	0x78e9, 0x2e78, 0xf02e, 0x52f0, 0x3353, 0xa133, 0xeda0, 0xbced, 0xe0bc,
+	0xfde0, 0x8dfd, 0xd78d, 0xf6d7, 0x3ff7, 0x240,	0xdc02, 0x96db, 0x2197,
+	0x2321, 0x3e23, 0x103f, 0xda10, 0x6dda, 0xed6d, 0x5fed, 0xd35f, 0xc7d2,
+	0x4ec8, 0xf04d, 0x87f0, 0xf587, 0x3ef5, 0x4b3f, 0x1d4b, 0x1d1d, 0x9f1c,
+	0x99f,	0x8209, 0x6682, 0x2067, 0x420,	0xc903, 0x8ec8, 0x658e, 0xca65,
+	0xbec9, 0xa6bf, 0xcba6, 0x8fcb, 0xf78e, 0xfbf6, 0xaefb, 0x1faf, 0x991f,
+	0x3399, 0x834,	0x7208, 0xdf71, 0x8edf, 0x138e, 0x5613, 0xbf56, 0x32bf,
+	0xe632, 0x1be6, 0x831c, 0xbc82, 0x47bc, 0x6148, 0x5d61, 0xf75d, 0x77f7,
+	0x9e77, 0x2a9e, 0xb32a, 0xc3b2, 0x48c4, 0x1649, 0xa615, 0x9fa6, 0x729f,
+	0x6b72, 0x556b, 0x8755, 0x987,	0x5b09, 0x625b, 0xd961, 0xc2d8, 0x53c3,
+	0x2053, 0xc420, 0x5ac4, 0xae5a, 0x88ae, 0x4789, 0x8447, 0x4984, 0xc849,
+	0xc4c7, 0xebc4, 0x86eb, 0x9487, 0x8d94, 0xd58d, 0x93d5, 0xfd92, 0xf3fd,
+	0x96f4, 0xd096, 0x7ad1, 0x757a, 0x5f75, 0x6660, 0x9266, 0x592,	0x1305,
+	0x4413, 0x2a44, 0x712a, 0x2171, 0x7e21, 0xf47d, 0xfef3, 0xf3fe, 0x5f4,
+	0x1606, 0xc715, 0xf9c6, 0xf0f9, 0x94f0, 0x7095, 0x2570, 0xd024, 0x18d0,
+	0x219,	0xb602, 0x1eb6, 0x561e, 0xcf56, 0x77cf, 0xa577, 0xa6a5, 0x93a6,
+	0x3793, 0x1537, 0x7e15, 0x207e, 0x4f20, 0x994e, 0x9b99, 0x159b, 0xd215,
+	0xacd2, 0xb4ac, 0xecb4, 0x84ec, 0xea84, 0x66ea, 0xb666, 0x18b6, 0xae18,
+	0xfbad, 0x6efc, 0x746f, 0x7c74, 0x797c, 0x7c79, 0xb97c, 0xdba,	0x620d,
+	0xd061, 0xa2d0, 0x5da2, 0x825d, 0x6082, 0xf85f, 0x72f8, 0xaf73, 0xc1ae,
+	0xd2c1, 0xb8a5, 0xacb8, 0x5aad, 0x805a, 0xcb80, 0xb6cb, 0x89b6, 0x2a8a,
+	0xf929, 0x5af9, 0x8d5a, 0x1d8d, 0xac1d, 0x4bac, 0x994b, 0x7d99, 0x17e,
+	0xff01, 0xf3fe, 0xa8f4, 0x9fa9, 0x51a0, 0x3251, 0x7c32, 0x887b, 0x9d88,
+	0x919d, 0xac91, 0x63ac, 0x7a63, 0x1c7a, 0xe51b, 0xbee4, 0x8dbe, 0xfd8d,
+	0xc1fd, 0x6ec2, 0xa66e, 0x5fa6, 0xd05f, 0x59d0, 0x3659, 0x6b36, 0x5a6b,
+	0xb859, 0xc1b7, 0xc5c1, 0xcc5,	0x930d, 0x8b92, 0x5a8b, 0xae5a, 0xe5ad,
+	0x4fe5, 0x6f50, 0x366f, 0xbb36, 0xe3bb, 0x2be3, 0x962b, 0x7196, 0xf071,
+	0x98f0, 0x3c99, 0x4f3c, 0x604f, 0x1660, 0xb915, 0xa1b9, 0xbea1, 0x11bf,
+	0xc311, 0xec3,	0xcd0e, 0xe1cc, 0xcde1, 0xbbcd, 0x6fbc, 0xf26e, 0x9f3,
+	0x250a, 0x8c24, 0xc88c, 0x2fc8, 0xf62e, 0x30f6, 0x7a30, 0x357a, 0x9b35,
+	0xf9b,	0xa30f, 0x92a3, 0xf492, 0xebf4, 0xf6eb, 0xcef6, 0x5ece, 0xe05e,
+	0xe0e0, 0xf7e0, 0x87f8, 0xb487, 0x70b4, 0x9c70, 0x839c, 0xa683, 0x92a6,
+	0xd192, 0x37d2, 0x2238, 0x1523, 0xd414, 0xacd3, 0x81ad, 0x9881, 0xf897,
+	0xfbf7, 0x14fc, 0xd15,	0x320d, 0x9032, 0x3390, 0xf232, 0xd5f1, 0xa7d5,
+	0x3a8,	0x2a04, 0x4e2a, 0xc64d, 0x21c6, 0xb321, 0x60b3, 0x361,	0x3a03,
+	0x5c39, 0xc25c, 0x60c2, 0x7660, 0x8976, 0x5489, 0xa654, 0xcaa5, 0x7bca,
+	0xf77b, 0x2f7,	0x9702, 0xaf97, 0x9caf, 0x9e9c, 0xdd9e, 0xd2dd, 0xdcd2,
+	0x62dd, 0x5463, 0xaa53, 0x76aa, 0xc375, 0x5c3,	0x2f06, 0xf42e, 0xa2f4,
+	0xa1a2, 0x4ea1, 0xe04e, 0x84e0, 0x8f85, 0x938f, 0x4c93, 0xf24c, 0xa1f2,
+	0xb9a1, 0x27ba, 0x8927, 0x1a89, 0xa51a, 0x4ba4, 0x114b, 0xde10, 0x12de,
+	0x6112, 0xab61, 0x50d3, 0xc250, 0xf6c2, 0xedf6, 0xe3ed, 0x13e4, 0x8913,
+	0x7089, 0xae6f, 0x66ae, 0x2466, 0xbf23, 0x16c0, 0x2917, 0x6a29, 0xe86a,
+	0x90e8, 0x7691, 0xb875, 0x37b9, 0xc837, 0x1bc9, 0xfc1b, 0xd9fb, 0xfbd9,
+	0x8ffb, 0xb88f, 0x52b8, 0xd751, 0xead6, 0xfcea, 0x7fd,	0x2408, 0xb223,
+	0xf6b1, 0x71f6, 0xc472, 0x13c4, 0x3c14, 0xc53c, 0x47c4, 0x3947, 0x8a38,
+	0x9b89, 0xbb9b, 0x55bb, 0x2456, 0xc24,	0x590c, 0x4258, 0x9642, 0xdc95,
+	0x2edc, 0x542f, 0xc54,	0xb90c, 0xd6b9, 0x14d7, 0x9214, 0xec91, 0xa4ec,
+	0xcda4, 0xf2cd, 0xadf2, 0x8fad, 0xc18f, 0x30c1, 0x430,	0x1205, 0x6112,
+	0x4061, 0xcd40, 0x81cc, 0x2682, 0x2e26, 0x382e, 0x6e38, 0x906e, 0x6590,
+	0xb265, 0x11b2, 0x6211, 0xe061, 0x8be0, 0xce8b, 0xeccd, 0xfcec, 0x3fd,
+	0x3504, 0x4d35, 0x114d, 0x1a11, 0xcf19, 0x82cf, 0xf83,	0x210,	0xfb01,
+	0xdfb,	0xbd0d, 0x6bd,	0x3607, 0xc735, 0x5c8,	0x7a05, 0x247a, 0xf824,
+	0x2cf8, 0x302d, 0x8530, 0x3d85, 0x1b3e, 0xc71a, 0x95c6, 0x5296, 0x7b52,
+	0xb97a, 0x6ab9, 0xca6a, 0xaca,	0x90b,	0x4409, 0x3144, 0x631,	0x5d06,
+	0x745c, 0x3474, 0x4835, 0x3e48, 0xa43e, 0x8ba4, 0xf68a, 0x20f7, 0xae20,
+	0x91ad, 0x8f91, 0x478f, 0x8f47, 0x9b8e, 0x5e9b, 0xb85e, 0x71b8, 0x4c71,
+	0xad4c, 0x73ad, 0x5273, 0xdb52, 0xe6db, 0x63e7, 0x2f64, 0x852f, 0xc884,
+	0x66c8, 0xa166, 0x6fa1, 0x726f, 0xb472, 0x4db4, 0xf94c, 0x81f9, 0x6581,
+	0xb365, 0xb4b3, 0x68b4, 0xb068, 0xbdb0, 0x23be, 0xeb23, 0xa3eb, 0xd8a3,
+	0x5ed9, 0xdc5e, 0x12dc, 0xa212, 0x85a1, 0x885,	0xeb07, 0xe9ea, 0xf8e9,
+	0xa7f9, 0x93a7, 0x9493, 0x6940, 0x1f69, 0xf61f, 0x33f6, 0x9933, 0x1f99,
+	0x201f, 0x1220, 0x1912, 0x4419, 0xf543, 0x29f5, 0xa62a, 0xa0a6, 0x2ea0,
+	0x772f, 0xb976, 0x40ba, 0x8240, 0x9582, 0x3b96, 0xe3c,	0x230e, 0x8022,
+	0x6f7f, 0x6f,	0x9900, 0x7599, 0x3c75, 0xf3c,	0xf60e, 0xb7f5, 0x79b8,
+	0x1f79, 0xd31f, 0x66d3, 0xb266, 0x16b2, 0x5b16, 0x65b,	0x4b06, 0xcd4a,
+	0xe8cc, 0x9ae8, 0x819a, 0xc81,	0x600d, 0x3a5f, 0xa23a, 0x46a2, 0x3346,
+	0x5f33, 0x4a5f, 0x854a, 0x7285, 0xf73,	0xa10,	0xf209, 0xebf1, 0x5deb,
+	0xe55d, 0x2ee5, 0xd2f,	0xf90c, 0xfff8, 0x6400, 0x5f63, 0xe5f,	0x850e,
+	0xba85, 0x8cba, 0x378d, 0x3437, 0x4734, 0xa147, 0xe0a0, 0x5ae0, 0x665b,
+	0x7d65, 0xe7e,	0xea0e, 0x1de9, 0x631e, 0x5a63, 0x685a, 0x2a68, 0x6b2a,
+	0x8b6a, 0xf8b,	0xe40f, 0x29e4, 0x4d2a, 0x6b4d, 0xb06b, 0xebaf, 0x10ec,
+	0xa910, 0x20a9, 0x5221, 0xe451, 0xd6e4, 0x18d7, 0xa019, 0xd89f, 0x71d8,
+	0x1372, 0x3313, 0x2333, 0x6e23, 0xe6e,	0xfe0e, 0x87fd, 0x488,	0x805,
+	0x7907, 0x9078, 0x1e90, 0xc81e, 0x1ec8, 0x901f, 0x1090, 0x6210, 0x2462,
+	0x4d24, 0x524d, 0x9e52, 0x8b9e, 0xfe8b, 0x4efe, 0xe34e, 0x29e3, 0xa629,
+	0xdca5, 0xb6db, 0x64b6, 0xab64, 0x5aab, 0x1d5a, 0x901d, 0x3490, 0xc134,
+	0x90c1, 0xe490, 0x3ae5, 0xe33a, 0x82e3, 0xdc82, 0xeddc, 0x6ded, 0xa06d,
+	0x90a0, 0xa490, 0x2ba5, 0x632b, 0xc562, 0x25c5, 0x5e25, 0xc5e,	0x9c0c,
+	0x359b, 0xec35, 0x48ec, 0xc048, 0x7c1,	0xa407, 0xe0a4, 0xde1,	0x8f0d,
+	0xf18e, 0xc9f1, 0x3fc9, 0xb23f, 0x7ab2, 0xa07a, 0x9da0, 0x1d9d, 0xd31c,
+	0xdbd2, 0x45dc, 0xa145, 0x1a2,	0x1e86, 0x2b1e, 0x8d2b, 0xd58c, 0x3d6,
+	0xfd03, 0xf0fc, 0x7cf1, 0xa87c, 0xbba8, 0xb9ba, 0xb8b9, 0xceb8, 0x6acf,
+	0xf86a, 0xd4f8, 0x2cd5, 0x332d, 0xa932, 0x3ba9, 0xaf3b, 0x7eaf, 0x37f,
+	0xa303, 0xd4a2, 0x24d4, 0x9224, 0x2592, 0x9225, 0x7c91, 0xd27c, 0xacd2,
+	0x67ac, 0x2267, 0xf221, 0xa7f1, 0xb5a8, 0xaab5, 0xb9aa, 0x5ba,	0x1105,
+	0x8410, 0x2484, 0xc923, 0xcac8, 0x10cb, 0xfd10, 0xbcfc, 0xbdbd, 0x77bd,
+	0x9977, 0xb599, 0x7db5, 0x627d, 0xcc62, 0x80cc, 0x4a81, 0x534a, 0x653,
+	0xa905, 0x55a9, 0xd155, 0x3bd1, 0x33c,	0x7302, 0xbd73, 0xabbc, 0x78ab,
+	0x3779, 0xdb37, 0xffdb, 0xdfff, 0x20df, 0x1d21, 0xb91c, 0x3cb9, 0x333d,
+	0x2233, 0x22,	0xdd00, 0x83dd, 0x5b83, 0xd15b, 0xe1d0, 0x42e1, 0xc142,
+	0x83c1, 0xbe83, 0xabbe, 0x11ac, 0x611,	0x5c06, 0x195c, 0xc319, 0x80c3,
+	0xee80, 0x49ee, 0x724a, 0xec72, 0x42ec, 0x2443, 0x3424, 0xa634, 0xcba5,
+	0x5acb, 0xe45a, 0x15e4, 0xe415, 0xdce4, 0xc3dc, 0xfbc3, 0x5efb, 0xb85e,
+	0x5b9,	0x8d05, 0x178d, 0xeb16, 0xf8ea, 0x3cf9, 0x803d, 0xee80, 0xcbee,
+	0x67cb, 0xd68,	0xfd0c, 0xf5fc, 0xbef6, 0x83be, 0x7d83, 0x87d,	0xff07,
+	0x9ff,	0xa809, 0x38a7, 0x9638, 0x2796, 0xaa27, 0x61aa, 0xc761, 0xfbc7,
+	0x51fc, 0x3852, 0xda37, 0xc4da, 0x21c4, 0x9e21, 0xa49e, 0x2ba5, 0xf82b,
+	0x93f7, 0xe393, 0x15e3, 0x3c16, 0x763c, 0xdf75, 0xf5de, 0x96f5, 0xa096,
+	0xf3a0, 0x8cf3, 0xd28c, 0x5d3,	0xe305, 0xf2e2, 0xbcf2, 0x4bbd, 0x714b,
+	0x2e71, 0xca2e, 0xe4ca, 0xd4e4, 0xe4d4, 0x63e4, 0x8363, 0x3b83, 0x2b3b,
+	0x402b, 0x8f3f, 0x3b8f, 0xc53b, 0xedc5, 0x8928, 0x889,	0x5e09, 0x405e,
+	0x9340, 0x7493, 0xb573, 0xbb6,	0xd10a, 0x85d1, 0x8385, 0x1683, 0x4217,
+	0x5d42, 0x1f5d, 0x7b1f, 0xa07a, 0xa3a0, 0x89a3, 0x5e8a, 0x145f, 0xa314,
+	0xfca2, 0x52fc, 0x2a53, 0x9229, 0x6e92, 0x1a6f, 0x8019, 0x7f7f, 0xf17e,
+	0xedf0, 0x6aee, 0xb66a, 0x50b6, 0xa750, 0x7ba7, 0x617b, 0xf561, 0x33f5,
+	0x5a33, 0x885a, 0xc187, 0x4bc1, 0xe64b, 0x41e6, 0x6342, 0x1363, 0xf113,
+	0x54f0, 0xf354, 0x26f3, 0xbe26, 0xc3bd, 0xe6c3, 0xcbe6, 0xbacc, 0xf5ba,
+	0x34f5, 0xb334, 0xc8b2, 0x2ac9, 0x882a, 0x6d88, 0x256d, 0xde25, 0x1ede,
+	0x211e, 0x2421, 0xb124, 0x17b1, 0x3c18, 0xf93b, 0xd8f8, 0x3bd9, 0xb3c,
+	0xcd0b, 0x5fcd, 0x6e5f, 0x646e, 0x5e64, 0xf25d, 0xe9f2, 0x14ea, 0xdf14,
+	0xeede, 0x5fee, 0xcd5f, 0x59cd, 0x245a, 0x9b24, 0x399b, 0xba39, 0x14bb,
+	0x1b15, 0x4d1b, 0x974c, 0x8d97, 0xf28d, 0x35f2, 0xd36,	0x50d,	0x8905,
+	0x8c88, 0xc98c, 0x99c9, 0x1399, 0xbb13, 0x90bb, 0xc190, 0xfc2,	0xe60f,
+	0x84e5, 0x3685, 0xab36, 0x7ab,	0xc907, 0x62c9, 0x8062, 0x4081, 0x9940,
+	0x2399, 0x9b23, 0x929a, 0x2b92, 0x1b2b, 0x941b, 0xe793, 0x48e7, 0x8a48,
+	0x308a, 0x8630, 0xf785, 0x7cf7, 0xcd7c, 0xeecd, 0x3aef, 0x93b,	0xbd08,
+	0x85bd, 0x9085, 0x5390, 0xa253, 0x2a3,	0xac02, 0x91ab, 0xf791, 0x9cf7,
+	0x89d,	0xa708, 0xfda6, 0xe5fc, 0x74e6, 0xa75,	0x370a, 0x4d37, 0x7d4c,
+	0x5d7d, 0x165e, 0x7815, 0xeb77, 0x70eb, 0x4670, 0x9246, 0x9592, 0x6696,
+	0x667,	0x6106, 0xb360, 0xc7b3, 0x72c7, 0xf272, 0xd0f2, 0x36d0, 0x3136,
+	0x4f31, 0x2c4f, 0x772c, 0x4777, 0x3747, 0xe38,	0x1893, 0x8018, 0x2280,
+	0xcf22, 0xbbce, 0x3ebc, 0x7f3e, 0x697f, 0x4469, 0x7844, 0xaa77, 0xbca9,
+	0xb5bc, 0xcdb5, 0xffcd, 0x9e00, 0x59e,	0xc805, 0x82c7, 0xe83,	0x6a0f,
+	0x106a, 0xd910, 0x47d9, 0x1847, 0x9517, 0x8d94, 0x5b8d, 0x835b, 0x1383,
+	0x5013, 0xed4f, 0x30ed, 0x6d30, 0x8c6d, 0xd58b, 0xc4d5, 0x65c5, 0x9265,
+	0xb692, 0x75b6, 0xb975, 0x27b9, 0xa227, 0x19a2, 0x1f19, 0xbd1f, 0x84bc,
+	0x3185, 0xb630, 0xdb6,	0x720d, 0x2e72, 0x662e, 0x1566, 0xd615, 0x2dd6,
+	0x4f2e, 0x814e, 0x1d81, 0x7b1d, 0x4b7b, 0xfb4b, 0x15fb, 0x1215, 0xb412,
+	0x36b3, 0x7d36, 0xfc7d, 0x6cfc, 0x9a6d, 0xa9b,	0x930a, 0x1693, 0xaa16,
+	0x92a9, 0xa792, 0xf6a7, 0x86f6, 0x9787, 0xfa97, 0x1ffa, 0xc61f, 0x23c6,
+	0x8d23, 0x18d,	0xf501, 0xaaf4, 0xfaaa, 0x75fb, 0x3576, 0x9835, 0x798,
+	0x3008, 0x2130, 0x4021, 0x803f, 0x5e80, 0xd55e, 0xf6d4, 0x7bf7, 0xba7b,
+	0x86ba, 0x6386, 0x7d63, 0x977d, 0x2797, 0x4228, 0x5d42, 0xf25c, 0x2df3,
+	0xd62d, 0x62d6, 0xa063, 0xee9f, 0xc7ee, 0x73c7, 0xba73, 0xb3ba, 0xc5b3,
+	0xc7c5, 0x48c7, 0x7048, 0xf66f, 0xf6f5, 0x9cf6, 0xc59d, 0x63c5, 0x9863,
+	0xce98, 0x67ce, 0x4d68, 0x884d, 0x2488, 0xc323, 0x78c3, 0x7978, 0x2479,
+	0x8524, 0xc385, 0x1ac4, 0x471a, 0xf546, 0x73f5, 0xbc73, 0xa4bc, 0x11a5,
+	0x6d11, 0x416d, 0x3b41, 0x553b, 0x3d55, 0x5b3d, 0xc75b, 0x59c7, 0x3859,
+	0x9637, 0xc895, 0x79c8, 0x1779, 0xc417, 0x8bc4, 0xdb8b, 0xc4db, 0x7ec4,
+	0x497f, 0xa449, 0x6ea4, 0x206f, 0x7b20, 0x687a, 0x1669, 0xbd16, 0x1ebd,
+	0x3d1e, 0xc13c, 0x4cc1, 0x4e4c, 0x794e, 0x6379, 0x6364, 0x4121, 0x4a41,
+	0xec4a, 0x2cec, 0x2f2d, 0x312f, 0xa630, 0xfa6,	0xb80e, 0xe8b7, 0x8ae8,
+	0xdf8a, 0x1ae0, 0xf21a, 0xf8f1, 0x4df9, 0x5b4e, 0x355b, 0x5f35, 0x360,
+	0x5803, 0x1358, 0xf812, 0x88f7, 0x1b89, 0x291b, 0xec28, 0x5aec, 0x495a,
+	0xca48, 0x8bca, 0x1b8b, 0x7a1b, 0x717a, 0x2971, 0x5829, 0xe058, 0x96e0,
+	0xf896, 0xcf9,	0xa90c, 0x96a8, 0x8196, 0x1381, 0x5a13, 0x8059, 0xd780,
+	0xcfd6, 0xa1d0, 0x58a1, 0x3c58, 0x7c3c, 0xa17b, 0xbfa1, 0x61bf, 0x4062,
+	0xe040, 0x6fe0, 0xf46f, 0xc5f3, 0x67c5, 0x2168, 0x1321, 0x7213, 0xea71,
+	0x6fea, 0xb96f, 0x4bb9, 0x964c, 0xaa96, 0x8ab,	0x9208, 0x6d91, 0xad6d,
+	0xc2ad, 0xc5c2, 0x43c6, 0x2444, 0x6323, 0xa663, 0xa8a6, 0x32a8, 0x5b33,
+	0x15b,	0x2e01, 0x532e, 0x8f53, 0x98f,	0x4809, 0x9148, 0x3b91, 0x8b3b,
+	0xf08a, 0xf1,	0x401,	0x104,	0xef00, 0x13ef, 0xd313, 0xcdd2, 0x2fce,
+	0xb82f, 0x9ab8, 0xea9a, 0x49ea, 0xc849, 0x45c8, 0x3246, 0x3b33, 0x5c3b,
+	0x715c, 0x9671, 0xd96,	0xf80d, 0x21f8, 0x4d21, 0xa24c, 0xdfa1, 0x88df,
+	0x2989, 0x9329, 0xca92, 0xa1ca, 0x72a1, 0x4672, 0xe146, 0xfce1, 0x2afd,
+	0x292b, 0x7629, 0x5d75, 0xd75d, 0xc6d6, 0x3fc6, 0x8b3f, 0xb68b, 0x3b7,
+	0x1803, 0xd817, 0x34d8, 0x2b35, 0x5a2b, 0xf5a,	0x440f, 0xf543, 0x38f5,
+	0x6939, 0xc469, 0x27c4, 0xf827, 0x77f8, 0x2877, 0x7428, 0x3274, 0xbd31,
+	0xd7bc, 0x6ed7, 0xe36e, 0xee4,	0x4a0e, 0xad49, 0x6ead, 0x796e, 0xd279,
+	0xebd2, 0xfceb, 0x99fc, 0x929a, 0xc93,	0x630d, 0x7462, 0x8874, 0xdd88,
+	0xf5dc, 0x6ef5, 0xed6e, 0xa1ed, 0xc9a1, 0x7dc9, 0x597d, 0xc159, 0xb47f,
+	0x3cb4, 0x133d, 0xd312, 0xa2d2, 0xa1a2, 0x86a1, 0x3287, 0x1d32, 0xd1d,
+	0x840c, 0x8f83, 0x7090, 0x5f70, 0xd55f, 0x42d6, 0x4942, 0x3849, 0x7e37,
+	0x447e, 0x5b45, 0xa75b, 0x56a7, 0x8856, 0xe187, 0xdfe0, 0x27e0, 0x8927,
+	0x9288, 0xce92, 0x28ce, 0x9e28, 0x959e, 0xa295, 0x8fa2, 0xae8f, 0x13af,
+	0x7413, 0x5274, 0x7e52, 0xe97d, 0xf7e8, 0x9bf7, 0x5e9b, 0xca5e, 0x22ca,
+	0x623,	0xda05, 0x14da, 0xb214, 0x88b1, 0xe688, 0x53e6, 0xe053, 0xd4e0,
+	0xe8d4, 0xcce8, 0x45cd, 0xc45,	0x220c, 0x4022, 0xdd3f, 0x95dd, 0x4096,
+	0x8440, 0xad84, 0x27ad, 0xd326, 0x70d3, 0x4171, 0x2142, 0xc521, 0x9c5,
+	0xdb09, 0x9eda, 0xd49e, 0xf1d4, 0x36f2, 0xf836, 0x83f8, 0x4984, 0x8449,
+	0xf584, 0x5ff5, 0x7b5f, 0x6e7b, 0x956e, 0xfc94, 0x30fc, 0x6231, 0x1e62,
+	0x4c1e, 0x5f4c, 0xb65f, 0x1b6,	0xd801, 0xa2d7, 0x11a3, 0xe711, 0x54e7,
+	0xfc54, 0xe8fb, 0xb8e9, 0xdab8, 0x27db, 0x3228, 0x8931, 0xf289, 0xe5f2,
+	0xb3e5, 0xa4b4, 0x1ba4, 0x3c1b, 0x1d3c, 0xf71c, 0xb0f6, 0x6db0, 0x616d,
+	0xba61, 0xa5ba, 0xe2a5, 0xee3,	0xd90e, 0x39d9, 0xd739, 0x88d7, 0xf288,
+	0xb4f2, 0x67b4, 0x9167, 0x2591, 0x1526, 0x5115, 0x3350, 0xde32, 0x27de,
+	0x1428, 0x2b14, 0xf22a, 0x4f2,	0x6405, 0xee63, 0x66ee, 0x9b67, 0xdb9a,
+	0xf5db, 0x8bf6, 0xaf8b, 0x40af, 0x6340, 0xdb62, 0xc7da, 0x4cc8, 0x4d4d,
+	0x524d, 0xa52,	0x5809, 0xc657, 0xacc6, 0x57ac, 0x1a58, 0x221a, 0x6f21,
+	0xf66f, 0xd7f6, 0xe4d8, 0xa5e4, 0x4a6,	0x2d05, 0x3a2d, 0xa639, 0xb4a6,
+	0x32b5, 0x7132, 0x7370, 0xe372, 0xffe2, 0x800,	0x3a08, 0x9c39, 0x29d,
+	0x2825, 0xad27, 0xf3ad, 0xf5f3, 0x7f6,	0xc607, 0x7fc5, 0xe27f, 0x72e2,
+	0x7a72, 0x607a, 0x8460, 0x5e84, 0x625e, 0xf461, 0x83f4, 0x4c84, 0xcc4c,
+	0xdccb, 0x43dd, 0x2144, 0x5e21, 0x925e, 0xb691, 0x2ab6, 0xe42a, 0xc4e3,
+	0xbc5,	0xae0b, 0xffad, 0x8eff, 0xf48e, 0xc8f4, 0x7fc8, 0xe97f, 0x1fe9,
+	0x5420, 0xd553, 0x6cd5, 0xc96c, 0x59c9, 0x9a59, 0xca99, 0x68ca, 0x3d68,
+	0x7c3d, 0x527c, 0x4452, 0xc744, 0xd2c6, 0xfbd2, 0x8efb, 0x408e, 0xb640,
+	0xecb5, 0x44ed, 0xa545, 0x1a5,	0x8f01, 0xf08e, 0xd9f0, 0x1ada, 0x41b,
+	0xc803, 0x5ec7, 0x445f, 0x4044, 0x640,	0xd07,	0x6f0d, 0xfd6e, 0xd3fd,
+	0xb7d3, 0xedb7, 0x33ee, 0xb233, 0x92b2, 0x8893, 0x9288, 0xe292, 0x96e2,
+	0x9f96, 0xfb9f, 0x52fb, 0x6452, 0x3f64, 0x783f, 0xbd77, 0x9fbd, 0x17a0,
+	0x1c17, 0x231c, 0x1323, 0xb413, 0x15b4, 0x5f16, 0x6f5e, 0x426f, 0x543,
+	0x4505, 0xda45, 0x52da, 0xfc52, 0x9afc, 0xd29a, 0x89d2, 0xbc89, 0x77bc,
+	0x1478, 0xd913, 0x79d9, 0x7f79, 0x77f,	0x9f07, 0x289f, 0x2d28, 0xbd2c,
+	0xa5bd, 0xf1a5, 0x6cf2, 0x736d, 0xb673, 0xceb5, 0xc3ce, 0x15c3, 0xa415,
+	0xbaa4, 0xf2ba, 0xf1f2, 0x84f1, 0x7884, 0x8678, 0x6186, 0x4661, 0xf845,
+	0xf7f7, 0x4cf8, 0xbf4c, 0x49bf, 0x5c4a, 0x4a5c, 0xab4a, 0x89ab, 0x8689,
+	0xf485, 0x60f4, 0xef60, 0x4eef, 0x194f, 0x7e19, 0x707e, 0xfa6f, 0x35fa,
+	0x3036, 0xf02f, 0x17f0, 0xc517, 0x79c4, 0xa279, 0x7ba2, 0x67c,	0xa07,
+	0x7b09, 0x687b, 0xf868, 0xbbf8, 0xd7bb, 0x30d8, 0x8231, 0xb582, 0xaab4,
+	0xaaaa, 0x90aa, 0xaf90, 0x2faf, 0x262f, 0x4126, 0xe640, 0x91e6, 0x9991,
+	0x1a9a
+};
+
+#define IPv4_MIN_WORDS 5
+#define IPv4_MAX_WORDS 15
+#define NUM_IPv6_TESTS 200
+#define NUM_IP_FAST_CSUM_TESTS 181
+
+static void test_ip_fast_csum(struct kunit *test)
+{
+	__sum16 csum_result, expected;
+
+	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
+		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
+			csum_result = ip_fast_csum(random_buf + index, len);
+			expected =
+				expected_fast_csum[(len - IPv4_MIN_WORDS) *
+						   NUM_IP_FAST_CSUM_TESTS +
+						   index];
+			CHECK_EQ(expected, csum_result);
+		}
+	}
+}
+
+static void test_csum_ipv6_magic(struct kunit *test)
+{
+	const struct in6_addr *saddr;
+	const struct in6_addr *daddr;
+	unsigned int len;
+	unsigned char proto;
+	unsigned int csum;
+
+	const int daddr_offset = sizeof(struct in6_addr);
+	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
+	const int proto_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr) +
+			     sizeof(int);
+	const int csum_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr) +
+			    sizeof(int) + sizeof(char);
+
+	for (int i = 0; i < NUM_IPv6_TESTS; i++) {
+		saddr = (const struct in6_addr *)(random_buf + i);
+		daddr = (const struct in6_addr *)(random_buf + i +
+						  daddr_offset);
+		len = *(unsigned int *)(random_buf + i + len_offset);
+		proto = *(random_buf + i + proto_offset);
+		csum = *(unsigned int *)(random_buf + i + csum_offset);
+		CHECK_EQ(expected_csum_ipv6_magic[i],
+			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
+	}
+}
+
+static struct kunit_case __refdata riscv_checksum_test_cases[] = {
+	KUNIT_CASE(test_ip_fast_csum),
+	KUNIT_CASE(test_csum_ipv6_magic),
+	{}
+};
+
+static struct kunit_suite riscv_checksum_test_suite = {
+	.name = "riscv_checksum",
+	.test_cases = riscv_checksum_test_cases,
+};
+
+kunit_test_suites(&riscv_checksum_test_suite);
+
+MODULE_AUTHOR("Charlie Jenkins <charlie@rivosinc.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1

