Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F053488F67
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 05:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiAJE4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 23:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiAJE43 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 23:56:29 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5493C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 20:56:28 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 201so1669215pge.1
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 20:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=9c4LYJL0ShltfZWmAlvzSKrllnosm1Ej3AfwYvUpFQs=;
        b=PYUzVLvP/9GMMC8SQ7bBedzhDPu6FqFft07nkw4ttEKIjcjDtmcIfSCLZmhrTVZsf/
         h00mhTC02zYtuGsTzaJjQbvZKMKPCGRrB+BAEG767xletiwlTEml+QixRsj4mhA1FEVm
         jXlWRAr1LWWrBwF+EboHA44XIrThs38jKwq7f8ieZhKqETI80ASBWwjpsC4zO0a+LB5X
         JBWAxYd3ICX+FyRiMAfFbtFo3hh8tjAQGEyBasbqRLWf+WiwqL3DH4o24WpglBk+89fA
         hHsWq5NPc0a4rEZTcI7VHknGoj31tbNIWDNf8EzxEm3wBmDU0pWneT2zxN4+7rEGMnq/
         U17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=9c4LYJL0ShltfZWmAlvzSKrllnosm1Ej3AfwYvUpFQs=;
        b=6Di6uNr3RzAOWPYX36SCoqkeSv3KO33yNAMMvQNMY3hIHx0Ad+XYFyIZ6WRH+f9/F0
         XVLHprJQVqfWXiCu3Nr+dCJ8CMHJSjIgK5muasSWgID/3bRZxRsCEGFIpRnm0+Amennb
         U8jRGqw6Da2DYFV4KPaz0r45nsbfQQT89TUDZEKf6vVKvEVl4/yr5RoQrUL2p7FHUVPS
         LQv6JVwajDXdoa5pwEBtpMtPlJcFqBhCsZjyzx7E6vTviiFgicx7lItdvF1TsPG7f8RB
         9fZIc3fU0J6yDiF3HCe1GJbLGWqYPr17lrLlNcqrJpvW2++nMgkBxFI2Xcz43ENx5y5z
         HzRw==
X-Gm-Message-State: AOAM533d9ECznC6WS7PHIi0C+lhXbDUdUqn0+IzxbAtSHq854a07Cg6Q
        q7oBQfZBw833O2U2iOwQ2t0=
X-Google-Smtp-Source: ABdhPJzB+kfugplmfiZ1j8U8tFMgrVnA5Hn0FQs0n9ajeArz/H99RaZ+x/LfDnva5g3puVGBTBNFvw==
X-Received: by 2002:aa7:9510:0:b0:4bd:ce79:d158 with SMTP id b16-20020aa79510000000b004bdce79d158mr6179326pfp.24.1641790588419;
        Sun, 09 Jan 2022 20:56:28 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id v4sm6620100pjk.38.2022.01.09.20.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 20:56:28 -0800 (PST)
Date:   Mon, 10 Jan 2022 14:56:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
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
In-Reply-To: <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1641790309.2vqc26hwm3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Linus Torvalds's message of January 10, 2022 7:51 am:
> [ Ugh, I actually went back and looked at Nick's patches again, to
> just verify my memory, and they weren't as pretty as I thought they
> were ]
>=20
> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'd much rather have a *much* smaller patch that says "on x86 and
>> powerpc, we don't need this overhead at all".
>=20
> For some reason I thought Nick's patch worked at "last mmput" time and
> the TLB flush IPIs that happen at that point anyway would then make
> sure any lazy TLB is cleaned up.
>=20
> But that's not actually what it does. It ties the
> MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
> last mmdrop() instead. Because it really tied the whole logic to the
> mm_count logic (and made lazy tlb to not do mm_count) rather than the
> mm_users thing I mis-remembered it doing.

It does this because on powerpc with hash MMU, we can't use IPIs for
TLB shootdowns.

> So at least some of my arguments were based on me just mis-remembering
> what Nick's patch actually did (mainly because I mentally recreated
> the patch from "Nick did something like this" and what I thought would
> be the way to do it on x86).

With powerpc with the radix MMU using IPI based shootdowns, we can=20
actually do the switch-away-from-lazy on the final TLB flush and the
final broadcast shootdown thing becomes a no-op. I didn't post that
additional patch because it's powerpc-specific and I didn't want to
post more code so widely.

> So I guess I have to recant my arguments.
>=20
> I still think my "get rid of lazy at last mmput" model should work,
> and would be a perfect match for x86, but I can't really point to Nick
> having done that.
>=20
> So I was full of BS.
>=20
> Hmm. I'd love to try to actually create a patch that does that "Nick
> thing", but on last mmput() (ie when __mmput triggers). Because I
> think this is interesting. But then I look at my schedule for the
> upcoming week, and I go "I don't have a leg to stand on in this
> discussion, and I'm just all hot air".

I agree Andy's approach is very complicated and adds more overhead than
necessary for powerpc, which is why I don't want to use it. I'm still
not entirely sure what the big problem would be to convert x86 to use
it, I admit I haven't kept up with the exact details of its lazy tlb
mm handling recently though.

Thanks,
Nick
