Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4818B2025F0
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jun 2020 20:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgFTSR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Jun 2020 14:17:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgFTSRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jun 2020 14:17:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so15009789lji.1
        for <linux-arch@vger.kernel.org>; Sat, 20 Jun 2020 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvNVjKHLtWO1dFhcir+/iDU+Lfgpi6JKmP8lzEdvB4E=;
        b=XZhtEb+0zgTmk7p1FKGgpCykCJGCR4QhBQlCJIvFhX2gO0uR1pqoBoOBIBXk8xm1oo
         nnYsLEAqabKP6xPYAXRe3MXkcyadqTMH+s5IProFdvebzb7pzQ6AkXwlDow2qmIdedzm
         oZw5CZPotJ22BL1wUHzVnLaBOGBVpYDODO31o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvNVjKHLtWO1dFhcir+/iDU+Lfgpi6JKmP8lzEdvB4E=;
        b=WVBiTfNtkGt6Adfyy6nzu9i+f+BEELBmGQ0tKQv/vBpyIvqww5mIEYEvC4l2G70aav
         2myNEnwQj5J9WT2Y8nPXMVoPf6adMA7NT/mA68OW6W6ig5mRIoO1Ue7AqJADxAmjp9cH
         +WzqIXID4RPvtDLIlqBAF5InXFLGj1xcO9nIz3qjG40/O05NzkRaL/mJtpn0iAo+rmZk
         Siib4WzHQsYBqjF6dxq48ucIzZZ+Q1IxZh3/lXq3hWa7be3ZrvnSPb4o8585ozYeNsQ+
         qjhxG3A2b4UgVi7f5YR0/rEFS3iRLw0z8pP5jthvTxs76MOwrnRe0UmqcMBIe7DG7uU8
         Xk2g==
X-Gm-Message-State: AOAM530sP05oHkw/q8S59wOp9JuTzaZElDM2MPgggxBlU1Amuu4Afpyp
        C/9uMs287sw+LDZ+SmvHRLunlCWxsAY=
X-Google-Smtp-Source: ABdhPJyCdcyZJxJHd+4yg6kPsoHehGFme0CKdIHohTHXmr2tKbe7hPszET7bLCqF+cvp56ATrPpUJw==
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr4898030ljc.125.1592677012898;
        Sat, 20 Jun 2020 11:16:52 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d3sm1928689lfe.93.2020.06.20.11.16.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:16:51 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id o4so7375791lfi.7
        for <linux-arch@vger.kernel.org>; Sat, 20 Jun 2020 11:16:51 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr5206631lfc.142.1592677011252;
 Sat, 20 Jun 2020 11:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210645.GB2212102@localhost.localdomain>
 <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com> <20200620075732.GA468070@localhost.localdomain>
In-Reply-To: <20200620075732.GA468070@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 11:16:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjt=mTBqymWuRYeiXQxdEdf6si_it=Yzm7KR62ws0vknw@mail.gmail.com>
Message-ID: <CAHk-=wjt=mTBqymWuRYeiXQxdEdf6si_it=Yzm7KR62ws0vknw@mail.gmail.com>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 20, 2020 at 12:57 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > If you want to build the kernel with C++, you'd be a lot better off just doing
> >
> >    /* C++ braindamage */
> >    #define this __this
> >    #define new __new
> >
> > and deal with that instead.
>
> Can't do this because of placement new.

Can you explain?

> > Because no, the 'new' renaming will never happen, and while 'this'
> > isn't nearly as common or relevant a name, once you have the same
> > issue with 'new', what's the point of trying to deal with 'this'?
>
> I'm not sending "new".

My point about 'new' is that

 (a) there's a lot more 'new' than 'this'

 (b) without dealing with 'new', dealing with 'this' is pointless

So why bother? Without some kind of pre-processing phase to make our C
code palatable to a C++ parser, it will never work.

And if you _do_ have a pre-processing phase (which might be a #define,
but might also be a completely separate pass with some special tool),
converting 'this' in the kernel sources isn't useful anyway, because
you could just do it in the pre-processing phase instead.

See? THAT is why I'm harping on 'new'. Not because you sent me a patch
to deal with 'new', but because such a patch will never be accepted,
and without that patch the pain from 'this' seems entirely irrelevant.

What's your plan for 'new'? And why doesn't that plan then work for 'this'?

              Linus
