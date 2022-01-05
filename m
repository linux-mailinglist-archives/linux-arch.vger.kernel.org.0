Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E337E48501E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiAEJhk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 04:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiAEJhj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 04:37:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90682C061761;
        Wed,  5 Jan 2022 01:37:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z29so159448954edl.7;
        Wed, 05 Jan 2022 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dL91I39WiegFKoqzSuVIyhjC/bBYZXjgDxDNGZC9bm8=;
        b=fWMphfJ+kLKLffih2SVQPP/xYmhpN3b8zFsaeobSyWWLngI6sZdubmjQAKy/3+jnuZ
         sBCNH3vjN2FaV80qbDf2h7IG0Z0vKbusXE2kfrQYP2nOQ9D+tbZ8VhUFDK+MpxA3S3lR
         rEYFjX5jPQWASaWRnr8PWAjWbXeWInKv8UWtqVE4HCWLwKJKz61050SkhW5CiINRbHDi
         U1PUoD9QlCa5UHh+RYx2zVh3Muxr15vCVF2mru3sOSyznomfetWuGL+h+a+ySQWn9LF9
         NzVpbxhpv9Fko9xhtf9r5Wdv2/8KT2vKW0dMeYKSb3g7p2q2bzqAATNej1CE/EcRK5Vv
         VX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL91I39WiegFKoqzSuVIyhjC/bBYZXjgDxDNGZC9bm8=;
        b=PWv5RcLr1UfK+UlmU819gswC1yLvip38be260e1qsUB3n8b0s0LizKX7zLo+oUMi4/
         +vZCJ6O1Bf972EqNedm8cLROtzP4HCjAxgss/qPzxMYATix2M2FxmgbDgysrWoLewMBz
         qTDbDpZN2k6MofmoagCth1TMmNag9oFcMyJO3gtwk59X3Pnfl1oM66JfcuXDFZOEa5o/
         N6lso4y/+Ziy4FXCxnjoKSMrr0hxSjHYhOVxCHKML3TnD6S9SjhLPC7HrPxV/F3Yg7Ew
         DkQdKYsjsINX8GOJAGVyeafdelMeXssTKCJuctg1I7I+WlLKcVKfDNClwFy5X9+fC0GF
         BY6g==
X-Gm-Message-State: AOAM532R4MmqjZ+RJDvbyNcz+Fxh6kvOEcWfgQxk+6PYKcNkN28VDGUF
        Y4TQaotTYCXZ6LwhG8wCzlJjmUa87rcZzGi1LozF1/MNk8A=
X-Google-Smtp-Source: ABdhPJz4YUuG5ppYtnGubuFGj+9zCXzK5uVlZcH4ghXBCpXx5EQpWUTzkQoLaoldbJaplWAP//W3E7yCbd/CGaVJ2/Q=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr50710493edc.125.1641375458165;
 Wed, 05 Jan 2022 01:37:38 -0800 (PST)
MIME-Version: 1.0
References: <YdIfz+LMewetSaEB@gmail.com> <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com> <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
In-Reply-To: <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 11:37:02 +0200
Message-ID: <CAHp75VeUmg73d6gua+LoHiyihMW3tqexTYe4QvKXS8gbXZP15w@mail.gmail.com>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree -v1:
 Eliminate the Linux kernel's "Dependency Hell"
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 5, 2022 at 4:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 3, 2022 at 6:12 AM Ingo Molnar <mingo@kernel.org> wrote:

...

> Most of the patches should be the same either way (adding back
> missing includes to drivers, and doing cleanups to commonly
> included headers to avoid the deep nesting), the interesting bit
> will be how to properly define the larger structures without pulling
> in the rest of the world.

I'm wondering if the compiler can provide us the statistics of usage
on a per custom type basis. In this case the highest frequency will
probably mean that we better have that type in a separate header or
tree of _independent_ headers.


-- 
With Best Regards,
Andy Shevchenko
