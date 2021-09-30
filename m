Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BFD41E029
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352659AbhI3R3E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 13:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352606AbhI3R3E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 13:29:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 595EB6137A;
        Thu, 30 Sep 2021 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633022841;
        bh=/0C11BR2NcWcrknqe3Jef9DMxhZDB9pEs6MHYZPMVss=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=JY3R+b3M4LV4FvPcQQ9Wn7grCq2Z36+1IxMR8ecV+Y7EQTZLwP0xcj+F0R6a/702z
         pNRt+ec6zFQkS36emeXZS4SF+8ZC/7r+qf5ExF6j3xALFDfDRpwsePsiK/FO92qrtP
         b8KJKarrsxoIPxh5S3GlhnsrAkrFrQkwy3DJH23vClkLI+Dp7Zr2fSuIhJOF3NoXJU
         s+agUlcSuV6mYAdTnahSi8DUh47FKXIsnBOPPDp+GdwpWQpM32CiRjNCg5gLqZ/JEy
         XTl4SSiSJC3ajOaruB+72dNH/uH5GafOdbw4aRsfkKT99lNsI6WFC/VRmh6G5txK67
         sxRlGi7uycXGQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 67C2827C007B;
        Thu, 30 Sep 2021 13:27:18 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 30 Sep 2021 13:27:18 -0400
X-ME-Sender: <xms:dfNVYV7vrUnN9XIzk7mylcbKYQwGbt3UXBgRPRf7xyGid4ST7NMYYA>
    <xme:dfNVYS57uxrJ9VAzy9PhgRJU0OQF_yHZNzqQH-UuK74sOjLe7cZk5J3Z-ZNHyt4DI
    MtMymVHiX0bBG9TPqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:dfNVYcceRzxnGFtGVDGetyZvcFnwvgBlJQIjasDPRT-dh_2pnLTM2A>
    <xmx:dfNVYeJQRsbhOnGGGJeDrq3uuBZH8BwMwTVWDcSUOj6hbfMU2uYXwQ>
    <xmx:dfNVYZJAN2GV7R9Kjeo8PPu1xI0YzNslIgPBKeHZd6o_D7VwRSN_qg>
    <xmx:dvNVYW7wX7ozg-K_PbsIX-cQdXveJHHHIyZ2XlhiYESUfa_n4KwBDjJiI14>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3CD8621E0063; Thu, 30 Sep 2021 13:27:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1322-g921842b88a-fm-20210929.001-g921842b8
Mime-Version: 1.0
Message-Id: <c8d69bc1-55eb-44c3-bf97-c5c4c475fded@www.fastmail.com>
In-Reply-To: <778d40fe-ad8e-fd7c-4caa-499910bb0925@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <456bf9cf-87b8-4c3d-ac0c-7e392bcf26de@www.fastmail.com>
 <YVXmGTo5Uzp44QQq@stefanha-x1.localdomain>
 <778d40fe-ad8e-fd7c-4caa-499910bb0925@intel.com>
Date:   Thu, 30 Sep 2021 10:26:55 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sohil Mehta" <sohil.mehta@intel.com>,
        "Stefan Hajnoczi" <stefanha@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Christian Brauner" <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Shuah Khan" <shuah@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        "Zeng Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Randy E Witt" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Ramesh Thomas" <ramesh.thomas@intel.com>,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Thu, Sep 30, 2021, at 10:24 AM, Sohil Mehta wrote:
> On 9/30/2021 9:30 AM, Stefan Hajnoczi wrote:
>> On Tue, Sep 28, 2021 at 09:31:34PM -0700, Andy Lutomirski wrote:
>>>
>>> I spent some time reviewing the docs (ISE) and contemplating how this all fits together, and I have a high level question:
>>>
>>> Can someone give an example of a realistic workload that would benefit from SENDUIPI and precisely how it would use SENDUIPI?  Or an example of a realistic workload that would benefit from hypothetical device-initiated user interrupts and how it would use them?  I'm having trouble imagining something that wouldn't work as well or better by simply polling, at least on DMA-coherent architectures like x86.
>> I was wondering the same thing. One thing came to mind:
>>
>> An application that wants to be *interrupted* from what it's doing
>> rather than waiting until the next polling point. For example,
>> applications that are CPU-intensive and have green threads. I can't name
>> a real application like this though :P.
>
> Thank you Stefan and Andy for giving this some thought.
>
> We are consolidating the information internally on where and how exactly 
> we expect to see benefits with real workloads for the various sources of 
> User Interrupts. It will take a few days to get back on this one.

Thanks!

>
>
>> (I can imagine some benefit to a hypothetical improved SENDUIPI with idential user semantics but that supported a proper interaction with the scheduler and blocking syscalls.  But that's not what's documented in the ISE...)
>
> Andy, can you please provide some more context/details on this? Is this 
> regarding the blocking syscalls discussion (in patch 11) or something else?
>

Yes, and I'll follow up there.  I hereby upgrade my opinion of SENDUIPI wakeups to "probably doable but maybe not in a nice way."
