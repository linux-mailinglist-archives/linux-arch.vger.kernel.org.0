Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49776A44B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjGaWno (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 18:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGaWni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 18:43:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE21FD3;
        Mon, 31 Jul 2023 15:43:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690843404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33Fq0Wu+LfDasDHlhoRJ+tEuyTqh8mt568Pu/UPLqZ0=;
        b=PHQpaRnDsOkNetg825gd7IMakLKEP04uFP8GjAkP881xDRNXfPSgpbfOr3P/ZzLgdLAcog
        t84/0kkZB8NqGFR3FI2hQNvWMOLbKioKkFwRxkdH20Fa27GvDIm0eywiEooeOxvDwJnTUQ
        7sULS3F2uUNKXpQByKioVMv0LN8JAUeUK56WYbfHkE8OeeH297dNymSbkyU4DVgQAASEBL
        RJovwWu7lOUgjmS/tGHcenWqOndXgJvUa/6STM+ARb/+OlxVyQ4tkiV4DBd8inkCx83kIq
        OyRIsZ33PKZchkj8QQIzWFKvLakZfO/1wjzytu0JTjG2FzHcVCS/YC3y6O7T1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690843404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33Fq0Wu+LfDasDHlhoRJ+tEuyTqh8mt568Pu/UPLqZ0=;
        b=PRvRmlunvV0e6RaleyV3C7+1OWJpkshHGoUIFIKaYZat4z36ufWvuSv5CP4m/eqDs0eWe2
        zwip5a5ebJA1mqCA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <20230731213341.GB51835@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org> <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
 <20230731192012.GA11704@hirez.programming.kicks-ass.net>
 <87a5vbn5r0.ffs@tglx>
 <20230731213341.GB51835@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Aug 2023 00:43:24 +0200
Message-ID: <87y1ivln1v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31 2023 at 23:33, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 11:14:11PM +0200, Thomas Gleixner wrote:
>> --- a/include/uapi/linux/futex.h
>> +++ b/include/uapi/linux/futex.h
>> @@ -74,7 +74,12 @@
>>  struct futex_waitv {
>>  	__u64 val;
>>  	__u64 uaddr;
>> -	__u32 flags;
>> +	union {
>> +		__u32	flags;
>> +		__u32	size	: 2,
>> +				: 5,
>> +			private	: 1;
>> +	};
>>  	__u32 __reserved;
>>  };
>
> Durr, I'm not sure I remember if that does the right thing across
> architectures -- might just work. But I'm fairly sure this isn't the
> only case of a field in a flags thing in our APIs. Although obviously
> I can't find another case in a hurry :/

I know, but that doesn't make these things more readable and neither an
argument against doing it for futex2 :)

> Also, sys_futex_{wake,wait}() have this thing as a syscall argument,
> surely you don't want to put this union there as well?

Why not? The anon union does not break the ABI unless I'm missing
something. Existing user space can still use 'flags' and people who care
about readability can use the bitfield, no?

Its inside struct futex_waitv and not an explicit syscall argument, right?

> I'd much prefer to just keep the 'unsigned int flags' thing and perhaps
> put a comment on-top of the '#define FUTEX2_*' thingies. Note that
> having it a field instead of a bunch of flags makes sense, since you can
> only have a single size, not a combination of sizes.

I'm aware of that by now :)

Still that explicit bitfield does neither need comments nor does it
leave room for interpretation.

Thanks,

        tglx
