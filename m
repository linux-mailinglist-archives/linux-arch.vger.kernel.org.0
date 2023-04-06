Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830096D97C8
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjDFNRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjDFNRq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174377EC6
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680787021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LyLWq4qOx1xU0bxV6bHK7gb5g8imneWyvQWEYXMsdJw=;
        b=gwPwcacj/kxvWQzqZyQwibbLJ2gwOW1xsXRxfey6wr6/y3l1OZswOkzYyWPUZgYUEsyWUf
        LQxbU87MvR91jrwyW3QnPQMjlrtD0BYC8bpBrREDzqGbkqkaRig+Gn4BwEA1LrxaCeRHAe
        qgvMdW/JILVmCLKW69VLl0BOVnNnJxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-LTw34yIZO-qtviR3tWXTcA-1; Thu, 06 Apr 2023 09:16:57 -0400
X-MC-Unique: LTw34yIZO-qtviR3tWXTcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EF4B857F81;
        Thu,  6 Apr 2023 13:16:55 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86155C1602C;
        Thu,  6 Apr 2023 13:16:54 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8BB9E41306EC9; Thu,  6 Apr 2023 09:38:50 -0300 (-03)
Date:   Thu, 6 Apr 2023 09:38:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZC69Wmqjdwk+I8kn@tpad>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405195226.GB365912@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 09:52:26PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 04:45:32PM -0300, Marcelo Tosatti wrote:
> > On Wed, Apr 05, 2023 at 01:10:07PM +0200, Frederic Weisbecker wrote:
> > > On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
> > > > On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> > > > > +	int state = atomic_read(&ct->state);
> > > > > +	/* will return true only for cpus in kernel space */
> > > > > +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> > > > > +}
> > > > 
> > > > Also note that this doesn't stricly prevent userspace from being interrupted.
> > > > You may well observe the CPU in kernel but it may receive the IPI later after
> > > > switching to userspace.
> > > > 
> > > > We could arrange for avoiding that with marking ct->state with a pending work bit
> > > > to flush upon user entry/exit but that's a bit more overhead so I first need to
> > > > know about your expectations here, ie: can you tolerate such an occasional
> > > > interruption or not?
> > > 
> > > Bah, actually what can we do to prevent from that racy IPI? Not much I fear...
> > 
> > Use a different mechanism other than an IPI to ensure in progress
> > __get_free_pages_fast() has finished execution.
> > 
> > Isnt this codepath slow path enough that it can use
> > synchronize_rcu_expedited?
> 
> To actually hit this path you're doing something really dodgy.

Apparently khugepaged is using the same infrastructure:

$ grep tlb_remove_table khugepaged.c 
	tlb_remove_table_sync_one();
	tlb_remove_table_sync_one();

So just enabling khugepaged will hit that path.

