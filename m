Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F6754393
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGNUKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjGNUKq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 16:10:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE030DC;
        Fri, 14 Jul 2023 13:10:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 30F825C0079;
        Fri, 14 Jul 2023 16:10:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Jul 2023 16:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689365445; x=1689451845; bh=ga
        PAQwdntztGOLiPMplHfdyiMwn46B6kS3SDmZfmT/c=; b=UiKsC+oQ9U1WlYM6OM
        gjGTV5NlSKJ22DSJQxmr+HBVOSOGXloGZmwlhzDuax0qJokzwunmP/B0LXXBU+IB
        O5GHqtXClcmby/8dk1dOt0wDSE0YCwEdNKUw85M12ayhrJvwI/XFd7L8fB0r0KLW
        6ppr3flC4Ohao7nTDQi4zDjOfZhI/he1yFCvFyLbPaI1cabqFLsnmA8R4B7xN5Kf
        st6Veg2HjO79Rmtw9ck4kxHWASjyJpi3VE0pP8UFCF5mFL+tXMZzJl8/3WXgBmhM
        rSWQsuu9g/6Ag5BiIk1+k9nd0WBulErAF1X6M1/QwMrnHYUrt4NAxO5IMdSQvwFx
        12yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689365445; x=1689451845; bh=gaPAQwdntztGO
        LiPMplHfdyiMwn46B6kS3SDmZfmT/c=; b=CEpTsjWAXMkWHu/nvKovCbJVDQqHv
        zREI/E6uIabljXUQ8ZBMe8VuLogoRgEpRyaXQz6qKWmHeLqZkNs1ieI/wwknAGcT
        QhbGPjoBnW67h8jwrl+z5PnArYZxRPB0JvQ62X76k77L0DCNXD+gUdeoTES4+zFL
        bx1yFpIovfcz0MXJak4v50wzu4iaIrYCDf/XN+vu4wIdTyz83PLUZdsTl2uicc/8
        OgkJ+Qvl3fXHOAMjg2BLTFb4VVhqdHTl1qGVDS+2D3YyrlXPOekL7bHBDd8Xixrp
        9LkzBLAGHWNvVMo/v7+aqnnsOXzEA+aJ9N3iNjhgReKxm622an0xo8kdg==
X-ME-Sender: <xms:xKuxZOtHnPjkwPcsmcuUjwfZGI4HMP8yMHyEjJDAFtzH7tJWmUOMQA>
    <xme:xKuxZDfdwaFOVGVD_mq1tGj_AQeCGPtN6EEZMXSzFIhf2DBIpVFyZy4rGoSyc2izB
    xeuB27M_rbyPjFGYZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xKuxZJzyXqST3REgFwmwOHxUqFQZRh6kkOrES2sfJMpDc6-6bMr2Aw>
    <xmx:xKuxZJPgGH9A-KdDAWuSbRrY-P0mcSBmlEPgfQTOuH_nOqOawjIAXg>
    <xmx:xKuxZO90IzV7N655TTDcHdQTwDDZiehTq96qDnSnaTCRIFJfmQ5DDA>
    <xmx:xauxZAft0YinFoFu7ewMVQ3d0Ex_PyHim0ayqH-oY3piRVaLdaZBxg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D4C8B60086; Fri, 14 Jul 2023 16:10:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <d8366484-63d7-4e7c-b02d-7354aa69c444@app.fastmail.com>
In-Reply-To: <20230714144749.GA3261758@hirez.programming.kicks-ass.net>
References: <20230714133859.305719029@infradead.org>
 <20230714141218.879715585@infradead.org>
 <c5a09710-a7a1-43df-ac25-42e8f3983f9c@app.fastmail.com>
 <20230714144749.GA3261758@hirez.programming.kicks-ass.net>
Date:   Fri, 14 Jul 2023 22:10:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        "Ingo Molnar" <mingo@redhat.com>,
        "Darren Hart" <dvhart@infradead.org>, dave@stgolabs.net,
        andrealmeid@igalia.com,
        "Andrew Morton" <akpm@linux-foundation.org>, urezki@gmail.com,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
        malteskarupke@web.de
Subject: Re: [RFC][PATCH 04/10] futex: Add sys_futex_wake()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023, at 16:47, Peter Zijlstra wrote:
> On Fri, Jul 14, 2023 at 04:26:45PM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 14, 2023, at 15:39, Peter Zijlstra wrote:
>> >
>> > +++ b/include/linux/syscalls.h
>> > @@ -563,6 +563,9 @@ asmlinkage long sys_set_robust_list(stru
>> >  asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
>> >  				unsigned int nr_futexes, unsigned int flags,
>> >  				struct __kernel_timespec __user *timeout, clockid_t clockid);
>> > +
>> > +asmlinkage long sys_futex_wake(void __user *uaddr, int nr, unsigned 
>> > int flags, u64 mask);
>> > +
>> 
>> You can't really use 'u64' arguments in portable syscalls, it causes
>> a couple of problems, both with defining the user space wrappers,
>> and with compat mode.
>> 
>> Variants that would work include:
>> 
>> - using 'unsigned long' instead of 'u64'
>> - passing 'mask' by reference, as in splice()
>> - passing the mask in two u32-bit arguments like in llseek()
>> 
>> Not sure if any of the above work for you.
>
> Durr, I was hoping they'd use register pairs, but yeah I can see how
> that would be very hard to do in generic code.

It kind of works to just use register pairs, the actual problem
you run into here is that:

- depending on the architecture, the register pairs need to be
  even/odd pairs, so there are two different ways that 32-bit
  architectures handle it

- The compat handler needs to explicitly name the registers that
  are used, so to make your version above work correctly, we'd
  need three entry points, for native 64-bit, compat 32-bit
  odd/even pairs and compat 32-bit even/odd pairs.

> Hurmph.. using 2 u32s is unfortunate on 64bit, while unsigned long
> would limit 64bit futexes to 64bit machines (perhaps not too bad).
>
> Using unsigned long would help with the futex_wait() thing as well.
>
> I'll ponder things a bit.
>
> Obviously I only did build x86_64 ;-)

I suspect that restricting the futexes to native work size is
ok since many 32-bit architectures don't have 64-bit atomic
instructions anyway (armv6k+ and i586tsc+ being the obvious
exceptions), so userspace code that relies on it becomes
nonportable.

    Arnd
