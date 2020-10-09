Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CB288A34
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgJIOBl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 10:01:41 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgJIOBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 10:01:41 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mm9NA-1k0ahf2Mca-00iGrh; Fri, 09 Oct 2020 16:01:39 +0200
Received: by mail-qv1-f43.google.com with SMTP id s17so4778529qvr.11;
        Fri, 09 Oct 2020 07:01:39 -0700 (PDT)
X-Gm-Message-State: AOAM5302ERk7DEDG4Ujo23oAg3QFGVR/Y+x3p3UPxnOpQboQWZTlwAO1
        VzcCI1Agl4pZyxsHHMkw7P67lwcsWVATKRF/VPo=
X-Google-Smtp-Source: ABdhPJwjNmSCNPZJ7fvoFaz4dcFko8eQYPdZ2dZqQAjsZwcIZUcYPFriGUhRAzz2id1fnZeZYevCTfiUhQzeS2CbBRg=
X-Received: by 2002:a0c:b39a:: with SMTP id t26mr13068697qve.19.1602252098321;
 Fri, 09 Oct 2020 07:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200901141539.1757549-1-npiggin@gmail.com> <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
In-Reply-To: <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Oct 2020 16:01:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com>
Message-ID: <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op functions
To:     Nicholas Piggin <npiggin@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:krlM9bfXGg2NhHGF91LtOYfERmZceSJnAfxV+3onQuKMBF5ymV4
 FT61q70WpWKC2m+mdHrPYJ+fzppalYWvTojy1dmcwU8mzsTN3cBk/+AzhnXX+OMsyIGv/AA
 xEcxtIXXyT1XCHYMAa0SukLT7q5I8r+K47Zl+mRqyF1ffnE/H7Z6VxiD4t0GeJVMVjX9GOw
 /hykiCRsoC/a7slx9Wtow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:30IzcaTGSmk=:WvMtqoPqF6ME0vFdoyRi08
 6bcVMeoRL2F4Wo+YYa58qKTSK0+kFFXhcYLwlI/OqcA0w0EFdosnMGQukJPo2mXFHGsAvpo80
 QiAuQaQsp15mG57beaMlbaw02iXMTYEP/JQp8ElaHhqoG9lybUn3/19T0TcvBZGPEvVYrCbGN
 uQk4UqhcDrm32TbnppSkf6ZA6t6Z3SEahkhLH3PpBmeh0xg/H2PMqmzg2nQ/kQkyxL6m5znuk
 5ATavZciPbOSxCuIAoA9dF9dzcPtRqliRsZWf2lXNSMUFJmgXJjmVVowsPQEzPgu4zHbvTjtJ
 bpmvbzw6NvRDMnsJJqlPs3IgxWx+IRXG/XKtUTYik4+DuAlZDUM3ntxSwyT0J2saqlCxTik81
 ncoSFgBafbx5UQSE83g38t182eDSl/9U9qJcCr0Dl0Nu1A62veN/CiAg3Pfupux67Iz01CM89
 jfo5sR7dKz1PO4iAODHTmr/Qu41gQU7slbk+MbyyctFf35ZAZMvnKHP7RstfYWQktsayg3kLg
 RAayGUyguAdFkWxxluH1aDNPh8kt7/jsQOwVIbUXZmGNLjJG42VazNYMSeVa0SsPEEHNIL3BH
 U3mUBlV+iE61/wJadYmrbD0OmrV75MX6ddpLz3XsdWLTnUuMCKLbNUQmdluCDlszvqydfrBaQ
 hkFv1PHf4638jwIObKtiC2CRGgttyVwvRYTfksqbTos6AbQFJCZ9OYFkoGTatB6n4YoFVmZ9d
 +B3RqtbaNIAWOKELJrmcQpsCxhntMFThf3LZE4R8Y/JXWx3QCRb1UwrP9jCtOp2r+zB/S5idv
 TwYyVA9fvBbeLUCeFhn+DGdjuVBvNuF5gYAm7RQ4pXRD8buG1ErO8WSG7AmpP9+wC437XB5yM
 cLIREz+c6Cnmq509/N6kx8SOq4JoL8G9zlFVt3ADHSpW1YwmB5Ab0/ObS/qlsCWzWK0buWa9o
 h1jugmuRpBZwD75/ASHOiyHtNX2la5qA41kGOicJv5c0EejIaWX4V
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 9, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, 2 Sep 2020 00:15:16 +1000, Nicholas Piggin wrote:
> > It would be nice to be able to modify mmu_context functions or add a
> > hook without updating all architectures, many of which will be no-ops.
> >
> > The motivation for this series is a change to lazy mmu handling, but
> > this series stands on its own as a good cleanup whether or not we end
> > up making that change.
> >
> > [...]
>
> Applied to asm-generic, thanks!

Hi Nick,

I just noticed a fatal mistake I made when pushing it to the branch on
kernel.org: I used to have both a 'master' and an 'asm-generic' branch
in asm-generic.git but tried to remove the 'master' one as there is not
really any point in having two.

Unfortunately I forgot to check which one of the two was part of
linux-next, and it was the other one, so none of the patches I picked
up ever saw any wider testing aside from the 0day bot building it
(successfully).

Are there other changes that depend on this? If not, I would
just wait until -rc1 and then either push the branch correctly or
rebase the patches on that first, to avoid pushing something that
did not see the necessary testing.

      Arnd
