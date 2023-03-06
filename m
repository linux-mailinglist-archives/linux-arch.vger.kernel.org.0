Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7826ACD5D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCFS6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCFS6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:58:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294837F22;
        Mon,  6 Mar 2023 10:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 10ACBCE1727;
        Mon,  6 Mar 2023 18:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EB5C433D2;
        Mon,  6 Mar 2023 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678129050;
        bh=6vXrvt7y3pSV5UzVc45cU2dXI063yro0+EDdwbCQfnU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=oTQSZEZgHcfYMEKuFyrO+0WbZv9W+W+iIfSFWSVUsjZRI1P86YeZim1S3X6MRab5s
         8WMGKLgSS2Jf7xVMkKCMcYYWq0BMvdT+LvXeDKxwENDftxflzdjx55Ebwh6Thqr5Mk
         vqA1twovNE7Khq55t/YdVKVGl1PiCEjLiaufAVGp8FSdXulPlnV4Hh/ic9KfLtW8C2
         TUHB0U7rb/UH0AMb2QdnQuZgd9Lf0uAlyvMNbFsgAkMzXFS97lURf0X4wZ1lHWjdtQ
         qFmfHv8UaF5rZXrLqgcsxCdZ+VCRxvY8SSUqBrWGUoz16tXpgW7pZLVBqeZIqRXXjJ
         9ZXbyKKGvRg0Q==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7654827C0054;
        Mon,  6 Mar 2023 13:57:28 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 06 Mar 2023 13:57:28 -0500
X-ME-Sender: <xms:ljcGZHkD9Azx8CnjaQr1OAMo85lvkMQHnS1OGc59t2xI0LLFXIo6zg>
    <xme:ljcGZK1Mhih9tBQOYsihBve47qe1Vfw6QVvj8fACKCnj3hIQap92OIHngSL3G5P42
    PhZgYfEsU9oGsOKScI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtkedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeiteejleegjeekleegveeujeejvdehjeekveegudduudffueek
    jefffeeujeekhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:ljcGZNpr7paDnSHmMFH-Gj7F5-y8Q53JTvKn0-UVV-q1eqD20cRBGw>
    <xmx:ljcGZPkzRTZmNcOa42iXgmYIyyT4fDqxGJeyrciMCneH3DJfV2_ziA>
    <xmx:ljcGZF2b-Ft6PTPRgbxnlmFOjAEg7Dj5aeKcE6lKu48F4KVEEadXDg>
    <xmx:mDcGZA55iif505_2sp6shY1Ep30GOjTS-AaJfQpumw6W_iDd0bNPWw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B80BE31A0063; Mon,  6 Mar 2023 13:57:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <2361d4e2-c8c9-4dc4-b925-ab6543ba3404@app.fastmail.com>
In-Reply-To: <c3e21d54fdc025c8e09f90b57dd3de0751cefbfd.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-25-rick.p.edgecombe@intel.com>
 <ZAXmOZYcoR3hq/CH@zn.tnic>
 <CALCETrViDpTbuBk+9wQa-PNzKZerwk=4MmKMXw2v3Ysxuv2k3A@mail.gmail.com>
 <c3e21d54fdc025c8e09f90b57dd3de0751cefbfd.camel@intel.com>
Date:   Mon, 06 Mar 2023 10:57:06 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Borislav Petkov" <bp@alien8.de>
Cc:     "David Hildenbrand" <david@redhat.com>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Jann Horn" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>, "Oleg Nesterov" <oleg@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack memory
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 6, 2023, at 10:33 AM, Edgecombe, Rick P wrote:
> On Mon, 2023-03-06 at 10:15 -0800, Andy Lutomirski wrote:
>> On Mon, Mar 6, 2023 at 5:10=E2=80=AFAM Borislav Petkov <bp@alien8.de>=
 wrote:
>> >=20
>> > On Mon, Feb 27, 2023 at 02:29:40PM -0800, Rick Edgecombe wrote:
>> > > The x86 Control-flow Enforcement Technology (CET) feature
>> > > includes a new
>> > > type of memory called shadow stack. This shadow stack memory has
>> > > some
>> > > unusual properties, which requires some core mm changes to
>> > > function
>> > > properly.
>> > >=20
>> > > Shadow stack memory is writable only in very specific, controlled
>> > > ways.
>> > > However, since it is writable, the kernel treats it as such. As a
>> > > result
>> >=20
>> >                                                                   =20
>> >         ^
>> >                                                                   =20
>> >         ,
>> >=20
>> > > there remain many ways for userspace to trigger the kernel to
>> > > write to
>> > > shadow stack's via get_user_pages(, FOLL_WRITE) operations. To
>> > > make this a
>>=20
>> Is there an alternate mechanism, or do we still want to allow
>> FOLL_FORCE so that debuggers can write it?
>
> Yes, GDB shadow stack support uses it via both ptrace poke and
> /proc/pid/mem apparently. So some ability to write through is needed
> for debuggers. But not CRIU actually. It uses WRSS.
>
> There was also some discussion[0] previously about how apps might
> prefer to block /proc/self/mem for general security reasons. Blocking
> shadow stack writes while you allow text writes is probably not that
> impactful security-wise. So I thought it would be better to leave the
> logic simpler. Then when /proc/self/mem could be locked down per the
> discussion, shadow stack can be locked down the same way.

Ah, I am guilty of reading your changelog but not the code.

You said:

Shadow stack memory is writable only in very specific, controlled ways.
However, since it is writable, the kernel treats it as such. As a result
there remain many ways for userspace to trigger the kernel to write to
shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this=
 a
little less exposed, block writable GUPs for shadow stack VMAs.

I read that as *denying* FOLL_FORCE.  Maybe clarify the changelog?

>
> [0]=20
> https://lore.kernel.org/lkml/E857CF98-EEB2-4F83-8305-0A52B463A661@kern=
el.org/
