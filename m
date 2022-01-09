Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240F488C4C
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 21:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiAIUeT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 15:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiAIUeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 15:34:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A839BC06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 12:34:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s15so8986471pfk.6
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IyjVliw9s696kRZB/QLeKMSxq5UJgw6Khm/VAr8RauQ=;
        b=QkwjEWKRB54fs1Ng+rV42lgLJVyLc7Nx+rISn2U5YvfLIMmK9jEQ05t4wFKGeCR3BP
         AJ0t12d7y1lkoZhJ1EPe6NKr4RPFd9VO7wxHk0Vu8xUfVmV7dq6CTxCj/K790UI+D/Vp
         oA4FqP0n3zTueZVfUh4+GMePK4tP6JfiB2a4/JB6MK0JgJC5k85OLJ45fMdyiyE76WG5
         x4/kkorbYeOWEyuZT4sTRpKkf1Kpf8TQ98sztnrCEHNfwkzZGgLahn7IMaGKQwqpzHZN
         ZASobw9UvA2zGGoQlzCC/wrmt8z6gI9EfP+3Jy7MbsIpXROlB/SSdrcaFGgKdURv1EmH
         6quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IyjVliw9s696kRZB/QLeKMSxq5UJgw6Khm/VAr8RauQ=;
        b=vSwoEKFuNS3dGX1PDcpO9/UKMjFmO6rOzMr5hVpXdspv+k3AArrl7Hyai2dOfz+kVl
         r66Tm5AA1jotC99u53r+bbH8ha5dB2hvdOs8a5q+01fdlBW0p6ucJpysbZ5zAYsIUNjj
         3ijLmSGINYc9Z3jPBTYGmcG7Ca1MSwgzWT1qSXg8KhDePIIg2ImWXhFJpsV0Zz/Q8AuX
         McNnwFAdx9QbxDoCpXVjvt4Y06s7sMgSwie7Vpd5am5hG34JLQO/gOII5kAg/exQ7AMB
         G67c8rlWWQyUYoj4T381eWeG8kH8+mtDNXtTWJR+ofpWRYTODH5I3qDTtW7375W0PoBk
         Uk6A==
X-Gm-Message-State: AOAM530suUpGUKbmJ/4g+/XyI2TvV5nPn6TWshLRr8WUiUplDzVycww9
        vQnIvN+TnBiWGYRt4xcOBcs=
X-Google-Smtp-Source: ABdhPJzCOtBYtlvHzWgZIm0xZ3/oUi3BFDBMsuS9sjcW7ngBA5yQpVoURDt3XbrmUithkD0A/K1DSA==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr55155833pgc.503.1641760457978;
        Sun, 09 Jan 2022 12:34:17 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g5sm4689939pfj.143.2022.01.09.12.34.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 12:34:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <355c148c-06a8-4e15-a77b-0ea2e22bf708@www.fastmail.com>
Date:   Sun, 9 Jan 2022 12:34:15 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B23F7F5-96F1-4E2C-8C17-0ECC21CA14C6@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
 <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
 <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
 <355c148c-06a8-4e15-a77b-0ea2e22bf708@www.fastmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 9, 2022, at 11:52 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Sun, Jan 9, 2022, at 11:10 AM, Linus Torvalds wrote:
>> On Sun, Jan 9, 2022 at 12:49 AM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>>=20
>>> I do not know whether it is a pure win, but there is a tradeoff.
>>=20
>> Hmm. I guess only some serious testing would tell.
>>=20
>> On x86, I'd be a bit worried about removing lazy TLB simply because
>> even with ASID support there (called PCIDs by Intel for NIH reasons),
>> the actual ASID space on x86 was at least originally very very
>> limited.
>>=20
>> Architecturally, x86 may expose 12 bits of ASID space, but iirc at
>> least the first few implementations actually only internally had one
>> or two bits, and hashed the 12 bits down to that internal very =
limited
>> hardware TLB ID space.
>>=20
>> We only use a handful of ASIDs per CPU on x86 partly for this reason
>> (but also since there's no remote hardware TLB shootdown, there's no
>> reason to have a bigger global ASID space, so ASIDs aren't _that_
>> common).
>>=20
>> And I don't know how many non-PCID x86 systems (perhaps virtualized?)
>> there might be out there.
>>=20
>> But it would be very interesting to test some "disable lazy tlb"
>> patch. The main problem workloads tend to be IO, and I'm not sure how
>> many of the automated performance tests would catch issues. I guess
>> some threaded pipe ping-pong test (with each thread pinned to
>> different cores) would show it.
>=20
> My original PCID series actually did remove lazy TLB on x86.  I don't =
remember why, but people objected.  The issue isn't the limited PCID =
space -- IIRC it's just that MOV CR3 is slooooow.  If we get rid of lazy =
TLB on x86, then we are writing CR3 twice on even a very short idle.  =
That adds maybe 1k cycles, which isn't great.

Just for the record: I just ran a short test when CPUs are on max freq
on my skylake. MOV-CR3 without flush is 250-300 cycles. One can argue
that you mostly only care for one of the switches for the idle thread
(once you wake up). And waking up by itself has its overheads.

But you are the master of micro optimizations, and as Rik said, I
mostly think of TLB shootdowns and might miss the big picture. Just
trying to make your life easier by less coding and my life simpler
in understanding your super-smart code. ;-)

