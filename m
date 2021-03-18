Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5433FC5A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 01:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCRAny (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 20:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCRAnt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 20:43:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFFC06174A
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 17:43:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f19so513176ion.3
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOag/GMbxvFnKe21R54I4959GVCR2CVEgzwMhhVFlb0=;
        b=O4FAh0AsJ5bANR6QDKzNnVi7bRnt9jz/h37ZR5tbKSCV9jB0UpjJVFNjmGG0f9sRO9
         keFoxK/03FeSnPHYT+aNiDfGKkMs26tdsdJ9E3Jnt6uAlm0ms3Oa6MLW06V2TW6PP4e5
         D/RNEA+C6yU/BCO7CNVnm1Z+41mKsN4VCDYJE/HsTJq1Kvu+FM76mdRbM5mYRQ5afGZC
         4g3/AGXu+AwCBIS5TnT/7m0xFLSVoMaggtBhVBmS3D5rQesflZ0lbsr/x9YPZ6dcWR/4
         COykxtR6eD9dNmGcknazUzUTeUjax73yrk6PaOAdWhpYxi8GwNRxFbOghRO6YLieGJAA
         1Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOag/GMbxvFnKe21R54I4959GVCR2CVEgzwMhhVFlb0=;
        b=JdNt33us6YzUBtvExVuRKArxSCfbvmWqhXyWPoweJiSjCzEi1Uo7bd+7r+KaOa7d4k
         cjg+X7XKtTwemdPW4MFxcfmFwuppY7jZ79nj98glPDm6Mp9GJPQOOeYvv59MvXgAdaW5
         syf+ntOxwEF0d1fzxhkZfU8i+uNmL3gvCgzLzJG6H+RUfJSzzqQ3EqvjkC6YgFdql4Aq
         wqPXqoyPYR6mJp9ioYfk8H0zUeHJEgbcM3SZAf8YD6ZgyZuA4st5QvbXz3N2BONQoiuX
         /KEfCNJQkFrS6a08O2XjF0FT/pkr1PGxsr4w93OORqKsq0JAmpI9oFCSjoVqw2NrWQ/f
         FeRw==
X-Gm-Message-State: AOAM530xwnrLryPoH92T5buuATCefy6tNjZOoOzazlRtlFUGV8eMcAwn
        LcPm/10nvGgqvRaJXXTcnpzYbuJ/B40omLVCLiw=
X-Google-Smtp-Source: ABdhPJwXQXNohvAh7T/t1qJMuSZpYssqeme/sivwCKHTC0lIwpL/LQzN/ZJx2W/8luOoPGzx9osNMt+CCjCYYHikek4=
X-Received: by 2002:a02:662b:: with SMTP id k43mr4865616jac.139.1616028228352;
 Wed, 17 Mar 2021 17:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1611103406.git.thehajime@gmail.com> <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
 <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
 <m25z1rc2ux.wl-thehajime@gmail.com> <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
 <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com>
 <3d3e446409d00dfbe62320832799d0a3b34b2b9c.camel@sipsolutions.net> <m2y2el9v1e.wl-thehajime@gmail.com>
In-Reply-To: <m2y2el9v1e.wl-thehajime@gmail.com>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 18 Mar 2021 02:43:37 +0200
Message-ID: <CAMoF9u26H9=Njr0MeOqcnro3PE1wgmXxN6FokLwJwZD5dZUkCw@mail.gmail.com>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
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

On Thu, Mar 18, 2021 at 2:15 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
>
>
> On Wed, 17 Mar 2021 23:28:10 +0900,
> Johannes Berg wrote:
> >
> > On Wed, 2021-03-17 at 16:19 +0200, Octavian Purdila wrote:
> > > > I can understand that your sample code wants btrfs just to show what it
> > > > can do, but IMHO it doesn't make sense to *always* enable it.
> >
> > Btw, what I said there also didn't distinguish between "always enable
> > it" and "always force it enabled".
> >
> > Right now this patch did the latter, but the former might sort of make
> > sense, but would take the form of a defconfig rather than a Kconfig code
> > change.
>
> Thanks, I understand the situation.
> I agree that using defconfig should be good in this case.  Will fix this.
>
>
> > > I agree. I think these can stay in defconfigs but here is where a
> > > library introduces complications which I don't know how is best to
> > > handle. Should we have the defconfig in arch/um or should we have it
> > > in tools/testing/selftests/um? Or perhaps both places, one being a
> > > generic config that would be used by most applications and one
> > > customized?
> >
> > Yeah, that's a question - and in that sense LKL will never be a general-
> > purpose "library" since then you'd have to basically build it with
> > "allyesconfig" instead of other things.
> >
> > Maybe just put a note there with the tools, and maybe a defconfig, and
> > then have some kind of detection at example/tool build or even runtime
> > that the necessary options are selected?
>
> preparing multiple defconfigs (e.g., tiny, normal, allyes) would be
> one option for build-time selection.
>
> Other possibilities (rather radical) could be to prepare multiple
> sub-libraries (liblinux-core.so liblinux-fs-ext4.so, liblinux-net.so,
> etc) so that users can pick only necessary codes when it's build (or
> open during runtime).  This needs to handle dependencies as kernel
> modules do, thus it's more complicated once we have this ?
>

Yes, this would be nice as it would allow distributions to build a
package for liblinux and simplify building applications with it. We
may be able to reuse some of the module work, maybe just the
dependency part as relocation should already be handled.
