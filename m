Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9C7548D8
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jul 2023 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjGONqD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGONqD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 09:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9832700;
        Sat, 15 Jul 2023 06:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B2060B86;
        Sat, 15 Jul 2023 13:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4836C433C7;
        Sat, 15 Jul 2023 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689428760;
        bh=q3/lU563XIc7l/7Z2Yw3lHNNvfkKn0JinKWbDxKVmso=;
        h=From:To:Cc:Subject:Date:From;
        b=b2xZq4nN1CppL9khriVnqpmsiHNeJRTXTF1PuBKU9mll18/A2WgoWV7gBGwF2E2pn
         Q8MotO6Vbs8zcKWsIq3taYPpH2csKD//dUChWHKpRw+lrNAw3cG5fH3OHzGDjMBOcr
         OM2NC+rG6GHVzwv8Mi+oX97ca9haFZheUED4cBAQdl/4F8BGunGMxyrG7E/Z4VOod4
         rvTeNh/5+9lJ9PA6I5aQdNJF6J1uZBuFCB8h4bzJW4pgMT04bWp+AEodm/YGJ2cTQ0
         pltG9vbma/1ywI9Io06hGHZ7fPbes3N4YuBGrKxFuDqzrD3za6icLusMWS3qr7/Wb3
         waUggRQIRIlZw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/2] riscv: stack: Fixup independent softirq/irq stack for CONFIG_FRAME_POINTER=n
Date:   Sat, 15 Jul 2023 09:45:50 -0400
Message-Id: <20230715134552.3437933-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The independent softirq/irq stack uses s0 to save & restore sp, but s0
would be corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber
list to fix the problem.

<+0>:     addi    sp,sp,-32
<+2>:     sd      s0,16(sp)
<+4>:     sd      s1,8(sp)
<+6>:     sd      ra,24(sp)
<+8>:     sd      s2,0(sp)
<+10>:    mv      s0,a0		--> compiler allocate s0 for a0 when CONFIG_FRAME_POINTER=n
<+12>:    jal     ra,0xffffffff800bc0ce <irqentry_enter>
<+16>:    ld      a5,56(tp) # 0x38
<+20>:    lui     a4,0x4
<+22>:    mv      s1,a0
<+24>:    xor     a5,a5,sp
<+28>:    bgeu    a5,a4,0xffffffff800bc092 <do_irq+88>
<+32>:    auipc   s2,0x5d
<+36>:    ld      s2,1118(s2) # 0xffffffff801194b8 <irq_stack_ptr>
<+40>:    add     s2,s2,a4
<+42>:    addi    sp,sp,-8
<+44>:    sd      ra,0(sp)
<+46>:    addi    sp,sp,-8
<+48>:    sd      s0,0(sp)
<+50>:    addi    s0,sp,16	--> our code clobber the s0
<+52>:    mv      sp,s2
<+54>:    mv      a0,s0		--> a0 got wrong value for handle_riscv_irq 
<+56>:    jal     ra,0xffffffff800bbb3a <handle_riscv_irq>

Guo Ren (2):
  riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
  riscv: stack: Fixup independent softirq stack for
    CONFIG_FRAME_POINTER=n

 arch/riscv/kernel/irq.c   | 2 +-
 arch/riscv/kernel/traps.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.36.1

