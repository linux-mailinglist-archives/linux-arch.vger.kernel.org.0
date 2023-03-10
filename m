Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC46B3445
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 03:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCJCaY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 21:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCJCaX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 21:30:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117AEDAB96
        for <linux-arch@vger.kernel.org>; Thu,  9 Mar 2023 18:30:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5670BCE2382
        for <linux-arch@vger.kernel.org>; Fri, 10 Mar 2023 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 444ACC4339B;
        Fri, 10 Mar 2023 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678415419;
        bh=pMzNuN821RyzrFx8yXNEEI+x1tjaQJEKQdnWQcuD2CY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aUYzlu7h91RfNyr4eDlK3VcyOouEGQuzGKmd/xyEVTunNTGAyr7j6l/nWQqC3HpOk
         C1R02yoB8kGzu4URC9vWWt/hXIoa40fkt6q0kkP7EMZuwir/0bKtJ1jaAp0SvevEfE
         Avl2Lb+RaWzNqFxzKG5ToiQuJZOzSaXihPbdUm4UopcbQp7CoRmpEufwTN84Q0Spvz
         HOKMkcR3qaBQbh7l4TaC0X5ZwwOD/MSRndfGYp6vU8zElFeZom+sBlQurx75NF+CYT
         OZoQ2aWjxbnk8w75bGij3R/UGYQuwjx0MWurs7fFenDqfFpDu3CqhJ/JvfSusF6D3L
         6nY1UxDLaUj5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C302E61B76;
        Fri, 10 Mar 2023 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: asid: switch to alternative way to fix stale TLB
 entries
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167841541911.17842.1187782812543670687.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 02:30:19 +0000
References: <20230226150137.1919750-1-geomatsi@gmail.com>
In-Reply-To: <20230226150137.1919750-1-geomatsi@gmail.com>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, zong.li@sifive.com,
        guoren@kernel.org, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 26 Feb 2023 18:01:35 +0300 you wrote:
> Hi all,
> 
> Some time ago two different patches have been posted to fix stale TLB
> entries that caused applications crashes.
> 
> The patch [0] suggested 'aggregating' mm_cpumask, i.e. current cpu is not
> cleared for the switched-out task in switch_mm function. For additional
> explanations see the commit message by Guo Ren. The same approach is
> used by arc architecture, so another good comment is for switch_mm
> in arch/arc/include/asm/mmu_context.h.
> 
> [...]

Here is the summary with links:
  - [1/2] Revert "riscv: mm: notify remote harts about mmu cache updates"
    https://git.kernel.org/riscv/c/e921050022f1
  - [2/2] riscv: asid: Fixup stale TLB entry cause application crash
    https://git.kernel.org/riscv/c/82dd33fde026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


