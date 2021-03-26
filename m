Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E534B1FF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 23:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCZWNP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZWMu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 18:12:50 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB6C0613B1;
        Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 19so6299970ilj.2;
        Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKRu/20dm1kx8lx57omGSjuR80s186bmUyk42/yIwsA=;
        b=C5tZkbk+9pDwahw0uqoqYov69orWGgkoeSD9AVzTJg+UwqQ2froXblxyfprXV8V1aL
         6AgWDxcDS6XWgsV9bq+CHyeNTd4wefqpaQeFniwBTGRW1zY7takF0+/KlBukVR0A439M
         x0tXjlcOSZ6UTqpob3Ln+ftFg4tXBBM99KwhNFVJ3MabD3DapQVXDrUMxJruF1/iKv66
         yaecCNuaDUCXOXNDfFMp61GLhTWdYT8y40NzuBp5JmabyPwZ+15ECuUdZzDhsPsW53MG
         pTEerwWnx6ahhp43RqYvy29IDKQHbCwp0+Ok43tr6SVXTO6JOJqljpB6IqPtW4Z0HWp0
         8KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKRu/20dm1kx8lx57omGSjuR80s186bmUyk42/yIwsA=;
        b=FWnlHmFgcRJZV2GghYDpHdVatzM0Y4pzIrRya53BWq83nkBXcvvFSigGG8xGF/RKEq
         j59wbbBAU2WnCeVM1e/PPClHwXLqLzWh/MEUbRja5U7UqqOAzadINSzvAcBFnTh4xBRP
         FiH4gG9xcbYaaynMAf7TWCKRbK/Nm4T2BIB+xsmp64ihmiPMjQg06CrrR999K4/Oi9ro
         jpBJ9z+Zf51iarX9bGvyT5Mvc7oGZhcbljZD63iGffrdq31w48QWUuFjFxew5bL+VwDh
         wl+haQIEwild0lrcXyhkP5wZH/7hnEFhoBk3RlvXxkPBE8ZbxGxYrORSw3fDPmHlMjmN
         yVEA==
X-Gm-Message-State: AOAM5338q4srXLKqel1gTCGU4YqjHTgUpxgsy5WiEQYHbCZKPikwWicA
        sBDAXKXpEpnOtzTwYw0dSHvF+iiNKn+VcTgm6f8=
X-Google-Smtp-Source: ABdhPJwdl4VGs/tkLkbpXsDNTVJ/2e4MIdPgFV7jnZyb31LofH3vnWHNyCk9SeYav7qDJrki2HQ3NJKEWw3vPqxiPcM=
X-Received: by 2002:a05:6e02:20c3:: with SMTP id 3mr11909241ilq.164.1616796769368;
 Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615038553.git.syednwaris@gmail.com> <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <CAHp75VfJ5bGaPkai_adsBoT6=7nS2K8ze0ka3gzZkQARkM5evA@mail.gmail.com>
In-Reply-To: <CAHp75VfJ5bGaPkai_adsBoT6=7nS2K8ze0ka3gzZkQARkM5evA@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sat, 27 Mar 2021 03:42:37 +0530
Message-ID: <CACG_h5pb0pA+cTNPGircAM3UrV5BGmqgk45LF_9phU_J4FaRyw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 26, 2021 at 11:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> > +       bitmap_set_value(old, 64, state[0], 32, 0);
> > +       bitmap_set_value(old, 64, state[1], 32, 32);
>
> Isn't it effectively bitnap_from_arr32() ?
>
> > +       bitmap_set_value(new, 64, state[0], 32, 0);
> > +       bitmap_set_value(new, 64, state[1], 32, 32);
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko

Hi Andy,

With bitmap_set_value() we are also specifying the offset (or start)
position too. so that the remainder of the array remains unaffected. I
think it would not be feasible to use bitmap_from/to_arr32()  here.

Regards
Syed Nayyar Waris
