Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C65A2912
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbiHZOIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHZOIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 10:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C5DC228F
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661522925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNgsj5k0ypmgE59A3sWqp3HYtOVnFWXRmYISxh7p32g=;
        b=PH8G9zwbsQqfRiipQtaZ3/zsH2NIxQRxUmeRMukDylhTnYxnZH49Ev2Vj39CEUoeCxMhhd
        09yrmJ6Hql/pTkqEjjgpRD1XxnUin4ROmDDABJZcn/GYb239DsAzJnq4mgiSG4ciWhGjnj
        o3z8eTw5jnqm455ks6Sg+xqmHWSieF0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-kiBHKF2zPjaer5RBGLXEAg-1; Fri, 26 Aug 2022 10:08:44 -0400
X-MC-Unique: kiBHKF2zPjaer5RBGLXEAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 361C11C09C84;
        Fri, 26 Aug 2022 14:08:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1013B492CA2;
        Fri, 26 Aug 2022 14:08:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27QE8hJM028999;
        Fri, 26 Aug 2022 10:08:43 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27QE8gsX028995;
        Fri, 26 Aug 2022 10:08:42 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Aug 2022 10:08:42 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
In-Reply-To: <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2208261003590.27240@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <20220826112327.GA19774@willie-the-truck> <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, 26 Aug 2022, Mikulas Patocka wrote:

> 
> 
> On Fri, 26 Aug 2022, Will Deacon wrote:
> 
> > On Thu, Aug 25, 2022 at 05:03:40PM -0400, Mikulas Patocka wrote:
> > > 
> > > For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all 
> > > (with or without this patch), so I only compile-tested it on arm64. I have 
> > > to bisect it.
> > 
> > It's working fine for me and I haven't had any other reports that it's not
> > booting. Please could you share some more details about your setup so we
> > can try to reproduce the problem?
> 
> I'm bisecting it now. I'll post the offending commit when I'm done.

So, the bad commit is aacd149b62382c63911060b8f64c1e3d89bd405a ("arm64: 
head: avoid relocating the kernel twice for KASLR").

> It gets stuck without printing anything at this point:
> Loading Linux 6.0.0-rc2 ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> 
> I uploaded my .config here: 
> https://people.redhat.com/~mpatocka/testcases/arm64-config/config-6.0.0-rc2 
> so you can try it on your own.
> 
> The host system is MacchiatoBIN board with Debian 10.12.

Mikulas

