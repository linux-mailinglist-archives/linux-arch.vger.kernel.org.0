Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96541287ABC
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgJHRNi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730738AbgJHRNi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 13:13:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41407C061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 10:13:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w11so7387173lfn.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaCJnSlPIyciQt4nD8G9yh1BgvSsCf2UaCoov08ls9E=;
        b=p3LPZPQG4i2fwOiA6i2DpESOVz43wfEyhtE5skH74r2krsQdqVYS0gcxJ1l0btFthG
         umZSDvDCXZBUfVTqbjZCkfWV7Zq9TTejGGt71rnpSuKlNmpmiAmw6j11Bh/lCuAE9+VP
         yjuaW83Ui/2MuP1jfUmrw7PjWnzWVW3KpHYIP2u4mlHWJcqdFZtVZkdUAsbHEDZWGcQF
         dXMbUoiqvVlHyH+T1n5ta1Xz9MVxfd+wAmWCp0sS/Us9e96HnK6SDq34ZpmTBT5ads5q
         Q08njIREP2/AQA/V1hs7OtGiUOsemiLlqkmwl3f+PPr8RXAAzm0LBacaIE1usXhxIQIB
         EDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaCJnSlPIyciQt4nD8G9yh1BgvSsCf2UaCoov08ls9E=;
        b=Oj5RVFjOJ4WdI5eOvqdzUN7NVijxGA3Ro2DmlXpdqK3lPt/ekY2NalFHPxXMMl6gms
         NC7Pnu4zNSYq4sRoqMom00oxloeWEhp+14ylWwxNz8AaUSs8fffl/zWFMmEUeNWxFUzh
         c+H9zCsBWUC+dUhXNrAE4xvQw4rAJy59AGWgbkJSz+q1cOH6nl/DvvHQNhvtBe59lQIF
         lSt8N80vhNQ5F+dlrNP/sz9pAlbna5jFoEO26N44hn/glCBvgC0wOF6nLRtHSp7UM6bZ
         u9xJdYzg3upBOa5zQpzGKaRLGbTnVG2IlEIKM8YijksK7g5YKLRRfBfv9jMmh5GlQfNb
         3VuA==
X-Gm-Message-State: AOAM531ULEZILoTfvbjqhZlbOmGIDIXb6fqB8LUjHjhC+1UagN/+/Q0X
        +IiewtoysiEQh8sB4n02u25zANc1QQAmDJz+Uc0=
X-Google-Smtp-Source: ABdhPJyDC3I+2qgUbNQrjZQRbETw7TQcjKQ8+HLi54/H25WX0Js82P26l4tjlpXedcSzBhBXmAcg2bjeVZ9VKo5TslY=
X-Received: by 2002:ac2:59d9:: with SMTP id x25mr2781194lfn.4.1602177216636;
 Thu, 08 Oct 2020 10:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600922528.git.thehajime@gmail.com> <cover.1601960644.git.thehajime@gmail.com>
 <1ba41b09-6bdb-2fb7-5696-7db429e0a6a5@cambridgegreys.com> <m2362o6hmv.wl-thehajime@gmail.com>
 <003d0714-3bb6-dc02-ba3d-0237f8c5f40c@cambridgegreys.com>
In-Reply-To: <003d0714-3bb6-dc02-ba3d-0237f8c5f40c@cambridgegreys.com>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 20:13:26 +0300
Message-ID: <CAMoF9u1j3hO_+jYvFdVvowG6mAYM=yEBV4z2BjfyUB=zhrF-3g@mail.gmail.com>
Subject: Re: [RFC v7 00/21] Unifying LKL into UML
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 8, 2020 at 3:50 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
> On 08/10/2020 13:12, Hajime Tazaki wrote:
> > Hello Anton,
> >
> > On Wed, 07 Oct 2020 22:30:03 +0900,
> > Anton Ivanov wrote:
> >>
> >> On 06/10/2020 10:44, Hajime Tazaki wrote:
> >>> This is another spin of the unification of LKL into UML.  Based on the
> >>> discussion of v4 patchset, we have tried to address issue raised and
> >>> rewrote the patchset from scratch.  The summary is listed in the
> >>> changelog below.
> >>>
> >>> Although there are still bugs in the patchset, we'd like to ask your
> >>> opinions on the design we changed.
> >>>
> >>> The milestone section is also updated: this patchset is for the
> >>> milestone 1, though the common init API is still not implemented yet.
> >>>
> >>>
> >>> Changes in rfc v7:
> >>> - preserve `make ARCH=um` syntax to build UML
> >>> - introduce `make ARCH=um UMMODE=library` to build library mode
> >>> - fix undefined symbols issue during modpost
> >>> - clean up makefiles (arch/um, tools/um)
> >> Hi Hajime, hi Tavi,
> >>
> >> Our starting point should be that it does not break the existing build. It still does.
> > I agree with the starting point.
> >
> >> If I build a "stock configuration" UML after applying the patchset
> >> the resulting vmlinux is not executable.
> > Ah, I confirmed the issue.
> > I was only trying to make the `linux` binary compatible, not vmlinux.
> >
> > Because vmlinux is now build as a relocatable object, this is
> > something we need to figure out if we wish to keep vmlinux executable.
> >
> > Do you think we should make vmlinux executable even if we have the
> > file linux executable ? If yes, we will work on this to fix the issue.
>
> In my opinion, any relocatable objects, etc should be clearly named - either .o, .so, etc depending on what they are. We should not try to reuse any of the existing files for a different purpose.
>
> I also agree with Johannes that we are not using the tools/ directory for its intended purpose.
>
> We are not trying to build a tool. We are trying to build a sub-architecture. IMHO, the build should use a subdirectory under arch/um.
>

Hi Anton, Johannes,

From strictly the UML point of view, I can see how this would be a
sub-architecture build since we are doing both the kernel build and
the UML binary as a single step.

If we look at arch/um as just the kernel that enables many
applications, just one of which it is uml, I believe it is cleaner to
build specific applications elsewhere. That is why we proposed to do a
two step build process: one that builds the kernel as a relocatable
object and one that uses this object to build programs, shared
libraries, etc. Besides allowing us to create multiple tools /
applications it also makes it much easier to support multiple OSes or
other environments (e.g. bare-metal applications). As you can see,
this allowed us to remove the linker script for UML and instead just
used the target compiler to build the executable.

We have picked tools because it has the infrastructure to build
programs, shared libraries, and it is the single place (AFAIK) where
we don't link the code in there with the kernel binary.

Thanks,
Tavi
