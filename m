Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A678DC74
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjH3Spu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbjH3NUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 09:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF9CDA;
        Wed, 30 Aug 2023 06:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC1DD6208E;
        Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE2DBC433BD;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=cuLPLucPgzyIA7ym72xVrHdEZINVLlHnb8WQoni9rVU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QyAIgZuy/C/TOqnKxD161167AISrmBTCr1WmpxsiHP9AB9WxONiSxAqsmPsdKVHUF
         4OYpw5mxRottJwKTojqVJPa2C/v62LniRZjK4/e5wabj3jKPvZq4+Irz4tRpUyKO+H
         0/PPE6BCIgU6UH8YxRPAn1+c5jmuOuNrpYNbrVqMLYgcn9Vetd5P8mgQCaWOD3Aq19
         QwW85d/nhsNKh3ACcxwAvmyEENZ8k80nd2BNolhJp1pnDBT+F2y0nC0A7gtirpm12E
         bvVPAVM1ZVxROqfUicljxB4n2sY77M1HYh+Win+uNdf32y6Ej/jMc6Zjn/277UAh+3
         ZY/Htaz9xw1LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C648EE29F3B;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: support PREEMPT_DYNAMIC with static keys
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163480.19859.2206176253038715452.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230716164925.1858-1-jszhang@kernel.org>
In-Reply-To: <20230716164925.1858-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
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

On Mon, 17 Jul 2023 00:49:25 +0800 you wrote:
> Currently, each architecture can support PREEMPT_DYNAMIC through
> either static calls or static keys. To support PREEMPT_DYNAMIC on
> riscv, we face three choices:
> 
> 1. only add static calls support to riscv
> As Mark pointed out in commit 99cf983cc8bc ("sched/preempt: Add
> PREEMPT_DYNAMIC using static keys"), static keys "...should have
> slightly lower overhead than non-inline static calls, as this
> effectively inlines each trampoline into the start of its callee. This
> may avoid redundant work, and may integrate better with CFI schemes."
> So even we add static calls(without inline static calls) to riscv,
> static keys is still a better choice.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: support PREEMPT_DYNAMIC with static keys
    https://git.kernel.org/riscv/c/15e062726f55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


