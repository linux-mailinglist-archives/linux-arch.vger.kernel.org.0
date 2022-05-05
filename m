Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA41151B6CA
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiEED7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiEED7V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF62528B;
        Wed,  4 May 2022 20:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FBE619F4;
        Thu,  5 May 2022 03:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AD2C385AC;
        Thu,  5 May 2022 03:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722942;
        bh=WtKfSSpJyyg8U7WnHs0+h877cAtlMW6k7Jts1zje+Yc=;
        h=From:To:Cc:Subject:Date:From;
        b=BLyjvww/B/ExPUb6b/Pk1RsHg+gDHh12Smnakuo3vtpcjA/Gfyrrl5GbQmSy7NSkz
         Sa90xNvLa5TzNNJtPCNdhdslVHc2fuiGV6Ra9c38lZrH+PznvaswjdiDo29al//gV1
         /P464VGIHNqGjDdaz7ETsrsjCrNH5j2kL4qHay5NTK+dJLnBrIV+aAMWxQvmYFk732
         s9O0mpeYfo2QG3X9NIOTe6UiuOm3DCwMij+65LerUhc6nwkLzpN8Q4CpNW3wALir8U
         p15YjkTYyRb66N056wfPtxuv8SfS8m0GdhRJPPExolHzQvm7jWYrkivUwe3IAGQD/2
         zw8LPryNF0SbQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 0/5] riscv: Optimize atomic implementation
Date:   Thu,  5 May 2022 11:55:21 +0800
Message-Id: <20220505035526.2974382-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Here are some optimizations for riscv atomic implementation, the first
three patches are normal cleanup and custom implementation without
relating to atomic semantics.

The 4th is the same as arm64 LSE with using embedded .aq/.rl
annotation.

The 5th is good for riscv implementation with reducing a full-barrier
cost.

Changes in V4:
 - Coding convention & optimize the comments
 - Re-order the patchset

Changes in V3:
 - Fixup usage of lr.rl & sc.aq with violation of ISA
 - Add Optimize dec_if_positive functions
 - Add conditional atomic operations' optimization

Changes in V2:
 - Fixup LR/SC memory barrier semantic problems which pointed by
   Rutland
 - Combine patches into one patchset series
 - Separate AMO optimization & LRSC optimization for convenience
   patch review

Guo Ren (5):
  riscv: atomic: Cleanup unnecessary definition
  riscv: atomic: Optimize acquire and release for AMO operations
  riscv: atomic: Optimize memory barrier semantics of LRSC-pairs
  riscv: atomic: Optimize dec_if_positive functions
  riscv: atomic: Add conditional atomic operations' optimization

Guo Ren (5):
  riscv: atomic: Cleanup unnecessary definition
  riscv: atomic: Optimize dec_if_positive functions
  riscv: atomic: Add custom conditional atomic operation implementation
  riscv: atomic: Optimize atomic_ops & xchg with .aq/rl annotation
  riscv: atomic: Optimize LRSC-pairs atomic ops with .aqrl annotation

 arch/riscv/include/asm/atomic.h  | 174 +++++++++++++++++++++++++++----
 arch/riscv/include/asm/cmpxchg.h |  30 ++----
 2 files changed, 162 insertions(+), 42 deletions(-)

-- 
2.25.1

