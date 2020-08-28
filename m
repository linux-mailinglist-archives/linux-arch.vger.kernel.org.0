Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5865255FF9
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH1Rq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1Rq1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 13:46:27 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF7C061264;
        Fri, 28 Aug 2020 10:46:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so1397674iln.1;
        Fri, 28 Aug 2020 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHD2od9a3q3ducRP27N4YhrcnzJznka8g9wB3couczI=;
        b=icC1BpgngsKcBshxupbrzi25rjmsbAQOUN7MB16qmho0eYgKflLT7ANJDf3pUDnubN
         78YGL05njlRMtdciiZsYVN1VVQBMZjIe6pdf/yGP9BwzPCATHFugUx2WpO0GwB/oM/td
         0fxLIn9YE98lUR6z93flUX7/YZT1bSXD8CjH+N+BS7Q3W0YWocw7ma5YnyqNywfSoYkK
         uQVabMZ/STD/n3oAfEe2stGAK92d83/wNDqP4Iw3itV6btGDhCX29orA4o/j41AJaIom
         anIODK7Y8nBxVFvG7/VA/SAMIZt37AHDfS/0UKi44VRdVWWh9s3JonKzphJdhvBH0fNY
         k6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHD2od9a3q3ducRP27N4YhrcnzJznka8g9wB3couczI=;
        b=qxzYvrxJGAgaoeuyi9q5k+Q643Q4G5Ke1oVC7xhzWS6ltrMTeoUJeekG4JTNQkWLsS
         gaM398A9IKzUNc6LWxrDTfDvsZG0yzqjsMUxwBbFxkULvHdKYzJi7k7D+imsIaF8G+mb
         NHI9O88dnqQZghaOg073S+6sODFucgnl/ekkrjruxw1c7bDm1AhIQ1N4WSxsLioQrL2e
         o6Z8L+JbyOxwDtgGDpdII5AzVGYCFQ5Eo8FmXgpK1bKxsS/8KgkvPz/HyMD6lRddoNRS
         HSKv1pc+eN/XZ16d9xZWaVBHLopFkg9q/WPGmse9m29F5ZgpSbrKDL0wOCuKbPrX9Wf+
         ccFw==
X-Gm-Message-State: AOAM5302lipA1LtVv7XoHpg/70z8SOoX7ombKU5Ys3bjqSuxLXsC3N8V
        I3TuvZei+O0OQSkPvv2twMcyrpuVNFcSe1BERxQ=
X-Google-Smtp-Source: ABdhPJxEPJRWFsSsLDEp8AT+kPrU4AEp/SFFKSWD282FnHn23h5DqcZW5RrwWZvBUnzwjewVJ+Pvt/vIrYZcV2MQjUc=
X-Received: by 2002:a05:6e02:586:: with SMTP id c6mr30110ils.13.1598636785749;
 Fri, 28 Aug 2020 10:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
 <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net> <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
 <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
 <CAMe9rOrt5hz6qsNAxPgdKCOhRcKKESv-D3rxdSfraeJ-LFHM4w@mail.gmail.com>
 <87v9h3thj9.fsf@oldenburg2.str.redhat.com> <CAMe9rOr=BZw3GyXf0g6tAZnfa8NbamoyBoU9KqoxtHg9c2yZhw@mail.gmail.com>
 <CALCETrUUKb6oyBmB3CSeVy1xT7mcnV=BD2eipAnKUhma7K3qKw@mail.gmail.com>
In-Reply-To: <CALCETrUUKb6oyBmB3CSeVy1xT7mcnV=BD2eipAnKUhma7K3qKw@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 28 Aug 2020 10:45:49 -0700
Message-ID: <CAMe9rOoWYJwg9Ug5-vrBs-iYUFTbKj-izdiCBEvGSj-3_zhSLw@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 10:39 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Aug 28, 2020 at 4:38 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Thu, Aug 27, 2020 at 11:24 PM Florian Weimer <fweimer@redhat.com> wrote:
> > >
> > > * H. J. Lu:
> > >
> > > > Can you think of ANY issues of passing more arguments to arch_prctl?
> > >
> > > On x32, the glibc arch_prctl system call wrapper only passes two
> > > arguments to the kernel, and applications have no way of detecting that.
> > > musl only passes two arguments on all architectures.  It happens to work
> > > anyway with default compiler flags, but that's an accident.
> >
> > In the current glibc, there is no arch_prctl wrapper for i386.  There are
> > arch_prctl wrappers with 2 arguments for x86-64 and x32.  But this isn't an
> > issue for glibc since glibc is both the provider and the user of the new
> > arch_prctl extension.  Besides,
> >
> > long syscall(long number, ...);
> >
> > is always available.
>
> Userspace is probably full of tools and libraries that contain tables
> of system calls and their signatures.  Think tracing, audit, container
> management, etc.  I don't know how they will react to the addition of
> new arguments.

Yes, they need to be updated to understand other new operations
added for CET.

-- 
H.J.
