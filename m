Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F655751B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiFWINO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiFWINN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 04:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7D275FA;
        Thu, 23 Jun 2022 01:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6D561C17;
        Thu, 23 Jun 2022 08:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55683C3411B;
        Thu, 23 Jun 2022 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655971991;
        bh=93/MTc5vO/nyRHGUbLO4hJYIXCO0SdlKGcjgsyj/v0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TElwhEpmTWVUyAHmXlDKIQesLpLn2W/YBd3iSa3zRv0wTczabb6/S8uggaBI52ZF3
         ep73EhM6rYn8N0UpLBPXRNSfL0cNJqo4OIMAL2JFW+5tL3Pg7POjkQgCksF6ikLLtT
         FEbu5CueGPzYQjBNf78BGjLdCJGMZpEiGKRLwQVlmgsmiSQwmjFLNgyn4AA2tb9Qnd
         j41cpCsvMJkeMGYmVaTD5P3I731ZqUVspZ7ppJeYhQZMapyr6UvPrkop3s0i64upL2
         A8Nu9W9ZHSl3y1iFTtcMEh6pnnYSpXhxftQj+0k28juu44KWAQfJ/72EcCJcF8op59
         VDbA6N4xk31Kw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o4Hxd-002Wmo-2E;
        Thu, 23 Jun 2022 09:13:09 +0100
MIME-Version: 1.0
Date:   Thu, 23 Jun 2022 09:13:08 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, mark.rutland@arm.com,
        pasha.tatashin@soleen.com, broonie@kernel.org,
        rmk+kernel@armlinux.org.uk, madvenka@linux.microsoft.com,
        christophe.leroy@csgroup.eu, daniel.thompson@linaro.org
Subject: Re: [PATCH v6 32/33] arm64: irq-gic: Replace unreachable() with
 -EINVAL
In-Reply-To: <20220623014917.199563-33-chenzhongjin@huawei.com>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-33-chenzhongjin@huawei.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7d26e36686495866e0752e12c38f170e@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenzhongjin@huawei.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org, catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net, ndesaulniers@google.com, mark.rutland@arm.com, pasha.tatashin@soleen.com, broonie@kernel.org, rmk+kernel@armlinux.org.uk, madvenka@linux.microsoft.com, christophe.leroy@csgroup.eu, daniel.thompson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-23 02:49, Chen Zhongjin wrote:
> Using unreachable() at default of switch generates an extra branch at
> end of the function, and compiler won't generate a ret to close this
> branch because it knows it's unreachable.
> 
> If there's no instruction in this branch, compiler will generate a NOP,
> And it will confuse objtool to warn this NOP as a fall through branch.
> 
> In fact these branches are actually unreachable, so we can replace
> unreachable() with returning a -EINVAL value.
> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/arm64/kvm/hyp/vgic-v3-sr.c | 7 +++----
>  drivers/irqchip/irq-gic-v3.c    | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)

Basic courtesy would have been to Cc the maintainers of this code.

> 
> diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c 
> b/arch/arm64/kvm/hyp/vgic-v3-sr.c
> index 4fb419f7b8b6..f3cee92c3038 100644
> --- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
> +++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
> @@ -6,7 +6,6 @@
> 
>  #include <hyp/adjust_pc.h>
> 
> -#include <linux/compiler.h>
>  #include <linux/irqchip/arm-gic-v3.h>
>  #include <linux/kvm_host.h>
> 
> @@ -55,7 +54,7 @@ static u64 __gic_v3_get_lr(unsigned int lr)
>  		return read_gicreg(ICH_LR15_EL2);
>  	}
> 
> -	unreachable();
> +	return -EINVAL;

NAK. That's absolutely *wrong*, and will hide future bugs.
Nothing checks for -EINVAL, and we *never* expect to
reach this, hence the perfectly valid annotation.

If something needs fixing, it probably is your tooling.

         M.
-- 
Jazz is not dead. It just smells funny...
