Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0272AF87
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jun 2023 00:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjFJWfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjFJWfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 18:35:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA2D3A89;
        Sat, 10 Jun 2023 15:35:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686436521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3YWu4vesiEmq8yQ43fCf61y6Kfro74ZpUbzYp6i9ipo=;
        b=FG1PzBBK93G9spaxq/ccgsCLD4R5x/g779/6y9E3roFPMbw+fgpuMWKzZ7sISsZwaAURHV
        gKdpv2uCcoqB07nc9c96ow2+PdVR0x6Qw6lp4ywBOIG6LozTFMwhUXBOq3w3r+tv2Rn+k3
        MJDUhACfnsW3dDOAriCvZHTHPy11MCBsp6zAY0gPqDVIfOQKK4g93FNFiDvgNvCkDwXCfL
        jeYII0srdU+Dsr+pU52pNI5eIsu14LTC9O7P49YCItA/qaTuNHKWRSM+9iJzIQR+m2DMcx
        yE7ud0wAx1oClYeynOcmlpTgbCblTjG9L/HaTVi3DXMF/TkcLjo10fU2O14ZRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686436521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3YWu4vesiEmq8yQ43fCf61y6Kfro74ZpUbzYp6i9ipo=;
        b=eDVMV+MdQjITqh2OpuwXpUo+ERakvDZ7eYn2M8lJ2Ee2m+hcfVspkNhfGclzOp769rKocS
        1Uh8PxvQgPukzJBQ==
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        ldufour@linux.ibm.com, bp@alien8.de, dave.hansen@linux.intel.com,
        mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH 5/9] cpu/SMT: Create topology_smt_thread_allowed()
In-Reply-To: <20230524155630.794584-5-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-5-mpe@ellerman.id.au>
Date:   Sun, 11 Jun 2023 00:35:21 +0200
Message-ID: <875y7v7xp2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
> A subsequent patch will enable partial SMT states, ie. when not all SMT
> threads are brought online.

Nitpick. I stumbled over this 'subsequent patch' theme a couple of times
now because it's very similar to the 'This patch does' phrase.

Just explain what you want to achieve at the end.

>  #else
>  #define topology_max_packages()			(1)
>  static inline int
> @@ -159,6 +160,7 @@ static inline int topology_max_smt_threads(void) { return 1; }
>  static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
>  static inline bool topology_smt_supported(void) { return false; }
>  static inline bool topology_smt_threads_supported(unsigned int threads) { return false; }
> +static inline bool topology_smt_thread_allowed(unsigned int cpu) { return false; }

Not all these functions need a !SMP stub. Think about the context in
which they are called. There is probably precedence for pointless ones,
but that does not make an argument to add more.

> +/**
> + * topology_smt_thread_allowed - When enabling SMT check whether this particular
> + *				 CPU thread is allowed to be brought online.
> + * @cpu:	CPU to check
> + */
> +bool topology_smt_thread_allowed(unsigned int cpu)
> +{
> +	/*
> +	 * No extra logic s required here to support different thread values
> +	 * because threads will always == 1 or smp_num_siblings because of
> +	 * topology_smt_threads_supported().
> +	 */
> +	return true;
> +}
> +

As x86 only supoorts the on/off model there is no need for this function
if you pick up the CONFIG_SMT_NUM_THREADS_DYNAMIC idea.

You still need something like that for your PPC use case, but that
reduces the overall impact, right?

Thanks,

        tglx
