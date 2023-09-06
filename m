Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2837793D4A
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjIFNAl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjIFNAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 09:00:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03F51730;
        Wed,  6 Sep 2023 06:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5769AC433C9;
        Wed,  6 Sep 2023 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694005226;
        bh=1DP3Bq6tXhJvAfMAEbUn0BCiRTI+8UxsMOSoViMeQfY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o87OEplqy9kFJSqA9FRIvBR2dQfoCZRXkNhvuZD6a+x1g/KKXXDGuJK1slIJcdWgW
         3zQNUIZTHcbBveMapQu3MPBTtp4vJVqwdhvBjS7GVxNLTi9oHzgiq0Jloc9L+7KtMo
         0Vl7Bsipcc/5qMXa6NCdlmeas9aTJTs3gJQmy3qa39nNm9lrQlKsag3L/fi+zEoSrH
         BP6fXWXJ+Cs7sauKa/mklzysY4rgzjSdIaISYsoUJ5VY0bgIV25OI/tOhS/6ghgZjn
         TFJ3SjhcQGdyp8BGLS1jS7UG5a7erdDVoehA1YDaRq9kpFrXws9d0dtuSpS2eIeZP1
         9HJxw3ue7BqKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B8ABC0C3FD;
        Wed,  6 Sep 2023 13:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] riscv: tlb flush improvements
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169400522623.22081.12040343048151715310.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 13:00:26 +0000
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
In-Reply-To: <20230801085402.1168351-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, mchitale@ventanamicro.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  1 Aug 2023 10:53:58 +0200 you wrote:
> This series optimizes the tlb flushes on riscv which used to simply
> flush the whole tlb whatever the size of the range to flush or the size
> of the stride.
> 
> Patch 3 introduces a threshold that is microarchitecture specific and
> will very likely be modified by vendors, not sure though which mechanism
> we'll use to do that (dt? alternatives? vendor initialization code?).
> 
> [...]

Here is the summary with links:
  - [v3,1/4] riscv: Improve flush_tlb()
    https://git.kernel.org/riscv/c/1245a70831b9
  - [v3,2/4] riscv: Improve flush_tlb_range() for hugetlb pages
    https://git.kernel.org/riscv/c/9d6fb1015281
  - [v3,3/4] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
    https://git.kernel.org/riscv/c/cfe5187b7e93
  - [v3,4/4] riscv: Improve flush_tlb_kernel_range()
    https://git.kernel.org/riscv/c/bbc9ad35b51b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


