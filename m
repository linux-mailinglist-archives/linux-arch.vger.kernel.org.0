Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E1508AFB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379595AbiDTOrW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbiDTOrV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 10:47:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F612C663;
        Wed, 20 Apr 2022 07:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED07B81CCE;
        Wed, 20 Apr 2022 14:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B81AC385A0;
        Wed, 20 Apr 2022 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650465872;
        bh=BJxtalf9Zs0yPnSPPVBN7503uk3AMK3IvHLCi2cAlLE=;
        h=From:To:Cc:Subject:Date:From;
        b=Cuhm4C+Fa6dviUDglNCm/8TyKK6NfQD7flxTILDwzI286WtwozK+tcR8hv+54Og/H
         TeziLf/5kWa0FwTuYC4Tdvq7aWiRf3TiwrIKopqR3gGU+mHMx7OcxQZfH4L8PypO/d
         kEXdHkNbW7whFULqddKLuwzIYS4kRMbOQfF4yfVuaWWbZ+ooFYWCedMlj+hILBdlCs
         mplvrcsCV48vq6dfUMfWehbzkxrYQh/LGc5bfhi+3s+pGxrgWWcyteP6TSTxQAzD4J
         GVPh2tXct1MsIM4bnHBPDv/F0QMSZY60ZKFpYG2oFPt8h7i7S30B6EvV9gRKdbiH+o
         4dZzBLeWVxaqg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/5] riscv: atomic: Optimize AMO instructions usage
Date:   Wed, 20 Apr 2022 22:44:12 +0800
Message-Id: <20220420144417.2453958-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These patch series contain one cleanup and some optimizations for
atomic operations.

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

 arch/riscv/include/asm/atomic.h  | 168 ++++++++++++++++++++++++++++---
 arch/riscv/include/asm/cmpxchg.h |  30 ++----
 2 files changed, 160 insertions(+), 38 deletions(-)

-- 
2.25.1

