Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF45A3AD68A
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 03:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhFSB5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 21:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhFSB5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 21:57:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA433C061574
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 18:55:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s22so16472656ljg.5
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 18:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg+K1zU+2dStQVWKUOdP34UwGw2vJJvLbwau/fvffAA=;
        b=Nv/flYhKtgltntmBq1tzvLsNQ/psPmRZIqCV37PZInIw1jjmg1gSirNRvsbGYE+6vY
         gL8r9JhQ4eH121zp95P8jrsbWkOQhH71GdmdgBwhs0lCOZKMohPCjreUdeeEZL7OLS69
         ij/+3/27K37keovrO3Eg3GR/AMfh26YRbefKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg+K1zU+2dStQVWKUOdP34UwGw2vJJvLbwau/fvffAA=;
        b=VzPkqBcrJLlCtaZmrHdsAwqIqJHyIQO8vQbh9xdipm/69D91XlPm9GfqFvfG1h01Pf
         iY3xFDIxglzMoDocMzr2IUHq38ojvZBn4PlmYKIPbiot1hZ53duSKIYLSVGHAmSonuIa
         sBkWtgpR8f5B5LyfcHQm518o+ogrAUAfNIUJuGX3V5p4NYHgSm59PZPRmoUcw8kGa7tv
         Org7BmARE2Fye8FepqXvjEiuC/gSPVdlKzoSWRg+zkrDqMY0/n3jb/ZX179Beo3j4tXf
         aibWjYWapmtzFD3Ca9sSRnVbfhzNrfXoYGHROkTfJlQqQu5y/Sg0Sb6zPU+bxcNcplXn
         r7kw==
X-Gm-Message-State: AOAM531CyxrqOfTUgu5Q+gGHbMf04Y6hhmI5MpCB4bjYs6bo9dnOETEg
        OZE3HWfNLWE+3GJnUPo+dts3SnknhdPACWFf
X-Google-Smtp-Source: ABdhPJzLSBVb6dzd+z1aNt19dgg7hxKO1oKOZu7m6L8KN1WA7qbQgTbTsHWWxWlDyUcJLh4s36KVbA==
X-Received: by 2002:a2e:155e:: with SMTP id 30mr11838162ljv.316.1624067708719;
        Fri, 18 Jun 2021 18:55:08 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v18sm1256904ljg.114.2021.06.18.18.55.08
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 18:55:08 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h4so19639056lfu.8
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 18:55:08 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr5217920lfc.201.1624067707828;
 Fri, 18 Jun 2021 18:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
 <91865b90-c597-6119-5e14-dfe521a33489@gmail.com> <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
 <2b2ba866-104c-afea-9c29-145e9d80c2d5@gmail.com>
In-Reply-To: <2b2ba866-104c-afea-9c29-145e9d80c2d5@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 18:54:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFG7zfO7RXu8RUOkuRPE59-OuqzBFsH-Zk1ieSKYbrYA@mail.gmail.com>
Message-ID: <CAHk-=wjFG7zfO7RXu8RUOkuRPE59-OuqzBFsH-Zk1ieSKYbrYA@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry points
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 18, 2021 at 6:32 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> *** FORMAT ERROR ***   FORMAT=0
> Current process id is 1
> BAD KERNEL TRAP: 00000000
> Modules linked in:
> PC: [<00002af0>] resume_userspace+0x14/0x16
> SR: 2204  SP: (ptrval)  a2: 00000000
> d0: 00000000    d1: 00000000    d2: 00000000    d3: 00000000
> d4: 00000000    d5: 00000000    a0: 00000000    a1: 00000000

Yeah, so that's presumably the rte that causes an exception due to
garbage on the stack.

The registers being zero at that point is actually expected, so that's
not much of a hint. But yeah, clearly I got some stack initialization
offset or something wrong there, and I don't know modern m68k nearly
well enough to even guess where I screwed up.

             Linus
