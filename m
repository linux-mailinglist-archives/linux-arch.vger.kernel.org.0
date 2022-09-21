Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076985BF4F4
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 05:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIUDt0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 23:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIUDtZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 23:49:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7847C310;
        Tue, 20 Sep 2022 20:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D0D5B824A5;
        Wed, 21 Sep 2022 03:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB2C433D7;
        Wed, 21 Sep 2022 03:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663732161;
        bh=jZgvA9rdGIurOcdhOjRWdFE+IHV1sRomNrMvYECgE60=;
        h=From:To:Cc:Subject:Date:From;
        b=WDjCyeszP29zz4rNsQUtHcqKhQDvtEilDHWUjPD7lhBOeZo0fOnYKmmibY4kSZ6C2
         bcwG6I27T5LIN2s9iuhFzNT8F3Pizy1U8WSjvPJOfVOW3KNTcXcy4podgyAYFxNhzk
         9tVez2zab/sDgYJMaUMvZE6gVXlvMwEGh3fdWCrvnZhiWKUktPbW+A3+G2QoLTG6ct
         eSpGR0H0Q07xyMF8oL6zu/7OSi7JciJetGLku755XH9FGKhOacUk+8oR3Dhlhw9qyd
         hZhFGR9cERHHD4Mf3Kjue8z/MlqtchzG1bVz4R63CPZ7u1c9j0dkWgeVanAHR0U8mo
         xW9LeVUgxzcWw==
From:   guoren@kernel.org
To:     arnd@arndb.de, palmer@rivosinc.com, rostedt@goodmis.org,
        andy.chiu@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com,
        jrtc27@jrtc27.com, mingo@redhat.com, palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/3] riscv: ftrace: Fixup ftrace detour code
Date:   Tue, 20 Sep 2022 23:49:07 -0400
Message-Id: <20220921034910.3142465-1-guoren@kernel.org>
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

The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems. The
most horrible bug is preemption panic which found by Andy [1]. Let's
disable preemption for ftrace first, and Andy could continue the
ftrace preemption work.

[1]: https://lpc.events/event/16/contributions/1171/

V2:
 - Add Signed-off for preemption fixup.

V1:
https://lore.kernel.org/linux-riscv/20220916103817.9490-1-guoren@kernel.org/

Andy Chiu (1):
  riscv: ftrace: Fixup panic by disabling preemption

Guo Ren (2):
  riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
  riscv: ftrace: Reduce the detour code size to half

 arch/riscv/Kconfig              |  2 +-
 arch/riscv/Makefile             |  6 ++-
 arch/riscv/include/asm/ftrace.h | 46 ++++++++++++++++++-----
 arch/riscv/kernel/ftrace.c      | 65 ++++++++++-----------------------
 arch/riscv/kernel/mcount-dyn.S  | 43 +++++++++-------------
 5 files changed, 78 insertions(+), 84 deletions(-)

-- 
2.36.1

