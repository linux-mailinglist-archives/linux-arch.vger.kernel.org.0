Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B426B6B0E
	for <lists+linux-arch@lfdr.de>; Sun, 12 Mar 2023 21:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCLU0I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCLU0H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 16:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503332504;
        Sun, 12 Mar 2023 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A1760FB8;
        Sun, 12 Mar 2023 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE2CC433D2;
        Sun, 12 Mar 2023 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678652725;
        bh=bnupbG1JXCaGHSBZxVm2cva37si3CwmVtUwbAWr6WcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iDLPl4h5XIb8/AG1ekwgzeXNJXNk2wwFSl8bRTJLND9d3EZq7wq4/QZIM/9knXxI0
         otS3kmfH1sioquSHmNJ4+IKrf81DSv8KOuPeBXVf5efXBvYm1D17+qsiw/e1+tzCfP
         FjYowqM3AKzXuAMME2W6lLAWhENstmSOjM9ecf9o=
Date:   Sun, 12 Mar 2023 13:25:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, ppandit@redhat.com, alougovs@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only
 to MM CPUs
Message-Id: <20230312132524.c37abfffe2c70eeda20f3217@linux-foundation.org>
In-Reply-To: <20230312080945.14171-1-ypodemsk@redhat.com>
References: <20230312080945.14171-1-ypodemsk@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 12 Mar 2023 10:09:45 +0200 Yair Podemsky <ypodemsk@redhat.com> wrote:

> Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> indiscriminately, this causes unnecessary work and delays notable in
> real-time use-cases and isolated cpus, this patch will limit this IPI to
> only be sent to cpus referencing the effected mm and are currently in
> kernel space.
> 
> ...
>
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -191,7 +192,15 @@ static void tlb_remove_table_smp_sync(void *arg)
>  	/* Simply deliver the interrupt */
>  }
>  
> -void tlb_remove_table_sync_one(void)
> +static bool cpu_in_kernel(int cpu, void *info)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	int statue = atomic_read(&ct->state);

Strange identifier.  Should be "state"?

> +	//will return true only for cpu's in kernel space

Please use /* */ style comments

And use "cpus" rather than "cpu's" - plural, not possessive.

> +	return !(statue & CT_STATE_MASK);

Using

	return state & CT_STATE_MASK == CONTEXT_KERNEL;

would more clearly express the intent.

> +}

And...  surely this function is racy.  ct->state can change value one
nanosecond after cpu_in_kernel() reads it, so cpu_in_kernel()'s return
value is now wrong?
