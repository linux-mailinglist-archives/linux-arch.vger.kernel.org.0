Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A59790E09
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 22:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbjICU6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348064AbjICU6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 16:58:40 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7910F;
        Sun,  3 Sep 2023 13:58:34 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5712b68dbc0so531647eaf.1;
        Sun, 03 Sep 2023 13:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693774713; x=1694379513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W9YSgb5UzuBSLARsJKFVPwq8VqiieJIYIspvDeQxNbU=;
        b=sAhVcZLrj7kh2sDWLyoOZA/XnaYSvI1trr0Rd4aDsYed2E+5nTHMUOnTV/IQ4EE/WH
         cyQaqXMDAnLXKUw1uWSWGpMep7Ft9euNdK3MSm0WsBkpd8U4wAmr26Y1Xo8w5LRllUud
         BiF9FS/GZuvqp4e0AsckTzdWLqBg8egLMGmPE6kx5ZtVm0qwWnSIif9Mjk2VM3CCvyBe
         J/wDE3s+kas/kosxx9w5weSUe0xKNKnoQ9nZj9lLKGp3nO1+oO7mjBfPn5ajsc6qTesZ
         S+x3413V9FkTkSn/ZlRQRLmVQqO2gfIrCTIoMmqLWwtgvFT6Z77ytSNjkXvERWvGQC1p
         77eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693774713; x=1694379513;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9YSgb5UzuBSLARsJKFVPwq8VqiieJIYIspvDeQxNbU=;
        b=GMbFIkNxm5gV/mOftWOsfDXgVUFuLkR6PQBVZBsbbyNYhwppUYHxgyxFR9xdlQWgc5
         sRQgOMLVxoXjaUDlf49+ybCv6CckNneVasjpuib0wbSSKXqHxqxJt2TWt1odo903XrX4
         qS7GziOhVyxHX4yFUQsmNmOh2oR/hPVqPdFpeLwHOixQNKsAEXk/mPdpiAFn5XFZKSkK
         kzvTdUfRtQ44iniVeyB2dBSDeZfs5AbeN4/5hpSUQpcDebaqKKZVNW25ppbZucN9qz7i
         +452iSXi3zvsRJ6BN2UWpU2kyk6OwT/VIIt6j/z2FBpyyNlwRyWWwv8sAvgeM/pnroFt
         aaUg==
X-Gm-Message-State: AOJu0YxjZXjG2KMvJkHfEBeE1MGBrJWXwLLfMxL2z+NXvOAWLrwZYHwV
        4JIisPO/oxqjPXMuni75k7Zc2KSKfrBKsOAobI47E7bwjP4=
X-Google-Smtp-Source: AGHT+IG+MJicFBXZWYdDI6fYqxEPzQcJrrpISMDWEh+L8JXxjV2uZOA4g5FbkTeB1DEPaJh0AAFwc1Pu3glsPP+IEZI=
X-Received: by 2002:a4a:2a13:0:b0:573:b2a4:7a6e with SMTP id
 k19-20020a4a2a13000000b00573b2a47a6emr7194860oof.5.1693774713127; Sun, 03 Sep
 2023 13:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 13:58:32 -0700 (PDT)
In-Reply-To: <20230903204858.lv7i3kqvw6eamhgz@f>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com> <20230903204858.lv7i3kqvw6eamhgz@f>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 3 Sep 2023 22:58:32 +0200
Message-ID: <CAGudoHGsuARwuMWa=2U9D2AY4bQPv0t1HOZ0_TocNLsB5yAf9g@mail.gmail.com>
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

On 9/3/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Sun, Sep 03, 2023 at 01:08:03PM -0700, Linus Torvalds wrote:
>> On Sun, 3 Sept 2023 at 11:49, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> > So I have no idea why you claim that "currently they have no choice".
>> > glibc is simply being incredibly stupid, and using newfstatat() for no
>> > good reason.
>>
>> Do you have any good benchmark that shows the effects of this?
>>
>> And if you do, does the attached patch (ENTIRELY UNTESTED!) fix the
>> silly glibc mis-feature?
>>
>
> "real fstat" is syscall(5, fd, &sb).
>
> Sapphire Rapids, will-it-scale, ops/s
>
> stock fstat	5088199
> patched fstat	7625244	(+49%)
> real fstat	8540383	(+67% / +12%)
>
> It dodges lockref et al, but it does not dodge SMAP which accounts for
> the difference.
>

I'm going to ask glibc people what's up with the change later.

I'll note statx does not have a dedicated entry point (I checked again
;)) which elides path lookup. It *did* have a way, but it got removed
in 1e2f82d1e9d1 ("statx: Kill fd-with-NULL-path support in favour of
AT_EMPTY_PATH").

One frequent consumer I know of is Rust.

Would be nice to have a non-hacky way to sort it out.

-- 
Mateusz Guzik <mjguzik gmail.com>
