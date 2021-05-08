Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F3377294
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhEHPYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 May 2021 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEHPYs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 May 2021 11:24:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B036C06175F
        for <linux-arch@vger.kernel.org>; Sat,  8 May 2021 08:23:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c15so808513ljr.7
        for <linux-arch@vger.kernel.org>; Sat, 08 May 2021 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA1s7H8iJNlnGDJOvq18ISrXAvebu3dTqmmAHQk0eXA=;
        b=GY8IBu+m+3oUOVWXByoeS1RqLfBljlxVoPUO1aOBONw/W07fMf6agecd8aDLxdwOd1
         3nY23XwejNO4BDe6uUc6gc5TIl5KmHHzgM8kd80MEqMLfPLKYvYzuPjuevyTVI9cpP47
         Kot8+lOIrEr77RreB4ghtv0EkSpqGsJgtN0WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA1s7H8iJNlnGDJOvq18ISrXAvebu3dTqmmAHQk0eXA=;
        b=tiaGY1wPmpu3S36lsd1wSwn8vi2OHiUUuIJOiyzzbQZ3w0ZBRzfG3AoU2P6Vn2qXTu
         5PJeRTens20k7grasCZ1aJmGAgUPChXDH7dpwtyIZFcAmTV3ame02MrfM6HMOHQiEOFL
         p+83FxmY0/PPQPY0Oyelehji8oxGu3Hsc4WEHGL8md8rnZRUl+GRalNk5M+rGGSZRzYY
         i8oAALQJuaiy9XcRCiVFQ/s+9ibV3atQXHJMtTsYnfoZXmWRlnmtayZnYuYLBMiHHwhw
         ea3sMnNoD2WuHBXX3QF0kV45uP27KP0+/Ss29B2iZ9/ErJTBipT0uPm6GxqXG3FlJ5uV
         S6Gg==
X-Gm-Message-State: AOAM5329zZd5hvj7pEbgccm3ei5K7Qot0Dgd7MWXmeEkKy6IlXU2ckzT
        qG8REUQDBPkCxI3sA66CGHPoD2ZnJOj7GSYu
X-Google-Smtp-Source: ABdhPJxU5J/wUqbMDu8raaCvWaUU22gUTcOsYQF6xf6+pG+jtfd2GkfOOqTwImswSRAnFB0GIDiSAg==
X-Received: by 2002:a05:651c:482:: with SMTP id s2mr12194211ljc.397.1620487424805;
        Sat, 08 May 2021 08:23:44 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l23sm1457560ljb.26.2021.05.08.08.23.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 08:23:44 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w15so15302632ljo.10
        for <linux-arch@vger.kernel.org>; Sat, 08 May 2021 08:23:43 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr12695518ljp.220.1620487423720;
 Sat, 08 May 2021 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-13-arnd@kernel.org>
 <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com> <CAK8P3a3sxfYG4WReXPe6fg33K7tQaP4K-F53yBcTfyEXv0W22A@mail.gmail.com>
In-Reply-To: <CAK8P3a3sxfYG4WReXPe6fg33K7tQaP4K-F53yBcTfyEXv0W22A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 08:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZvroqVj0+R+Eg_OAjk1DkvP9AVzQn81E+BZeoWR5AFQ@mail.gmail.com>
Message-ID: <CAHk-=wjZvroqVj0+R+Eg_OAjk1DkvP9AVzQn81E+BZeoWR5AFQ@mail.gmail.com>
Subject: Re: [RFC 12/12] asm-generic: simplify asm/unaligned.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 8, 2021 at 2:29 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, May 8, 2021 at 1:54 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >   #define get_unaligned(ptr) \
> >         __get_unaligned_t(typeof(*__ptr), __ptr)

That's missing a set of parentheses around that __ptr thing ('*__ptr'
should be '*(__ptr)'), btw, so don't use that as-is.

> Both versions are equally correct, I picked the __auto_type version
> because this tends to produce smaller preprocessor output when you have
> multiple layers of nested macros with 'ptr' expanding to something
> complicated,

Ahh.

Yeah, that's probably not a problem for get_unaligned(), but it might
happen in other situations.

              Linus
