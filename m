Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432AD575E14
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGOIyG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiGOIxy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 04:53:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54683F25
        for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2022 01:52:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a18-20020a05600c349200b003a30de68697so368975wmq.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2022 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lnbKwcn88f6NuJinTbm+K+QRokDztEAvNGDk/1bg6OE=;
        b=EPbgaSiEgC0y6d0plpABJbe4WhG92iJsdO7dU4p4mGED6SykJ/QDLH8/N2MxjUYHLX
         qVDpoVZVSrTIEGtj5KQFMHqpe9JYWRRZDrXn2v3rXeazNEUOWy1DUOcrai9kkXEGTF6r
         Zorc70RXImp1DoNbN7gOVkLYiKKr0zAgFDhslcXhBW1frZb9YL6LGtquavH5ImbiumLf
         HUjYzzAfkRf7I3yGNLmsMogn7wQTzJWPX+9gDPv59k8FDoh+Ws/bvhFWFmYkGhTrDud6
         qS5XqssX+c/dSGecigcLJNoTijBqR9PRcLFbV7SqARVFen9kuXNNiMutKStWZWzooUJD
         jaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnbKwcn88f6NuJinTbm+K+QRokDztEAvNGDk/1bg6OE=;
        b=i45gNqYMDCMFmO+Rlk8W4I0QYkh6E9G5z79tNKTNiCk6+YRH3N5+vrk+kRvFK+tpJT
         Afgs3Q8jtmaS0TYKZY9O/HRhMDAcN/y/+ftI+A/yDNMABz79A3Es84VMwG1j1L7zUqnv
         pwzGOSZJrKRUCvjHnzxhQHQvS/4GEqXZ/+Lxrk52+dU6uV2PMRzbdUQVDSj1brwCGsoZ
         5IkCPMpXYBrgD9YQIvCJMQROwPHAcztqx29uZ0iGaj+syyDU7VyeZ9leQkghTCf1DrGt
         7jC15ojQ/pQZf3VZH2WJWd2cWTaHabRjNLHqBtDeve5kzJ60ub2y58jtgwiJcQJlLs4r
         Mngw==
X-Gm-Message-State: AJIora8f11a7YheqxfadQ1bWYuaGtTAWV2epyVpVP4ob4pdI3oorfLqL
        xBtFibf4lV6Xx7rAB7DaKNQjAw==
X-Google-Smtp-Source: AGRyM1tkG0LUmTaEynDGXTm4Zb2UyVqfYMmac0HS4kuDLCGKKbrryKEGrHBi6pSIk5JB5Rsgrgifsw==
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id i14-20020a05600c354e00b003a19ddf468dmr18784274wmq.145.1657875177165;
        Fri, 15 Jul 2022 01:52:57 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:b388:52a3:7014:22f5])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d438f000000b0021d4d6355efsm3285703wrq.109.2022.07.15.01.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:52:56 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:52:49 +0200
From:   Marco Elver <elver@google.com>
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/45] kmsan: add ReST documentation
Message-ID: <YtEq4dFk/NvE43iM@elver.google.com>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-7-glider@google.com>
 <CANpmjNN=XO=6rpV-KS2xq=3fiV1L3wCL1DFwLes-CJsi=6ZmcQ@mail.gmail.com>
 <CAG_fn=X5w5F1rwHuQqQ9GRYT4MiNGQLh71FRN16Wy3rGJLX_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X5w5F1rwHuQqQ9GRYT4MiNGQLh71FRN16Wy3rGJLX_AA@mail.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 15, 2022 at 09:42AM +0200, Alexander Potapenko wrote:
[...]
> > This sentence might still be confusing. I think it should highlight
> > that runtime and compiler go together, but depending on the scope of
> > the value, the compiler invokes the runtime to persist the shadow.
> 
> Changed to:
> """
> Compiler instrumentation also tracks the shadow values as they are used along
> the code. When needed, instrumentation code invokes the runtime library in
> ``mm/kmsan/`` to persist shadow values.
> """

Ack.

[...]
> > > +Passing uninitialized values to functions
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +KMSAN instrumentation pass has an option, ``-fsanitize-memory-param-retval``,
> >
> > "KMSAN instrumentation pass" -> "Clang's instrumentation support" ?
> > Because it seems wrong to say that KMSAN has the instrumentation pass.
> How about "Clang's MSan instrumentation pass"?

Maybe just "Clang's MemorySanitizer instrumentation" - no abbreviation,
and "pass" is very compiler-implementation specific and not everyone
might know what "pass" even means in this context, so I'd leave it out.

[...]
> > It would be useful to move this section somewhere to the beginning,
> > closer to usage and the example, as this is information that a user of
> > KMSAN might want to know (but they might not want to know much about
> > how KMSAN works).
> 
> I restructured the TOC as follows:
> 
> == The Kernel Memory Sanitizer (KMSAN)
> == Usage
> --- Building the kernel
> --- Example report
> --- Disabling the instrumentation
> == Support
> == How KMSAN works
> --- KMSAN shadow memory
> --- Origin tracking
> ~~~~ Origin chaining
> --- Clang instrumentation API
> ~~~~ Shadow manipulation
> ~~~~ Handling locals
> ~~~~ Access to per-task data
> ~~~~ Passing uninitialized values to functions
> ~~~~ String functions
> ~~~~ Error reporting
> ~~~~ Inline assembly instrumentation
> --- Runtime library
> ~~~~ Per-task KMSAN state
> ~~~~ KMSAN contexts
> ~~~~ Metadata allocation
> == References

LGTM.

Thanks,
-- Marco
