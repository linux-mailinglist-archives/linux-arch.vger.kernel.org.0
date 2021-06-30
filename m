Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC63B7F2A
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhF3ImU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 04:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232904AbhF3ImT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Jun 2021 04:42:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 407A461D0C;
        Wed, 30 Jun 2021 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625042391;
        bh=nF7bRnKiTfUwAEQZZ4y99Ifd5yL4YN8o4MyvNHrDvp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MpqndtoVyuwdHmtwGrVrGcFJ0F6VxobYQR7k5p6T5BBM3yD7cXtMc2KrSM240IEae
         Mru3I2+bK5p+AAh29/LS1LvnTUGRO8ov1AV2jN8DawuaTyJyt/4onD/JEyM51Y+buD
         NYh8DxmbEqDYxxu1NVb1xjmwnUEqzvFM4p+m8mzendALw5bkZXQj2R+IaELz3oaGkw
         uHtYh/SD/6bmX729ejU/1SLfdQ78LvvZm9s4iEOi/fzNQ7UaJ/Cn6UE7Yr9Ags0Rpn
         WvC/AEWx0w4moWKTuveXjlvuyz59lcyeE2IaUsa3M847Cl3n0BqP+eoshBPE7VQ0Xf
         ZnKEDw6Z9vRvg==
Received: by mail-wr1-f47.google.com with SMTP id u6so2571795wrs.5;
        Wed, 30 Jun 2021 01:39:51 -0700 (PDT)
X-Gm-Message-State: AOAM5330lkVgszk4fuboD/FAtvRu7HHQ1x3z7zs6wgsjAZkt2pB7Amu4
        cjQ3VF0gVTy0MLaqFqrzY/ESv/OAJun9YhKsG8M=
X-Google-Smtp-Source: ABdhPJy5zClIXH6gfYBFh+/svLWqgI96t+bAqOlJJAIzgHK1Q/gPj3CBEHSVyEyQRwmgsqb+Od88D+57FqAsW4c5SOY=
X-Received: by 2002:adf:e107:: with SMTP id t7mr37744493wrz.165.1625042389771;
 Wed, 30 Jun 2021 01:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133> <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133> <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133> <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk> <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
 <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com> <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
 <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com> <CAMuHMdVKdZNBU-cTUY0zotA5DmtQ=dxH+iFY0_GX=4DzqpycZQ@mail.gmail.com>
 <36123b5d-daa0-6c2b-f2d4-a942f069fd54@gmail.com> <87sg10quue.fsf_-_@disp2133>
In-Reply-To: <87sg10quue.fsf_-_@disp2133>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 30 Jun 2021 10:37:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=A7WhiWBpX+yy6+haR84paXWUOO2=65uP9E82yNomoQ@mail.gmail.com>
Message-ID: <CAK8P3a0=A7WhiWBpX+yy6+haR84paXWUOO2=65uP9E82yNomoQ@mail.gmail.com>
Subject: Re: [CFT][PATCH] exit/bdflush: Remove the deprecated bdflush system call
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 29, 2021 at 10:28 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> The bdflush system call has been deprecated for a very long time.
> Recently Michael Schmitz tested[1] and found that the last known
> caller of of the bdflush system call is unaffected by it's removal.
>
> Since the code is not needed delete it.
>
> [1] https://lkml.kernel.org/r/36123b5d-daa0-6c2b-f2d4-a942f069fd54@gmail.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> I think we have consensus that bdflush can be removed. Can folks please
> verify I have removed it correctly?

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

We are traditionally somewhat inconsistent about whether to leave the
__NR_bdflush macro present in asm/unistd.h or to remove it when the
syscall is gone. Leaving it in place as you do is probably better here.

        Arnd
