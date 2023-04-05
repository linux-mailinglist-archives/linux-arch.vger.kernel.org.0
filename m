Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE456D7A19
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbjDEKoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbjDEKoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 06:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E694ECA;
        Wed,  5 Apr 2023 03:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2975763C57;
        Wed,  5 Apr 2023 10:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC61C433EF;
        Wed,  5 Apr 2023 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680691441;
        bh=+ZO/yBxfJv0GaHczUgdJTBFHBjfQ/ykADeJttq42HmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfEi0EWHrVtgDNTDmAkQHpOA1xGMHUdirDcpsD08NWpiRE8In3RAHPfhmz+mLo3Re
         keFWgaWXAHpSzJgLMWdEzHtCNaP6XaC77hbIAZwK+4PpDX/Zwb9pTItZlq4DbE4Bcj
         gF37NoMLKD33dyuHM4yV5O3ouVk+s6lLupFGmAHvGBDdJp1MrGsgJ5ZzVLp7GXS7g2
         UIOMTpAu0+CUNt+73VKyRli+76KWSC33YcG5QeaD76fiXSWmghliODfhBl98LZE/dA
         PhaBHuqHXYQ037jMpcPmRNTtYCqZtKeIbh0pk5/nikjbQBZDel/38qAxiwMpnOZnDc
         uqZAC/jHMG+Ow==
Date:   Wed, 5 Apr 2023 12:43:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <ZC1Q7uX4rNLg3vEg@lothringen>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134224.137038-4-ypodemsk@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> @@ -191,6 +192,20 @@ static void tlb_remove_table_smp_sync(void *arg)
>  	/* Simply deliver the interrupt */
>  }
>  
> +
> +#ifdef CONFIG_CONTEXT_TRACKING
> +static bool cpu_in_kernel(int cpu, void *info)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);

Like Peter said, an smp_mb() is required here before the read (unless there is
already one between the page table modification and that ct->state read?).

So that you have this pairing:


           WRITE page_table                  WRITE ct->state
	   smp_mb()                          smp_mb() // implied by atomic_fetch_or
           READ ct->state                    READ page_table

> +	int state = atomic_read(&ct->state);
> +	/* will return true only for cpus in kernel space */
> +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> +}

Also note that this doesn't stricly prevent userspace from being interrupted.
You may well observe the CPU in kernel but it may receive the IPI later after
switching to userspace.

We could arrange for avoiding that with marking ct->state with a pending work bit
to flush upon user entry/exit but that's a bit more overhead so I first need to
know about your expectations here, ie: can you tolerate such an occasional
interruption or not?

Thanks.

