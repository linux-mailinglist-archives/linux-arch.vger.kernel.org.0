Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285A6259DFA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgIASTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIASTu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 14:19:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B721C061244;
        Tue,  1 Sep 2020 11:19:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so2356658iod.12;
        Tue, 01 Sep 2020 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLstzH1LNj+g6CEwT6Bs49sL4xGFgD5yGkJsHn4QoB0=;
        b=e3DcllFiRd99EFhMW9PLPljTKxeW0vc47NVr96CC+Vzh6dkUK4Mmdgcl1sZq/kJoLz
         3gSmb4o3MV+chM/XWnck2/Zy6U7/keXIVgEz6ul7hTS5rc5nzSq0xbh/ySELyvsy9XIl
         lhjnS4qyrQbLLnuMaEAxGqsrEafBGzFSqtavTwXm8Ld91gWaaYxdXma2DtaUItBrCsZO
         rBFEQvxDLcIoPbDzdA8dqgJSFMXSmhb7Yy6Z4CsWymvHmVt6CT3Vu2JFpWvDhWC7XIDi
         pbII5TYx04WFyt8aDKcjv64XYlRzKlnU8AwnIK6LecQEoJlhDlzZTCKQpAjaKs0YXLkK
         rBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLstzH1LNj+g6CEwT6Bs49sL4xGFgD5yGkJsHn4QoB0=;
        b=YXNIdLVrd9ApRB1gt8TRDCQ1NV1gKC6y7ltZAPl7qHQvTRvOxP6ZElwhkpSl3uWMvb
         gsJO25nXa9LuXz8gKgiQ8+HFPcD4/WJhvJSB8LEfatek43PM9XB0L6808xerGLp4yeL1
         5nRNqNayxA3SI+TnSVlBBET8bKxBINBL9BFL7B1t5clZ2ILDKIDNsQFSdYsaUCyTdDQN
         10z+N5di2yRprnQWpDm0/BSTN7BO8lcd0xRwHWALGjL2EULv2i6akRdRVE+PeENgKpqr
         aDyCD1uL7Akgt1uPXqP5wljSQYPsdrshE4WAJFJyzSCyG1wm1kz9Y8YF0dghINwuVGmo
         d80Q==
X-Gm-Message-State: AOAM531lGP+gtNCQ6IOHOvn/Tj8NfrS8B2ZJ3eQ+T0aXkCjh0UQJXAal
        jiDnFBMIuWFrf73yMTwWhGpTTHo+s1pyBp3jIJQ=
X-Google-Smtp-Source: ABdhPJwd56XRn3AqwOqX/fuwEl0+tQ4bzTp0vBg+8n/ljzCRzmGOanyF29SjgH/2vSndKMmE/sNtorHvr4RnNE87cJ8=
X-Received: by 2002:a05:6602:6c9:: with SMTP id n9mr269234iox.91.1598984389615;
 Tue, 01 Sep 2020 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002540.3351-1-yu-cheng.yu@intel.com> <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com> <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com> <20200826170841.GX6642@arm.com>
 <87tuwow7kg.fsf@oldenburg2.str.redhat.com> <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
 <873648w6qr.fsf@oldenburg2.str.redhat.com> <CAMe9rOqpLyWR+Ek7aBiRY+Kr6sRxkSHAo2Sc6h0YCv3X3-3TuQ@mail.gmail.com>
 <CAMe9rOpuwZesJqY_2wYhdRXMhd7g0a+MRqPtXKh7wX5B5-OSbA@mail.gmail.com>
 <3c12b6ee-7c93-dcf4-fbf7-2698003386dd@intel.com> <87o8mpqtcn.fsf@oldenburg2.str.redhat.com>
 <b84e6fae-5d51-b0a0-d917-76f86b3186b7@intel.com> <87k0xdqs3t.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87k0xdqs3t.fsf@oldenburg2.str.redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 1 Sep 2020 11:19:13 -0700
Message-ID: <CAMe9rOqhjhL=caGg=j4M=1+xFyEY-2vHsFn8vZNSaF33R5fVqQ@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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

On Tue, Sep 1, 2020 at 11:17 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Yu-cheng Yu:
>
> > On 9/1/2020 10:50 AM, Florian Weimer wrote:
> >> * Yu-cheng Yu:
> >>
> >>> Like other arch_prctl()'s, this parameter was 'unsigned long'
> >>> earlier. The idea was, since this arch_prctl is only implemented for
> >>> the 64-bit kernel, we wanted it to look as 64-bit only.  I will change
> >>> it back to 'unsigned long'.
> >> What about x32?  In general, long is rather problematic for x32.
> >
> > The problem is the size of 'long', right?
> > Because this parameter is passed in a register, and only the lower
> > bits are used, x32 works as well.
>
> The userspace calling convention leaves the upper 32-bit undefined.
> Therefore, this only works by accident if the kernel does not check that
> the upper 32-bit are zero, which is probably a kernel bug.
>
> It's unclear to me what you are trying to accomplish.  Why do you want
> to use unsigned long here?  The correct type appears to be unsigned int.
> This correctly expresses that the upper 32 bits of the register do not
> matter.
>

unsigned int is the correct type since only the lower 32 bits are used.

-- 
H.J.
