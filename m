Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2AC6FE292
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjEJQfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjEJQfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 12:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914E7D99;
        Wed, 10 May 2023 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C8C664A11;
        Wed, 10 May 2023 16:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF292C433D2;
        Wed, 10 May 2023 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736512;
        bh=xdYYdDgbeOJh27nNgHFmZzDLEDBpmLgBjwcmj+Nf3Qo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ai1fuoEkb9u4C4wGl9R2tgr/RHpVl5lsEnKBu1vH6mNsGLY/jjHm8BqcvPlUHIKQ8
         eCB1lLFWH5QTU3rFLgFZiAXV5GvfucEMWbtXp+N9ChOkxUh3T8a6+BM/z4kz5qevc3
         qCxqhUnaRiemW6zyiwP1enG9ewAv7kMK3dSo11CCXCZC2IuPz9tAn+2Y8M5i7m02YM
         IiOevP4GQDOabCnTmoL8PLPRwcOAaDrtsecp/R/kiuNtD3Qpwn5yUmE+cPoTkIgtrV
         F1WGS37oCrfOJUE1oTNqpGh2wrKqXVfs0QcEaz02CM7OO9lRmQ3THYBqERDPMipx8B
         m/wPG2pwQLLGw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Schaffner Tobias <tobias.schaffner@siemens.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RT 0/3] riscv: add PREEMPT_RT support
Date:   Thu, 11 May 2023 00:24:03 +0800
Message-Id: <20230510162406.1955-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

This series is to add PREEMPT_RT support to riscv. Compared with last
try[1], there are two major changes:

1. riscv has been converted to Generic Entry. And riscv uses
asm-generic/preeempt.h, so we need to patch asm-generic's preeempt to
enable lazy preempt support for riscv. This is what patch1 does.
However, it duplicates the preempt_lazy_count() defintion, I'm sure
there must be an elegant solution. Neverless, it doesn't impact the
riscv PREEMPT_RT support itself.

2. three preparation patches(patch1/2/3 in [1]) has been merged in
mainline.

I back-ported the lastest linux-6.3.y-rt patches to the lastest Linus tree,
then cook this series.

Link: https://lore.kernel.org/linux-riscv/20220831175920.2806-1-jszhang@kernel.org/

Jisheng Zhang (3):
  asm-generic/preempt: also check preempt_lazy_count for
    should_resched() etc.
  riscv: add lazy preempt support
  riscv: Allow to enable RT

 arch/riscv/Kconfig                   | 2 ++
 arch/riscv/include/asm/thread_info.h | 5 ++++-
 arch/riscv/kernel/asm-offsets.c      | 1 +
 include/asm-generic/preempt.h        | 8 +++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.40.1

