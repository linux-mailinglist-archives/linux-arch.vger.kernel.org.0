Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC63BD36
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfFJT4D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 15:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389240AbfFJT4D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 15:56:03 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5012146E
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2019 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560196562;
        bh=BSrEs7k4Eaj+qfKqbXB7x6RBjqYairyQB7xlNqEmonI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uLzHkUDAQ8jOsA8YXnkz0O3Qklab8tzkEtYYWwVgKRQkiQKzSqsdLapdzrorKdIKK
         n6Eo4HwM27qI73UXdMC+Vo7aJo27Dlu5OTlBwsHayFksgsHw2rZwNM92HHc08myrfM
         frywWd5NERvhfQ373QnY3PfJ7m2L8vxY6KRo3fOE=
Received: by mail-wm1-f43.google.com with SMTP id x15so543161wmj.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2019 12:56:01 -0700 (PDT)
X-Gm-Message-State: APjAAAVVFh4hv8ozo6goTHZroK8xEGazOeeSEjHUX0b+GmBmpI7E+8ro
        y5Eus/+Zv7c7PE3rR9fSQDLhaE9ixPdiJtG5geYXTA==
X-Google-Smtp-Source: APXvYqzM9tcFDkfc5EcsyyIB59pCxk2ffDwv+KGOuXFY/1fKRXVVJv6PtkR8yujMk0ZblpfWuwOhhYeBeaPhDe6KICk=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr14984047wmj.79.1560196560570;
 Mon, 10 Jun 2019 12:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net> <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
 <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net> <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
 <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net> <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
 <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com> <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
 <0665416d-9999-b394-df17-f2a5e1408130@intel.com>
In-Reply-To: <0665416d-9999-b394-df17-f2a5e1408130@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Jun 2019 12:55:48 -0700
X-Gmail-Original-Message-ID: <CALCETrVzgkhu=kjF4U5MEc+TJmsDJf8pVgnoPH5F4gTdsDF4rQ@mail.gmail.com>
Message-ID: <CALCETrVzgkhu=kjF4U5MEc+TJmsDJf8pVgnoPH5F4gTdsDF4rQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 10, 2019 at 12:52 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/10/19 12:38 PM, Yu-cheng Yu wrote:
> >>> When an application starts, its highest stack address is determined.
> >>> It uses that as the maximum the bitmap needs to cover.
> >> Huh, I didn't think we ran code from the stack. ;)
> >>
> >> Especially given the way that we implemented the new 5-level-paging
> >> address space, I don't think that expecting code to be below the stack
> >> is a good universal expectation.
> > Yes, you make a good point.  However, allowing the application manage the bitmap
> > is the most efficient and flexible.  If the loader finds a legacy lib is beyond
> > the bitmap can cover, it can deal with the problem by moving the lib to a lower
> > address; or re-allocate the bitmap.
>
> How could the loader reallocate the bitmap and coordinate with other
> users of the bitmap?
>
> > If the loader cannot allocate a big bitmap to cover all 5-level
> > address space (the bitmap will be large), it can put all legacy lib's
> > at lower address.  We cannot do these easily in the kernel.
>
> This is actually an argument to do it in the kernel.  The kernel can
> always allocate the virtual space however it wants, no matter how large.
>  If we hide the bitmap behind a kernel API then we can put it at high
> 5-level user addresses because we also don't have to worry about the
> high bits confusing userspace.
>

That's a fairly compelling argument.

The bitmap is one bit per page, right?  So it's smaller than the
address space by a factor of 8*2^12 == 2^15.  This means that, if we
ever get full 64-bit linear addresses reserved entirely for userspace
(which could happen if my perennial request to Intel to split user and
kernel addresses completely happens), then we'll need 2^48 bytes for
the bitmap, which simply does not fit in the address space of a legacy
application.
