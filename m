Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231844D3B50
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 21:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiCIUqi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Mar 2022 15:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiCIUqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2022 15:46:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4171EF4
        for <linux-arch@vger.kernel.org>; Wed,  9 Mar 2022 12:45:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r13so7748524ejd.5
        for <linux-arch@vger.kernel.org>; Wed, 09 Mar 2022 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yeinogDeuOBTA+RgXs0VaNGe2cwXag06ouy/qbMCCs=;
        b=eAKctOojBAW5vDxW9VxH+BGy31s6He186/PWHaAwIkHLzVegn5dhGdivM4jeg72UAe
         GkML1gmaFxGvszjifGcmZzmlorfKxzX8XLPWQ94CkkGCi+OMrgGduicTJGG3qmRhfXQA
         JD8i+KL7gGnY5EOdq35cteeedEM2EWl62TU3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yeinogDeuOBTA+RgXs0VaNGe2cwXag06ouy/qbMCCs=;
        b=WxpKmQdRGopSSD59Fucb/XKUfZJQBcaQL9s+WKPzYHh6jpQ2u2ma9TFT2YlDHcoXcQ
         UBez10g1sNZbIt+ZRzCWA/4nQDG655vpilgg1tdR+/MZZHfdAnNlHfx8Lni6DbAQlZXR
         UfXfrYz7pamGMBoKvj+gN1cdAYoIDObKWxfYWhE3khkMmXg94t/PMcFeEbRVZYp4XHU/
         rzqIiXq+YigmA2jfzgubgMb21pSv91n+StgXzYENO52dE57L7vdT+B9ZsDHTzKJeOVHa
         OGq5sABnpN/BDgZwcYxN/dq/1pih97FtK/cHMOLDf3wlPftHc7EYZqczilxrKCCrL2VP
         u45Q==
X-Gm-Message-State: AOAM530bVLIpeB/BbFJOfi8zKK1JVfVi3UJKwEwIPv3sDqw7QKMVGV91
        Tj4p8R7HcrL8JjX7sS7/s/mF+1Ea9UTPoK8Blko=
X-Google-Smtp-Source: ABdhPJyDwl4iFBAKTWIhv/fFRcj8TLolYLIANy9ZBt9KUbOZMNb5Nbs0YF03ex+KPj05kMoxVS/vRw==
X-Received: by 2002:a17:907:3dab:b0:6d6:a9a8:be4b with SMTP id he43-20020a1709073dab00b006d6a9a8be4bmr1499963ejc.34.1646858730794;
        Wed, 09 Mar 2022 12:45:30 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090633d300b006ce3d425b22sm1133108eja.1.2022.03.09.12.45.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:45:30 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id k24so4882718wrd.7
        for <linux-arch@vger.kernel.org>; Wed, 09 Mar 2022 12:45:30 -0800 (PST)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr823721lji.291.1646858290905; Wed, 09 Mar
 2022 12:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic> <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic> <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
 <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:37:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+TYsns5JvNds6BVG7ezdg8uM_z9m8uJBcRDANdd7csw@mail.gmail.com>
Message-ID: <CAHk-=wg+TYsns5JvNds6BVG7ezdg8uM_z9m8uJBcRDANdd7csw@mail.gmail.com>
Subject: Re: [PATCH] a.out: Stop building a.out/osf1 support on alpha and m68k
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Theodore Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 9, 2022 at 12:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Let's see if anyone cares about a.out support on the last two
> architectures that build it, by disabling the build of the support in
> Kconfig.

Oh, I'm pretty sure we can't do this.

a.out on alpha is afaik still very much alive - well, as alive as
anything alpha is - although it's called "ECOFF".

It's the native Tru64 (aka "DEC OSF/1", aka "Digital UNIX") format, so
it's more than some old legacy Linux thing.

We still call it "a.out", but the history is that a.out with some
extensions became COFF, which then became ECOFF, so our a.out code
really covers the whole gamut.

Yeah, we don't actually parse any of the extensions that make COFF
what it is, or ECOFF what _it_ is, but the a.out loader ends up
working "well enough" for simple binaries by using ugly code like

  #define N_TXTOFF(x) \
    ((long) N_MAGIC(x) == ZMAGIC ? 0 : \
     (sizeof(struct exec) + (x).fh.f_nscns*SCNHSZ + SCNROUND - 1) &
~(SCNROUND - 1))

which jumps over all the section headers.

But sure, it would be interesting to know if any alpha people care - I
just have this suspicion that we can't drop it that easily because of
the non-Linux legacy.

                   Linus
