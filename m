Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692B6287B2C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 19:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgJHRsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHRsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 13:48:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57180C061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 10:48:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so7463313lfs.13
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWx52P7NdIDgNqHP52ADcmPOZbfNe9S3idC4urBmNbw=;
        b=sQPCf8imh6renbI7uR8CD7gL0n0jsCjHJLDtMZe/k026hDbDd2ben2obHbDFRBiJvD
         O3sX37J99MWaumtBIZ6miHt3kOtqkFuhO8sQZ4waXE6WC/2f3iL6Rpmo1iv4GnlXVCKb
         a8Nt3QeujLmMiIY5aVHGUgMf/X7mXtbdW12OzBJxbeRPsd0LsDL5pegrve1Vf3la6dv1
         YpLWVAsPTaKdGKaOy8Gg4NLHkB9hmNvYFy+dyJR181TNBTWPUJxZ5RIjjbx3tDCu6LRI
         jEOOger02FGI9DjiCqgWLUTWck+sE1kAHHZXypS2dJs5wcH+svwofwOZGvACu9vRNSjb
         z4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWx52P7NdIDgNqHP52ADcmPOZbfNe9S3idC4urBmNbw=;
        b=SGj3Vope7KwLKLPWnoT9U8FIiRCuL0qIedcFapS8Mv3RW1N6z4EsmvQb/t6GYTaecd
         /W4WheC+nYBZzqzNW6IcqeF26YHf4hTlce/FRyoPUxZkiYTH/x6V6hau+noJirJHZiYe
         IKmTkt18uEERp1u1HBu1D64+M8mnMcAZtlSbzT3mLZMbNydjqmnQz0aHLmu6Wqum9yr0
         tbLnfltMiQSJ48lZ7e4/OdWOUEqq6bbYj9SkB70vOJ59B6rYnJjc/+WS5EwbonWVuapE
         5bHaaHRWuoTPsJ5tCH7S45x7ycNdJiCPrtDTFOvED1ImTROWOTPwYkSk4MJrKKbvXBnt
         S2Ww==
X-Gm-Message-State: AOAM531jcGEnn4qGHxld7HwXBVyChb2RGo27YVi7B1PoLdjzbT5Vj91u
        xGhmraI9We/F6Bw4DgmkgNJQ1s4x1Brg/vxdwDV0yYpRyFsrdr08
X-Google-Smtp-Source: ABdhPJybPhbw1YN7eYjx/MJdJuNqB+ZqWBpDLFImA3uTeeGfwu1i4hUoJz2RHqB9cgMymTHI/8LUQzq5wvmNMYAq/kk=
X-Received: by 2002:a19:8c17:: with SMTP id o23mr2865258lfd.279.1602179308630;
 Thu, 08 Oct 2020 10:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
 <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
In-Reply-To: <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 20:48:18 +0300
Message-ID: <CAMoF9u1XX6gJpPfUh-6hmh1RNosn+=GUf75FQsMoxacrP=f7jg@mail.gmail.com>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
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

On Wed, Oct 7, 2020 at 6:20 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>

Hi Johannes,

Thank you for the review.

> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > This patch moves underlying OS dependent part under arch/um to tools/um
> > directory so that arch/um code does not need to build host build
> > facilities (e.g., libc).
>
> Hmm. On the one hand, that build separation seems sensible, but on the
> other hand this stuff *does* fundamentally belong to arch/um/, and it's
> not a "tool" like basically everything else there that is a pure
> userspace application to run *inside* the kernel, not *part of* it.
>
> For that reason, I don't really like this much.
>

I see the os_*() calls as dependencies that the kernel uses. Sort of
like calls into the hypervisor or firmware.

The current UML build is already partially split. USER_OBJS build with
a different rule set than the rest of the kernel objects. IMHO this
change just makes this more clear and streamlined, especially with
regard to linking.

>
> >  tools/um/uml/Build                            | 48 +++++++++++++++++++
> >  tools/um/uml/drivers/Build                    | 10 ++++
>
> Also, what's with the names here? What's wrong with "Makefile"?
>
>

We are using the same build system as the rest of the stuff in tools.
Since it is building programs and libraries and not part of the kernel
binary build, it is using a slightly different infrastructure, which
is detailed in tools/build/Documentation/Build.txt

> I'm also not sure I see how this is built at all from the top level
> Makefile? Oh. I think Anton said it doesn't ... that alone would be a
> reason not to do it I guess.
>
>
> So why do you think it must be under tools/? Even if you consider "lkl"
> a "tool", that doesn't mean it must be there. I also consider a UML
> binary ("linux") a "tool" in my simulation environment, etc.
>
>
> And even LKL, which is the eventual goal here - why would you consider
> that a "tool"? I don't think we should.
>

The reason for picking tools was that it already has the
infrastructure to build programs and shared libraries and the fact
that it is the only place in the kernel source tree where code is not
built directly into the kernel binary.
