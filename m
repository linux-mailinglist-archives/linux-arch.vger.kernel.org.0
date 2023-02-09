Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA036914C9
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 00:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBIXla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Feb 2023 18:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBIXlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2023 18:41:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936B6F8D2;
        Thu,  9 Feb 2023 15:40:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFE961C28;
        Thu,  9 Feb 2023 23:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DDC2C433A0;
        Thu,  9 Feb 2023 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675986017;
        bh=HCHcr5aTKt1OPUwAH00/oOdmH1TMv7ouKZHMe+UhXk0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tHeLQa/2Jcu6T2BjcEcFrVaK8JDMPyp3lVEmNIi6eTE91V3rHi3xKAxFNegLy0Z55
         38fCYTcD5BTE66XxMt88QjxSFgcyOMuGfcwHQ3zj6fOdexyijypd70QAhiQE6FOsLB
         BtwS8S+UgylBxM8wkiOVsgbo3tejSkIR0ROTJ48klTdpAABBZDA8mBNCTrhpZ3jxRV
         jqho6B4GV/tMF09Uc7WOEfC6PILoZg1ckJ9p5Y4HM+9B20f+E2DQFqELqI3kBK/tzb
         ZQDhgbGgY+753mA4ILiKBXPoIIpI3ZtzOLNzarLfDdNdN96Tjr8wkFdjrS1OsnYJng
         z3jsifi3WUxWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 628EBE21EC9;
        Thu,  9 Feb 2023 23:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: kprobe: Fixup misaligned load text
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167598601740.16272.1273076344376497011.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Feb 2023 23:40:17 +0000
References: <20230204063531.740220-1-guoren@kernel.org>
In-Reply-To: <20230204063531.740220-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        bjorn@kernel.org, jrtc27@jrtc27.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com,
        bjorn.topel@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat,  4 Feb 2023 01:35:31 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The current kprobe would cause a misaligned load for the probe point.
> This patch fixup it with two half-word loads instead.
> 
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base.are.belong.to.us/
> Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>
> 
> [...]

Here is the summary with links:
  - [V2] riscv: kprobe: Fixup misaligned load text
    https://git.kernel.org/riscv/c/eb7423273cc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


