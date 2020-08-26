Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FEE253875
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 21:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHZToQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 15:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHZToQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 15:44:16 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116DC061574;
        Wed, 26 Aug 2020 12:44:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v2so2867029ilq.4;
        Wed, 26 Aug 2020 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJ9q/iTfnCsZrkSkcmh8UHaAoIWOgUVnnZaiByIljT0=;
        b=Ps/pJgcT6hlQjSiv9LSDBFUBLEqMhQjJl+vRmYXQWoVU8FEt85TyheW93v4c1xKGn/
         Anw5MGEuck1Lw8tOFZoHxtEaoxnCWoz8uxKNhvVxhLt+YphOBqavRg8DvHi4gVLDpJcQ
         W70rn7508qLaTn6d9FhUW8fZwkyu+CkONk1SFPOv9lniXIv0xYoBp3tMPOrfY4rb383t
         n+bYcmhHNKNXw0DztTgcTxgPH7HSyrQl+OQFOQkCrktG37+gm086BRyxfgUHercSBzx/
         70sVcuJy44Tn1oIqxDtgzULX/9cii27Iygnv0Rs35vn6icujZTGyyAU2BAqnhJtO3wcU
         HnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJ9q/iTfnCsZrkSkcmh8UHaAoIWOgUVnnZaiByIljT0=;
        b=tP3xqVqJVBWgbiN709DipcbMnp8XvnqapX1VMT3PfSlXtATyxhGz5yk0pCRGvWkz2T
         uH+DfLydZKVZ6WlyVEmZFQ0Ymwt0gs4Rd7mzsCfoKyyla1QCIIaZD8O/x7131O2i1RKF
         HUDK+nybp/gCWVB2N/NICk+DAqbsCiZeBxm6YnGyZNjAF+M/nwx4UkW759h1dCMR9FNN
         CsDPn5pI3pYLPBmIp3fUFJi+6Ktcju8/aVlZd2vT8HyAjCJY21XFmQ34y6Kd3g2GH//I
         445s6o7QAs1PT7maruk7bPmNp4YMN1R1e6bX9DtfgKZMWnnP/ojM1TzePxeRel76x0du
         N0IA==
X-Gm-Message-State: AOAM5333/fI7N24v2CsO8Yndr8j2aiu8FskIMjEUK+ULWZQzVUWULcif
        m4suG5eerIxREicwZ0mrj6Ve3pi0u7U44FO3swM=
X-Google-Smtp-Source: ABdhPJyGdPysh4JKvoSDONuj1Ue7wOLo62LEhwvjaBQ4WLmEDtNbWJ0lmUlU7vm1HojwsowSWTK8yJUtc2vFc3XGcvo=
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr13581043ilc.213.1598471055050;
 Wed, 26 Aug 2020 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002540.3351-1-yu-cheng.yu@intel.com> <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com> <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com> <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
In-Reply-To: <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 26 Aug 2020 12:43:39 -0700
Message-ID: <CAMe9rOprn69GcJ9btgDZA+ej3+vstNE0xd4wT27_2vcso0A4Og@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
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

On Wed, Aug 26, 2020 at 11:49 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 8/26/2020 10:04 AM, Andy Lutomirski wrote:
> > On Wed, Aug 26, 2020 at 9:52 AM Florian Weimer <fweimer@redhat.com> wrote:
> >>
> >> * Dave Martin:
> >>
> >>> On Tue, Aug 25, 2020 at 04:34:27PM -0700, Yu, Yu-cheng wrote:
> >>>> On 8/25/2020 4:20 PM, Dave Hansen wrote:
> >>>>> On 8/25/20 2:04 PM, Yu, Yu-cheng wrote:
> >>>>>>>> I think this is more arch-specific.  Even if it becomes a new syscall,
> >>>>>>>> we still need to pass the same parameters.
> >>>>>>>
> >>>>>>> Right, but without the copying in and out of memory.
> >>>>>>>
> >>>>>> Linux-api is already on the Cc list.  Do we need to add more people to
> >>>>>> get some agreements for the syscall?
> >>>>> What kind of agreement are you looking for?  I'd suggest just coding it
> >>>>> up and posting the patches.  Adding syscalls really is really pretty
> >>>>> straightforward and isn't much code at all.
> >>>>>
> >>>>
> >>>> Sure, I will do that.
> >>>
> >>> Alternatively, would a regular prctl() work here?
> >>
> >> Is this something appliation code has to call, or just the dynamic
> >> loader?
> >>
> >> prctl in glibc is a variadic function, so if there's a mismatch between
> >> the kernel/userspace syscall convention and the userspace calling
> >> convention (for variadic functions) for specific types, it can't be made
> >> to work in a generic way.
> >>
> >> The loader can use inline assembly for system calls and does not have
> >> this issue, but applications would be implcated by it.
> >>
> >
> > I would expect things like Go and various JITs to call it directly.
> >
> > If we wanted to be fancy and add a potentially more widely useful
> > syscall, how about:
> >
> > mmap_special(void *addr, size_t length, int prot, int flags, int type);
> >
> > Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
> > this is really just mmap() except that we want to map something a bit
> > magical, and we don't want to require opening a device node to do it.
> >
>
> One benefit of MMAP_SPECIAL_* is there are more free bits than MAP_*.
> Does ARM have similar needs for memory mapping, Dave?
>

arch/arm64/include/uapi/asm/mman.h:

#define PROT_BTI   0x10     /* BTI guarded page */

-- 
H.J.
