Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A59287AEF
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgJHRYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJHRYY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 13:24:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC8FC061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 10:24:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so6605101ljj.8
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY6UQChdFaVJ5YnMTTZoR/8o3FiYaRTkUYityYQadUg=;
        b=odRr7BL6wqi/jGfL5tAZXPJjAZUxhfkgSpur0rSPubQur7F4Hk47OmUl9Qgx9DvgW7
         qpYnC98av90XxOcCAUnUxGr8hxs1zwPTswIEmwRaiB/6h9U8CrGiLXGKuZxAhsmwQ/tk
         ub8eNcE+v6Ytj2SHV1+lIvD3OLZyDjtirJlmvwl1WRuXyaEfueq7CXsm5eADQYHOirgQ
         uZAwl6kozpK6XrDd69Yz3XLFUxVHorgbPlN1j9nwPKcro8tEMkf8yZwW+OmcgKw8oSrQ
         nqxmuOWLdfdIMcBhzsiDigyHNIOFgtANmOWojspO6xVvyR91ZoJcmVms4AVuomtJz71J
         1/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY6UQChdFaVJ5YnMTTZoR/8o3FiYaRTkUYityYQadUg=;
        b=hSzwEbsAIDv8cNnQnOMKl2bZzOu6+4lCTKbstnzNfZTr3GBUiCOCI0k/qD5Vce5ZtI
         I7la0jMPXIIbHyWJTOTYA0+qnGVVHnbAYH9lh15PWd68ulnmjK70V2HZlZmvMPtUqUtR
         dYSs14HfKzJT/1yJoQNNAg+gIcH7YnBxC5Wgx/rQ5VpeXxqakoJjrw4AXIArDhNz6b3v
         /bpknLYiwTRq56twXNUIrWhwCTlT6QukomEy5qBogLAMoP5r0IwXQQ4NhLXRRkxafHxR
         99iB62nacjTehpimzfoDIVvR3pgVq01IxEOTfEkxsM47hthw0zdeijEVQfUcowY4aJTs
         jiGg==
X-Gm-Message-State: AOAM533gzxpr90yq44TiFHkYf9SY5VF6F4NE9U05vE+wkCCxiU1/6CJb
        3xdtsiNwfcPvXFuIQ8NL4sTcNwTsfTpagSFkzis=
X-Google-Smtp-Source: ABdhPJwAAxbPgjp+9UvFMsrtVX9eJ+4xeFlgDMPphvSYQnCO+GLSLkvskPIevu9MXZq28Aw1yCPOdv0vzhwdaJOUxR4=
X-Received: by 2002:a2e:6816:: with SMTP id c22mr3986940lja.200.1602177862121;
 Thu, 08 Oct 2020 10:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600922528.git.thehajime@gmail.com> <cover.1601960644.git.thehajime@gmail.com>
 <1ba41b09-6bdb-2fb7-5696-7db429e0a6a5@cambridgegreys.com> <m2362o6hmv.wl-thehajime@gmail.com>
 <003d0714-3bb6-dc02-ba3d-0237f8c5f40c@cambridgegreys.com> <CAMoF9u1j3hO_+jYvFdVvowG6mAYM=yEBV4z2BjfyUB=zhrF-3g@mail.gmail.com>
 <9b618028-d333-dfe2-ab23-bc8f0da06832@cambridgegreys.com>
In-Reply-To: <9b618028-d333-dfe2-ab23-bc8f0da06832@cambridgegreys.com>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 20:24:11 +0300
Message-ID: <CAMoF9u26zM22hKruTEc=LrYEV4bYOUtE5K_TtaqOuQ-szK06PA@mail.gmail.com>
Subject: Re: [RFC v7 00/21] Unifying LKL into UML
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 8, 2020 at 8:18 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 08/10/2020 18:13, Octavian Purdila wrote:
> > On Thu, Oct 8, 2020 at 3:50 PM Anton Ivanov
> > <anton.ivanov@cambridgegreys.com> wrote:
> >>
> >> On 08/10/2020 13:12, Hajime Tazaki wrote:
> >>> Hello Anton,
> >>>
> >>> On Wed, 07 Oct 2020 22:30:03 +0900,
> >>> Anton Ivanov wrote:
> >>>> On 06/10/2020 10:44, Hajime Tazaki wrote:
> >>>>> This is another spin of the unification of LKL into UML.  Based on the
> >>>>> discussion of v4 patchset, we have tried to address issue raised and
> >>>>> rewrote the patchset from scratch.  The summary is listed in the
> >>>>> changelog below.
> >>>>>
> >>>>> Although there are still bugs in the patchset, we'd like to ask your
> >>>>> opinions on the design we changed.
> >>>>>
> >>>>> The milestone section is also updated: this patchset is for the
> >>>>> milestone 1, though the common init API is still not implemented yet.
> >>>>>
> >>>>>
> >>>>> Changes in rfc v7:
> >>>>> - preserve `make ARCH=um` syntax to build UML
> >>>>> - introduce `make ARCH=um UMMODE=library` to build library mode
> >>>>> - fix undefined symbols issue during modpost
> >>>>> - clean up makefiles (arch/um, tools/um)
> >>>> Hi Hajime, hi Tavi,
> >>>>
> >>>> Our starting point should be that it does not break the existing build. It still does.
> >>> I agree with the starting point.
> >>>
> >>>> If I build a "stock configuration" UML after applying the patchset
> >>>> the resulting vmlinux is not executable.
> >>> Ah, I confirmed the issue.
> >>> I was only trying to make the `linux` binary compatible, not vmlinux.
> >>>
> >>> Because vmlinux is now build as a relocatable object, this is
> >>> something we need to figure out if we wish to keep vmlinux executable.
> >>>
> >>> Do you think we should make vmlinux executable even if we have the
> >>> file linux executable ? If yes, we will work on this to fix the issue.
> >> In my opinion, any relocatable objects, etc should be clearly named - either .o, .so, etc depending on what they are. We should not try to reuse any of the existing files for a different purpose.
> >>
> >> I also agree with Johannes that we are not using the tools/ directory for its intended purpose.
> >>
> >> We are not trying to build a tool. We are trying to build a sub-architecture. IMHO, the build should use a subdirectory under arch/um.
> >>
> > Hi Anton, Johannes,
> >
> >  From strictly the UML point of view, I can see how this would be a
> > sub-architecture build since we are doing both the kernel build and
> > the UML binary as a single step.
> >
> > If we look at arch/um as just the kernel that enables many
> > applications, just one of which it is uml, I believe it is cleaner to
> > build specific applications elsewhere. That is why we proposed to do a
> > two step build process: one that builds the kernel as a relocatable
> > object and one that uses this object to build programs, shared
> > libraries, etc. Besides allowing us to create multiple tools /
> > applications it also makes it much easier to support multiple OSes or
> > other environments (e.g. bare-metal applications). As you can see,
> > this allowed us to remove the linker script for UML and instead just
> > used the target compiler to build the executable.
>
> I have no objection to the proposal. In fact I like it very much.
>
> My only concern is that we end up with files which are named identically
> to already existing ones.
>
> IMHO, the kernel relocatable object should be vmlinux.a or vmlinux.so or
> vmlinux.o. It should not replace an already existing file which behaves
> differently.
>

Got it, we will change that for the next patch series.
