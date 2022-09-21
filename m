Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4D5BF4D4
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 05:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiIUDfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 23:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiIUDeF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 23:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCD1147F;
        Tue, 20 Sep 2022 20:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 195AA62F2B;
        Wed, 21 Sep 2022 03:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1FC43470;
        Wed, 21 Sep 2022 03:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663731125;
        bh=MxNuze7CJb1Pmp8L25+DA/brD4eP/MM76a60K8U4Mcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRxeTfpE+CmJ/UHg18U/YEKM1cdw9Nd3/ZrMO+2WFlPQcIVZmG+oLxSeOIhiqj56m
         30PUkA8R4skrh/squVPaUW2yj1m6I8Fo5mLX3/pyuNyIY0OMQbhrQluBMmcoKAjmu2
         Zp9XtC37CjSARm5j/qE2CdK2w6c/YsSL57SNs8KPW0ZFXTLDliXZx30woV5Knoc4aO
         Y4fy+5wVX9wUM83y8byyhaKmtUaLVvmFLCg4E3MWPFgbYzy8ihHsV+AxJ4PVnE7ja0
         e/nLwc2DtA6WcmfvtE/jt0kHwDO9FPdhe6hUBQ+s/2HzV96A/6IIm2nnsA3rIs9ogo
         gnPzMokyo8yAA==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        palmer@rivosinc.com, heiko@sntech.de, liaochang1@huawei.com,
        jszhang@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V4 3/3] arch: crash: Remove duplicate declaration in smp.h
Date:   Tue, 20 Sep 2022 23:31:34 -0400
Message-Id: <20220921033134.3133319-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220921033134.3133319-1-guoren@kernel.org>
References: <20220921033134.3133319-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h which
has been done in include/linux/smp.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
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

