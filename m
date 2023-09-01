Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7178FFD8
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjIAPUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjIAPUr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 11:20:47 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07001E65;
        Fri,  1 Sep 2023 08:20:43 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5731fe1d2bfso1186806eaf.3;
        Fri, 01 Sep 2023 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693581642; x=1694186442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ljs23L1dyT+b0tWVJbCp2yNtFCpJjRsgeCDP2SeGOEQ=;
        b=qArdKwaeHM2h8wphgelg2BLF1nRAQ8qt4gp0Zj38iAy91eTEEM4AKotehCfa9PdV9o
         8LEBidtujxseslzFRR7DAjhd4MLPGnFUdYpLaRvOmjCXP2REDQ9Zb69ZRRIUCDrkV1A2
         isfT4yFL3kqOJLf0dzBcuvFqRANJ5M/WNTdZPod9jV9Pco9/l2yP1XXojADVoZgNS+Kr
         3+nQYkNUo5wbHLGsV0ZgU3oXqIZdaAeXbm7QNRJAN7iUUQVO/g8iDgFMMBAewsFjYHFJ
         S02YeJx0XfDYUBVLOGXBEncv7l101FLEPiAYHrv6vCbOybivUrRilAZBakZmiBlM30xb
         m3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693581642; x=1694186442;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljs23L1dyT+b0tWVJbCp2yNtFCpJjRsgeCDP2SeGOEQ=;
        b=WiH86oPR3TzVlFSoO/tjWH5eHyCC5pAUE98xeKf2inyz6YC+9gGxf+ySPGtX+7RGg4
         s4vWZSTHXsPVRUDjdnRkSHQ5cM7tdD55fEHIra4fUkh62TwTJUEqK4ybCJKrRM8BF7L9
         WZS9diUfa0BHYe76L+G+wrtkIZzchq4877PAlJevxVmmORG2w2iGeYnyZdthbScz/5Su
         9gDTvwcXmWmUkVUftC6Pe0osF/pgDJPjw6KgpN4IYslMrBykbze0dTj4imd49LzFmIhG
         FOSeL/wu3shYDqmG45cdpccrzsMSJvLmBE8lAAFTrm4W8+ZlfOlFLjLzxoa+xOMHOfKp
         ZZmw==
X-Gm-Message-State: AOJu0Yz4E2zBzK5zqpiTBQsl2rG8XaiaPVj+pR5XZ4cRp2kSJbtfUOdU
        xY679coCZgVkOd0tTsaKYEnroIa+8dKK71FYlGusfJJTiUI=
X-Google-Smtp-Source: AGHT+IEO9n6CvHZ47MH662HDsFeehhhhQwQie05IJmcLJgZELhnWr/wbJGIVq8+EeWk6VtLB4/ZC5oNCGqTZS1Ri0PY=
X-Received: by 2002:a4a:6c11:0:b0:573:4e21:5d25 with SMTP id
 q17-20020a4a6c11000000b005734e215d25mr2747226ooc.9.1693581642029; Fri, 01 Sep
 2023 08:20:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Fri, 1 Sep 2023
 08:20:41 -0700 (PDT)
In-Reply-To: <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 1 Sep 2023 17:20:41 +0200
Message-ID: <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/30/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Side note, if you want to play around with the user copy routines (or
> maybe Borislav wants to), I have a patch that handles a couple of
> common cases statically.
>

No thanks mate, I'm good ;) (but see below)

> In particular, it should help with copying structures - notably the
> 'stat' structure in cp_new_stat().
>

So my first side note is that I agree this is going to help a bunch of
cases, but I disagree about this one.

cp_new_stat and the counterpart for statx can dodge this rep mov by
filling user memory directly.

I know for a fact statx already had that implemented, but it was
before (or around the time) SMAP was introduced -- afterwards all the
__put_user were shafting performance big time. As the kernel did not
have support for delineating several accesses in a row, code got
reworked to the usual massage locally and copyout. I can't be arsed to
check but I suspect it was the same story with cp_new_stat. The
necessary machinery is implemented for quite some time now but nobody
revisited the area.

I'm going to patch this, but first I want to address the bigger
problem of glibc implementing fstat as newfstatat, demolishing perf of
that op. In their defense currently they have no choice as this is the
only exporter of the "new" struct stat. I'll be sending a long email
to fsdevel soon(tm) with a proposed fix.

> The attached patch is entirely untested, except for me checking code
> generation for some superficial sanity in a couple of places.
>
> I'm not convinced that
>
>     len >= 64 && !(len & 7)
>
> is necessarily the "correct" option, but I resurrected an older patch
> for this, and decided to use that as the "this is what
> rep_movs_alternative would do anyway" test.
>
> And obviously I expect that FSRM also does ok with "rep movsq", even
> if technically "movsb" is the simpler case (because it doesn't have
> the alignment issues that "rep movsq" has).
>

So I was wondering if rep movsq is any worse than ERMS'ed rep movsb
when there is no tail to handle and the buffer is aligned to a page,
or more to the point if clear_page gets any benefit for going with
movsb.

The routine got patched to use it in e365c9df2f2f ("x86, mem:
clear_page_64.S: Support clear_page() with enhanced REP MOVSB/STOSB"),
which was a part of a larger patchset sprinkling ERMS over string ops.
The commit does not come with any numbers for it though.

I did a quick test with page_fault1 from will-it-scale with both
variants on Sapphire Rapids and got the same result, but then again
that's just one arch -- maybe something really old suffers here?

Not having to mess with alternatives would be nice here. That said I'm
just throwing it out there, I have no intention of pursuing it at the
moment.

As a heads up what I *do* intend to do later is add back rep to memcpy
and memset for sizes >= 64.

Gathering stats over kernel build: bpftrace -e
'kprobe:memcpy,kprobe:memset  { @ = lhist(arg2, 64, 16384, 512); }'

@[kprobe:memcpy]:
(..., 64)        3477477 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[64, 576)        1245601 |@@@@@@@@@@@@@@@@@@                                  |
[576, 1088)        44061 |                                                    |
[1088, 1600)          11 |                                                    |
[1600, 2112)           9 |                                                    |
[2624, 3136)           1 |                                                    |
[3136, 3648)           2 |                                                    |
[3648, 4160)         148 |                                                    |
[4160, 4672)           0 |                                                    |

@[kprobe:memset]:
(..., 64)       20094711 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[64, 576)       11141718 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
[576, 1088)        28948 |                                                    |
[1088, 1600)       59981 |                                                    |
[1600, 2112)       11362 |                                                    |
[2112, 2624)       13218 |                                                    |
[2624, 3136)       14781 |                                                    |
[3136, 3648)       15839 |                                                    |
[3648, 4160)       48670 |                                                    |
[7744, 8256)           1 |                                                    |
[16K, ...)         32491 |                                                    |


[I removed rows with no hits; also I had a crap hack so that bpftrace
can attach to these]

This collects sizes bigger than 64, with a 512 byte step. While vast
majority of calls are for sizes which are very small, multikilobyte
uses keep showing up making it worthwhile.

I'm going to try to work out alternative_jump which avoids the current
extra nops and which works on both gcc and clang (or in the worst case
I'll massage what you had for gcc and let clang eat the nops, with the
macro hiding the ugliness).

I make no commitments when I get to it, but probably early September.

btw these string ops would probably benefit from overlapping stores
instead of 1 or 8 byte loops, but I'm not submitting any patches on
that front for now (and in fact would appreciate if someone else
sorted it out) :)

Cheers,
-- 
Mateusz Guzik <mjguzik gmail.com>
