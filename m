Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEB1615D70
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 09:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKBIPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBIPo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 04:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7053B1F9D4;
        Wed,  2 Nov 2022 01:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D41961856;
        Wed,  2 Nov 2022 08:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADCEC433C1;
        Wed,  2 Nov 2022 08:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667376942;
        bh=UxH40MzWMTgfzw2DpcmVuLk/WjWfLctWt4uq1vUp0i0=;
        h=From:To:Cc:Subject:Date:From;
        b=or6LzbYCHRbrao7fc8U/fz26mg1WS1im9d2FT2tbZCHMqTHPdBJS8v1KR65ucRjai
         qxf5Mwqwjg3JE6Y3ZU6cPwDevAAN8Cz3PtxSYRjoZpLpWHTLzuhMr3JE932rS7Tjxc
         s+6iC8znsYc8mF+z2PN8L22RM8o9HJiVmU+Sr0ODZKql2zSpEXd02z4paci1D+5dUf
         WFyuen5Pg/RHPJHiFSk64ob5eELxSXQ9VRu6aNEzJ1+cu5M5F+kwbyM/DpNMxXNYZl
         nMlszKcCisBqW2Rjrf2SKMzKVC020+UY0YAx2wdkdzMEkmyQXOTB4TS2TlHgbJHmPM
         X3eOpS1BqUkDA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, shuah@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        "haocheng . zy" <haocheng.zy@linux.alibaba.com>,
        Mao Han <han_mao@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Elliott Hughes <enh@google.com>
Subject: [PATCH] selftests/vDSO: Add riscv getcpu & gettimeofday test
Date:   Wed,  2 Nov 2022 04:15:31 -0400
Message-Id: <20221102081531.882149-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Elliott Hughes <enh@google.com>
---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c       | 5 +++++
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index fc25ede131b8..1e474f406a87 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -14,8 +14,13 @@
 #include "../kselftest.h"
 #include "parse_vdso.h"
 
+#if defined(__riscv)
+const char *version = "LINUX_4.15";
+const char *name = "__vdso_getcpu";
+#else
 const char *version = "LINUX_2.6";
 const char *name = "__vdso_getcpu";
+#endif
 
 struct getcpu_cache;
 typedef long (*getcpu_t)(unsigned int *, unsigned int *,
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

