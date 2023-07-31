Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123E76A23A
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGaUwb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 16:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGaUwa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 16:52:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294A198D;
        Mon, 31 Jul 2023 13:52:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690836748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=buYJKjQ237JCo+lND5Be2oqIGKiZxmUkCcs0tnZIjrA=;
        b=nLxjrl/FgW7S5RAri34yJK3Fps7e3JoJprljai7RwaoDmY+XLlkIWCsJAWaHFrbEh8cOZa
        kc82sC5ZUoxnTxPyQ3ZjZORcYpjlAjTE1Sutd5dff2HoHm5WQrb291oFq3LkyxH3lh3c5C
        DS/BUlUb5YVNmdAF5IbOHufqlyo76BEx2OXrh7f3j1qs8CojtQL8dsuhq5EInC22NFuFas
        5p6HnQmIPVS9nbe7vmDs+FnD+1j9Y+89QRdLk0Jmir61FVRe0KSRQxYix3Py1fzA+51Yw7
        Yy4oNDR+7Y8rKN3nOeFpPSP64iK/UeEbrP5ONDh1XikPJZ6LACJfdPhm/SdiLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690836748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=buYJKjQ237JCo+lND5Be2oqIGKiZxmUkCcs0tnZIjrA=;
        b=yY7ufkgtHNjU8gf3lLYpYl69LwEFgE9y4qgu3u0WHPPKKI0piKmkBxl8ghoz+vka0QjIgr
        0AnxLUi+55/ZG3Dw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <20230731173515.GP29590@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org> <87edkonjrk.ffs@tglx>
 <87v8e0m26q.ffs@tglx>
 <20230731173515.GP29590@hirez.programming.kicks-ass.net>
Date:   Mon, 31 Jul 2023 22:52:27 +0200
Message-ID: <87cz07n6r8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31 2023 at 19:35, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 07:16:29PM +0200, Thomas Gleixner wrote:
>> On Mon, Jul 31 2023 at 18:11, Thomas Gleixner wrote:
>> > On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
>> >> -#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
>> >> +#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
>> >>  
>> >>  /**
>> >>   * futex_parse_waitv - Parse a waitv array from userspace
>> >> @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
>> >>  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
>> >>  			return -EINVAL;
>> >
>> > With the above aux.flags with FUTEX2_32 set will result in -EINVAL. I
>> > don't think that's intentional.
>> 
>> Also if you allow 64bit wide futexes, how is that supposed to work with
>> the existing code, which clearly expects a 32bit uval throughout the
>> place?
>
> Not allowed yet, these patches only allow 8,16,32. I still need to audit
> the whole futex core and do 'u32 -> unsigned long' (and everything else
> that follows from that), and only when that's done can the futex2
> syscalls allow FUTEX2_64 on 64bit archs.
>
> So for now, these patches:
>
>   - add the FUTEX2_64 flag,
>   - add 'unsigned long' interface such that
>     64bit can potentiall use it,
>   - explicitly disallow having it set.

I figured that out very late. This flags having a size fields which
claims to be flags had confused the hell out of me.

