Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725EA6D872B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDETqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDETqo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 15:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C91BCB
        for <linux-arch@vger.kernel.org>; Wed,  5 Apr 2023 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680723962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2zEtqXoZ8EUol2cclpRVKkKNXmBP9BtyvyLsaVT0jc=;
        b=IHr326Oj0N26xa5gQkJW3os8cdcmQWMlINIkTgYno6gdUDUnNTTv/csK3/fUP3av3Sd8hU
        2Z2vebdoiAkOo6CAgUKASMsGdssEeOBM6GTltzvz1XFtcQNofFD0ONTpeSJ9BjAk6sfUJF
        rLEGgkP1qL8KZk+d2C9112Mt/JpPC9U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-6AAFnWjlOs2G1gaCxtVpqg-1; Wed, 05 Apr 2023 15:46:00 -0400
X-MC-Unique: 6AAFnWjlOs2G1gaCxtVpqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C7243C0D86F;
        Wed,  5 Apr 2023 19:45:57 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9FF21121314;
        Wed,  5 Apr 2023 19:45:55 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id E6884400E055B; Wed,  5 Apr 2023 16:43:14 -0300 (-03)
Date:   Wed, 5 Apr 2023 16:43:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, arnd@arndb.de,
        keescook@chromium.org, paulmck@kernel.org, jpoimboe@kernel.org,
        samitolvanen@google.com, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vschneid@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <ZC3PUkI7N2uEKy6v@tpad>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1Q7uX4rNLg3vEg@lothringen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 12:43:58PM +0200, Frederic Weisbecker wrote:
> On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> > @@ -191,6 +192,20 @@ static void tlb_remove_table_smp_sync(void *arg)
> >  	/* Simply deliver the interrupt */
> >  }
> >  
> > +
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +static bool cpu_in_kernel(int cpu, void *info)
> > +{
> > +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> 
> Like Peter said, an smp_mb() is required here before the read (unless there is
> already one between the page table modification and that ct->state read?).
> 
> So that you have this pairing:
> 
> 
>            WRITE page_table                  WRITE ct->state
> 	   smp_mb()                          smp_mb() // implied by atomic_fetch_or
>            READ ct->state                    READ page_table
> 
> > +	int state = atomic_read(&ct->state);
> > +	/* will return true only for cpus in kernel space */
> > +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> > +}
> 
> Also note that this doesn't stricly prevent userspace from being interrupted.
> You may well observe the CPU in kernel but it may receive the IPI later after
> switching to userspace.
> 
> We could arrange for avoiding that with marking ct->state with a pending work bit
> to flush upon user entry/exit but that's a bit more overhead so I first need to
> know about your expectations here, ie: can you tolerate such an occasional
> interruption or not?

Two points:

1) For a virtualized system, the overhead is not only of executing the
IPI but:

	VM-exit
	run VM-exit code in host
	handle IPI
	run VM-entry code in host
	VM-entry

2) Depends on the application and the definition of "occasional".

For certain types of applications (for example PLC software or
RAN processing), upon occurrence of an event, it is necessary to
complete a certain task in a maximum amount of time (deadline).

One way to express this requirement is with a pair of numbers,
deadline time and execution time, where:

       	* deadline time: length of time between event and deadline.
       	* execution time: length of time it takes for processing of event
                          to occur on a particular hardware platform
                          (uninterrupted).



