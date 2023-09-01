Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBF7900A8
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjIAQZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIAQZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 12:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A7610EB;
        Fri,  1 Sep 2023 09:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BA3D628D1;
        Fri,  1 Sep 2023 16:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BFDBC433CB;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693585515;
        bh=noAvIfpMGFcZorZdKdFmseXEzNomZCMzL+8qZXfzzJk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZDKqWbh1gbOILnoUkmILmBnmCqApJbL1o4X6I7NxlIF5Bw86+I5KDeVng4+GDq532
         OVrw9hCGh38cvj+9jge4FUsv8m1q0r6cvbObtvuoLoN52kC9ge4s7QMkYUVoO2AvdL
         6SfgoZE0LKu2TAfDqhwBOyshO1UCyvW+PJl7BiieoEIN7swSAhOnLr5deHucUnqyGh
         ZO7AgqUyGwRbZ8PLm126bpbvQswhPJ8tgOxzpWzrFG2+g/sjnRpx11o60z8umIR3yu
         VgvB1sO1BR0dX/dt5wnPb/Z4K/yLPj4kZ82KqVTuQ0ge67eHf337Ok4gsb/nBiRC/5
         ZSfpO3lJgKsLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83DBEE29F3E;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 22/38] riscv: Implement the new page table range API
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169358551553.8276.14329578180496231845.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:25:15 +0000
References: <20230802151406.3735276-23-willy@infradead.org>
In-Reply-To: <20230802151406.3735276-23-willy@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        rppt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
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

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed,  2 Aug 2023 16:13:50 +0100 you wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> 
> [...]

Here is the summary with links:
  - [v6,22/38] riscv: Implement the new page table range API
    https://git.kernel.org/riscv/c/864609c6a0b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


