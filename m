Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F7790E15
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 23:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbjICVGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjICVGU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 17:06:20 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8407010C;
        Sun,  3 Sep 2023 14:06:15 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57361de8878so545723eaf.0;
        Sun, 03 Sep 2023 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693775175; x=1694379975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5DcI7CSTA0DXB0f7TWXzeRwOjmGYUwoknwb9WpO8Nw=;
        b=J6Nb5f48kKIHYfUPwfDZwea8GZsLIUV6HecZrCescG0Q3EXAOdh8juo+wqlNSDi0HU
         hSZK+5DJdaaAHGirErVFnb3GJYtoijB/slo6In49Q3JBy1gVByf88zosVG13cYALJrfd
         azNbgy9LBhPylHE9isHdYvfrpCKapV0kqhWLW8VtuSSiwVTE6xayGICSIjSkKxpPYN7N
         YfXiaC6viFdvaH7zJKWvU7oTyO3LDg8oJEdH05FP46KTevjGoue6kPZ5fnlpz85THfse
         5CK3NMJZ/3JbAJcGLX+XBepB+DWS7bQOay0xtRRhKFIe6XJtUnKuVITKwuaTmlj8Spgu
         TF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693775175; x=1694379975;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5DcI7CSTA0DXB0f7TWXzeRwOjmGYUwoknwb9WpO8Nw=;
        b=W519BdYcDreLuQ0dOyqTQmzZIDhiwCkBNSgIPeHWw6cKJlTjZQ5d6j2v2wLxgTCbda
         kJq8nY5pTRmF/Ie4WbmcXlz8JI3plLIaysW1ts8kUsP96xos5bwjH/y2WD4nwRNLMgeU
         YJXrGRC0n0q8eWzdz2s4pRY1swiE82QIAXHeSHbvRvHfM+3JGhlIYFDGmooN9jbNvFC+
         9gNe6OBJfpSMeqnmPYmRBOJR8+JdNRZrXAOeDfAL9ORtKf47rM8CYrwhIbiMR4I9ys0O
         WHfJl2TNTRCr/6T0wam34ADe7ZwKVbDCiwmZnD1nGTWCwl6NQI73dHDb4hIp4d+peDMA
         cjJg==
X-Gm-Message-State: AOJu0YyUXwvaUpphElm+zPeMjnDYP74zw8CNYy9x+kZWjiTjkXli14se
        4xMdHNfrrRF22qNkTr8O25u1RI4u63ZaUSQkpzFddMiekOE=
X-Google-Smtp-Source: AGHT+IHIq3io5UHSsSNYnsEGGcc25gvWF2P8V7QLtUaujytjjZBoER9LcQCsUd+qGN+VHE8j2JDq4Qrv+Z5D1/ZSHPE=
X-Received: by 2002:a4a:6c1d:0:b0:570:c8fa:4ad7 with SMTP id
 q29-20020a4a6c1d000000b00570c8fa4ad7mr6618978ooc.1.1693775174749; Sun, 03 Sep
 2023 14:06:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 14:06:14 -0700 (PDT)
In-Reply-To: <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 3 Sep 2023 23:06:14 +0200
Message-ID: <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com>
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

On 9/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 3 Sept 2023 at 13:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> It dodges lockref et al, but it does not dodge SMAP which accounts for
>> the difference.
>
> Yeah, just doing that "check if the name is empty" is not free. The
> CLAC/STAC overhead is real.
>
> I see no way of avoiding that cost, though - the only true fix is to
> fix the glibc braindamage.
>
> In fact, I suspect that my stupid patch is unacceptable exactly
> because it actually makes a *real* fstatat() with a real path much
> worse due to the "check if the path is empty".
>

I don't think it is *that* bad. I did a quick sanity check on that
front by rolling with bpftrace on cases which pass AT_EMPTY_PATH *and*
provide a path. Apart from my test prog which deliberately did that
nothing popped up in casual testing. But there is definitely funny
code out there which passes both not for testing purposes, so there is
that.

> We could possibly move that check into the getname() path, and at
> least avoid the extra overhead.
>

Complexity aside that would eat some of the win as kmalloc/kfree are
not particularly cheap, and I'm even ignoring the INIT_ON_ALLOC
problem.

So I would not go for it, but that's my $0,03.

That said, I'm going to engage glibc people to sort this out on their
end. Arguably this is something everyone will be able to backport to
their distro no matter how LTSy (not that I expect it to happen ;)).

-- 
Mateusz Guzik <mjguzik gmail.com>
