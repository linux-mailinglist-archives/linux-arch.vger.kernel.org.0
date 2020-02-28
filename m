Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B44173EEA
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 18:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1Rxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 12:53:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46223 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Rxj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 12:53:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so3736963qkh.13
        for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2020 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7A81NCRtl/YMUGoXqhguAxYpB741arq6+hyuPYrsxj8=;
        b=sY0DpGEQqcJV+Om5EC5uuAuFwKAdjsRvhCmg7xEn8ttC+eOSqdtl9G7psxfJzUGzyq
         CFgexnJMO3BoZGn/iSzwSiVKiNzwcPPDrFaf2Kub18f4onnWtjyleou7j3D2qhFdanI8
         98t3lMngB6DyG5RzEw7SjgPkXdKjFb3VE9dGVTR5oeAa+IK8b22h9bpLrpLx/BgQzkUe
         Toz5kRGpIoqs7+ZszYosKGlJnWIVNnjOECOmsMnWFqnLNWmKzGIpmPLHE0mrnCM6fr0q
         CIvoVZX6V+zY/5T2ce6U9NoaV0KO+J1Ir2Q/sD+StqT1lsJW9n9C8bqwLC/RPl6XtCpv
         6fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7A81NCRtl/YMUGoXqhguAxYpB741arq6+hyuPYrsxj8=;
        b=DFGiZDn1okkmBCYoCyOiEq69W4MyVHRev5UxXrlY8F2L44fR5myZpFK77pBxUMIo/l
         SxLguKyGl25lOoY1WxVyC2ggSx0rbvX6MXL098Gu5qHRHsde4YrPhPxiu4azfVhqjXpy
         Yr3EA8Rmcm/RSob4auFkULWq9qcjJuzpOju3fiyNeHCNsr6zrlI25L6O8qXWcWs4LSz+
         U3om2kDfCH2uBRsHWt7t8CqWahQc2X//NeN7XAKMRxUBICuh5/Bd+IsIUIpU6fUxXu9W
         nvZffDtuMfpbh7JEDNToVBFzPWgKbUpKVWXhqk/L0AsS2cBfRfKx2SokilB+/Be6irN4
         PIMw==
X-Gm-Message-State: APjAAAV5RReESbedzb5psA4a4vx6Bl4v1YDJnQmPfWs+j8MZOv8UYWPu
        sxBIR578mHOl+z2Md1DBDUvMneJSUfqkqLBskV3V
X-Google-Smtp-Source: APXvYqxuUZyxP1RTj056y0C7X/UxFsJhJD3+Tlwcqh1VF5LE+BUAzmAANREZPS01D5w3HfGzooO7MBqD5Ciibnynh/Y=
X-Received: by 2002:ae9:f301:: with SMTP id p1mr5320690qkg.422.1582912416914;
 Fri, 28 Feb 2020 09:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200228012036.15682-2-brendanhiggins@google.com> <CAFd5g46dVaV18=5mPLTHh06KQ6nDh4Xw4r8PAZDfSXASi=Qpmg@mail.gmail.com>
In-Reply-To: <CAFd5g46dVaV18=5mPLTHh06KQ6nDh4Xw4r8PAZDfSXASi=Qpmg@mail.gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Fri, 28 Feb 2020 09:53:00 -0800
Message-ID: <CAAXuY3qnButVR4hRQcsUbUsvLFg9cSvxSe15uG82T=j+QSQUqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vmlinux.lds.h: add linker section for KUnit test suites
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We went with this alignment precisely because it's the largest that
any supported arch may possibly need. The problem as I understood it
was that the compiler, seeing a bunch of pointers decided to put them
at the memory-access efficient alignment rather than at the section
start. Remember that the section start used to be unaligned for some
reason. Note that the alignment that is a multiple of smaller
alignment is still aligned wrt the smaller alignment, so the compiler
shouldn't need to put the pointers elsewhere.
I wonder if there's a more robust way of forcing the compiler to put
the pointers right at the section start and insert no gaps between
them than playing with alignment.

On Thu, Feb 27, 2020 at 11:22 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 5:20 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Add a linker section where KUnit can put references to its test suites.
> > This patch is the first step in transitioning to dispatching all KUnit
> > tests from a centralized executor rather than having each as its own
> > separate late_initcall.
> >
> > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index e00f41aa8ec4f..99a866f49cb3d 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -856,6 +856,13 @@
> >                 KEEP(*(.con_initcall.init))                             \
> >                 __con_initcall_end = .;
> >
> > +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> > +#define KUNIT_TEST_SUITES                                              \
> > +               . = ALIGN(8);                                           \
>
> After posting this, I saw I had gotten an email from 0day[1]. After
> some investigation, I discovered that this 8 byte alignment works for
> x86 64 bit fine, but only *sometimes* for 32 bit. 4 byte alignment
> seems to work in all cases (so far). I am not sure why we went with
> such a large alignment in hindsight. In any case, I should have a
> fixed revision out pretty soon.
>
> > +               __kunit_suites_start = .;                               \
> > +               KEEP(*(.kunit_test_suites))                             \
> > +               __kunit_suites_end = .;
> > +
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  #define INIT_RAM_FS                                                    \
> >         . = ALIGN(4);                                                   \
> > @@ -1024,6 +1031,7 @@
> >                 INIT_CALLS                                              \
> >                 CON_INITCALL                                            \
> >                 INIT_RAM_FS                                             \
> > +               KUNIT_TEST_SUITES                                       \
> >         }
> >
> >  #define BSS_SECTION(sbss_align, bss_align, stop_align)                 \
> > --
>
> [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/4I4UW4OAT63ETMIEUJQTOF3BFTMO6ROD/
