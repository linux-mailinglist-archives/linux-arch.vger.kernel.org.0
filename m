Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1670C6862F5
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBAJkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 04:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjBAJkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 04:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015C5B585;
        Wed,  1 Feb 2023 01:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3681061727;
        Wed,  1 Feb 2023 09:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284C8C433D2;
        Wed,  1 Feb 2023 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675244415;
        bh=dDiMrAuD2jJiEu0GSefWpr5gCrPFP3YeIHhIbx9yqds=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gp2hNSeXdQwtWvUuUQtDMTLm/xCZU2ZeKwg7AIgvq0k0stTayd9xseyrv2+Mpg6XA
         lobPEboO/QnN1rhCPuP9k645XKww+OhqE09vshEzIIsCRYRxRCASpD57Ktl/6pweK5
         WDGErxfp8fbwLF8hX+8fa4EVemXG5qU3ZK2x/MsowvM/Af49sUQsv7FunLHEfJKqor
         +N5/q47YWoCQKQP2kDh1JP0F1D9EMIxlWCaAaC52Tvf/zly9YPh7wAutoCeXr7FKbj
         6oBp7CYU8QomarEoSs/q2ltxY5ZpUH4+tDdthM5kKY9wxyqsbBaJp2ovyH6zs8wn2I
         FOXtFl+PJ1/fg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, liaochang1@huawei.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup misaligned load text
In-Reply-To: <20230201064608.3486136-1-guoren@kernel.org>
References: <20230201064608.3486136-1-guoren@kernel.org>
Date:   Wed, 01 Feb 2023 10:40:12 +0100
Message-ID: <87tu05pvur.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current kprobe would cause a misaligned load for the probe point.
> This patch fixup it with two half-word loads instead.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base.are.belong.to.us/
> Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index 41c7481afde3..c1160629cef4 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -74,7 +74,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  		return -EILSEQ;
>  
>  	/* copy instruction */
> -	p->opcode = *p->addr;
> +	p->opcode = (kprobe_opcode_t)(*(u16 *)probe_addr);
> +	if (GET_INSN_LENGTH(p->opcode) == 4)
> +		p->opcode |= (kprobe_opcode_t)(*(u16 *)(probe_addr + 2))
>  	<< 16;

Ugh, those casts. :-( What about the memcpy variant you had in the other
thread?
