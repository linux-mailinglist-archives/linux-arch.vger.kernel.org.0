Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBB72EB47
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjFMSyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjFMSyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 14:54:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0DB5;
        Tue, 13 Jun 2023 11:53:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686682437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdtlI8O+BR0qXbj58jg6FvKGaw0Wgflhz7GcVSQmqTs=;
        b=YozCldYNSkvTr+p9N13aPfwrZCetTLmVfUgIMbRgkvTdFFB+KsP7Bc/nFSb3Aypyiv3CtJ
        HiuQX/BkK7i+txHUJVO80Cn39d+oKpyNlYvhUF6GtTt/iEmIeLnL4hHBqe9qfjvYA8icZW
        JNHNPfIj64QFoIrIGtcCm13NRVIint6VhQQnicYv56ihWKYgciJBCzhZPAkHZaFFBXXc1A
        8607gVBbh+RzZYZJD+9BxOzRVoHJ/rUVtqyFpu3qlIjx34p5HeSyUYw2Z62Fs7yM4TdSfE
        uLF4gJ6HFLP7AbKgTVN3BrFWVDHbfFUnF1+bUBT4A5G674zBIhW963/HDlYDgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686682437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdtlI8O+BR0qXbj58jg6FvKGaw0Wgflhz7GcVSQmqTs=;
        b=l6BZB5sr7NAcDi+r4y/BXgbOdgHhlHQ9Vb1NshrItcfbmq+cZw4PchfvnAucey7KgaZUrI
        PGUXnPawzxE9tdAg==
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/9] cpu/SMT: Store the current/max number of threads
In-Reply-To: <d42e9452-8210-a06a-4c91-6c2f1d038a61@linux.ibm.com>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-3-mpe@ellerman.id.au> <87fs6z80w5.ffs@tglx>
 <d42e9452-8210-a06a-4c91-6c2f1d038a61@linux.ibm.com>
Date:   Tue, 13 Jun 2023 20:53:56 +0200
Message-ID: <87sfav5h2z.ffs@tglx>
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

On Tue, Jun 13 2023 at 19:16, Laurent Dufour wrote:
> On 10/06/2023 23:26:18, Thomas Gleixner wrote:
>> On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
>>>  #ifdef CONFIG_HOTPLUG_SMT
>>>  enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
>>> +static unsigned int cpu_smt_max_threads __ro_after_init;
>>> +unsigned int cpu_smt_num_threads;
>> 
>> Why needs this to be global? cpu_smt_control is pointlessly global already.
>
> I agree that cpu_smt_*_threads should be static.
>
> Howwever, regarding cpu_smt_control, it is used in 2 places in the x86 code:
>  - arch/x86/power/hibernate.c in arch_resume_nosmt()
>  - arch/x86/kernel/cpu/bugs.c in spectre_v2_user_select_mitigation()

Bah. I must have fatfingered the grep then.

> An accessor function may be introduced to read that value in these 2
> functions, but I'm wondering if that's really the best option.
>
> Unless there is a real need to change this through this series, I think
> cpu_smt_control can remain global.

That's fine.

Thanks,

        tglx
