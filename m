Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7273325478D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgH0OvX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgH0N1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 09:27:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BEC061232;
        Thu, 27 Aug 2020 06:26:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h10so1282146ioq.6;
        Thu, 27 Aug 2020 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3rM/s09CyTTr9lsRuYlr+CDTRnp96lIqmXrR7O4ris=;
        b=sDuPAMwyq2iaWGTIoS5gCuxEF7/8dQebiq2GQBQW3Ea8W+S5M4BxfTu8rNxQRsT2OE
         qivotQ/CsKAGuQXSMZJALTIdsrJcmPAmtbxjl/afnsHDpUI2P7q1ujOsMGm4m1DBkQMm
         o6MNSz4O+tSKLztWAovSUrtlbObut08eODM4+byTdb6EQdawaTGuyc+dbgMlxYkT7QlU
         uE2pa4zzkiedG1liIbX434R3WSH/G+20TTjrooRvrv2GNXnYy1KS6b0jYQrksbv6nbXi
         FDvt98BgQMeP9DrUtZEAmZ6SP/0Cfb2GSYl3BztAkv0kzjNEbg0BV0cM3rYXaxK6iMsZ
         mtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3rM/s09CyTTr9lsRuYlr+CDTRnp96lIqmXrR7O4ris=;
        b=oqYyBei6vR4B45WTvUOiYT0/3kZKoV8+77p2KvV7r3vrMejkQkDcRyMADW4Gdn7FJT
         AzB/UrN0t0K4/lK8hTMc+3z6oWNyeNBVI7h5RGgbqUdmSTb219Z0E3pk2bV26NYHPv9z
         fH3Ti75dIOShMKpHVZpShQLYh5so0un7S/iC2lY7mQE2he55cJwqn9UbrIx76cj/RJjD
         fJiQ5v5+vaTqYYFYuESHMz5bgb82214gspNnFpRNfN0WxFPjF8O83aFTHcvshj+WoGjx
         lFZnPRRjO5z5FRXixD8Iou1ttdIegRGVwlk1T6HCbTV4oTcm/TdleksD4XR0ztfKVgH1
         SbPw==
X-Gm-Message-State: AOAM531hjE9uztfEQR/41GEzqaji1itqVAmMr0nnwIQUo04c2ym000zW
        W0EGfQyv2PPJXPJKpYGVzDszMKEDaaqc4bAfxZw=
X-Google-Smtp-Source: ABdhPJyB3BGNlYSy6idrDHa0529fu+S4aI1rBmtXPi+OyTmClxS6ugobiVojUBykK3d7ZiXNOZaWep4R8pAyBk5UKR4=
X-Received: by 2002:a05:6638:1690:: with SMTP id f16mr19670170jat.91.1598534807749;
 Thu, 27 Aug 2020 06:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002540.3351-1-yu-cheng.yu@intel.com> <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com> <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com> <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com> <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
In-Reply-To: <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 27 Aug 2020 06:26:11 -0700
Message-ID: <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>, X86 ML <x86@kernel.org>,
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

On Wed, Aug 26, 2020 at 12:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/26/20 11:49 AM, Yu, Yu-cheng wrote:
> >> I would expect things like Go and various JITs to call it directly.
> >>
> >> If we wanted to be fancy and add a potentially more widely useful
> >> syscall, how about:
> >>
> >> mmap_special(void *addr, size_t length, int prot, int flags, int type);
> >>
> >> Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
> >> this is really just mmap() except that we want to map something a bit
> >> magical, and we don't want to require opening a device node to do it.
> >
> > One benefit of MMAP_SPECIAL_* is there are more free bits than MAP_*.
> > Does ARM have similar needs for memory mapping, Dave?
>
> No idea.
>
> But, mmap_special() is *basically* mmap2() with extra-big flags space.
> I suspect it will grow some more uses on top of shadow stacks.  It could
> have, for instance, been used to allocate MPX bounds tables.

There is no reason we can't use

long arch_prctl (int, unsigned long, unsigned long, unsigned long, ..);

for ARCH_X86_CET_MMAP_SHSTK.   We just need to use

syscall (SYS_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, ...);

-- 
H.J.
