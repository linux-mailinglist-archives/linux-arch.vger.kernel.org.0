Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04726C881F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 23:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCXWKx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCXWKw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 18:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A830125AE;
        Fri, 24 Mar 2023 15:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C2562CDB;
        Fri, 24 Mar 2023 22:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A34AC433D2;
        Fri, 24 Mar 2023 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679695820;
        bh=7NwS0U01MV0dfXKZoaLQ2hFmYS51CthUEOZmKxykaMI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hClVYetXTib/837YePQUK5+XtDS+o/RD51zAHlmROciMRK8ibiL57HjFIDhpFG/hF
         xAALL+OkPw+0YEpZpUl7205PKFvgmuJImIr3cqxmkn72Ut6UCMNjljzzM4jVZgs5Hk
         DZE7wdnE2C/dGgUoTd0pC6xZQ3C4ldBhcJ9tmBJKfIe0h4lIr5nnaUE8g+NnZsqlDN
         DpWkddNLe2h+oDEvl5Z84MXxCUc377wSNzB2YxN0tllgTKnLlBJCnaxqfi6LjYDbgi
         c6i8l1nu40jIaJQKchJ7eCSlpJr84hsnM5Xy7S0QGCHMtEqrXmbD5xRnfT0h+4iS2b
         Rkjvhio+9m8sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63A65E52505;
        Fri, 24 Mar 2023 22:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next V17 0/7] riscv: Add GENERIC_ENTRY support
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167969582040.16091.14731927626105849742.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Mar 2023 22:10:20 +0000
References: <20230222033021.983168-1-guoren@kernel.org>
In-Reply-To: <20230222033021.983168-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 21 Feb 2023 22:30:14 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The patches convert riscv to use the generic entry infrastructure from
> kernel/entry/*. Some optimization for entry.S with new .macro and merge
> ret_from_kernel_thread into ret_from_fork.
> 
> The 1,2 are the preparation of generic entry. 3~7 are the main part
> of generic entry.
> 
> [...]

Here is the summary with links:
  - [-next,V17,1/7] compiler_types.h: Add __noinstr_section() for noinstr
    (no matching commit)
  - [-next,V17,2/7] riscv: ptrace: Remove duplicate operation
    https://git.kernel.org/riscv/c/8574bf8d0ddd
  - [-next,V17,3/7] riscv: entry: Add noinstr to prevent instrumentation inserted
    https://git.kernel.org/riscv/c/d0db02c62879
  - [-next,V17,4/7] riscv: entry: Convert to generic entry
    https://git.kernel.org/riscv/c/f0bddf50586d
  - [-next,V17,5/7] riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
    https://git.kernel.org/riscv/c/0bf298ad2b61
  - [-next,V17,6/7] riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
    https://git.kernel.org/riscv/c/ab9164dae273
  - [-next,V17,7/7] riscv: entry: Consolidate general regs saving/restoring
    https://git.kernel.org/riscv/c/45b32b946a97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


