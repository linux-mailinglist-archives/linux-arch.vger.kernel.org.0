Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAB69F73B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjBVPAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 10:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBVPAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 10:00:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5673772E
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 07:00:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FEDBB815CE
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 15:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6844EC4331F;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=1eibqrEVyHu9DLfK/UXBBIAovcr/WxnHB/rsWksX1+g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kcfJwyFqxdeHC4R5LTjDXNmal+HVth0hqbbz+djzUU/Pi2yJBJvALDCiCbQhWG7Tm
         VNF9j6Nuli2a1kV+qkktkV8teVIkEAQwd+gh/RfymM7HXQhKOy0U4VezZ/jkroa7vt
         xelK2KlnFeHIe1r9CvCmdkDz+elp6kG395GaoL2FzY8i7FZ/lRWQGhsJHKftoZEG2I
         vGnKDh5PttJSubPfQM1yZHLbDAZ50JVmZo9BDGz3UpSwUuB5IsukWQM7mXqz+Z/r9u
         gblA6fzhBlxsuR2RGq+OioSt1RM0daB8wqf/TtC8x2vcqZES+rL8p8Gs7jmLy8kdr5
         OgaPOfmXBQ4Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E491C43151;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: mm: fix regression due to update_mmu_cache change
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802231.24438.5384447032819989101.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230129211818.686557-1-geomatsi@gmail.com>
In-Reply-To: <20230129211818.686557-1-geomatsi@gmail.com>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        prabhakar.csengg@gmail.com, guoren@kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, heiko@sntech.de,
        sergey.matyukevich@syntacore.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 30 Jan 2023 00:18:18 +0300 you wrote:
> From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> 
> This is a partial revert of the commit 4bd1d80efb5a ("riscv: mm: notify
> remote harts about mmu cache updates"). Original commit included two
> loosely related changes serving the same purpose of fixing stale TLB
> entries causing user-space application crash:
> - introduce deferred per-ASID TLB flush for CPUs not running the task
> - switch to per-ASID TLB flush on all CPUs running the task in update_mmu_cache
> 
> [...]

Here is the summary with links:
  - riscv: mm: fix regression due to update_mmu_cache change
    https://git.kernel.org/riscv/c/b49f700668ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


