Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8255368F7C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhDWJhw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 05:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhDWJhw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Apr 2021 05:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE646144D;
        Fri, 23 Apr 2021 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619170635;
        bh=DhWbEd6Zvej3S1gi9RrvaWUTau2t6QhBVtOz/AAHkCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AWXh7jkigqZyb4phESyB8qzBxlF5kBw2rJTxmT89CflV8bWUOnwpS8uiVMUShm8Z3
         024BBWofWDpYOSlZih/r2j5VtxR/KU4tZpFVxJ4NPvSdcpIz1zWaiyLErdRtTrop8A
         sF+pKRnX70UKVtTTsZmiyt5DFaiOxFzgknqsEa5POLUnCrmZAEEzfoN7aZsz/me5Er
         gv4g8qeemNIsjhQfvbtJVFTTyXWz3/pw8KIkjKaZkAcTOcxGFb64R7X81YeDWHNyyI
         FT107TIQ1p24RWiWdzyPZ7R7XOCJGIbiny8UgVbHuvR9DeFgannYm+ikOAO1eVlWKC
         XlSc5jOcBBJ2w==
Received: by mail-wr1-f52.google.com with SMTP id p6so41015380wrn.9;
        Fri, 23 Apr 2021 02:37:15 -0700 (PDT)
X-Gm-Message-State: AOAM531Ii/zN2Z6ebcD8F5lrzARQJSkdevC4fJEqC1grX4Aj9P8cIcwZ
        UYd/FrlsgaRajUuFszO6Bdps7chclP56KOPDJq0=
X-Google-Smtp-Source: ABdhPJzZmFcXcp4maY4jkuBcNPwUzX/RFcQIP2ASUdLO84NCx4+UA6Z5ZqhZAvPt9eOmSU0Kf5SYBYFsjwBaDOvZ6Ec=
X-Received: by 2002:adf:db4f:: with SMTP id f15mr3513380wrj.99.1619170634187;
 Fri, 23 Apr 2021 02:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
In-Reply-To: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 23 Apr 2021 11:36:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Message-ID: <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Subject: Re: ARCH=hexagon unsupported?
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Arnd,
> No one can build ARCH=hexagon and
> https://github.com/ClangBuiltLinux/linux/issues/759 has been open for
> 2 years.
>
> Trying to build
> $ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu make LLVM=1 LLVM_IAS=1 -j71
>
> shows numerous issues, the latest of which
> commit 8320514c91bea ("hexagon: switch to ->regset_get()")
> has a very obvious typo which misspells the `struct` keyword and has
> been in the tree for almost 1 year.

Thank you for looking into it.

> Why is arch/hexagon/ in the tree if no one can build it?

Removing it sounds reasonable to me, it's been broken for too long, and
we did the same thing for unicore32 that was in the same situation
where the gcc port was too old to build the kernel and the clang
port never quite work in mainline.

Guenter also brought up the issue a year ago, and nothing happened.
I see Brian still occasionally sends an Ack to a patch that gets merged
through another tree, but he has not send any patches or pull requests
himself after taking over maintainership from Richard Kuo in 2019,
and the four hexagon pull requests after 2014 only contained build fixes
from developers that don't have access to the hardware (Randy Dunlap,
Viresh Kumar, Mike Frysinger and me).

       Arnd

[1] https://lore.kernel.org/lkml/04ca01d633a8$9abb8070$d0328150$@codeaurora.org/

---
$ git log --grep=linux-hexagon-kernel
commit bb736a5c0e9a2605f11c2bbb60a68f757832da32
Merge: 45979a956b92 18dd1793a340
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Sep 20 11:28:43 2019 -0700

    Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel

    Pull Hexagon maintainership update from Richard Kuo:
     "I am leaving QuIC, and Brian Cain will be taking over maintainership
      of the Hexagon port"

    * 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel:
      Hexagon: change maintainer to Brian Cain

commit 72d4c6e5893a122c2fd060ded2b490582a5bb377
Merge: 1d176582c795 5c41aaad409c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 13 16:33:26 2018 -1000

    Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel

    Pull hexagon fixes from Richard Kuo:
     "Some fixes for compile warnings"

    * 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel:
      hexagon: modify ffs() and fls() to return int
      arch/hexagon: fix kernel/dma.c build warning

commit 2d618bdf71635463a4aa4ad0fe46ec852292bc0c
Merge: f2125992e7cb 330e261c35df
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue May 1 19:54:22 2018 -0700

    Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel

    Pull hexagon fixes from Richard Kuo:
     "Some small fixes for module compilation"

    * 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel:
      hexagon: export csum_partial_copy_nocheck
      hexagon: add memset_io() helper

commit 0cdf5a464070c8a2980a27113c47fb8e71babb9c
Merge: 65c61bc5dbbc 02cc2ccfe771
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 10 16:19:07 2015 -0700

    Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel

    Pull hexagon updates from Richard Kuo:
     "Just two fixes -- one for a uapi header and one for a timer interface"

    * 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel:
      Revert "Hexagon: fix signal.c compile error"
      hexagon/time: Migrate to new 'set-state' interface
