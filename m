Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B580287D0E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgJHUZv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgJHUZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 16:25:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E1C0613D2
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 13:25:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so6006504ljk.1
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEqjD09SgSyIvWPmDCyWGp6kbBmb0wz3VLFLWVAAGUk=;
        b=X4QWKYNqyqjS9Vvi4DU3kNSnqst8Z0vz9pWu3lP6WQ9Ho4y+G+x0Yt1BjdABjQdzc9
         sjQ3aOIni16Sy3mb88OikbdJ6kflpGETRwEUdl5k8PRsNmuz1KjCw7Efhc3KT2ItCaAv
         0or+7eX3KMopt6Dv4aLkHflcA+9jeNiZEKDO6XmtYpZ5bD3GJqNcZg5U9/la1IBvAlTs
         9si/LfruFgCufJC8Wsb1nqdVQrOlpBtlgQVmKiOFUSqYCLsFkqNhMz4O/KCmShA7rmZ3
         QHVnsbF5ze1uSXsCEsYX8YBM1aS3i4zHY0W81ag0lhFstGDM/C1PzVz3BIn6vxH0q2i0
         hK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEqjD09SgSyIvWPmDCyWGp6kbBmb0wz3VLFLWVAAGUk=;
        b=Fk6DPp4c2qZqLLw2W2RRwzCSBVZCPPUoDzmIDpMOLGm4fjnJG4c1kUVML3AKizCwcz
         /ySnntdz1WKPzXX+YNQwxa3Qlg9Dwl9yTu4hrTFCEONH+Ai9JrJ1uZQkVoWCEKPuVzIa
         3hv0ACO2hX1rc0+FJ2yAHuRPvM2UqdIyETKNbp8BqJPXAbW7/svJhfnXde6gEd6RRoD6
         1PDn6wDj1VgHgFTjKBTYL5KqzENmDSIVxgOH/VOhrvkVlPEqlvuUE1mD4I8Sf46f791D
         6hvrW1TOwIrZYNAg0tCqB5+Vai+9fFdbIo4PGjFAQBDZzrxeqcwtbyt+bJxjesXSld1P
         0lQQ==
X-Gm-Message-State: AOAM531W02/JpGPuh+zlP9v9YyqLH7gCCML/vbb3GyRaXwtDytK+k/to
        WAv+p94NX3t91gyKj6LiQEHyonMPrXXCgwRKs8c=
X-Google-Smtp-Source: ABdhPJwtZDIn1h8LnTfBTZXRPsiMNDNzZVhd+aSOKLxN7UYABZaOGqnyYTbGOBaLjbLjEjVOYDoBxkKATkqq9iJK3Wk=
X-Received: by 2002:a2e:9183:: with SMTP id f3mr95077ljg.343.1602188749295;
 Thu, 08 Oct 2020 13:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <ff2087f4983a2b93abef0a4ad31c1309f71ea52d.1601960644.git.thehajime@gmail.com>
 <295bff3f6ddc941dbf3933e8e310ad641da3ce01.camel@sipsolutions.net>
 <CAMoF9u3n-FyumX0S7vbjN-e+fWNe6k8aLeR-_BVJa7sR7qcFHg@mail.gmail.com> <38aee48aceda961fa7418b42f3f2055b8799cf9b.camel@sipsolutions.net>
In-Reply-To: <38aee48aceda961fa7418b42f3f2055b8799cf9b.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 23:25:38 +0300
Message-ID: <CAMoF9u2vEOPUx+wNWmt6fCKiHLEynB_O3j_YcYzDje6=jErkFQ@mail.gmail.com>
Subject: Re: [RFC v7 11/21] um: nommu: kernel thread support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 8, 2020 at 10:39 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-10-08 at 21:54 +0300, Octavian Purdila wrote:
> > On Wed, Oct 7, 2020 at 9:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > > nommu mode does not support user processes
> > >
> > > I find this really confusing. I'm not sure why you ended up calling this
> > > "nommu mode", but there *are* (still) (other) nommu arches, and they
> > > *do* support userspace processes.
> > >
> > > Isn't this really just "LKL mode" or something like that?
> > >
> >
> > This is a very good point, while some other patches make sense in the
> > nommu mode, this one does not - it is rather needed because of the
> > "library mode".
> >
> > Not sure what we can do other than creating a new "library mode" in
> > addition to the "nommu mode". Any suggestions?
>
> Well there's no "nommu mode" in UML other than what you're doing here,
> so as I said on some other patch, it sort of makes sense to have "LKL ==
> NOMMU", but the equation doesn't make sense everywhere, since it's not
> fundamentally NOMMU that drives the need for things (like here no
> userspace, elsewhere the ifdefs, etc.), but LKL-mode.
>
> So I don't think it would be *in addition* to "nommu mode" since such a
> thing doesn't exist on UML (only on other architectures), but mostly be
> a rename of "nommu mode" to "lkl mode" or so?
>
> Don't really have any other suggestions, or maybe I'm not understanding
> your question right.

OK, I agree, renaming "nommu mode" to "lkl mode" looks like the right
thing to do for now.

>
> > > IOW, why isn't this just
> > >
> > > void lkl_sem_free(struct lkl_sem *sem);
> > > void lkl_sem_up(struct lkl_sem *sem);
> > > ...
> > >
> > > and then posix-host.c just includes the header file and implements those
> > > functions?
> > >
> > > I don't see any reason for this to be allowed to have multiple variants
> > > linked and then picking them at runtime?
> > >
> >
> > We could try that and see how it goes. This was baked liked this long
> > time ago, when we wanted to support Windows and there was no proper
> > support for weak functions in mingw for PE/COFF (it still not
> > supported but at least we do have a few patches that fix that).
>
> You've required weak functions elsewhere, but in this case you don't
> even need them since you don't need things to link without an
> implementation? At least I don't see why you'd want to be able to link a
> binary that doesn't have an implementation of the ops required to run?

Yeah, all good points :) I'll discuss it more with Hajime to make sure
I haven't missed anything and we will try it in the next patch series.


> > > Yeah, what? That's an incomprehensible piece of code. At least add
> > > comments, if it _really_ is necessary?
> > >
> >
> > Yeah, sorry about that. We missed adding a bunch of comments in the
> > commit message. It got this complicated because of optimizations to
> > avoid context switching between the native thread running the
> > application and the kernel thread running the system call or interrupt
> > handler.
> >
> > Maybe we should revert to the initial simpler implementation for now
> > and add it later?
>
> Perhaps? Not really sure. Could the optimisations be added in steps so
> they're something that can be explained/followed? If not, well, perhaps
> to ease review for now it'd make sense to start simpler, but I guess
> eventually it'd still want some better explanation of what's going on.
>

OK, I'll discuss more with Hajime, at this point I think we might want
to focus on getting the basics merged first. In either case we will
make sure to have it properly explained.
