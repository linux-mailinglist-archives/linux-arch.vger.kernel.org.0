Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4911F686183
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 09:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBAIVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 03:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBAIVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 03:21:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A395EF93;
        Wed,  1 Feb 2023 00:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675239667; bh=nIEY4apzyLlyWFMN72KR8ORW9CNCVCN52QajOPlyYwo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oNssR/eW4U9i93XZzC5okbhpAN2K77250ebKPHGyTHgYZVg0h7/eya3oIjVUEKet8
         YkXvoovEvA9ET/m5WAvowjldMBpROQazTxIRROKH5hTsxNlMUuJ1zLGycZb93yrmhP
         cY0vkmU5Z248n1q9vydZL5GAHWSoaZneQGZVcW1q5CAODuJkWXfForETMMB37gCBJa
         qnmXTfHKMvZ7yjpS5ye5UbXQCTqwVd28JIjjnnvbi4UGfDzdICB2MS19N2lWmptv0z
         Z8GH9HkDOqsZXi/EXX9rufAqfNd/4dL8Cm5U2vq8s9KZRfUivXRqY2dzWt4BEZyrJv
         9niLw33Pf3iQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.144.73]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1pH7Hh12fm-008NFj; Wed, 01
 Feb 2023 09:21:07 +0100
Message-ID: <8f60f7d8-3e2f-2a91-c7a3-6a005d36d7d3@gmx.de>
Date:   Wed, 1 Feb 2023 09:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VJjTp2f4w/U81CommQGsYVR97pmOEtKM3VseSorFkmrHtlYdJlM
 i3Tn8DYOGFSfdC+kVEAZ0/IKHCB6dV9MUVaLeSV1syyJGt/YgCAusweR1VWRBoG96dAULMC
 7oCXZgwWBpRp9fHxaFIphLkLoDyKW85fn6rXhNHvEAJUaen/R5RUsxaDTzom7JmQCtVmh9U
 U8Z1CE/kj+ng0pE19O48g==
UI-OutboundReport: notjunk:1;M01:P0:4jbCVgdATAs=;2LiFtZfsiJkpqHBubFQf4Ijy5AM
 R1g603I/+h3xXVpxLkbJ2Eqaqz6D9IaMQmvdGdpm3xy1OIt63CorGkMtiWi0t7g1fRxyfmEQi
 UjBcpGv57Fekspcu+tKpMpok/FaAHXLc+kq62Ys7zTFymlD6TGo+ciiS7Rt9HZo+3FMBKXv1s
 R7tlXacePKF9HZjFN/S6e73hxwVuTC6Nv29uFsvseB8dKo6DCd9CDeUovplKmTkB+0HwT+R5F
 QKGykydKD2qkyAsNkgji/6NRv0k/Bh1L01YXdju1lo+qZvcIRJxqBp8XoX+V/1lYj61ulACQR
 clHiUEw0wOPib0sQGFxiKPUb3EXTz+S99fye7+CBBFPZz7czD4zWMocCoAWIAv08SnU6hmpK8
 OuYSRJoUohXdwmzZYOhL/9VAQzmhv6GvfvFmXgA8c1w30fuRjva7dTd5QOC5sChGg29XKypwv
 tio65NvUj8UNjeC0ljR6pKBrkG3jf+efDP3LmEOHF7r2MYV0pXlNZf/e+sI521Bqsmt1dw0/t
 lHZ7J6PINf0tCKmmvxUNiHBKG2WYo3T9wnwUE34w5MO7qdU7uNNRTpc3m0CFCZMCTpxB6hXzX
 rizkD9++/uR59wZvjhTeEZFAyaywfVb82bGxkcRB/Rkh3hWQRQlaedzokMteUpX12HaH7nfju
 Fc5QY9yW0pdqGHUpYsbSqf973amoWOuGKX+g6DkweMaw3KtAKppF5ahuI9y9X7IuVWo/PVHzZ
 aXUiVgWrl+5ifgoRpCg+VOQLEl1gEHlOoJ66dTybGvgTlJgNQ42JGHsiCWmlgDDdCtHUDEpvv
 vGDZpMZ+wAWwak8bsI8PChlWhfM2dqFCnGwlPuGqemk0AiuH1WFcLuvh0TQwHECI7+bBNgDqG
 fHZ5uBcz5rhnPjnqEHstGGFnchXCxNIhjnxIgnxNeTG/hTMhXrSapKDQQFnqbggnE6yvAN/tC
 xrWvQQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/31/23 22:19, Linus Torvalds wrote:
> On Tue, Jan 31, 2023 at 1:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Umm...  What about the semantics of get_user() of unmapped address?
>> Some architectures do quiet EFAULT; some (including alpha) hit
>> the sucker with SIGBUS, no matter what.
>
> I think we should strive to just make this all common.
>
> The reason alpha is different is almost certainly not intentional, but
> a combination of "pure accident" and "nobody actually cares".
>
>> Are we free to modify that behaviour, or is that part of arch-specific
>> ABI?
>
> I'd just unify this all, probably with a preference for existing
> semantics on x86 (because of "biggest and most varied user base").
>
> That whole "send SIGBUS even for kernel faults" is certainly bogus and
> against the usual rules. And I may well be to blame for it (I have
> this memory of disliking how EFAULT as a return code didn't actually
> return the faulting address). And realistically, it's also just not
> something that any normal application will ever hit.  Giving invalid
> addresses to system calls is basically always a bug, although there
> are always special software that do all the crazy corner cases (ie
> things like emulators tend to do odd things).
>
> I doubt such special software exists on Linux/alpha, though.
>
> So I wouldn't worry about those kinds of oddities overmuch.
>
> *If* somebody then finds a load that cares, we can always fix it
> later, and I'll go "mea culpa, I didn't think it would matter, and I
> was wrong".

AFAICS, the only applications which really care about the return
code are
- testsuites like LTP (i.e. the fstat05 testcase)
- some (not just debian) packages execute tests at the end of the
   build process and verify the return codes, i.e. libsigsegv.

The differences between the architectures is currently often taken care
of via #ifdefs, so if the return code is harmonized across platforms
it would at least help to simplify such testcases.

Helge
