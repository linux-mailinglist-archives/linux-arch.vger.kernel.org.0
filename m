Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7627A739C9B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjFVJWi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjFVJVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 05:21:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221814224;
        Thu, 22 Jun 2023 02:12:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687425145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wyD3yiae4RqAqg4/PcAoMB/t3rxUu0dXpqSaXrgfqA=;
        b=zAdjYj0urbgxQ+q85LblYhZqhR0wZe8A1YtfMgZIllOWR6PU9Yr7GMT5nH7nzb9NSBpzJR
        LERkTBLa2iz4rjaE8yjKRi68VR/FPSWyYREiOt+h/KUZFxG85sv+Ax1oxxuCfPJWkjI8u6
        UllBmquVsyyi/ww0+qFI9iOWHGEkUdxtR2KTBdaBZW39X7MKIFkS/mblJ6Vz35Y/fDT4DC
        5hKp4q3nJjyzfiDlnhyYz/pavfCdrME/BjdmSgC4rT0NG0kolJpfQUWl+KhQA2gDsji4bJ
        AdrDtGj/1uaUIF6EPTajairYGTmSXBnSs+QFeZH5BaJ7Eh8VU0IIDA6MrNNSpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687425145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wyD3yiae4RqAqg4/PcAoMB/t3rxUu0dXpqSaXrgfqA=;
        b=ihmbkNRtGNL2/681+Calept6cNhMoNdxJ0agon4MLtpuxishE9sFXkKNB3hqUIiaR73bm3
        NtrBF6+nK5mNCSBA==
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH 07/10] cpu/SMT: Allow enabling partial SMT states via sysfs
In-Reply-To: <20230615154635.13660-8-ldufour@linux.ibm.com>
References: <20230615154635.13660-1-ldufour@linux.ibm.com>
 <20230615154635.13660-8-ldufour@linux.ibm.com>
Date:   Thu, 22 Jun 2023 11:12:24 +0200
Message-ID: <87legb7tdz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 15 2023 at 17:46, Laurent Dufour wrote:
>  
> -	if (ctrlval != cpu_smt_control) {
> +	orig_threads = cpu_smt_num_threads;
> +	cpu_smt_num_threads = num_threads;
> +
> +	if (num_threads > orig_threads) {
> +		ret = cpuhp_smt_enable();
> +	} else if (num_threads < orig_threads) {
> +		ret = cpuhp_smt_disable(ctrlval);
> +	} else if (ctrlval != cpu_smt_control) {
>  		switch (ctrlval) {
>  		case CPU_SMT_ENABLED:
>  			ret = cpuhp_smt_enable();

This switch() is still as pointless as in the previous version.

OFF -> ON, ON -> OFF, ON -> FORCE_OFF are covered by the num_threads
comparisons.

So the only case where (ctrlval != cpu_smt_control) is relevant is the
OFF -> FORCE_OFF transition because in that case the number of threads
is not changing.

          force_off = ctrlval != cpu_smt_control && ctrval == CPU_SMT_FORCE_DISABLED;

	  if (num_threads > orig_threads)
		  ret = cpuhp_smt_enable();
	  else if (num_threads < orig_threads || force_off)
		  ret = cpuhp_smt_disable(ctrlval);

Should just work, no?

Thanks,

        tglx


