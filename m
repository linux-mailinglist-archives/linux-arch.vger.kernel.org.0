Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44187511925
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiD0Nbn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiD0Nbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 09:31:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C633E23;
        Wed, 27 Apr 2022 06:28:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651066104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XeLkj9226T84S9BXMt19LKkxjN+pWXBCLzkSQX80Wy0=;
        b=CnD8+0uDIKN5dkS4D3kOiZHg/aTrcuU3CSgu/18pNHX4Bq8eAM1hY3aI4Xu+WNh8Jmn/j7
        R+SzJ5YdJvI5nC5LZnNvdrrvEC1pm6pUjngAw2WcmmOvWeilo9o88BsPnZiOq5IP7iVI/U
        Ld+1XVU5417idG7bq4A6e0TRt8nItIYLaV0EYBB8dfsEPPtRua6GcUSKSQk5VEUw7RDcyu
        sGfWU16My8O6Qii/arx971F7FyOPp6CQNVj3UlU8KnyEdjlbltkVPpGGF181Oy1zG3PJcb
        dlAkAuEeKrWfS/iDZAZL6H5bcANyx5Px2Bs4sti+fqx2XT88qk8IB+qGc5NGQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651066104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XeLkj9226T84S9BXMt19LKkxjN+pWXBCLzkSQX80Wy0=;
        b=mqNvTWF9p2Pn5UfW0rssM+TDypdzsffTK7XDNT84SfjwuIlFAdc4suevqEXX1MmYnM9rdo
        Ccy/wwrc6gkF4WCA==
To:     Alexander Potapenko <glider@google.com>, glider@google.com
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
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 27/46] kmsan: instrumentation.h: add
 instrumentation_begin_with_regs()
In-Reply-To: <20220426164315.625149-28-glider@google.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-28-glider@google.com>
Date:   Wed, 27 Apr 2022 15:28:23 +0200
Message-ID: <87bkwmy7t4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26 2022 at 18:42, Alexander Potapenko wrote:
> +void kmsan_instrumentation_begin(struct pt_regs *regs)
> +{
> +	struct kmsan_context_state *state = &kmsan_get_context()->cstate;
> +
> +	if (state)
> +		__memset(state, 0, sizeof(struct kmsan_context_state));

  sizeof(*state) please

> +	if (!kmsan_enabled || !regs)
> +		return;

Why has state to be cleared when kmsan is not enabled and how do you end up
with regs == NULL here?

Thanks,

        tglx
