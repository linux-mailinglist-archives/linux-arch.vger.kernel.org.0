Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21F814B02F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 08:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgA1HTl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 02:19:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41598 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1HTj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 02:19:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so6159874pfw.8
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 23:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3k6NKPH7fR4pIU1iDhzXIE3sCOzlwL1ZN9ZIEkKxkCM=;
        b=srujTkRlXcMYfFAU4ajeK8XzFxdSFdtymlFDHFWwtjl6RYYdXfct49yGfp0R3Ft/Gk
         b21LQneptyAycuw/QTxfkxRds7UsDs0nOcvfIjhPf5kg6HG/fumf1p+SOyhPDP/nWgeP
         N5AwCoyysSHeNcp/4iev4K0SThnflmL0sS9bNw5CfETHliSa70QE6XwKZ6Bfqiixt3vq
         zSUjHO7HdXpF/GNVk0WVWL+Zc6eaGXSoDWtvFQJdB+9aFEzKZ4wrtQexneK+aEI716Ld
         KNu+IVGouW2wF3H1iVqEscIlzXyahFYpfZmS4xEkSoV7/uFbghBbqV5xBi32Vua8xClE
         x64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k6NKPH7fR4pIU1iDhzXIE3sCOzlwL1ZN9ZIEkKxkCM=;
        b=UTl1tnGAq16dbi2NYQ2juVC863acEa3/H40JBeiDyRoZEOsw1pFtUxFYDgN0WoXweB
         ieCOxkw8q2/5ivM9hf9AjCP0MwOxygrv9I/e5VbvXR6QERas4fye2A1mAla8fAVKhLSr
         rA5WnvugNGHa0eJ1+b5+NHJfK1RAyb8q7nav8I4LpWVRRrPcrLxT7y9u/UtROjsfApTL
         9AUOoJpRKuldxsGyuL9qJ4QwaW/WlJy+O3lA6NfF2RF7zd1lDMsUavjd8ZIOrhb/ZtH8
         3TYLg1dqv63AhKawYGtuL4Z/Io6Y6yIbYNrf0cTKXpNPs1Sk0v8bcvlB/4xZSa+5Eky7
         e49g==
X-Gm-Message-State: APjAAAUqqZqqv91xQMiBygXAgBDfSmJD9Vy3X7CbfCB6KS4dLdPpSUJb
        zwLpCFvgnRCPiRauAfnaHxAJ6Nwk5xtqO32iNp6oLg==
X-Google-Smtp-Source: APXvYqy6yh7GNcB6s7imvcW4J3ThOHyV8BHpXsRpcDoPYs5OW9TxXs3eEbw4y8pGn08q7d0OirpiVqtM1t8RAzdN/Q8=
X-Received: by 2002:a63:597:: with SMTP id 145mr22603404pgf.384.1580195978166;
 Mon, 27 Jan 2020 23:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com> <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
In-Reply-To: <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 27 Jan 2020 23:19:27 -0800
Message-ID: <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/23/20 4:40 PM, Brendan Higgins wrote:
> > Sorry for the late reply. I am still catching up from being on vacation.
> >> > On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >> It does beg the question if this means kunit is happy to not be a tool
> >> to test pre basic setup stuff (terminology used in init.c, meaning prior
> >> to running all init levels). I suspect this is the case.
> >
> > Not sure. I still haven't seen any cases where this is necessary, so I
> > am not super worried about it. Regardless, I don't think this patchset
> > really changes anything in that regard, we are moving from late_init
> > to after late_init, so it isn't that big of a change for most use
> > cases.
> >
> > Please share if you can think of some things that need to be tested in
> > early init.
>
> I don't have a specific need for this right now.  I had not thought about
> how the current kunit implementation forces all kunit tests to run at a
> specific initcall level before reading this email thread.
>
> I can see the value of being able to have some tests run at different
> initcall levels to verify what functionality is available and working
> at different points in the boot sequence.

Let's cross that bridge when we get there. It should be fairly easy to
add that functionality.

> But more important than early initcall levels, I do not want the
> framework to prevent using or testing code and data that are marked
> as '__init'.  So it is important to retain a way to invoke the tests
> while __init code and data are available, if there is also a change
> to generally invoke the tests later.

Definitely. For now that still works as long as you don't build KUnit
as a module, but I think Alan's new patches which allow KUnit to be
run at runtime via debugfs could cause some difficulty there. Again,
we could add Kconfigs to control this, but the compiler nevertheless
complains because it doesn't know what phase KUnit runs in.

Is there any way to tell the compiler that it is okay for non __init
code to call __init code? I would prefer not to have a duplicate
version of all the KUnit libraries with all the symbols marked __init.
Thoughts?
