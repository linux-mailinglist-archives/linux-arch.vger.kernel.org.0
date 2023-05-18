Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2880708271
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjERNPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjERNPC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19B1BD3;
        Thu, 18 May 2023 06:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4DC64F58;
        Thu, 18 May 2023 13:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867F1C433EF;
        Thu, 18 May 2023 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415652;
        bh=MyHJegve8NZNKQPZ+1otBp4zGgUGxsJifmAO8XUsjmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zku0hQdEV1exPT3SP1wIQ3khOpfFtF+qMJJdeGimM00UCnJ1z3lRyLxy9ZeaD2GA7
         kvoGNPfdoFZBUI8hyocJ1TK5nCnDerh6/rWdFQpX0MMpjQSpxJ1CXOfKRYjiccD3io
         FtdTmfxlGx/TOtpIclqH9RrchewsGAgtATU3mwpvt9agtw7b2QVRk1nG0JR14UNyJ7
         fg2V4YuaXuF4bmFv5DoNlcrrJScjph1XlhNBoBbIU2eEZ4T3czhDyVHPfiU1uV8QjI
         LxnVDvrIPbL1FwdEXwlde2XnhMZ4T3p3eHq766tK8/WKOHqP1rmj8aIwCynqDNeSnu
         wpQLSaWkHWYFw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 18/22] riscv: s64ilp32: Disable KVM
Date:   Thu, 18 May 2023 09:10:09 -0400
Message-Id: <20230518131013.3366406-19-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

Disable the KVM host feature for s64ilp32 first, and let's work on this
feature after the s64ilp32 main feature is merged.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index d5a658a047a7..a91ce7e0b754 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -20,6 +20,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
+	depends on !ARCH_RV64ILP32
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
-- 
2.36.1

