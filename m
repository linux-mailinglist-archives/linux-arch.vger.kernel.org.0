Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD696D97C7
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjDFNRr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjDFNRq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B86159F9
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680787020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEZb6SaUsngmnCMPg4YGowc9TbgaZEBXr+mRqfM4dbw=;
        b=L9bvvX0HUgj5Ia4Sdazsh7hYJdQ7NjenSVL2IEAavelW4pO6fF8Bapm3+mqjmPKExqhCOS
        1PMoofur1pZCogD3rEJUr9OCLY465Xx2RejyHj6TruoXRsCtsS3Zq74abVpau5BqYSjf4a
        Fut0ai/sTJeD8VnDz9aA9b8QxVq7ca0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-10l_5oWZPX2YbGgfWqkGXw-1; Thu, 06 Apr 2023 09:16:57 -0400
X-MC-Unique: 10l_5oWZPX2YbGgfWqkGXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B0A9884EC0;
        Thu,  6 Apr 2023 13:16:55 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82F2D2166B26;
        Thu,  6 Apr 2023 13:16:54 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id A64FC40EB07D7; Thu,  6 Apr 2023 09:49:22 -0300 (-03)
Date:   Thu, 6 Apr 2023 09:49:22 -0300
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
Message-ID: <ZC6/0hRXztNwqXg0@tpad>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC3PUkI7N2uEKy6v@tpad>
 <20230405195457.GC365912@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405195457.GC365912@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 09:54:57PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 04:43:14PM -0300, Marcelo Tosatti wrote:
> 
> > Two points:
> > 
> > 1) For a virtualized system, the overhead is not only of executing the
> > IPI but:
> > 
> > 	VM-exit
> > 	run VM-exit code in host
> > 	handle IPI
> > 	run VM-entry code in host
> > 	VM-entry
> 
> I thought we could do IPIs without VMexit these days? 

Yes, IPIs to vCPU (guest context). In this case we can consider
an IPI to the host pCPU (which requires VM-exit from guest context).

> Also virt... /me walks away.
> 
> > 2) Depends on the application and the definition of "occasional".
> > 
> > For certain types of applications (for example PLC software or
> > RAN processing), upon occurrence of an event, it is necessary to
> > complete a certain task in a maximum amount of time (deadline).
> 
> If the application is properly NOHZ_FULL and never does a kernel entry,
> it will never get that IPI. If it is a pile of shit and does kernel
> entries while it pretends to be NOHZ_FULL it gets to keep the pieces and
> no amount of crying will get me to care.

I suppose its common practice to use certain system calls in latency
sensitive applications, for example nanosleep. Some examples:

1) cyclictest		(nanosleep)
2) PLC programs		(nanosleep)

A system call does not necessarily have to take locks, does it ?

Or even if application does system calls, but runs under a VM,
then you are requiring it to never VM-exit.

This reduces the flexibility of developing such applications.



