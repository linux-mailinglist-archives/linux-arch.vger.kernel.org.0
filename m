Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1846D9855
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjDFNdi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDFNdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 09:33:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6976598;
        Thu,  6 Apr 2023 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8m50I/Ah33OEfXawnqY/+7a+kb6PdH9s8PZL/puCTb8=; b=BDn6m0yWTioOdmUoj2vNFk/9Kq
        E3jqJ2aswcVVxCzKrLJcxUza7IGtwWNvHaCywMfJf4ZqTjvIJqrQnKwgLnyKqVaB8mB0HJrFfgWJ5
        QoWrxGQt8uXMJZ1oWyaF6RQG2UmojK9F4eXmB1OkhAO+YwUs7gNgvlxNnenV+vzWvaD9yCcGzNyhH
        qY9Fq8ToVeVAGpc7TALor/XzTwT+IgjMjtlibDz2/Kw4q0z21hdW+F2EDFbmp5RoMAX9GLXNwIa9b
        e5q7Ym/WFOQGFTf28c+5rkhAfU4qynJ0DYOiow3+Q0jkH8SYzkWKnhoWVPQCxLWuVTNBYyo1iOZF7
        OufwRulQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkPih-00AXEX-1N;
        Thu, 06 Apr 2023 13:32:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA9393000DC;
        Thu,  6 Apr 2023 15:32:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1731212E36AE; Thu,  6 Apr 2023 15:32:06 +0200 (CEST)
Date:   Thu, 6 Apr 2023 15:32:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vschneid@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230406133206.GN386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC3PUkI7N2uEKy6v@tpad>
 <20230405195457.GC365912@hirez.programming.kicks-ass.net>
 <ZC6/0hRXztNwqXg0@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC6/0hRXztNwqXg0@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 09:49:22AM -0300, Marcelo Tosatti wrote:

> > > 2) Depends on the application and the definition of "occasional".
> > > 
> > > For certain types of applications (for example PLC software or
> > > RAN processing), upon occurrence of an event, it is necessary to
> > > complete a certain task in a maximum amount of time (deadline).
> > 
> > If the application is properly NOHZ_FULL and never does a kernel entry,
> > it will never get that IPI. If it is a pile of shit and does kernel
> > entries while it pretends to be NOHZ_FULL it gets to keep the pieces and
> > no amount of crying will get me to care.
> 
> I suppose its common practice to use certain system calls in latency
> sensitive applications, for example nanosleep. Some examples:
> 
> 1) cyclictest		(nanosleep)

cyclictest is not a NOHZ_FULL application, if you tihnk it is, you're
deluded.

> 2) PLC programs		(nanosleep)

What's a PLC? Programmable Logic Circuit?

> A system call does not necessarily have to take locks, does it ?

This all is unrelated to locks

> Or even if application does system calls, but runs under a VM,
> then you are requiring it to never VM-exit.

That seems to be a goal for performance anyway.

> This reduces the flexibility of developing such applications.

Yeah, that's the cards you're dealt, deal with it.
