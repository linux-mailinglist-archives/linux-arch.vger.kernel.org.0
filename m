Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25C5973F5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiHQQOV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Aug 2022 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbiHQQN4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2022 12:13:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1CA0317;
        Wed, 17 Aug 2022 09:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F116DB81E35;
        Wed, 17 Aug 2022 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B8AC433D6;
        Wed, 17 Aug 2022 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660752799;
        bh=kXQNLS4CwMPiKcaeiXiEF6+1NRLEt3k8IA9vim983Jk=;
        h=From:To:Cc:Subject:Date:From;
        b=JneOmSwu4MkndSGmEfBm3JLuf37aATz+WYX+zZsypRYYknRqAJ4SwUBJvm8MkDAZt
         asHwG4f/EkA3SkrE6HqOooxFTzSZ7XBq+76dkp+GdcLGETSAqGRE9F14gk5IjU0qm1
         C6MVy5Bw+GIaSlNoEbg+/INn01IpTXb4gWJcTOBweniK6YkExd1EHIAeqPJY3aw7Ju
         wu38BHQawUkfJbpggxqxYzgMQzmlXQvChYrPyBqQiSGnzEcBrZJk2j6gg1xfeWiz5y
         xldRSPkjfV16eSB2gWrLQqi+fHxVkPRv0Q6BH1yU3tdtPsugFqR3/BZuos3bK9I+2J
         nHlJ4M7fGLOhA==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, guoren@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/2] riscv: kexec: Fixup crash_save percpu and machine_kexec_mask_interrupts
Date:   Wed, 17 Aug 2022 12:12:56 -0400
Message-Id: <20220817161258.748836-1-guoren@kernel.org>
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

Changes in v2:
 - Add Fixes tags
 - Remove extern from bool smp_crash_stop_failed(void)

v1: https://lore.kernel.org/linux-riscv/20220816012701.561435-1-guoren@kernel.org/

Guo Ren (2):
  riscv: kexec: Disable all interrupts in kexec crash path
  riscv: kexec: Fixup crash_smp_send_stop with percpu crash_save_cpu

 arch/riscv/include/asm/smp.h      |  6 +++
 arch/riscv/kernel/machine_kexec.c | 44 +++++++++++----
 arch/riscv/kernel/smp.c           | 89 ++++++++++++++++++++++++++++++-
 3 files changed, 126 insertions(+), 13 deletions(-)

-- 
2.36.1

