Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB84C478D04
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhLQOF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 09:05:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56664 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhLQOF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 09:05:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0156A621DF;
        Fri, 17 Dec 2021 14:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F5C36AEA;
        Fri, 17 Dec 2021 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639749955;
        bh=R3p4IlxpIOk+bhmWK3QHe8v2JljS8h79moLro0wuj0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwjlCQ4gubETPTyimE5qoeuOU4KeKvyoR2caZCn3yTlqTPhvAU8aifzMghWWptjt1
         yomGTySuOrTSEsTI9lGYgcci4VctNHqo7SRB3OaNKw4IF2Iy5lKqZvTU82yaFUTIFT
         yJehBlIjIlJ5S6sXAtFJGfbvx/aAZzV9zelX1E0ouwU9rr6T0C/6ZHTzjkA/jLhPVe
         TRUKZylcDY0SvUZ8aaFqd5xypnXoAUiYvCTkOCvNoW4UAmM0p/jZKiEHuFEIakjd7N
         44EdabyleIZnIq7zNUNoyQ7F6obG6RyEvVGMWfRgkd2HpSjFdoMiChJ3gP0gtpvmPg
         +4Cp0y2AB3s5g==
Received: by mail-wm1-f49.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1616432wme.4;
        Fri, 17 Dec 2021 06:05:55 -0800 (PST)
X-Gm-Message-State: AOAM5324HyOuVjGWKDVWxl14ARxVMzjxdnVzNxR+bC+Aw7d1m6+ISjNI
        NdeL0nhRBiaMwVXNuCFAsMeOzPQxZV12k8wYSCw=
X-Google-Smtp-Source: ABdhPJxsUWz+N1ClJKnFPY/XkFL+DUSGHrR7kXnuztqtzZoPPENmUDb8MbOTP3vLH1mkgHgayBgiQkrzJxRkW3F2c7M=
X-Received: by 2002:a1c:8013:: with SMTP id b19mr2770905wmd.35.1639749953718;
 Fri, 17 Dec 2021 06:05:53 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com> <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com> <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com> <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
 <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com> <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
In-Reply-To: <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 17 Dec 2021 15:05:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2=gm1OZtD+tN8Cn1RCuuOOCKFLyf6E2NzNYjeqNRq5bA@mail.gmail.com>
Message-ID: <CAK8P3a2=gm1OZtD+tN8Cn1RCuuOOCKFLyf6E2NzNYjeqNRq5bA@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 17, 2021 at 2:52 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > The CONFIG_LEGACY_PCI should take care of a lot of it, and I
> > think that can be a single patch. I'd expand the Kconfig description
> > to explain that this also covers PCIe devices that use the legacy
> > I/O space even if they do not have a PCIe-to-PCI bridge in them.
> >
> > The introduction of CONFIG_HAS_IOPORT, plus selecting it from
> > the respective architectures makes sense as another patch, but
> > I would make that separate from the #ifdef and 'depends on'
> > changes to individual subsystems or drivers, as they are
> > better reviewed separately.
>
> Sounds like a plan. How should I mark authorship in the split up
> patches. I definitely still see you as the main author to all of this
> but of course I'll have to do quite a bit of editing and you shouldn't
> get blamed for any mistakes I make. So not sure how to handle Sign-off-
> bys and git's author property.

I don't care much either way. The two options are:

a) leave me as patch author, with my Signed-off-by, and list
    in the changelog what you have changed that wasn't in
    my version

b) list me as 'Co-developed-by' and have yourself as the patch
    author.

        Arnd
