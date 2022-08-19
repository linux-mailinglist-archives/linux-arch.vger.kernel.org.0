Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD459934B
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 05:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbiHSCy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 22:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiHSCy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 22:54:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C1D39B4;
        Thu, 18 Aug 2022 19:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 317CCB82558;
        Fri, 19 Aug 2022 02:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACEFC433D6;
        Fri, 19 Aug 2022 02:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660877695;
        bh=MWB0MHyVat//RCNcc5nnre2niTbT73AZeuEoxZb/j5I=;
        h=From:To:Cc:Subject:Date:From;
        b=toZYXqMaVqIO8OTDDRJtnrrNomIuEAiPS86Hrmo94FdHsZSV8tTL9aTemldPAceix
         iZ3BUhvzmkSYGcSvGqTN/78PwcPPzY0CDt76g+N4jyRqoLAqQByoQaQtmfR0CGzFs0
         /ADmlXcN03Gv5aQ7JHE0bzN/zEnF2UAbJE4zg5iN4a4r8NQR6/tx+n39mdJAl/2FKv
         80TWYqEt70t/MqIXpimdZtdZqRHPyE2LwrlBHPizEF77xmxsz1EdcX3gHMp4EaK41z
         lkNsXKQNpd9QCPEd2yJzg5v40ayZPQEES9o+1wmybFR6obzkpFXu1FKKRX2Q+3OIwd
         PgFeELRDYZoKQ==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, guoren@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/3] riscv: kexec: Fixup crash_save percpu and machine_kexec_mask_interrupts
Date:   Thu, 18 Aug 2022 22:54:41 -0400
Message-Id: <20220819025444.2121315-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v2: https://lore.kernel.org/linux-riscv/20220817161258.748836-1-guoren@kernel.org/ 
v1: https://lore.kernel.org/linux-riscv/20220816012701.561435-1-guoren@kernel.org/

Changes in v3:
 - Fixup compile problem with !SMP, which reported by lkp@intel.com
 - Cleanup declarations in asm/smp.h
 - Add reviewed-by

Changes in v2:
 - Add Fixes tags
 - Remove extern from bool smp_crash_stop_failed(void)

Guo Ren (3):
  riscv: kexec: Disable all interrupts in kexec crash path
  riscv: kexec: Fixup crash_smp_send_stop with percpu crash_save_cpu
  arch: crash: Remove duplicate declaration in smp.h

 arch/arm64/include/asm/smp.h      |  1 -
 arch/riscv/include/asm/smp.h      |  3 ++
 arch/riscv/kernel/machine_kexec.c | 46 ++++++++++++----
 arch/riscv/kernel/smp.c           | 89 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/crash.h      |  1 -
 5 files changed, 125 insertions(+), 15 deletions(-)

-- 
2.36.1

