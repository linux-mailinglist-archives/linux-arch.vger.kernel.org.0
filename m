Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392916E7873
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjDSLUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 07:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjDSLUe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 07:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94AA256
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2023 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681903133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yk2MXIcMGsqVm4bpeyyiPIAlxJgEs4vB5F4slfGpqbs=;
        b=T84gPzenBLipwWXMLyNLS8wHcJboOQDcZ+hiP+T24usAlnwF7o6OgfSWEp4+y0lVdVIPCJ
        2xDR4mWyKrE/s5woLjia87k2xcCDjxR0mplC9BlKi/NJhgFlqfOIesCapTKCuPK0gUVByT
        3Yn1vnt1py8nyRQ61rPIWuEylgtLW7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-jmHSCGkANleXDaHYHeFrNA-1; Wed, 19 Apr 2023 07:18:51 -0400
X-MC-Unique: jmHSCGkANleXDaHYHeFrNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59BDC101A54F;
        Wed, 19 Apr 2023 11:18:49 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C83492B05;
        Wed, 19 Apr 2023 11:18:48 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id C0514401344A1; Wed, 19 Apr 2023 08:01:41 -0300 (-03)
Date:   Wed, 19 Apr 2023 08:01:41 -0300
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
Message-ID: <ZD/KFW0BaG1qJr0l@tpad>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC3PUkI7N2uEKy6v@tpad>
 <20230405195457.GC365912@hirez.programming.kicks-ass.net>
 <ZC6/0hRXztNwqXg0@tpad>
 <20230406133206.GN386572@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406133206.GN386572@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 03:32:06PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 09:49:22AM -0300, Marcelo Tosatti wrote:
> 
> > > > 2) Depends on the application and the definition of "occasional".
> > > > 
> > > > For certain types of applications (for example PLC software or
> > > > RAN processing), upon occurrence of an event, it is necessary to
> > > > complete a certain task in a maximum amount of time (deadline).
> > > 
> > > If the application is properly NOHZ_FULL and never does a kernel entry,
> > > it will never get that IPI. If it is a pile of shit and does kernel
> > > entries while it pretends to be NOHZ_FULL it gets to keep the pieces and
> > > no amount of crying will get me to care.
> > 
> > I suppose its common practice to use certain system calls in latency
> > sensitive applications, for example nanosleep. Some examples:
> > 
> > 1) cyclictest		(nanosleep)
> 
> cyclictest is not a NOHZ_FULL application, if you tihnk it is, you're
> deluded.

On the field (what end-users do on production):

cyclictest runs on NOHZ_FULL cores.
PLC type programs run on NOHZ_FULL cores.

So accordingly to physical reality i observe, i am not deluded.

> > 2) PLC programs		(nanosleep)
> 
> What's a PLC? Programmable Logic Circuit?

Programmable logic controller.

> > A system call does not necessarily have to take locks, does it ?
> 
> This all is unrelated to locks

OK.

> > Or even if application does system calls, but runs under a VM,
> > then you are requiring it to never VM-exit.
> 
> That seems to be a goal for performance anyway.

Not sure what you mean.

> > This reduces the flexibility of developing such applications.
> 
> Yeah, that's the cards you're dealt, deal with it.

This is not what happens on the field. 

