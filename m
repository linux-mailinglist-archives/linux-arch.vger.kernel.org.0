Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B59643BA9
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 04:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLFDKU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 22:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiLFDKT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 22:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275A640C;
        Mon,  5 Dec 2022 19:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91FD76151F;
        Tue,  6 Dec 2022 03:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5865C433C1;
        Tue,  6 Dec 2022 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670296215;
        bh=qeizWKrMRBlX8e3HYxm64lxGx4nQAx2XYIbFJQHbZaA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qZDrQUpROzJA2U8Ya8NfzQ9pZbxg7fdmfbfTDXTgpyWVw8iMGqgpymc2c0Pv3c2ei
         2T4G4bzQfU9pZGVPmAiYEi9fxyEoYh0U17pdglXEHL0hab0Ohlh3sE2Tgbir12mzip
         UC0kpa+AWAo/koHQP+jYM+lTNWM312+PtCyRZDG5sWusv5wTeikHwlVAO4xc4DZwuH
         VHwU4Uj0sWQUcSm2DC4sZV1OxH9KqlIZLtAm0Ei95UVkBld29ZzqJc904ejWdVxuNy
         RmMgiYyLMKnLHIhhD73qsTno0Kt4RvIA0UE+HkFVNLBILrqpfmRYuUVS5KAuFH29vG
         qDDj4x2cU6V0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B73BDE270C7;
        Tue,  6 Dec 2022 03:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: stacktrace: A fixup and an optimization
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167029621574.4417.18172654401785175878.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 03:10:15 +0000
References: <20221109064937.3643993-1-guoren@kernel.org>
In-Reply-To: <20221109064937.3643993-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, keescook@chromium.org,
        paulmck@kernel.org, frederic@kernel.org, nsaenzju@redhat.com,
        changbin.du@intel.com, vincent.chen@sifive.com,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  9 Nov 2022 01:49:35 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> First is a fixup for the return address pointer. The second makes
> walk_stackframe could cross the pt_regs frame.
> 
> Guo Ren (2):
>   riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
>   riscv: stacktrace: Make walk_stackframe cross pt_regs frame
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
    https://git.kernel.org/riscv/c/5c3022e4a616
  - [2/2] riscv: stacktrace: Make walk_stackframe cross pt_regs frame
    https://git.kernel.org/riscv/c/7ecdadf7f8c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


