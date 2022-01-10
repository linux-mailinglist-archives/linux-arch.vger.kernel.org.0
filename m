Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79148A125
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiAJUxZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 15:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbiAJUxY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 15:53:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28FC06173F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 12:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC1A6144E
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 20:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EB3C36AE3;
        Mon, 10 Jan 2022 20:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641848003;
        bh=0PW5r2nP460ugTGZVLLTEhHzGNNGpRMC9O/OqvQe9os=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=pCmSKdi+bgYvC07R1azklpA2Fy2qqBRuFn2xNiw0cwTHQCzZHlDNuar0TCQDuHY2m
         H8eUUSkX0QprEZELN7hLsN4hJG6bobmfYhaywHGde0PhVbQBXA8qQdZxWx02W53dPH
         B6eICKx5HvMCNt0ku7ffCPS/BIit3JjMN/fzO2pfQbJNjuZZr2dOsgMbeTGgxRBUqy
         OhFSfvBkjR2P/3ZHOlNE83mx9xxiIIxAr/cE9kgP+IFB7kjMxq71Y+J5UvFLO5NId+
         U+LahHw7uV6cPwc98WdodXl7HTsk2mFAZmLOP/tAuimoQ7W85xJcWRoqEd1oEpC0iJ
         bm+yfuc7J6I+w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 657B627C0054;
        Mon, 10 Jan 2022 15:53:21 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Mon, 10 Jan 2022 15:53:21 -0500
X-ME-Sender: <xms:wJzcYeEMKQuZ2hAxwn_b-1YXx7-aa2-wLZGUchJq3C9caYzgBAt0OA>
    <xme:wJzcYfW9budBt33y2jYkQvdOZXXQzpdw4sB1Wf9WFeOXW0YnXCZ08lX6J7AGPmeF-
    zO1naVNL9PNBxYP5yI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:wJzcYYJXDZQFVb43hTaH5UAI4qv5NIHc2iuNZCnQLygZbPohBn5amA>
    <xmx:wJzcYYF6CLPut9z6nftt0cyFWo8cI-IuKemOX8wnGKbnSrn7a8LE5w>
    <xmx:wJzcYUXT2-HPjRH6WQnEK6XNTvWPNSFVHUKQgfDBBLxgjWdfhNtiLQ>
    <xmx:wZzcYVu-QpiBSn1CuSvH1ELkaRi7ks7o_SU-7aKwlBG_bVfaPcnMKiNmEGue96V7>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A744D21E0073; Mon, 10 Jan 2022 15:53:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4527-g032417b6d6-fm-20220109.002-g032417b6
Mime-Version: 1.0
Message-Id: <0d905aef-f53c-4102-931f-a22edd084fae@www.fastmail.com>
In-Reply-To: <1641790309.2vqc26hwm3.astroid@bobo.none>
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
 <1641790309.2vqc26hwm3.astroid@bobo.none>
Date:   Mon, 10 Jan 2022 12:52:49 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Anton Blanchard" <anton@ozlabs.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rik van Riel" <riel@surriel.com>, "Will Deacon" <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sun, Jan 9, 2022, at 8:56 PM, Nicholas Piggin wrote:
> Excerpts from Linus Torvalds's message of January 10, 2022 7:51 am:
>> [ Ugh, I actually went back and looked at Nick's patches again, to
>> just verify my memory, and they weren't as pretty as I thought they
>> were ]
>>=20
>> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I'd much rather have a *much* smaller patch that says "on x86 and
>>> powerpc, we don't need this overhead at all".
>>=20
>> For some reason I thought Nick's patch worked at "last mmput" time and
>> the TLB flush IPIs that happen at that point anyway would then make
>> sure any lazy TLB is cleaned up.
>>=20
>> But that's not actually what it does. It ties the
>> MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
>> last mmdrop() instead. Because it really tied the whole logic to the
>> mm_count logic (and made lazy tlb to not do mm_count) rather than the
>> mm_users thing I mis-remembered it doing.
>
> It does this because on powerpc with hash MMU, we can't use IPIs for
> TLB shootdowns.

I know nothing about powerpc=E2=80=99s mmu. If you can=E2=80=99t do IPI =
shootdowns, it sounds like the hazard pointer scheme might actually be p=
retty good.

>
>> So at least some of my arguments were based on me just mis-remembering
>> what Nick's patch actually did (mainly because I mentally recreated
>> the patch from "Nick did something like this" and what I thought would
>> be the way to do it on x86).
>
> With powerpc with the radix MMU using IPI based shootdowns, we can=20
> actually do the switch-away-from-lazy on the final TLB flush and the
> final broadcast shootdown thing becomes a no-op. I didn't post that
> additional patch because it's powerpc-specific and I didn't want to
> post more code so widely.
>
>> So I guess I have to recant my arguments.
>>=20
>> I still think my "get rid of lazy at last mmput" model should work,
>> and would be a perfect match for x86, but I can't really point to Nick
>> having done that.
>>=20
>> So I was full of BS.
>>=20
>> Hmm. I'd love to try to actually create a patch that does that "Nick
>> thing", but on last mmput() (ie when __mmput triggers). Because I
>> think this is interesting. But then I look at my schedule for the
>> upcoming week, and I go "I don't have a leg to stand on in this
>> discussion, and I'm just all hot air".
>
> I agree Andy's approach is very complicated and adds more overhead than
> necessary for powerpc, which is why I don't want to use it. I'm still
> not entirely sure what the big problem would be to convert x86 to use
> it, I admit I haven't kept up with the exact details of its lazy tlb
> mm handling recently though.

The big problem is the entire remainder of this series!  If x86 is going=
 to do shootdowns without mm_count, I want the result to work and be mai=
ntainable. A few of the issues that needed solving:

- x86 tracks usage of the lazy mm on CPUs that have it loaded into the M=
MU, not CPUs that have it in active_mm.  Getting this in sync needed cor=
e changes.

- mmgrab and mmdrop are barriers, and core code relies on that. If we ge=
t rid of a bunch of calls (conditionally), we need to stop depending on =
the barriers. I fixed this.

- There were too many mmgrab and mmdrop calls, and the call sites had di=
fferent semantics and different refcounting rules (thanks, kthread).  I =
cleaned this up.

- If we do a shootdown instead of a refcount, then, when exit() tears do=
wn its mm, we are lazily using *that* mm when we do the shootdowns. If a=
ctive_mm continues to point to the being-freed mm and an NMI tries to de=
reference it, we=E2=80=99re toast. I fixed those issues.

- If we do a UEFI runtime service call while lazy or a text_poke while l=
azy and the mm goes away while this is happening, we would blow up. Refc=
ounting prevents this but, in current kernels, a shootdown IPI on x86 wo=
uld not prevent this.  I fixed these issues (and removed duplicate code).

My point here is that the current lazy mm code is a huge mess. 90% of th=
e complexity in this series is cleaning up core messiness and x86 messin=
ess. I would still like to get rid of ->active_mm entirely (it appears t=
o serve no good purpose on any architecture),  it that can be saved for =
later, I think.
