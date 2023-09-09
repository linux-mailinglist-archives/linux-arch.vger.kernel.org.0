Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449957999AB
	for <lists+linux-arch@lfdr.de>; Sat,  9 Sep 2023 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjIIQZ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Sep 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjIIPSn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Sep 2023 11:18:43 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DE1AA;
        Sat,  9 Sep 2023 08:18:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 030FA2B00070;
        Sat,  9 Sep 2023 11:18:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 11:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694272714; x=1694279914; bh=vY
        LOo58Iptv/FkcVRywLSH84q+eDgwPgYFmT3FsJ9xY=; b=FmmAfgEinxxxgQdl5D
        MEIu3fx2JqIPqaBSe4Rsy0QD3yV6BO3uJiKmKfBCNYva5D5aSnxQKdiA2givRYxQ
        YRQ4G5K49IZAysK1E98AO9QwwTAoT6v1hY8G9e5Wb2hwzHzuW8nh4rfkp8MTr7jS
        bU5L174g/Wrelp1Xn3ve6f6nu9nQQyCUg3d+kC3fcMYTiz62htbYo4n/WzEd6i2L
        bcdZGnfycIZn8+P9KlIsvQdEAXgztfjuDDjyk4sgI4qFpPAvXJ97Pd1C2jPad1B/
        ifEOThnz+KVyKBH3SMRl9BJ31wgKWzThlYTxsLU3tip5ei7noVDSqnUou9qS3doG
        nr9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694272714; x=1694279914; bh=vYLOo58Iptv/F
        kcVRywLSH84q+eDgwPgYFmT3FsJ9xY=; b=ADFjWIHJXiB7QkuSltA3ZOTDmxbrk
        QI5ov4HYSdPTBtyNlX0kW4sn3Ji0Z60r2jqHvwwf6NbO17/N1kOaeNb+64ciLsud
        tS9KrC1KaGeBBZVjFE3BUtyWHO6NuTMvxXvefLImRlvugm6mrG10n8rCzsD4Vo5a
        R65j41ZUCDRqiqdYGhS64j0ZbHf++80pz7Hga0kdzi0x0XCP5xRlvPSuRH/BMFaL
        o6uGcijgWBwI+gqZMt8jcfhMu1xtlmqvYzrLZcEZDVDkpdcIxY8ONjfaDtYrPwvR
        IIi+8q2bS3i9k5qFORUrUH9Fw2emvEsNXiNPv1IcWkr4EtgBTGQuBLSpA==
X-ME-Sender: <xms:yYz8ZMfwcXncPEHro1kBz6-PeXUeI3sAQSMV9hLkxk1R8eNnNP-dmA>
    <xme:yYz8ZONqQOXno3MtFMLa4i6SzW2ImuFzW-wOEJ-_lCJZCVZ8WjqkAfPcPqjRC8mWJ
    BbcXGdJBAdz3K4QDqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yYz8ZNjMGdd69pqDui8IgW3d0ups0C1gdH6tcMXvq19HU0MsmierRQ>
    <xmx:yYz8ZB-0CTDI0ph9tdfO7YieUU20C9QieSNAF6y6umnbfJn8yg5MEg>
    <xmx:yYz8ZItPzVZjG2Zg7v5d6Hk1-KeiOCBJqwXlU2hIKKSsUsj2pXTveQ>
    <xmx:yoz8ZJFd_FLQMqWD_Cuzga5iAHhjgUjUjuUKKiyCPZhGGQ6cNvsoXACWXV8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54359B60089; Sat,  9 Sep 2023 11:18:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <2fe03345-01a2-4cfe-9648-ae088493d1af@app.fastmail.com>
In-Reply-To: <ZPrRcJCjRBvJ9c3N@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
 <ZPrRcJCjRBvJ9c3N@memverge.com>
Date:   Sat, 09 Sep 2023 17:18:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gregory.price@memverge.com>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 8, 2023, at 09:46, Gregory Price wrote:
> On Sat, Sep 09, 2023 at 10:03:33AM +0200, Arnd Bergmann wrote:
>> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> > index 22bc6bc147f8..6860675a942f 100644
>> > --- a/include/linux/syscalls.h
>> > +++ b/include/linux/syscalls.h
>> > @@ -821,6 +821,11 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned 
>> > long nr_pages,
>> >  				const int __user *nodes,
>> >  				int __user *status,
>> >  				int flags);
>> > +asmlinkage long sys_move_phys_pages(unsigned long nr_pages,
>> > +				    const void __user * __user *pages,
>> > +				    const int __user *nodes,
>> > +				    int __user *status,
>> > +				    int flags);
>> 
>> The prototype looks good from a portability point of view,
>> i.e. I made sure this is portable across CONFIG_COMPAT
>> architectures etc.
>> 
>> What I'm not sure about is whether the representation of physical
>> memory pages as a 'void *' is a good choice, I can see potential
>> problems with this:
>> 
>> - it's not really a pointer, but instead a shifted PFN number
>>   in the implementation
>> 
>> - physical addresses may be wider than pointers on 32-bit
>>   architectures with CONFIG_PHYS_ADDR_T_64BIT
>> 
>
> Hm, good points.
>
> I tried to keep the code close to move_pages for the sake of
> familiarity and ease of review, but the physical address length
> is not something i'd considered, and I'm not sure how exactly
> we would handle CONFIG_PHYS_ADDR_T_64BIT.  If you have an idea,
> I'm happy to run with it.

I think a pointer to '__u64' is the most appropriate here,
that is compatible between 32-bit and 64-bit architectures
and covers all addresses until we get architectures with
128-bit addressing.

Thinking about it more, I noticed an existing bug in
both sys_move_pages and your current version of
sys_move_phys_pages: the 'pages' array is in fact not
suitable for compat tasks and needs an is_compat_task
check to load a 32-bit address from compat userspace on
the "if (get_user(p, pages + i))" line.

> on address vs pfn:
>
> Would using PFNs cause issues with portability of userland code? User
> code that gets access to a physical address would have to convert
> that to a PFN, which would be kernel-defined.  That could be easy
> enough if the kernel exposed the shift size somewhere.

I don't think we currently use PFN anywhere in the syscall
ABI, so this introduces a new basic type into uapi headers that
is currently kernel internal.

A 32-bit PFN is always sufficient to represent all physical
addresses on native 32-bit kernel, but not necessarily for
compat user space on 64-bit kernels with an address space wider
than 44 bits (16 terabyte address range).

For the interface it would also require the same quirk
for compat tasks that I pointed out above that is missing
in sys_move_pages today.

A minor quirk of PFN values is that they require knowing
the page size to convert addresses, but I suppose you need
that anyway.

>> I'm also not sure where the user space caller gets the
>> physical addresses from, are those not intentionally kept
>> hidden from userspace?
>> 
>
> There are presently 4 places (that I know of), and 1 that is being
> proposed here in the near future
>
> 1) Generally: /proc/pid/pagemap can be used to do page table
>      translations.  I think this is only really useful for testing, 
>      since if you have the virtual address and pid you would use
>      move_pages, but it's certainly useful for testing this.
>
> 2) X86:  IBS (AMD) and PEBS (Intel) can be configured to return physical
>      address information instead of virtual address information. In fact
>      you can configure it to give you both the virtual and physical
>      address for a process.

Ah right. I see these already require CAP_SYS_ADMIN permissions
because of the risk of rowhammer or speculative execution attacks,
so I suppose users of move_phys_pages() would need additional
permissions compared to move_pages() to actually use that information.

> 3) zoneinfo:  /proc/zoneinfo exposes the start PFN of zones
>
> 4) /sys/kernel/mm/page_idle:  A way to query whether a PFN is idle.
>      While itself seemingly not useful, if the goal is to migrate
>      less-used pages to "lower tiers" of memory, then you can query
>      the bitmap, directly recover idle PFNs, and attempt to migrate
>      them (which may fail, for a variety of reasons).
>
>      https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html
>
>
> 5) CXL (Proposed): a CXL memory device on the PCIe bus may provide
>      hot/cold information about its memory.  If a heatmap is provided,
>      for example, it would have to be a device address (0-based) or a
>      physical address (some base defined by the kernel and programmed
>      into device decoders such that it can convert them to 0-based).
>
>      This is presently being proposed but has not been agreed upon yet.

These do not seem to be problematic from the ASLR perspective, so
I guess it may still be useful without CAP_SYS_ADMIN.

     Arnd
