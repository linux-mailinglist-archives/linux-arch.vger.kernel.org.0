Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12396633E0
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 23:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjAIWYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 17:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjAIWYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 17:24:08 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF4D2D9;
        Mon,  9 Jan 2023 14:24:07 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 309MMgc91098500
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 9 Jan 2023 14:22:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 309MMgc91098500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673302968;
        bh=fnGYAzEZ9G8dLu8p7poBHQBQEB9rPQ3/UMIcvkLwwzM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WejDa96NbA9JLXU2m0szWHfgneU/slCZk5DjNVsOfl5UknDPxUHbTkZ6sEdxf59yK
         9U7HagGGXs01t5o3C3FlSBzlH9R65yjEnQPiI7DSfoLPQ7oJL3l8ONaBv4XrhO1aJL
         evjamXSvHozlp6HrXLBdZOlgNXZ8Xw68aTY+YTfrGv01tZtVjdmkWPlqx2GNapF+OU
         1XDruEvD71KM60s3EzeSPt+avCMdL8wF1t5q1SPoEzxWVG5X4JOfYhfXslqozmahes
         Kt/+GCZIfIH/ei228BT79xoMyGyyseHDKAM3bk1zKMPGAbFM3epvVbrFUoK2p6U4pt
         R82wWXoLceQRA==
Date:   Mon, 09 Jan 2023 14:22:39 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Heiko Carstens <hca@linux.ibm.com>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
References: <20221219153525.632521981@infradead.org> <20221219154119.550996611@infradead.org> <Y7Ri+Uij1GFkI/LB@osiris> <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com> <Y7xAsELYo4srs/z/@hirez.programming.kicks-ass.net> <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
Message-ID: <3C179EF2-0B8A-47F0-8FE6-3BF97A4442BA@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On January 9, 2023 2:02:33 PM PST, Linus Torvalds <torvalds@linux-foundatio=
n=2Eorg> wrote:
>On Mon, Jan 9, 2023 at 10:29 AM Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>>
>> I ran into a ton of casting trouble when compiling kernel/fork=2Ec whic=
h
>> uses this_cpu_cmpxchg() on a pointer type and the compiler hates castin=
g
>> pointers to an integer that is not the exact same size=2E
>
>Ahh=2E Yeah - not because that code needs or wants the 128-bit case, but
>because the macro expands to all sizes in a switch statement, so the
>compiler sees all the cases even if only one is then statically
>picked=2E
>
>So the silly casts are for all the cases that never matter=2E
>
>Annoying=2E
>
>I wonder if the "this_cpu_cmpxchg()" macro could be made to use
>_Generic() to pick out the pointer case first, and then only use
>'sizeof()' for the integer types, so that we don't have this kind of
>"every architecture needs to deal with the nasty situation" code=2E
>
>Ok, it's not actually the this_cpu_cmpxchg() macro, it's
>__pcpu_size_call_return() and friends, but whatever=2E
>
>Another alternative is to try to avoid casting to "u64" as long as
>humanly possible, and use only "typeof((*ptr))" everywhere=2E Then when
>the type actually *is* 128-bit, it all works out fine, because it
>won't be a pointer=2E That's the approach the uaccess macros tend to
>take, and then they hit the reverse issue on clang, where using the
>"byte register" constraints would cause warnings for non-byte
>accesses, and we had to do
>
>                unsigned char x_u8__;
>                __get_user_asm(x_u8__, ptr, "b", "=3Dq", label);
>                (x) =3D x_u8__;
>
>because using '(x)' directly would then warn when 'x' wasn't a
>char-sized thing - even if that asm case never actually was _used_ for
>that case, since it was all inside a "switch (sizeof) case 1:"
>statement=2E
>
>            Linus

I wrote a crazy macro for dealing with exactly this at one point, basicall=
y producing the "right type" to cast to=2E It would need to have 128-bit su=
pport added to it, but that should be trivial=2E It is called something lik=
e int_type() =2E=2E=2E not in front of a computer right now so can't double=
 check=2E
