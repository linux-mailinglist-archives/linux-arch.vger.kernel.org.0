Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2368855D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 18:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBBRaV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 12:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBBRaU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 12:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226056A325;
        Thu,  2 Feb 2023 09:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB495B82753;
        Thu,  2 Feb 2023 17:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B81C4339B;
        Thu,  2 Feb 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675359017;
        bh=4PONHIEudcXNZESaUql5vum3JtEcjpY8pniiHFOE15w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HQveGkALcid7UBYNr7QwtKoolhvCGaYfmB3m3zEH1HtC4+U+Ulm2wjrgX2hgqZmcv
         uGOFMDhl3/1Lr5mnNvMZbvA0impyok2Ga+PtW6vH4+bmJON5pEp2JKahJXJ/obZ7oM
         d5R85b6K8n5OTmrT31WWHiVWSjZ8txpxduKr9IfzmYF4mJX7ncczG1jYMv9YukOzf7
         jEBw+mT1ZSPWWS6J7zdgE6ZpXRv+wp3FDdAnayDbUJINVVLY9D7+nMa12sC+7g89BC
         BklVVXsXB94VRWLzrx/Ku1TZ99HNCjjBOZ1XvQ5+GFxto+gFEtneUco3fcxf5nnavA
         Ydg1Oa3FRpNng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D25FE270CC;
        Thu,  2 Feb 2023 17:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: kprobe: Fixup kernel panic when probing an illegal
 position
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167535901731.19827.1576402289548615657.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Feb 2023 17:30:17 +0000
References: <20230201040604.3390509-1-guoren@kernel.org>
In-Reply-To: <20230201040604.3390509-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
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

On Tue, 31 Jan 2023 23:06:04 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The kernel would panic when probed for an illegal position. eg:
> 
> (CONFIG_RISCV_ISA_C=n)
> 
> echo 'p:hello kernel_clone+0x16 a0=%a0' >> kprobe_events
> echo 1 > events/kprobes/hello/enable
> cat trace
> 
> [...]

Here is the summary with links:
  - [V2] riscv: kprobe: Fixup kernel panic when probing an illegal position
    https://git.kernel.org/riscv/c/87f48c7ccc73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


