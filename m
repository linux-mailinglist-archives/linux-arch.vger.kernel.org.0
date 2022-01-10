Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788D0488D91
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 01:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiAJAxG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 19:53:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47840 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiAJAxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 19:53:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C5DAB81053
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 00:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D763C36AF2;
        Mon, 10 Jan 2022 00:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641775983;
        bh=BauJqSgB/c/WvTGy2CsGlWb+czkFpCo3Hty1Af1jVeg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=m6K7kO8/iUiObsEI2TqWeHurmbTLD2h5N+5hqY2GjEttLgBoKWXhjaN2FZdyvhxyy
         l0Hq3UHuWrKQFwq+1IhcILAsImHfXH/+itTM4bumgGNqgpk1dg2ipj8f6Iy/AqiI/2
         /QacFrgtSmok+jLqPc9aaK8oDC8EeOX8ZlePZur08BYhdlQnD/tWqU2C/sW1omoI8u
         NACkmlQhjqUoeBBomlKMQPVFiEVxU/f+SnumLgDFm9YJfEYCfPKU4jUisyG8BWFlEB
         PW4AGl824AVOHXd0mSnhe7waIRSxKk1Newt7VnnT6u+H4r7vl2e40O5+KVLAC37Ssi
         +90nu7pwTA4Dg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 18B8827C005B;
        Sun,  9 Jan 2022 19:53:01 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sun, 09 Jan 2022 19:53:01 -0500
X-ME-Sender: <xms:bIPbYQIGvfvMXfvWY4YrpKmoh5cZ8NnfQUu-mcfQB91WdAkYWaqjPQ>
    <xme:bIPbYQJ3r5DMmcTw4dNPs1hqVl051bGQyRsl1Y38EfxzYtqHk8DDbC1--yxiFgBl8
    2H4Ec730o1Ng22t1ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegledgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:bIPbYQvQ2aiYax5N7UraP3WQrWiHqfSUvbErOCSPxZKNXzt969RzgA>
    <xmx:bIPbYdbiri7_EDODue8cjUBhsirtw6Ngw8Og4VUzoZo19V9rWm_ejg>
    <xmx:bIPbYXadzu0hS0CiNXNkxrID1PjGGAFK0o8Xmn1NmPgfGfcQOjHbrA>
    <xmx:bIPbYdzsaT1WBo-de8k5QOy3yLfoRVeWHRTaHYNX-aTWB4BJzdalg5SyUImOmT3V>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1927521E006E; Sun,  9 Jan 2022 19:52:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <00f58dff-9df5-45ac-a078-d852f13b1dfe@www.fastmail.com>
In-Reply-To: <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
 <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
 <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
 <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
 <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
Date:   Sun, 09 Jan 2022 17:52:39 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Anton Blanchard" <anton@ozlabs.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022, at 1:51 PM, Linus Torvalds wrote:
> [ Ugh, I actually went back and looked at Nick's patches again, to
> just verify my memory, and they weren't as pretty as I thought they
> were ]
>
> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'd much rather have a *much* smaller patch that says "on x86 and
>> powerpc, we don't need this overhead at all".

I can whip this up.  It won=E2=80=99t be much smaller =E2=80=94 we still=
 need the entire remainder of the series as prep, and we=E2=80=99ll end =
up with an if (arch needs mmcount) somewhere, but it=E2=80=99s straightf=
orward.

But I reserve the right to spam you with an even bigger patch, because m=
m_cpumask also pingpongs, and I have some ideas for helping that out too.

Also:

>> exit_mmap();
>> for each cpu still in mm_cpumask:
>>   smp_load_acquire
>>
>> That's it, unless the mm is actually in use
>
> Ok, now do this for a machine with 1024 CPU's.
>
> And tell me it is "scalable".
>

Do you mean a machine with 1024 CPUs and 2 bits set in mm_cpumask or 102=
4 CPU with 800 bits set in mm_cpumask?  In the former case, this is fine=
.  In the latter case, *on x86*, sure it does 800 loads, but we're about=
 to do 800 CR3 writes to tear the whole mess down, so the 800 loads shou=
ld be in the noise.  (And this series won't actually do this anyway on b=
are metal, since exit_mmap does the shootdown.)
