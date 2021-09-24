Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE97416AAF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 06:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhIXEJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 00:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIXEJl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 00:09:41 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B1C061574;
        Thu, 23 Sep 2021 21:08:09 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id az15so8699228vsb.8;
        Thu, 23 Sep 2021 21:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrfZTnPPcM70O+mM7svGzbSZyFLavyq7xdJVv7AuMNA=;
        b=AArxpfs5t7Tz2blzs1aSH0nNCrhMd8+cwSBQ19o4cZa1TsGYBouqIdFikADBbqpdbH
         //kH56sx3wfBf3MpEP4zIyjrpGtN87iLmdvjRz9DK1j/ho8vLQ8KJ6Ffc2CrxslmlYmh
         TewPJMNgYPbYaDcmRGDJHtCPKzIYwrhsXcFlO6SlEWY+WZBu9aHeg3xIPgoMBBHk/x9A
         5rZLietz9KoYY9tsOgbYAjOp6HpGB7wdU5ue6AhHB48btdeupZlALSeJvWr+NWBqxtzt
         1O+kjP3vi2La3Bq6Jd9/2fNy8EBqTDBn65OLwplhZ+ybVX87UsrvAgidu/IjtoCuWvhs
         Vb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrfZTnPPcM70O+mM7svGzbSZyFLavyq7xdJVv7AuMNA=;
        b=vZyrL10d+QBNnVYtQYTRYvW4V41EQuU1XYMsyYorkX2dW9wSowSyWOvuGgwvvTW/mS
         Qzrwxit+MJ2yL5XGsM3bgPsdr/aBUgqaZDcsuLFjKhNi4DHUkiZQ61K6+v2S7M91nkJ+
         yZlFpYI2zRKGZodPfssguNsleIWsHUZgeq0Zg4XI/tWHd0r4AMi8W7oVqftQnEP8yA4i
         eqpIXw2nUsSt5n6D6ECjqiHrei9n4qnM7v2txI/An/L6Q5akJJlyfvps5Rgdam0lYD6f
         H3iiufARLyIV50pzEq0nidaIz/jfmhbywph6lX8HzjPiANfPwTFwQ1npwjTYTztLJRFX
         FMIQ==
X-Gm-Message-State: AOAM532yTYKPc1JP577/yZwF8JVZv+zkeCvos7Z0CiWHq/dV5XZhsIaT
        wnfvFdaGP76kSt9CngfCZxMnslpAlEi/rVDlGUU=
X-Google-Smtp-Source: ABdhPJzBYtMAeuTPKkvolL/ISASIbDnfE9Ljusmo03aOxkckysqJQg0jrvbRLz3JEOjHsN+a0k6NC4qjSg1U/flIT5c=
X-Received: by 2002:a05:6102:e55:: with SMTP id p21mr7453555vst.18.1632456488526;
 Thu, 23 Sep 2021 21:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-2-chenhuacai@loongson.cn> <20210923203705.GA1936@bug>
In-Reply-To: <20210923203705.GA1936@bug>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 24 Sep 2021 12:07:56 +0800
Message-ID: <CAAhV-H4=Fdsut8c+Zs3RmR9p=_4pNeYb7Bw-JA51UwV7SF9GgA@mail.gmail.com>
Subject: Re: [PATCH V3 01/22] Documentation: LoongArch: Add basic documentations
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Pavel,

On Fri, Sep 24, 2021 at 4:37 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Add some basic documentations for LoongArch. LoongArch is a new RISC
>
> ... documentation ...
OK, thanks.

>
> > +wide in LA64. $r0 is always zero, and other registers has no special feature,
>
> ...have no special features...
OK, thanks.

>
> > +but we actually have an ABI register conversion as below.
>
> convention?
Yes, should be convention here.

>
> > +``$r21``          ``$x``          Reserved            Unused
> > +``$r22``          ``$fp``         Frame pointer       Yes
> > +``$r23``-``$r31`` ``$s0``-``$s8`` Static registers    Yes
> > +================= =============== =================== ============
>
> Not sure I know the term 'static registers' before.
"Static register" comes from the MIPS code "SAVE_STATIC", maybe it is
called "Saved register" in other places, but I think "static register"
is also OK.

Huacai
>                                                                 Pavel
