Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D203D664500
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAJPf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 10:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjAJPfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 10:35:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6223D1CB;
        Tue, 10 Jan 2023 07:35:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FAC8B816D4;
        Tue, 10 Jan 2023 15:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C42C433F0;
        Tue, 10 Jan 2023 15:35:05 +0000 (UTC)
Date:   Tue, 10 Jan 2023 10:35:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase
 MAX_STRUCT_PAGE_SIZE
Message-ID: <20230110103504.6ee5f783@gandalf.local.home>
In-Reply-To: <20230110085549.GA12778@lst.de>
References: <20220701142310.2188015-11-glider@google.com>
        <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
        <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
        <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
        <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
        <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
        <Y7z99mf1M5edxV4A@kroah.com>
        <63bd0be8945a0_5178e29414@dwillia2-xfh.jf.intel.com.notmuch>
        <CAG_fn=X9jBwAvz9gph-02WcLhv3MQkBpvkZAsZRMwEYyT8zVeQ@mail.gmail.com>
        <CANn89iJRXSb-xK_VxkHqm8NLGhfH1Q_HW_p=ygAH7QocyVh+DQ@mail.gmail.com>
        <20230110085549.GA12778@lst.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 10 Jan 2023 09:55:49 +0100
Christoph Hellwig <hch@lst.de> wrote:

> Folks, can you please trim your quotes to what is relevant?  I've not
> actually beeng finding any relevant information in the last three mails
> before giving up the scrolling after multiple pages.

If I don't see a response after three scrolls, I ignore the email.

-- Steve
