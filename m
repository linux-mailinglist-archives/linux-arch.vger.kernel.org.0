Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45AB565E3D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGDUIg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 16:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGDUIe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 16:08:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAC631E;
        Mon,  4 Jul 2022 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ox3ejexcnSO2kiSqXPJuX7n+jNsz1cXUFvtntlnSEE0=; b=KPzqGIDnsQbpbNt1Wz0FLR4Yea
        YTGGUZEI2IkZ47YhlmX7+xh6rCVSFOfOYnClmktO4RMBDRXAUxj3viZFsLa+M+FwuDS5XFriHUZNd
        pwIf4rbrr5ozbHt95+smAi2y1FG8EZon8fB5o7uI28YWZmkXDGbxnUOYVwtAXw2P+c67wKgA9eQ0G
        XtA5Z+6oqzemjCMZ7jQ00aqOEVFpQtaCOZXjY8eD1p8MVG374Pd7n/78fePVwK943ag/oUX2890RT
        y7jzFVZ6dpEEpl1lO3Gp0kIhGZA15MVer+DWorPPva5JQh0TgjuZN3ksg0VqDPW2PGnm3WdLemIc6
        CvLSpYfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8SMB-00HYnF-MF; Mon, 04 Jul 2022 20:07:43 +0000
Date:   Mon, 4 Jul 2022 21:07:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
Message-ID: <YsNIjwTw41y0Ij0n@casper.infradead.org>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-45-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701142310.2188015-45-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 01, 2022 at 04:23:09PM +0200, Alexander Potapenko wrote:
> Functions implementing the a_ops->write_end() interface accept the
> `void *fsdata` parameter that is supposed to be initialized by the
> corresponding a_ops->write_begin() (which accepts `void **fsdata`).
> 
> However not all a_ops->write_begin() implementations initialize `fsdata`
> unconditionally, so it may get passed uninitialized to a_ops->write_end(),
> resulting in undefined behavior.

... wait, passing an uninitialised variable to a function *which doesn't
actually use it* is now UB?  What genius came up with that rule?  What
purpose does it serve?

