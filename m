Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD75BF4D6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 05:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiIUDfG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 23:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiIUDd6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 23:33:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5042631D;
        Tue, 20 Sep 2022 20:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E2CB81D05;
        Wed, 21 Sep 2022 03:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBF0C433C1;
        Wed, 21 Sep 2022 03:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663731113;
        bh=L86JnuAVDjwV91egGrglApUiZIzU+Mu/qe9sCYqDgWM=;
        h=From:To:Cc:Subject:Date:From;
        b=e9O4oZsEDvFJZ7tY+/tb3bYBz7fd04JUedr8USCPhjsB0NBVfG1ApVlve/CntD5i9
         VZSnYPnkRaUKTYNpwEuywjnLtOV2A0dNc6Blto0Ctmg/vI7Ps0QRT2Tf97bJvtimtW
         Xqsfol0cY4sQmKgfg4eiDyx+MXz1kgpCe/2cPWKu1A5229It89GrCmH93svxyDNLKq
         13Sk5DhTVzGTlqzL19tTEwKWDtfy6iO/yvE+uunLajQfaNHKYTO8VbKaVYVKWD9Bpj
         AVYrcu65tCejmheajxcXRVz35zYP9RaG/SBJ5PW3A7+quaPkPJngBfGwKvfYsM8Pcu
         amwxs3N7G2Jtg==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        palmer@rivosinc.com, heiko@sntech.de, liaochang1@huawei.com,
        jszhang@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 0/3] riscv: kexec: Fxiup crash_save percpu and machine_kexec_mask_interrupts
Date:   Tue, 20 Sep 2022 23:31:31 -0400
Message-Id: <20220921033134.3133319-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

Current riscv kexec can't crash_save percpu states and disable
interrupts properly. The patch series fix them, make kexec work correct.

Also cleanup arm64, x86 declarations in asm/smp.h.

Changlogs:

v4:
 - Add cpu_ops[cpu]->cpu_stop() in ipi_cpu_crash_stop
 - Wording optimization in comments

V3:
https://lore.kernel.org/linux-riscv/20220819025444.2121315-1-guoren@kernel.org/
 - Fixup compile problem with !SMP, which reported by lkp@intel.com
 - Cleanup declarations in asm/smp.h
 - Add reviewed-by

V2:
https://lore.kernel.org/linux-riscv/20220817161258.748836-1-guoren@kernel.org/ 
 - Add Fixes tags
 - Remove extern from bool smp_crash_stop_failed(void)

V1:
https://lore.kernel.org/linux-riscv/20220816012701.561435-1-guoren@kernel.org/

Guo Ren (3):
  riscv: kexec: Fixup irq controller broken in kexec crash path
  riscv: kexec: Fixup crash_smp_send_stop without multi cores
  arch: crash: Remove duplicate declaration in smp.h

 arch/arm64/include/asm/smp.h      |  1 -
 arch/riscv/include/asm/smp.h      |  3 +
 arch/riscv/kernel/machine_kexec.c | 46 +++++++++++----
 arch/riscv/kernel/smp.c           | 97 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/crash.h      |  1 -
 5 files changed, 133 insertions(+), 15 deletions(-)

-- 
2.36.1

