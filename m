Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7060A4F7794
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 09:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiDGHf6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiDGHfz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 03:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D5189A1D;
        Thu,  7 Apr 2022 00:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F96F61D95;
        Thu,  7 Apr 2022 07:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A0C385A0;
        Thu,  7 Apr 2022 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649316834;
        bh=xjLgB5PrZaAqNXMKyws1eRXeGpUexWFgvPvaoYecqs8=;
        h=From:To:Cc:Subject:Date:From;
        b=Au9/wc6+Ragli+eLY5wZFETAnYQtG3/nG8XNYR0WnZUpS6F/4SopgPC/jX2Pdougd
         MHudk7DtRxUlxt9gc22aQ1zHgxtBOhgMVQBrLzHoS0k7U4Px5QJs5qdKLeL6+i45qo
         qjymLcfdNYI85/BrfR5HkGznCURUJsOMtGpWtqHfQRhSwc0MBHKWpgaGEGbgb+hGrb
         yqI5mr+xxx51Ihclz1RgBvkyKahgCXIT8iRWuRQSCB24ftNLKDRlw0gfpejeMOBDbU
         JDB3DShnCZg5CEB1KGZd4S22VeJ+X53KEQTaz3t0iejjnwVI8WxFPrwHW+KGf6+0jG
         CM/vqrwLZjZGA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 0/4] arch: patch_text: Fixup last cpu should be master
Date:   Thu,  7 Apr 2022 15:33:19 +0800
Message-Id: <20220407073323.743224-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
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

These patch_text implementations are using stop_machine_cpuslocked
infrastructure with atomic cpu_count. The original idea: When the
master CPU patch_text, the others should wait for it. But current
implementation is using the first CPU as master, which couldn't
guarantee the remaining CPUs are waiting. This patch changes the
last CPU as the master to solve the potential risk.

Changes in v4:
 - Add "Fixes:" for stable fixup
 - Add cover letter for the patch series

Changes in v3:
 - Separate the patch for different arch.

Changes in v2:
 - Fixup num_online_cpus() - 1 is not last cpu

Guo Ren (4):
  arm64: patch_text: Fixup last cpu should be master
  riscv: patch_text: Fixup last cpu should be master
  xtensa: patch_text: Fixup last cpu should be master
  csky: patch_text: Fixup last cpu should be master

 arch/arm64/kernel/patching.c      | 4 ++--
 arch/csky/kernel/probes/kprobes.c | 2 +-
 arch/riscv/kernel/patch.c         | 2 +-
 arch/xtensa/kernel/jump_label.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

