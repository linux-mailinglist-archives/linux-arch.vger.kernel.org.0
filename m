Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC2538A0BE
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhETJXu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 05:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhETJXu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 05:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C59D6135B;
        Thu, 20 May 2021 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621502549;
        bh=mUcJvIDAEBZyVHNKECFJUZjJN3jvp0QlOwLkY/Lr9Fk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cueszxQKwQo1fo7eIWpKuItZ8ECXgi/2vnaWA0pNz+29DdsMCsgVBrOylLW1Tc796
         ykghyQdgdNweB99uGbZpBiR/abnhi6a6tvpDSRJBSlTRH+guNjbEILhH11pM5YVW8l
         qikrLp12Gf3+V0bI2mTYHPHnuLF0sMWN+jW1Zc9wp2Hnz4R6Qx6IqWRrTyetKnOTxT
         VTAYRrZ5Cty92fnQiP6W2f7v4CjKifEpoWSK06xHDI2820QymWBehcgfdTzIfeA1+S
         axUDrX0WCefyze7NmG8HS8370jvh0dHH2OX6jwBgO/zCzl5dACYCmgdd7qT1dFDN63
         +47eoiF2EDfgQ==
Received: by mail-wr1-f49.google.com with SMTP id n2so16960849wrm.0;
        Thu, 20 May 2021 02:22:29 -0700 (PDT)
X-Gm-Message-State: AOAM530wSHLlQY/IxbV8+KgIOXuQNcSRlcK5sl2nUhEDoIqsXLJWFiAW
        TtkwIT3xox3uLR+w9gNoCNSomurX5s0+D8S+1qc=
X-Google-Smtp-Source: ABdhPJzsrao8n8zbfttxKQpALJPp9YROd3f6fNW2rL/Ta9Y6h4hoYQ0fRUSF+pGM0FB3yjSG8oB6dY7AKuvOfp8E4v0=
X-Received: by 2002:adf:e589:: with SMTP id l9mr3343339wrm.361.1621502547736;
 Thu, 20 May 2021 02:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-5-arnd@kernel.org>
 <87h7iycvlo.ffs@nanos.tec.linutronix.de> <CAK8P3a0KULCWrGZt=C9uWDgqNf184KC-uaK9rN8ZXjTG1HAqsw@mail.gmail.com>
In-Reply-To: <CAK8P3a0KULCWrGZt=C9uWDgqNf184KC-uaK9rN8ZXjTG1HAqsw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 20 May 2021 11:21:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2fBRe4PS40iV5-_LQGuAneN1HKksq6Xp3ETijs5xxG_Q@mail.gmail.com>
Message-ID: <CAK8P3a2fBRe4PS40iV5-_LQGuAneN1HKksq6Xp3ETijs5xxG_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] compat: remove some compat entry points
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 11:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 10:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, May 17 2021 at 22:33, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > These are all handled correctly when calling the native
> > > system call entry point, so remove the special cases.
> > >  arch/x86/entry/syscall_x32.c              |  2 ++
> > >  arch/x86/entry/syscalls/syscall_32.tbl    |  6 ++--
> > >  arch/x86/entry/syscalls/syscall_64.tbl    |  4 +--
> >
> > That conflicts with
> >
> >   https://lore.kernel.org/lkml/20210517073815.97426-1-masahiroy@kernel.org/
> >
> > which I'm picking up. We have more changes in that area coming in.
>
> Ok, thanks for the heads-up. I'll try a merge or rebase to see how this can be
> handled. If both the drivers/net and drivers/media get picked up for 5.14, maybe
> the rebased patches can go through -mm on top, along with the final
> removal of compat_alloc_user_space()/copy_in_user(). If not, I suppose these
> four patches can also wait another release.

On second thought, this patch 4/4 is not even required here to kill off
compat_alloc_user_space, so the easiest alternative might be to merge the
other patches first, and then do this part together with the removal of
the unused functions in a follow-up series.

        Arnd
