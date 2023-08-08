Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9D97742B1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjHHRse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 13:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjHHRsF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 13:48:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2AD26326;
        Tue,  8 Aug 2023 09:21:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691485930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DoNI5v5umT0Z8D7XCCNoP2aZrQ/gIq+jzyHgWzWgdgo=;
        b=NqxDxnpmcGRK6PtnO2RtI8BZQByg8ruKL7AL6OSKYguyFob+ikfLazgjxgzcUIJWkJhrIV
        Yd3n5dzvSzw5eVwwC0r2HOYW6OtbKaFSRM6SpqW5HBgBtS+xwvuxk7HIponmeb+5YGaRpK
        vmUnB89jlJlxzC0YFhTOSLlZj8RqGKax7LN8fMKvpWMl8AmHQ4jses991y5VE8KX5/bm9r
        Q9vK4dhdNvj/zvq32GeI8WemoTegluSjDa6sohOJpDMN/IkUd9004TZI2p/1xDXw0ONEa5
        yykhTXK511yAJf2tMDinXIC4bHb2+ZzTgMR07UtYcZ4/sDGELEpKDRe1y3Rqkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691485930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DoNI5v5umT0Z8D7XCCNoP2aZrQ/gIq+jzyHgWzWgdgo=;
        b=AKO4JGVhFpvSXlHLtgexL3PAvihILrtXinYpKnJnh4vFOWYHw1/0e+Pbm0TdD8Oax1T3wG
        mduROucX9K/ICRAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20230808085406.GU212435@hirez.programming.kicks-ass.net>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.504975124@infradead.org> <87fs4utv6f.ffs@tglx>
 <20230808085406.GU212435@hirez.programming.kicks-ass.net>
Date:   Tue, 08 Aug 2023 11:12:09 +0200
Message-ID: <87y1ilsxsm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 08 2023 at 10:54, Peter Zijlstra wrote:
> On Mon, Aug 07, 2023 at 11:11:04PM +0200, Thomas Gleixner wrote:
>> On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:
>> >  /**
>> >   * futex_hash - Return the hash bucket in the global hash
>> >   * @key:	Pointer to the futex key for which the hash is calculated
>> > @@ -114,10 +137,29 @@ late_initcall(fail_futex_debugfs);
>> >   */
>> >  struct futex_hash_bucket *futex_hash(union futex_key *key)
>> >  {
>> > -	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
>> > +	u32 hash = jhash2((u32 *)key,
>> > +			  offsetof(typeof(*key), both.offset) / sizeof(u32),
>> >  			  key->both.offset);
>> > +	int node = key->both.node;
>> > +
>> > +	if (node == -1) {
>> 
>> NUMA_NO_NODE please all over the place.
>
> Ah, so our (futex2) ABI states this needs to be -1, but in theory
> someone could come along and change the kernel internal NUMA_NO_NODE to
> something else.
>
> That is, I explicitly chose not to use it. I can of course, because as
> of now these values do match.

Fair enough, but can we at least have a proper define in the futex2 ABI
please?
