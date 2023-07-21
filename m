Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A175D66D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUVYA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGUVX7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 17:23:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087430D0;
        Fri, 21 Jul 2023 14:23:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 03BE53200A01;
        Fri, 21 Jul 2023 17:23:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 17:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689974632; x=1690061032; bh=BX
        A5sL4xRNZhXccbqClwUqLOYCKhWLZB5FjhdMOfEyY=; b=KIWSyr1gDGjK5zOe64
        CjDoz6RYdvcy0EBMoGa/JdfwjIzcqn5BmUC9VCIKCw7NxZMfzt4z2Sa84XokZDHh
        D5UuaQEEeYlymRrPIp66kpzRRSIN/at++4LkuoNgOyR36Zhoc2rjzZ6KZwYlymge
        0tEakJnvKGwlsyAYsg//PGS89t+lvztpDAo0kUyXnjMz+9ZC+0uLqc+K5RNwntKx
        Gv4AtsdcWzrAu4+yHh6VG7qXSeDWQ6aUHOw9xXjD0B3LCrKYHsAEJxG7xDVfwk77
        6c+ZATLarJtSVzeAZdXzWXe2gYcEAzdls5VstykuKCV2YIwUkjQZhYbH48/ar0VE
        GnEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689974632; x=1690061032; bh=BXA5sL4xRNZhX
        ccbqClwUqLOYCKhWLZB5FjhdMOfEyY=; b=vEJWu1BeTLrHTDMqWmtuHU4Q7AyYu
        bd8BzeEIVML4QdPofZ/ZZS/RiGJ7LajTTSg3Jh4Btcxb8MpOjEvRkI+e6vsbr8LR
        Xn04DY3Kw9A6lpnISSTN91IJNkl7vxl/pHY7Xpa1/ijV4Vd2dgRWUTO4yiBo6vBP
        o2t8luG+lIf2+QaZyTrkrSqeE8ODIv4qfkSyUqYe7dXhj9pXGKhuWplSBI6tJX90
        40jy6Am6cz1J5/XK8dCLFZ0vxqmM0bBY8wl1uSeV23QAX0b6xHvqVgGpKPjhuAX/
        Ratl1Lx/lLyWcmFJUlA34do5XZDDiuieSs3trLcZWPLSwApDUc7KqmOfw==
X-ME-Sender: <xms:Zve6ZALfqNq7Boo-zlWow6j4YQVVpwJ6n2VTG9_w2rHQkxzr1Jd1Ug>
    <xme:Zve6ZALcEGyJrX1fMorzJpL7fm9KJ8iwG3jLymrlKgg_lNggQsEr33PceJbwBZswX
    2zCuwhLa00g1l65kkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Zve6ZAvRD67NV8bRZceXBiW0I78r3rj81xwHdEjWA7cKSKBvI9rmxw>
    <xmx:Zve6ZNZPk9cKLCJc-8FK0gGXw2E2jldMOWVP7ZSkdCx3-pJY0heFyg>
    <xmx:Zve6ZHYG_4xReXGC1gpXGr2qv_yBjlzI8HI8RER7c8kgIqRlKH2psw>
    <xmx:aPe6ZDowLks1ypP3hCXSITwNPyMclEPm4oa37yepuDYmsz4MUs7yQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7204B60089; Fri, 21 Jul 2023 17:23:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <02045e07-0f9a-49bf-b6ca-354cb67678f8@app.fastmail.com>
In-Reply-To: <20230721185445.GS4253@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.022509272@infradead.org>
 <2a1f8ae6-ed2b-4fe8-85af-df64e9c84794@app.fastmail.com>
 <20230721185445.GS4253@hirez.programming.kicks-ass.net>
Date:   Fri, 21 Jul 2023 23:23:27 +0200
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
Subject: Re: [PATCH v1 05/14] futex: Add sys_futex_wake()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023, at 20:54, Peter Zijlstra wrote:
> On Fri, Jul 21, 2023 at 05:41:20PM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 21, 2023, at 12:22, Peter Zijlstra wrote:
>> > --- a/kernel/sys_ni.c
>> > +++ b/kernel/sys_ni.c
>> > @@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
>> >  COND_SYSCALL(get_robust_list);
>> >  COND_SYSCALL_COMPAT(get_robust_list);
>> >  COND_SYSCALL(futex_waitv);
>> > +COND_SYSCALL(futex_wake);
>> >  COND_SYSCALL(kexec_load);
>> >  COND_SYSCALL_COMPAT(kexec_load);
>> >  COND_SYSCALL(init_module);
>> 
>> This is fine for the moment, but I wonder if we should start making
>> futex mandatory at some point. Right now, sparc32 with CONFIG_SMP
>> cannot support futex because of the lack of atomics in early
>> sparc processors, but sparc32 glibc actually requires futexes
>> and consequently only works on uniprocessor machines, on sparc64
>> compat mode, or on Leon3 with out of tree patches.
>
> PARISC is another 'fun' case.

I had to look up how that works, but as far as I can tell, the
parisc code actually has a chance of working, as the userspace
atomics go through the light-weight syscall that shares a hashed
lock with the actual futex syscall. On sparc32 I think it's
worse because userspace assumes that atomic instructions are
supported while the kernel assumes they are not.

        Arnd
