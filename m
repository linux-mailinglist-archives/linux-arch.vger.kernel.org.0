Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9C791C0B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbjIDR2l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Sep 2023 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDR2i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 13:28:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FECCDE
        for <linux-arch@vger.kernel.org>; Mon,  4 Sep 2023 10:28:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a5be3166a2so231060666b.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Sep 2023 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693848513; x=1694453313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhPCx05WUQGrMDBfkZ0CMhccNBEJ/5RWaLJN+3UFg+M=;
        b=XT+l/ZZivOJS5IknoEIELjRliyV5jsrOwI1MRpdF0bkffrUTxeWlmvwELJ03ID+5e4
         bi1SruJMM2jROjZ7rmBe/mJJvEg38H3obq8jwpKHAGN1501KhQL9RpDQlxJTZygnNJtN
         oqgBHTH1Y02oRMJ5yZbtUCHFbqkAnpZ9k+bpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693848513; x=1694453313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhPCx05WUQGrMDBfkZ0CMhccNBEJ/5RWaLJN+3UFg+M=;
        b=KoQU3XNig7QCZlVM/rmACWOod6b9EXPU0do/HpdkvW02FlHn5i0BgcAX59iI2QLOO4
         inbtxM44fmS/ISPudUtvBYBW5lwTdGZAab4HFqnbLpp3d/CpzZ0CSC1FYHciKx/phJne
         I4NwBlfacHfABUnaVeNV9kl1w8vGuYHjC7Ejnuj81D6emPwCbqDVbPgNF2tsLtEt1w1b
         vFff89r2dZpadRx3J2FOrkWlUjziwxQivzgzEp5njqnpd7qmdIi2pZDaiDeNZGDbzIZ7
         DD0eU9WqoHnt6rt4e8qVc3wYIMeC0KPulMQ0bo5rmVxxQY/mFzOphVQorf/s8oTxbuV9
         9lZQ==
X-Gm-Message-State: AOJu0Yx6ehI3Xi5H/l3aMQCQEVkVYeY+CCtRVYv4KFkh15/HvHw39qe5
        r9OxXIjwTNGp1T8bV0t1F7x01gvD4Al2mRLinxERPgvQ
X-Google-Smtp-Source: AGHT+IH63V3zfV9v3t/RwwbdHLf47BBFWLyYfJ6Lnb0GEdXRnOHL2utAulBRH0mZ/daYxP2Brf4UGw==
X-Received: by 2002:a17:906:1d5:b0:99d:ec81:df58 with SMTP id 21-20020a17090601d500b0099dec81df58mr7390538ejj.19.1693848513163;
        Mon, 04 Sep 2023 10:28:33 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b00993a9a951fasm6584097ejm.11.2023.09.04.10.28.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 10:28:30 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so2331405a12.2
        for <linux-arch@vger.kernel.org>; Mon, 04 Sep 2023 10:28:30 -0700 (PDT)
X-Received: by 2002:a05:6402:751:b0:522:3849:48db with SMTP id
 p17-20020a056402075100b00522384948dbmr8085286edy.3.1693848509629; Mon, 04 Sep
 2023 10:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
 <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com> <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
In-Reply-To: <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 10:28:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
Message-ID: <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 3 Sept 2023 at 23:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Worst case if the 64 bit structs differ one can settle for
> user-accessing INIT_STRUCT_STAT_PADDING.

As I said, try it. I think you'll find that you are wrong.  It's
_hard_ to get the padding right. The "use a temporary" model of the
current code makes the fallback easy - just clear it before copying
the fields. Without that, you have to get every architecture padding
right manually.

You almost inevitably end up with "one function for the fallback case,
a completely different function for the unsafe_put_user() case, and
fairly painful macro for architectures that get converted".

And even then, you'll get non-optimal code, because you won't get the
order of the stores right to get nice contiguous stores. That
admittedly only matters for architectures with bad store coalescing,
which is hopefully not any of the ones we care about (and those kinds
of microarchitectures usually also want the loads done first, so
ld-ld-ld-ld-st-st-st-st patterns).

But just giving up on that, and using a weak fallback function, and
then an optimal one for the (single) architecture that anybody will do
this for, makes it all much simpler.

Feel free to send me a patch to prove your point. Because without a
patch, I claim you are just blowing hot air.

               Linus
