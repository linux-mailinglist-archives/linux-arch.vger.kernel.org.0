Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4253564BB35
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 18:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiLMRk0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 12:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiLMRkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 12:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BDF1F9E7;
        Tue, 13 Dec 2022 09:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12E01B8154D;
        Tue, 13 Dec 2022 17:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86EACC433D2;
        Tue, 13 Dec 2022 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670953217;
        bh=X8gCjHqeNZe9a2MlXtFDCd8a5lhsjje1sO7jDqfY058=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bX8jVzlNMeinU3ZVwz0J6CYvme1pvo1CRTvr2DhD9F6o+NwZh4zCKKN4ygfW9My8f
         4s19eRCqor7bnGPeyjyNOJGa4UoZjU6gL3uF89wq5wrvex9V0aaswbBYWM4uL+gJPy
         m+HBjeV/oS2Q3Y9TMOUigm5EI1cTmF0F9zYTSE8CVyJCPMAKJde90ntg8M0osh8/eI
         9gDSasM72nHM+tQOfLk8nWVUhGsYf9BimpofPqSro69TMZ6w7LiVYhysnVy5i97n5K
         o4NdiPg2VSOEsb6wXSAw/Q3zGpqsjLwysgARUy3lWLebgVJn3twj9TAguMU5Cufo/j
         IM++L3cSAjRGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AFFAE4D02A;
        Tue, 13 Dec 2022 17:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fixup compile error with !MMU
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167095321743.5951.3619740095349418774.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Dec 2022 17:40:17 +0000
References: <20221207091112.2258674-1-guoren@kernel.org>
In-Reply-To: <20221207091112.2258674-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        lizhengyu3@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com,
        conor@kernel.org, lkp@intel.com
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

On Wed,  7 Dec 2022 04:11:12 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Current nommu_virt_defconfig can't compile:
> 
> In file included from
> arch/riscv/kernel/crash_core.c:3:
> arch/riscv/kernel/crash_core.c:
> In function 'arch_crash_save_vmcoreinfo':
> arch/riscv/kernel/crash_core.c:8:27:
> error: 'VA_BITS' undeclared (first use in this function)
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> 
> [...]

Here is the summary with links:
  - riscv: Fixup compile error with !MMU
    https://git.kernel.org/riscv/c/c528ef0888b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


