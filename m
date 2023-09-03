Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0249790F2E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjICXPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXPP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 19:15:15 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAE2A4;
        Sun,  3 Sep 2023 16:15:12 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5731fe1d2bfso405537eaf.3;
        Sun, 03 Sep 2023 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693782912; x=1694387712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNvGWFX+BiC84qrst/QwR2D8E+xq9Q4AFUhflVmCcEQ=;
        b=F7DqH8TjUxT8A0syRMObZ2Ecczq71AXQu6TRuNSPtjsj8rRJ46UcMN9Csi/1JHfJUj
         Si+XeIWRcxqRkK6uO8mlgv7oiQIK0wFpgS4pNK28tHsbilN4M7ngOfmqhKGkfnIxKB47
         3ireE/75tlIrWVuf+KRmEbcvaaEyIoci+zYJ+AqPSwkb1OWMdt09X8q/bREs74MRpXcq
         8J0ipYz4ViwK5CPqcj1tF5+iaz7fesvOTwvQ/tpdmYhXn5iibvhNmtwuKdbeMz6TISBL
         OjsWHtwPXSZ9IyUwIQot4hGibroYB3eUsPiYqseFsA/1zfsRNT5zjVt1hKM4PbgkOHFz
         sgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693782912; x=1694387712;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNvGWFX+BiC84qrst/QwR2D8E+xq9Q4AFUhflVmCcEQ=;
        b=UW5ZDh/H7fgDdzz8LssQDU2UAjQgwkwrK5Q5WJMpcJ9/LkWO3QZE/9TUCW45kMf4yA
         R/F5cebXcWPxqaocyVdCjG7ylYDwBRUb7R0ov4BJ24/oik56dZpQ8msSLZ4U5hZrWCFS
         MukbHF49P6QbYBliLjcaD+0E+kZ+YhOBwHstKbqkHhFCDlFX17q5ZaqR5ggVa69e2s9y
         awJVly7Z8QPvwmrrtcqNxtwOqg0yrK1b1ZqPDONB0fSCoH1E3NSHgjcBaO8vhwPP5Oxj
         xphtoq+2O88k6d7DF0lfqNwD9GkgK6x8gbyamCIt4uoNL7AfqTNXbLrsJz+nNFOCUlJy
         PJqQ==
X-Gm-Message-State: AOJu0YzQe4B2p4WgH4VQSXbzz9M+GVAM6tcbUgQt3tgukZtbBBf/6ZyV
        EklRN4grCTiAu58tzz4T6HLudmPqw2tAyQTt8ZAwavd5mf8=
X-Google-Smtp-Source: AGHT+IFFjxAjFtpT360JheX76IURM2VUYdS3METH2SledTTwf8aPdWbtUH1Df6vN1aIf0le/B0CbPa2CzbGbJ/CvQ1Q=
X-Received: by 2002:a4a:301e:0:b0:571:23ce:a4af with SMTP id
 q30-20020a4a301e000000b0057123cea4afmr5961421oof.3.1693782911404; Sun, 03 Sep
 2023 16:15:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 16:15:10 -0700 (PDT)
In-Reply-To: <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 4 Sep 2023 01:15:10 +0200
Message-ID: <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
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

On 9/4/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 3 Sept 2023 at 14:48, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> If measurements support it then this looks like a nice optimization.
>
> Well, it seems to work, but when I profile it to see if the end result
> looks reasonable, the profile data is swamped by the return
> mispredicts from CPU errata workarounds, and to a smaller degree by
> the clac/stac overhead of SMAP.
>
> So it does seem to work - at least it boots here and everything looks
> normal - and it does seem to generate good code, but the profiles look
> kind of sad.
>
> I also note that we do a lot of stupid pointless 'statx' work that is
> then entirely thrown away for a regular stat() system call.
>
> Part of it is actual extra work to set the statx fields.
>
> But a lot of it is that even if we didn't do that, the 'statx' code
> has made 'struct kstat' much bigger, and made our code footprints much
> worse.
>
> Of course, even without the useless statx overhead, 'struct kstat'
> itself ends up having a lot of padding because of how 'struct
> timespec64' looks. It might actually be good to split it explicitly
> into seconds and nanoseconds just for padding.
>
> Because that all blows 'struct kstat' up to 160 bytes here.
>
> And to make it all worse, the statx code has caused all the
> filesystems to have their own 'getattr()' code just to fill in that
> worthless garbage, when it used to be that you could rely on
> 'generic_fillattr()'.
>
> I'm looking at ext4_getattr(), for example, and I think *all* of it is
> due to statx - that to a close approximation nobody cares about, and
> is a specialty system call for a couple of users
>
> And again - the indirect branches have gone from being "a cycle or
> two" to being pipeline stalls and mispredicts. So not using just a
> plain 'generic_fillattr()' is *expensive*.
>
> Sad. Because the *normal* stat() family of system calls are some of
> the most important ones out there. Very much unlike statx().
>

First a note that the patch has a side-effect of dodging hardened
usercopy, but I'm testing on a kernel without it.

bad news: virtually no difference for stat(2) (aka newfstatat)
before:  3898139
after: 3922714 (+0%)

ok news: a modest win for the actual fstat system call (aka newfstat,
*not* the libc wrapper calling newfstatat)
before: 8511283
after: 8746829 (+2%)

That is rather disappointing, but I would check it in for the time
when glibc fixes fstat, on some conditions.

The patch as proposed is kind of crap -- moving all that handling out
of fs/stat.c is quite weird and trivially avoidable, with a way to do
it already present in the file.

Following the current example of INIT_STRUCT_STAT_PADDING you could
add these to an x86-64 header:
#define INIT_STRUCT_STAT_PAD0 unsafe_put_user(0,
&ubuf->__pad0,          Efault);
#define INIT_STRUCT_STAT_UNUSED { unsafe_put_user(0, ....);
unsafe_put_user(0, ....) }

the new func placed in fs/stat.c would get the same code gen as it
does with your patch, but other archs could easily join and there
would be no stat logic escaping the file (or getting duplicated again
if another arch wants to dodge the temp buffer)

Then I think it is a perfectly tolerable thing to do, but again given
the modest win it is perhaps too early.

Someone(tm) should probably sort out stat performance as is. ;)

-- 
Mateusz Guzik <mjguzik gmail.com>
