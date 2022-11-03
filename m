Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C2617845
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 09:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKCIFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 04:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCIFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 04:05:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26C116C;
        Thu,  3 Nov 2022 01:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5061CB82695;
        Thu,  3 Nov 2022 08:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D7C433C1;
        Thu,  3 Nov 2022 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667462704;
        bh=0H/9grb2h1ZdT4tEjfsYpds+m01aFKc77P1+gyy/5Kc=;
        h=From:To:Cc:Subject:Date:From;
        b=S61gmKRQeL/qIkrXM6DcGZ60Mxme4miDWVTrAJLek6OczOIhvnd3ew4OSq5qsaaL6
         QCFj8EkymGXHCVM61erCNj1zxqL5YMlqVvPStNdgVP83D9/7ZK56YCYt/U4BjP2BSS
         u3zyHDqNoR9v3t3j3Fu7WRK74jq05iIa7w0y61otsQCG88GQeofE5K2WqATIXiA7uh
         L9dsUv/FkjxM3VGXui2WiADK5oC9wGa0auHfjlsgw4a6isUYRaf0fXtvFbEOwn+U1C
         1ktyawcdNc1bXSFZIqfhUE+iDE1XG7Xaiwd+DpQrXJ0AUfhrVkCR2DX5jyH6zdB5YK
         fuQs6j5P68noQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, shuah@kernel.org,
        skhan@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        "haocheng . zy" <haocheng.zy@linux.alibaba.com>,
        Mao Han <han_mao@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Elliott Hughes <enh@google.com>
Subject: [PATCH V2] selftests/vDSO: Add riscv getcpu & gettimeofday test
Date:   Thu,  3 Nov 2022 04:04:51 -0400
Message-Id: <20221103080451.1642500-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@kernel.org>

Enable vDSO getcpu & gettimeofday test for riscv. But only riscv64
supports __vdso_gettimeofday and riscv32 is under development.

VERSION
{
        LINUX_4.15 {
        global:
                __vdso_rt_sigreturn;
                __vdso_gettimeofday;
                __vdso_clock_gettime;
                __vdso_clock_getres;
                __vdso_getcpu;
                __vdso_flush_icache;
        local: *;
        };
}

Co-developed-by: haocheng.zy <haocheng.zy@linux.alibaba.com>
Signed-off-by: haocheng.zy <haocheng.zy@linux.alibaba.com>
Suggested-by: Mao Han <han_mao@linux.alibaba.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Elliott Hughes <enh@google.com>
---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c       | 4 ++++
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index fc25ede131b8..1df5d057d79f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -14,7 +14,11 @@
 #include "../kselftest.h"
 #include "parse_vdso.h"
 
+#if defined(__riscv)
+const char *version = "LINUX_4.15";
+#else
 const char *version = "LINUX_2.6";
+#endif
 const char *name = "__vdso_getcpu";
 
 struct getcpu_cache;
diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 8ccc73ed8240..e411f287a426 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -27,6 +27,9 @@
 #if defined(__aarch64__)
 const char *version = "LINUX_2.6.39";
 const char *name = "__kernel_gettimeofday";
+#elif defined(__riscv)
+const char *version = "LINUX_4.15";
+const char *name = "__vdso_gettimeofday";
 #else
 const char *version = "LINUX_2.6";
 const char *name = "__vdso_gettimeofday";
-- 
2.36.1

