Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09B5952B9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 08:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiHPGln (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 02:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiHPGl1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 02:41:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31245722F;
        Mon, 15 Aug 2022 18:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60F55B81236;
        Tue, 16 Aug 2022 01:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7627C433D6;
        Tue, 16 Aug 2022 01:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660613228;
        bh=/mGseJZgdyPhe4TH7J2aYC+EJppAEfiwBjSFQw9INt8=;
        h=From:To:Cc:Subject:Date:From;
        b=J8eswGHY/mdK84n3nQJ3tGDW86TCcvnDcZ0H51QoTkk0DMWnOFN4aLX+MXCXkhMOt
         izzVootNZbADGtoDgczSj2Fvy2XmdnVpemma1gGufx2Kw0P3vGpxfqvUdZ6uIFuyhl
         6dqPU/Y+KOgJSHe/m0YgsKP06zD2r+ts6bp3tpm85lQe/o5fMBY2m4jITN96uAIF7j
         fURLJV3NQQNJrDahX+ms1FnzhyMShNss7znOQfN6qsSJsRnBLtc1QE1NwJSjCKONQm
         rII+kIh1Ak1snp4OWUdLNqZhYH8KTsvfdMMzzVD6rYtA8i3BzJUmSp3nOrRvgpHZ6J
         Jgfu0h0fZq1qQ==
From:   guoren@kernel.org
To:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/2] riscv: kexec: Support crash_save percpu and machine_kexec_mask_interrupts
Date:   Mon, 15 Aug 2022 21:26:59 -0400
Message-Id: <20220816012701.561435-1-guoren@kernel.org>
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
interrupts properly. The patch series fix them.

Guo Ren (2):
  riscv: kexec: EOI active and mask all interrupts in kexec crash path
  riscv: kexec: Implement crash_smp_send_stop with percpu crash_save_cpu

 arch/riscv/include/asm/smp.h      |  6 +++
 arch/riscv/kernel/machine_kexec.c | 44 +++++++++++----
 arch/riscv/kernel/smp.c           | 89 ++++++++++++++++++++++++++++++-
 3 files changed, 126 insertions(+), 13 deletions(-)

-- 
2.36.1

