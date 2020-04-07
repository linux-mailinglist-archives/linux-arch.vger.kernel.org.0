Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31E61A15F3
	for <lists+linux-arch@lfdr.de>; Tue,  7 Apr 2020 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDGTZl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Apr 2020 15:25:41 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45210 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDGTZl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Apr 2020 15:25:41 -0400
Received: by mail-lj1-f179.google.com with SMTP id t17so4998847ljc.12
        for <linux-arch@vger.kernel.org>; Tue, 07 Apr 2020 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cTvV83D9tyi0R+IQtypCgkVC9GEIyiZWJmJET7kjhGw=;
        b=HAlLzotb9PU34aLkQ1YZV2sHVnDWRiDqERuQNFq1Lgpueu8nNAMhW2f3TEg5ZiceVe
         esVXN+LhFhJoA+x8yyZi25C9SQrqSJgx4lISXRug/CODk3ch8AANRIfqsT5D/msE8vkC
         D2fuP8LLh2OgAyRsBpkAInIMOtk8ylp8kWfujJrZqvkfe2Cyb3qY4L4Bmqt0kYYnMrH2
         C7t6yD6IFiGSr8W+pq7Ipzr3zoqfs3d+dXGyKMq2HtSqW6+HN0bAgcR4907fKfn3bXXK
         nZZGWnQZfCs1NiUF3C4UY+mxSR84ZLCe2jS6JQPp6ufo9JQGvuFsgpd0atZ3LhcXau8i
         bmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTvV83D9tyi0R+IQtypCgkVC9GEIyiZWJmJET7kjhGw=;
        b=PmYjLCmhTX8uL1IRU4v40kMmFX2wp5WQB65H7NVRb/fb8eQk/S1RYri5F6PzNmcNKi
         Fj1f4GIoe4ENXOsfrUp2sSwDdsTjz+bU//vUiirbHZVYn8Z7XMq6PfzGPGFHw8pSsFZi
         hUG7OQT7kTLHtVrxVj9CGnTDmYk61BEJ52dQyD0l6dHUozxZpI7k+AbwHu3VpdHDoViO
         2k3DZ09289WtiRriNSjIW47V+Sb6T99NDRqPthSH0eHNEb6YftalmwqUUpfqt4i2B3Hj
         FtHtAjugISJX+xrn8D8Cax5qqWGWgZlVDDnX5L7f3NC/VTqqBKvSRHQBOaTf6azUfkNH
         2L7A==
X-Gm-Message-State: AGi0PuaNM2H70Uq05/rp+UxcZrSC7G3ube8ooxDrp7aiWLuolSL2eAZg
        ZT+Qb7lZB0GFkgv/LlvOV90k2m/oWakkpaPY1hI=
X-Google-Smtp-Source: APiQypJd52M9JP6lflf4jxKcg8K0qiC7e7im/va0coeD1jvOIT2UPF3K1VUelMFxAWQKwNWPJvEFYaiiJjkEopZC/Pw=
X-Received: by 2002:a2e:a586:: with SMTP id m6mr2463483ljp.32.1586287538708;
 Tue, 07 Apr 2020 12:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585579244.git.thehajime@gmail.com> <dca6ea7260830a03c060f57e6ab9961f16ad55ed.1585579244.git.thehajime@gmail.com>
 <a84f3d7bcddbaa6125349c4bcdec6e3e07d6b783.camel@sipsolutions.net>
 <CAFLxGvyFqXZSmMcD_=o81AHLzdM_u2iH8h412w7VZrxON7Ohig@mail.gmail.com>
 <m21rp9xaqt.wl-thehajime@gmail.com> <ba2199bd17b6457c97305f6688b13ed36e7feac3.camel@sipsolutions.net>
 <m2tv22wfmr.wl-thehajime@gmail.com>
In-Reply-To: <m2tv22wfmr.wl-thehajime@gmail.com>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Tue, 7 Apr 2020 22:25:27 +0300
Message-ID: <CAMoF9u11mUvOO6NZoEq9Hu=ndOz_2he3Mjb2dEpCEAT6fk_CjQ@mail.gmail.com>
Subject: Re: [RFC v4 02/25] um lkl: architecture skeleton for Linux kernel library
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Levente Kurusa <levex@linux.com>,
        Matthieu Coudron <mattator@gmail.com>, cem <cem@freebsd.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jens Staal <staal1978@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Akira Moroo <retrage01@gmail.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Yuan Liu <liuyuan@google.com>,
        Mark Stillwell <mark@stillwell.me>,
        pscollins <pscollins@google.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        Pierre-Hugues Husson <phh@phh.me>,
        sigmaepsilon92 <sigmaepsilon92@gmail.com>,
        Luca Dariz <luca.dariz@gmail.com>,
        "Edison M . Castro" <edisonmcastro@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

<snip>


> > And like I said before, that decision will frame everything else. I
> > really don't think we can make significant progress here without having
> > decided whether this is possible.
> >
> > Perhaps UML *can* become a "special case" of LKL, with a special API
> > function (that's not part of the syscall surface) to "boot(cmdline)" or
> > something. But if it can't, and has to remain as separated as the two
> > are today, I would argue we're better off just not calling them the sam=
e
> > architecture.
>
> I agree with this if the unification has all completed.
>

I tought a lot about this and I agree with Johannes that if we want to
unity UML and LKL we should start with the hard parts.

I am also starting to think that it is unlikely to be able to merge the
two "nicely" and that we should probably turn this on its head and start
with reworking UML towards the LKL features. We will end up
re-implementing *some* of the LKL concepts from scratch in UML but I
think at this point this is unavoidable.

Here are my thoughts on a very rough plan for doing that:

Milestone 1: LKL lib on top of UML
 * Kernel - Host build split
   Build UML as a relocatable object using the UML=E2=80=99s kernel linker
   script.
   Move the ptrace and other well isolated os code out of arch/um to
   tools/um (or maybe start directly with tools/lkl?)
   Use standard host toolchain to create a static library stripped of
   the ptrace code. Use standard host toolchain to build the main UML
   executable.
   Add library init API that creates the UML kernel process and starts
   UML.
* System calls APIs
   Add new system call interface dbased on fd irq.
   Use the LKL scripts to export the required headers to create system
   calls APIs that use the UML system calls infrastructure.
   Keep the underlying host and driver operations (threads, irqs, etc.)
   as they are now in UML.
 * Boot test
   Port the LKL boot test to verify that we are able to programatically
   issue system calls.

Milestone 2: add virtio disk support
 * Export asm/io.h operations to host/os. Create IO access operations
   and redirect them to weak os_ variants that use the current UML
   implementation.
 * Add the LKL IO access layer including generic virtio handling and the
   virtio block device code.
 * Port LKL disk test and disk apps (lklfuse, fs2tar, cptofs)

Milestone 3: new arch ports
  * Abstrac the system call / IRQ mode the move the implementation to host
  * Abstract the thread model and move the implementation to host
  * Add LKL thread model and LKL ports

Thanks,
Tavi
