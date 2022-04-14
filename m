Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC5501898
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiDNQP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349701AbiDNP5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 11:57:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AA12197;
        Thu, 14 Apr 2022 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kH6ujGoL9etk6d7SqVYOo2pyqaz/8ZlPBQf0CoqEg68=; b=Oh6jCARzLKsg4PYNtSSV5THm2O
        ldBW0UrCujjnxpsSKs0Y0+Gbtj6k3fyeYqaDCunqgh3pAF22qDYLd27vm03t7eIkC8oVwBUNq0cV4
        Ald/PULQLxQGzviKQsVL3bPa9ufarOurPeYUj2vuTH6zRIMe352e2hycGGGmjj+MqTVSEb6otgYjt
        MekoMBu1AHHSrhdoMu4blI7h5csyF1pb2J0lmrQjs8/YDbWcoQBFKQx+WtVEY7VDz1mzAui2Ly3Ey
        bnt3LQkbTAwtYfR2A9Jc2VU+tkfHBw6yPbYMXxPU8YnauiiJTiVFqzgzEmejSx6QYdw3IPMbz1v7n
        8TspuD2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf1Xp-00FFwW-A8; Thu, 14 Apr 2022 15:38:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DA0F30027B;
        Thu, 14 Apr 2022 17:38:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBEA631B90AC3; Thu, 14 Apr 2022 17:38:01 +0200 (CEST)
Date:   Thu, 14 Apr 2022 17:38:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 38/48] objtool: kmsan: list KMSAN API functions as
 uaccess-safe
Message-ID: <Ylg/2dqbL3t/EE65@hirez.programming.kicks-ass.net>
References: <20220329124017.737571-1-glider@google.com>
 <20220329124017.737571-39-glider@google.com>
 <20220330084615.GH8939@worktop.programming.kicks-ass.net>
 <CAG_fn=UzshCuwbq7pZ93v7+eVUgFq1dZ4L_9nEWhYnotmyZtJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UzshCuwbq7pZ93v7+eVUgFq1dZ4L_9nEWhYnotmyZtJg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 14, 2022 at 05:30:34PM +0200, Alexander Potapenko wrote:
> On Wed, Mar 30, 2022 at 10:46 AM Peter Zijlstra <peterz@infradead.org>
> wrote:
> 
> > On Tue, Mar 29, 2022 at 02:40:07PM +0200, Alexander Potapenko wrote:
> > > KMSAN inserts API function calls in a lot of places (function entries
> > > and exits, local variables, memory accesses), so they may get called
> > > from the uaccess regions as well.
> >
> > That's insufficient. Explain how you did the right thing and made these
> > functions actually safe to be called in this context.
> >

> As a result, none of KMSAN API functions perform userspace accesses, but
> since they might be called from UACCESS regions they
> use user_access_save/restore().

^ That.. very good.

Thanks!
