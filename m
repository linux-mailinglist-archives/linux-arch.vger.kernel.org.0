Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDB7509F7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGLNuY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGLNuX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 09:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849CE4D;
        Wed, 12 Jul 2023 06:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B2E617DF;
        Wed, 12 Jul 2023 13:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22FDCC433CB;
        Wed, 12 Jul 2023 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689169822;
        bh=+INPXCSjseSzvQoIoq1K3Ufdrd2Nr/9VbLoRTyTK27Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DbfCGjVJTPIgow49B4kh03vLgqRiPE1f2YrId/mmhoQ3QaxWLwjA+xSF3PY0/Byba
         kGACyCPmtpAPF7ZaULXkN2iCw/zpnWRWVeUD7npvnkOyj/ptYtVkRecCJShhlG4wXm
         qh9DYfu+J/H+W+EqEX7z52g7auACdfwckf0gTe6z/MbdS95o+OYd8sLE9D9d7QsiWr
         eVeQE+Qloc/Ik7lfjEzkeHQ+rfq4QfMYOPS6kYIxYigeYhqPEFNDBLcooqM9hDthzC
         QBWYoTQEh5yD6o8rBjBID+saoP1a9w9uG/m8rsaDzMsBc7spzZ4IQ2+K27MIfkEekt
         uyhHXQaloRgKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ADC8E4D006;
        Wed, 12 Jul 2023 13:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: sigcontext: Correct the comment of sigreturn
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168916982203.8919.10360262283664186104.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 13:50:22 +0000
References: <20230628091213.2908149-1-guoren@kernel.org>
In-Reply-To: <20230628091213.2908149-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de,
        palmer@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 28 Jun 2023 05:12:13 -0400 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The real-time signals enlarged the sigset_t type, and most architectures
> have changed to using rt_sigreturn as the only way. The riscv is one of
> them, and there is no sys_sigreturn in it. Only some old architecture
> preserved sys_sigreturn as part of the historical burden.
> 
> [...]

Here is the summary with links:
  - riscv: sigcontext: Correct the comment of sigreturn
    https://git.kernel.org/riscv/c/471aba2e4760

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


