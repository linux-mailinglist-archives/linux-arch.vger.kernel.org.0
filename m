Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA68E77FA99
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353142AbjHQPUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353155AbjHQPU2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 11:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3992724;
        Thu, 17 Aug 2023 08:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C20462A95;
        Thu, 17 Aug 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE2E0C433C9;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285624;
        bh=NfOEJNXNpKdohlsC54VKkIQeTA+pi3oxUi+fegoDms8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m8k+4yi2KrnIbAyVLtanud5zOz3gxKdpBrYc9Mf9cyIM4WavnCq9eC7pDs7mzBU9p
         0iUb1aMrMfOmL63sVcYJXcV1ohvZLl20XkmXXfEnx1SQ49VAQ/h57j0+kleqMSh8ni
         JDGmmQ98Fb64QnoDYZwFBnGmO5dH0cXz7wrmMm1dE1GWs0ZzsFCltU1Apj5FnMtmw5
         fXnjSMv1JDc41jpDIBEImh68wCD7vZM4Xil3uJ+tpXyQiLQpJhtg+pz623hVRlpRx8
         TnogrILg9tx8B9MUsmqzCO4a5zGCGbJTiZ5rsC0jqrD/AjrPLkhFwsRZUroAN7i9Yy
         ggJuQfvg8tDfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4A61E1F65A;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/2] riscv: stack: Fixup independent softirq/irq stack for
 CONFIG_FRAME_POINTER=n
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169228562466.20811.13415270526946490389.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 15:20:24 +0000
References: <20230716001506.3506041-1-guoren@kernel.org>
In-Reply-To: <20230716001506.3506041-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        paul.walmsley@sifive.com, falcon@tinylab.org, bjorn@kernel.org,
        conor.dooley@microchip.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        guoren@linux.alibaba.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 15 Jul 2023 20:15:04 -0400 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The independent softirq/irq stack uses s0 to save & restore sp, but s0
> would be corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber
> list to fix the problem.
> 
> <+0>:     addi    sp,sp,-32
> <+2>:     sd      s0,16(sp)
> <+4>:     sd      s1,8(sp)
> <+6>:     sd      ra,24(sp)
> <+8>:     sd      s2,0(sp)
> <+10>:    mv      s0,a0		--> compiler allocate s0 for a0 when CONFIG_FRAME_POINTER=n
> <+12>:    jal     ra,0xffffffff800bc0ce <irqentry_enter>
> <+16>:    ld      a5,56(tp) # 0x38
> <+20>:    lui     a4,0x4
> <+22>:    mv      s1,a0
> <+24>:    xor     a5,a5,sp
> <+28>:    bgeu    a5,a4,0xffffffff800bc092 <do_irq+88>
> <+32>:    auipc   s2,0x5d
> <+36>:    ld      s2,1118(s2) # 0xffffffff801194b8 <irq_stack_ptr>
> <+40>:    add     s2,s2,a4
> <+42>:    addi    sp,sp,-8
> <+44>:    sd      ra,0(sp)
> <+46>:    addi    sp,sp,-8
> <+48>:    sd      s0,0(sp)
> <+50>:    addi    s0,sp,16	--> our code clobber the s0
> <+52>:    mv      sp,s2
> <+54>:    mv      a0,s0		--> a0 got wrong value for handle_riscv_irq
> <+56>:    jal     ra,0xffffffff800bbb3a <handle_riscv_irq>
> 
> [...]

Here is the summary with links:
  - [V2,1/2] riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
    https://git.kernel.org/riscv/c/8d0be64154cf
  - [V2,2/2] riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTER=n
    https://git.kernel.org/riscv/c/ebc9cb03b21e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


