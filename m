Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070A2289F78
	for <lists+linux-arch@lfdr.de>; Sat, 10 Oct 2020 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgJJJHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Oct 2020 05:07:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgJJJEo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Oct 2020 05:04:44 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MzQTm-1kE37Q1l0S-00vRJx; Sat, 10 Oct 2020 10:25:28 +0200
Received: by mail-qv1-f50.google.com with SMTP id y7so4606173qvn.13;
        Sat, 10 Oct 2020 01:25:28 -0700 (PDT)
X-Gm-Message-State: AOAM532IMKebEPJuVAIQVXFIjq+ynMSNSk2ATXmJGohTZRsSrnjl2ZCm
        mrLw6IS3cwzOUKSviy0Ihs0Xg4R9Qwbk2bMYY7k=
X-Google-Smtp-Source: ABdhPJyrAiQ6qE9DCNYjmw/dGVUTPN/37bZishBBxjjFwhcE2Nf8BuW8PqPKjXhdRPKbpPRzxl5bA1UBfHuTsFa0P00=
X-Received: by 2002:a0c:916d:: with SMTP id q100mr15701510qvq.8.1602318327227;
 Sat, 10 Oct 2020 01:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200901141539.1757549-1-npiggin@gmail.com> <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
 <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com> <20201010130230.69e5c1a5@canb.auug.org.au>
In-Reply-To: <20201010130230.69e5c1a5@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 10 Oct 2020 10:25:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EgaGEtOQzsjR8YhALAaSxScsAhaQLMqU9UmEdhKQ+-Q@mail.gmail.com>
Message-ID: <CAK8P3a0EgaGEtOQzsjR8YhALAaSxScsAhaQLMqU9UmEdhKQ+-Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op functions
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NAZgk1+74tXojKZ7zokQp1xAL6AmkotKIogVnkegN/AqSHfkXEj
 PROOgoon/FHEdJq/wkpgSVRMeFZlYFMZoNrwbAq5SnqkycHa7IFRkr04Z+cqFLzs4JRXDDA
 2bTAhF6KO3juHStkAZM1oygS9PdlKHU3tx8gjdOrL4/E28139R5vWIf55z/FS303dEOvVTG
 zVwGsT2MASZnn0vl37SXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EKIueck8IXU=:PrpRPoeA93GAriCPSNDZAz
 RWoRqk4yhg629Ifkb5W2LIIc77hBO6RVFM9NN3sODoApBwg/s+iP6u+48BKnhhxsrkhqRfJdW
 lAMjlcR9gku5fXFeD0twX8EZFQcRUK3xFk0tE/Gwd0+O2YoFNc9y8rOGJfDF/OLbDnMWQE1dH
 96vxJqzJQauNSYqqaYC5ZvS9T1JY4ddJ4qjEjXEf5OoHqZNhhMolqIqOidRRJMavxm+0iRLAH
 hfO2yAROXukP726k01m4QXxem8E2WH0thnjUE+ZEyw37MLe5e8tLtSUeUsLpLMIFBOtlq6f3X
 XYOpqDgTYitRJ9gxMSz6NWCPXwjPCh8eM0cVs6oJLl95+jI2WeN7u+SPh2Uj9/sRGU5NInuF3
 6fLyYH3QSE3hQEXy59EpxdFsTLexnQ05qTQH62mwuepuDAjuR7epqnOmdqdCJaHiLk5yfbrWf
 UXBrJx85zysM2osBKioCclM/xzSVbDrPMVYEqZy1/GPTBBY7Wgh/dbcy+jdQdc/fnbVS0bmLk
 k3/OjtHpf6FyiJFgawUCpoWuUm3mm4WD9XyRgxmrkBYwy50NmXkHZAT+g5Lh7gEPcAlAe6Gap
 H2ifNV8yTKKjYFNpmfCXxA7ldehmUxKDRrAO8NUL6I1oqbZC39BZrqIVleRieljSdHV5FrCUg
 fNMp2aSdsIZY7kjR1CpxUFxq5b5f6V4xqRSCHdfpx74kuGUWsWrxMA3tUg6DedL9hjBW5vt0r
 QN0Jl1ZnnHt068aMAMj5vhnk6dPrKqGD6tl3LxKAcmCnxyqyDvnoEMIC6ZVsxdv9W1JCFZnpH
 xCSOf0hdixEaiPF9g4GpZR/1w9ebC3xnZt+ojk4NL11Co+5hqyJHYSiohZ+9L6Zqb59AFZ1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 10, 2020 at 4:02 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Fri, 9 Oct 2020 16:01:22 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Are there other changes that depend on this? If not, I would
> > just wait until -rc1 and then either push the branch correctly or
> > rebase the patches on that first, to avoid pushing something that
> > did not see the necessary testing.
>
> If it is useful enough (or important enough), then put in in your
> linux-next included branch, but don't ask Linus to merge it until the
> second week of the merge window ... no worse than some other stuff I
> see :-(

By itself, it's a nice cleanup, but it doesn't provide any immediate
benefit over the previous state, while potentially introducing a
regression in one of the less tested architectures.

The question to me is really whether Nick has any pending work
that he would like to submit after this branch is merged into
mainline.

    Arnd
