Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225B6062AD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJTOQn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJTOQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 10:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E5B14DF13;
        Thu, 20 Oct 2022 07:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1335C61BA0;
        Thu, 20 Oct 2022 14:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0C7C433C1;
        Thu, 20 Oct 2022 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666275399;
        bh=33WQ+X8Qxfmn5zCJMZeuV/59uVzIastC86R8fyKVBYI=;
        h=From:To:Cc:Subject:Date:From;
        b=UqAXvdKiv0PFm/2rr+IKWX8v6m2RJdSIXCy1N/7qPZlDbUQ5AoydaM0T4yrlbKJ3O
         nIKH6mQfM68kYjzey51RWW8Sr/Nwxozc3KNeEZOhtEEP2V9DxEI84MzOAvw8LovEJi
         CijQAoWzEdT59evlZpm8ngoCkpoOH/YMcfLlY21wlKdD/WnUSZA/gT0MrlLJYa5mtl
         Qpv9QlPy0qwybO3yNoV4jROBQm6o0pv0E9KETolxNWzOb74SmiephxjS0O4OAlPWNG
         guLvHaQHOpGZ1o/RAbkgVn9xUEtkkLzG48+x/ATY2JxMtfwN1qwo7kKyEgyULhADtc
         +DEjwpm83v6hA==
From:   guoren@kernel.org
To:     guoren@kernel.org, xianting.tian@linux.alibaba.com,
        palmer@dabbelt.com, palmer@rivosinc.com, heiko@sntech.de,
        arnd@arndb.de, lijiang@redhat.com, bagasdotme@gmail.com,
        bhe@redhat.com, yixun.lan@gmail.com, goyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, crash-utility@redhat.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 0/2] riscv: kexec: Fxiup crash_save percpu and machine_kexec_mask_interrupts
Date:   Thu, 20 Oct 2022 10:16:01 -0400
Message-Id: <20221020141603.2856206-1-guoren@kernel.org>
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

Current riscv kexec can't crash_save percpu states and disable
interrupts properly. The patch series fix them, make kexec work correct.

Changlogs:
v5:
 - Remove the patch which isn't relate to riscv
 - Add fixup crash_smp_send_stop test result

v4:
https://lore.kernel.org/linux-riscv/20220921033134.3133319-1-guoren@kernel.org/
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


Guo Ren (2):
  riscv: kexec: Fixup irq controller broken in kexec crash path
  riscv: kexec: Fixup crash_smp_send_stop without multi cores

 arch/riscv/include/asm/smp.h      |  3 +
 arch/riscv/kernel/machine_kexec.c | 46 +++++++++++----
 arch/riscv/kernel/smp.c           | 97 ++++++++++++++++++++++++++++++-
 3 files changed, 133 insertions(+), 13 deletions(-)

-- 
2.36.1

