Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197273D543
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 01:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFYXU2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFYXU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 19:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF768E47;
        Sun, 25 Jun 2023 16:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FAA960C51;
        Sun, 25 Jun 2023 23:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3437C433C0;
        Sun, 25 Jun 2023 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687735223;
        bh=9T9wbf7SB0laUWaTFhRmYXAuMcUBhfaXs+Wo6X0IGHk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rgGRKrggNqFKiwwh39BQt9eFyMXiDMmWBnl8PRdiLjd10/XIEhNGqK+xQfs+QRDB0
         DWl4HXyg/jrhe/qHpnmIiSxMd6/gQBoD/do6ahDRsKx2nu2EDNbZhVUOGczllL5VS3
         9IprX8JT2thDPbhrwsDO7g0/IP1pZFNvKn6uFZgfLyrjbRTrRQ6u/k7rEauEkBhCaY
         vMJ2bOqAJdVqNzf0chE6ia+LG68sI+mv+QIArhZLp9+LysV95kwDDB0G/g8RdmsZWn
         PitAgCmYme1QUcZhhdonFBsHDJB5ue9Cg2ttyBlO9U+7z3lD0IWW78xooMjPVaHfwM
         00Mg/D/GkXOwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5C9EE26D3F;
        Sun, 25 Jun 2023 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next V13 0/3] riscv: Add independent irq/softirq stacks
 support
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168773522366.24181.11030375429651091401.git-patchwork-notify@kernel.org>
Date:   Sun, 25 Jun 2023 23:20:23 +0000
References: <20230614013018.2168426-1-guoren@kernel.org>
In-Reply-To: <20230614013018.2168426-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de,
        palmer@rivosinc.com, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, bjorn@kernel.org, cleger@rivosinc.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 13 Jun 2023 21:30:15 -0400 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This patch series adds independent irq/softirq stacks to decrease the
> press of the thread stack. Also, add a thread STACK_SIZE config for
> users to adjust the proper size during compile time.
> 
> This patch series belonged to the generic entry, which has been merged
> to for-next now.
> 
> [...]

Here is the summary with links:
  - [-next,V13,1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
    https://git.kernel.org/riscv/c/163e76cc6ef4
  - [-next,V13,2/3] riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK
    https://git.kernel.org/riscv/c/dd69d07a5a6c
  - [-next,V13,3/3] riscv: stack: Add config of thread stack size
    https://git.kernel.org/riscv/c/a7555f6b62e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


