Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83056D986B
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjDFNit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjDFNip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 09:38:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D70C6EB6;
        Thu,  6 Apr 2023 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rsfbSrxkyNUKnA+3L2zt42sf6Zqq9lCcgt0uWjy7k60=; b=Ayo4gvUWmcUkBURpVFBSM+eYhV
        l7P2VtXOZBB6jb1wtuH+SdKdAItVAe+kMpSzp3YHtSIOle0g7qoCA/xj5KLlB2TlzHd4JmzQKG0FG
        ctlJPIo/yJy3hcmtZqn4NrRTzxtN/fnZe8ae5QDZOAmpGmMl3PtsYG2hCbTsLjgSNkrwGT4IOrh74
        AX3ervbDbcchBnb5NvAJ5/MXEGpH67rwaQ648BB6lvgDw2ZlLdz6jKQfgBg5U/zbLSkUQry3H0GEj
        zy0FeIX/yV9L32RTQOxJW9GjquZ0APcE4Plys2ZHWAXHTK7OJBep9Io61I07aKVmKD7SgpcMnYUx2
        9zUW7zgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkPoU-00HSLt-Th; Thu, 06 Apr 2023 13:38:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 690B43000DC;
        Thu,  6 Apr 2023 15:38:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F208212E36AE; Thu,  6 Apr 2023 15:38:05 +0200 (CEST)
Date:   Thu, 6 Apr 2023 15:38:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
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
        linux-mm@kvack.org, mtosatti@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230406133805.GO386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen>
 <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 01:45:02PM +0100, Valentin Schneider wrote:
> On 05/04/23 14:05, Frederic Weisbecker wrote:
> >  static void smp_call_function_many_cond(const struct cpumask *mask,
> >                                       smp_call_func_t func, void *info,
> > @@ -946,10 +948,13 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
> >  #endif
> >                       cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
> >                       if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
> > -				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> > -				nr_cpus++;
> > -				last_cpu = cpu;
> > -
> > +				if (!(scf_flags & SCF_NO_USER) ||
> > +				    !IS_ENABLED(CONFIG_GENERIC_ENTRY) ||
> > +				     ct_state_cpu(cpu) != CONTEXT_USER) {
> > +					__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> > +					nr_cpus++;
> > +					last_cpu = cpu;
> > +				}
> 
> I've been hacking on something like this (CSD deferral for NOHZ-full),
> and unfortunately this uses the CPU-local cfd_data storage thing, which
> means any further smp_call_function() from the same CPU to the same
> destination will spin on csd_lock_wait(), waiting for the target CPU to
> come out of userspace and flush the queue - and we've just spent extra
> effort into *not* disturbing it, so that'll take a while :(

I'm not sure I buy into deferring stuff.. a NOHZ_FULL cpu might 'never'
come back. Queueing data just in case it does seems wasteful.
