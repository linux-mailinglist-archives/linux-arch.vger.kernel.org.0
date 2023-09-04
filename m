Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BD791043
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbjIDDHq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 23:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbjIDDHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 23:07:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8461110
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 20:07:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso14168991fa.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693796859; x=1694401659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9x9/Aqy0Q3Hq7H8kkvHt4T4iDLN9ojDkJfODIFW/SI=;
        b=dhIMobwcPssZytpIKdekrR0e3NW8SFDJ/fCgCMX++xlW7U3zjKATO23m4F0/nMHqRc
         7lc09gIK/p+Uel++ky1sNCYNfF3Yjq4wmG6pp6ixpBJQEiIWJGmw7Cz82RzrUfn/WcZ2
         sYE7Ohs7YR5K8SwTkWlvWoA8Pan/lqor+hm2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693796859; x=1694401659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9x9/Aqy0Q3Hq7H8kkvHt4T4iDLN9ojDkJfODIFW/SI=;
        b=Y9O2qo1s4qComGDGfKYF5NBOmmL5HoGjdClDj1rBhah/eEL2D9ZVCfBGHdSYGgmwik
         CDrZeKcVJPCI5UX9zmxlLVj43aaDxGy/QtqYKLINNW1dVdj6jxmN0mrzsx+13Msrwfz+
         IQuu0nZLoDHFgO26JqJ1gmAl6ptGxToP4BGgCn9ywON/ehk0H/6mVePLHNevE88uDMMx
         5E3zweWPtiyymU4L/ha8fzM9UzLBsjVsJjMmy6czMckhCzP+kytQOAIF83nCfKGCKi8L
         wfKbsyH3FwcYotKECV1dLgAqq3p5WXW6AXVokCa610Ibq+KGbxAdSbI5HsTaS5lKAvNe
         rcyg==
X-Gm-Message-State: AOJu0YyORChhq3Qx+GIyZLyfjNC0DKHnUBfhpBjptjVshN46DugNGEFY
        mAHuK6yD5SZMje8OXKyH3tf8rNlriwjxz4UyE2jyuQZi
X-Google-Smtp-Source: AGHT+IFT+iUbWAxc+AohJ1Vog7N4f2b8Uvt94JNtwXxkJbTDKaC25rmWmtVAFb4nvWE5FNJ5oS97lQ==
X-Received: by 2002:a19:e01a:0:b0:4f9:7aee:8dc5 with SMTP id x26-20020a19e01a000000b004f97aee8dc5mr4770203lfg.19.1693796859589;
        Sun, 03 Sep 2023 20:07:39 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s13-20020a19ad4d000000b004fddb0eb961sm1496666lfd.18.2023.09.03.20.07.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 20:07:38 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50078e52537so1614847e87.1
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 20:07:38 -0700 (PDT)
X-Received: by 2002:ac2:5499:0:b0:4fb:91c5:fd38 with SMTP id
 t25-20020ac25499000000b004fb91c5fd38mr5699314lfk.0.1693796858205; Sun, 03 Sep
 2023 20:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
In-Reply-To: <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 20:07:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
Message-ID: <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 3 Sept 2023 at 16:15, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> bad news: virtually no difference for stat(2) (aka newfstatat)
> before:  3898139
> after: 3922714 (+0%)

Yeah, the path lookup is way more expensive than a slight win in a L1
copy, and the pathname lookup will also have gone much deeper on the
stack.

> ok news: a modest win for the actual fstat system call (aka newfstat,
> *not* the libc wrapper calling newfstatat)
> before: 8511283
> after: 8746829 (+2%)

We might end up with slightly less deep stack, so potentially a
smaller cache footprint, and there is much less other stuff going on..

> The patch as proposed is kind of crap -- moving all that handling out
> of fs/stat.c is quite weird and trivially avoidable, with a way to do
> it already present in the file.

So you say. I claim that you're full of crap.

Try it and you'll see it is not even *remotely* as easy as you claim.
Not when you have to deal with random sizes and padding of 20+
different architectures.

             Linus
