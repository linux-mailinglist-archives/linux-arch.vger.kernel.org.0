Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3E6D6840
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjDDQEd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjDDQEc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 12:04:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381949E2;
        Tue,  4 Apr 2023 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XM/YkwYDYZGFI0IIp06DYqUacNJSQj373t93IN8a29o=; b=TIsAixbuLFpyKt07sPwhVOn1aU
        cGv4c07N1emcfPmogLhgtjgpYR5LP6Nol8J6+PExO760jDlXjp+iCnrnWKK5UDZCU5FyEMUHrK0C1
        SzrfvIUBbupni78V14bc2bjHewYPLY7HCVNoH9SqFSqG/2cWP412xfsne3M0o6n8fQU1Z2r+E2QHx
        +fmjMHwxYiumGqYm7KWWTj1cAFUYaVEKYoqK3JR4anEGIOdaaPQwrDyMDfUbtnoOrucjM9WZUX3vA
        cX9hzeBUJB03YvO04ppUKlwYspcwruBk8VDTYKJ3joh88cne62yn4oUyr/Od+3XIdZ24B2xIuVJdx
        WXoLpPZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjj5O-00FV9O-TT; Tue, 04 Apr 2023 16:00:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07BC4300202;
        Tue,  4 Apr 2023 18:00:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D69342CB6F7B0; Tue,  4 Apr 2023 18:00:38 +0200 (CEST)
Date:   Tue, 4 Apr 2023 18:00:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, paulmck@kernel.org,
        jpoimboe@kernel.org, samitolvanen@google.com, frederic@kernel.org,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230404160038.GB38236@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <20230404151217.GB297936@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404151217.GB297936@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 05:12:17PM +0200, Peter Zijlstra wrote:
> > case 2:
> > CPU-A                                             CPU-B
> > 
> > modify pagetables
> > tlb_flush (memory barrier)
> >                                                   state == CONTEXT_USER
> > int state = atomic_read(&ct->state);
> >                                                   Kernel-enter:
> >                                                   state == CONTEXT_KERNEL
> >                                                   READ(pagetable values)
> > if (state & CT_STATE_MASK == CONTEXT_USER)
> > 


Hmm, hold up; what about memory ordering, we need a store-load ordering
between the page-table write and the context trackng load, and a
store-load order on the context tracking update and software page-table
walker loads.

Now, iirc page-table modification is done under pte_lock (or
page_table_lock) and that only provides a RELEASE barrier on this end,
which is insufficient to order against a later load.

Is there anything else?

On the state tracking side, we have ct_state_inc() which is
atomic_add_return() which should provide full barrier and is sufficient.
