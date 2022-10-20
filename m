Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F0606258
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJTN7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJTN73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 09:59:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42EE0E4;
        Thu, 20 Oct 2022 06:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B364B82764;
        Thu, 20 Oct 2022 13:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA2EC433C1;
        Thu, 20 Oct 2022 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666274363;
        bh=cwUkz84JsLM2TshjpD90WcMoj2koUKfkqasFe6OlzrE=;
        h=From:To:Cc:Subject:Date:From;
        b=Z18qUnteaysOgIqGlS+z5kP7aJ5dDxbm5nFwuo1Efxdv5npV4+l/ke2X0jFrDW8EB
         49hKVpInnqxEb5e938QukCtM5cFU+ur7Kkd+/XlqzbBdCsr2jwQqBjeVCbBJcirFTX
         s43KPm3ZwMMqZ72pnqOauprL4eGdyL2P8VYq1C4gY4dKqNQ5dDxbZvY7glZ7VWixU7
         svTdhJ25DrXaZ77dOLvqqm9ws6cLamepysT4IxvIp5q9SPPtdpMBupGMXgUTS2XBvo
         XYwKTM6yi6ITR/pi/B8ANoPxCQGGoQ9+VQD5syAhfNb/yXmEPZaSgfArVYt0fSmGou
         vDoX1h8OED8Tg==
From:   guoren@kernel.org
To:     arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, guoren@kernel.org
Cc:     heiko@sntech.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] arch: crash: Remove duplicate declaration in smp.h
Date:   Thu, 20 Oct 2022 09:59:13 -0400
Message-Id: <20221020135913.2850550-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h
which has been in include/linux/smp.h since 6f1f942cd5fb ("smp:
kernel/panic.c - silence warnings").

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---

This patch is separated from the series [1] to let maintainer take
easily. It still needs a Acked-by from x86 side, hope it could be
soon done.

[1] https://lore.kernel.org/linux-riscv/20220921033134.3133319-1-guoren@kernel.org/
---
 arch/arm64/include/asm/smp.h | 1 -
 arch/x86/include/asm/crash.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index fc55f5a57a06..a108ac93fd8f 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -141,7 +141,6 @@ static inline void cpu_panic_kernel(void)
  */
 bool cpus_are_stuck_in_kernel(void);
 
-extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
 extern void panic_smp_self_stop(void);
 
diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..6a9be4907c82 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -7,6 +7,5 @@ struct kimage;
 int crash_load_segments(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
-void crash_smp_send_stop(void);
 
 #endif /* _ASM_X86_CRASH_H */
-- 
2.36.1

