Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086CEDB0CD
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfJQPLU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 11:11:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46395 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfJQPLT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:11:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so2155809lfc.13
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWXmeJPuiymseCj6xcWqVS3Sx+bDYNGGghSQDXs7lGU=;
        b=dQnAoMOLXxdnkmMnZKKhqkYSJhPE7fd37smKpuRu1Gx0ghF6svHjIV4OA+BFbSyFWz
         qodi5h6+xJSpeqac66M2SEEgLt8Cv2pZxx2LJtw5GbnIXariCqWdbHEGfCZ99W6M/6CN
         xfncevHjC0P6+Y9xBhshp3XPxzlCFmQ5Uf9bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWXmeJPuiymseCj6xcWqVS3Sx+bDYNGGghSQDXs7lGU=;
        b=MeJwyvs+zdNkT6pVJehqmef5DtaclziFdzavksPMZDTJHb6IQO5XcdMb/cNTSBmX7P
         Aq6X6uaEL795JqerBs4FjWuW0sqkO3JkV6Lq3gVDpCus1tA8hGOVS///nDiSKzs+BR0u
         g9s1I/TjNCda52Gk6BLiut0S87rgLswkdc7x/7Y8qSaAav2Ne9FJ/e3ZzyZxZmAjtJB8
         g7P08NT5kpyNZkBvJiFm24rESlyGboa54lWGnn8bZLKWdQzv9MzydLjzEohTwwvgVszz
         PMWsSqFlJe55ynNilxToXC5y0JyRH4u6r2XeB/i8KC0MVN8lJTgU302k5hatPVrwH9lA
         ltHQ==
X-Gm-Message-State: APjAAAXrjT2S1+tbqhKzvYnqJjNH3nX5dBNmp1sn71OMfpzEFA4egcwK
        H1lIU5pcY7xTA521ffjNsHH31vmtCI4=
X-Google-Smtp-Source: APXvYqwfQCv0x5eKrLkw3WOqC31cleje5EeTKGFae4O5XMInINRAMjyfjgaQMaQL1VUMKO+oMle0Gw==
X-Received: by 2002:ac2:5592:: with SMTP id v18mr2207303lfg.2.1571325077441;
        Thu, 17 Oct 2019 08:11:17 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h9sm1101680lfp.40.2019.10.17.08.11.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:11:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id v8so1601607lfa.12
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:11:16 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr2721336lfl.134.1571324744327;
 Thu, 17 Oct 2019 08:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de>
In-Reply-To: <20191017125637.1041949-1-arnd@arndb.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Oct 2019 08:05:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
Message-ID: <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 6:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Change enough of the kernel to allow building a 'defconfig'
> kernel on x86 and arm, by turning the compound literals into
> struct initializers.

Ugh. I detest this patch.

Not only is the patch itself fairly ugly, the end result is
unmaintainable, since any regular kernel developer will

 (a) not use ancient compilers

 (b) look at code like this

   static struct rb_root memtype_rbroot = __RB_ROOT;

and go "that double underscore is pointless" and fix it. And it will
build fine for the developer.

So some of the patch looks like fine cleanups and not bad at all, but
some of it really looks like it's going to be long-term annoyance,
with duplicate names and unnecessary underscores.

In general the double underscores in contexts where they don't exist
from before just look wrong.

Some of the "just remove the cast from the macro define" look good,
though. And making users do DEFINE_RB_ROOT() looks fine. It's more the
"make users have to use the internal double-underscore versions" where
I go "that's wrong".

What distros are still stuck on gcc-4?

              Linus
