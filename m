Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B9825469D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH0OQi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgH0OJB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 10:09:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B57C061234;
        Thu, 27 Aug 2020 07:07:56 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g13so5907161ioo.9;
        Thu, 27 Aug 2020 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iITVmmu5F1v+iFfIuLRs81s+K0iMXUs2nHXl8cgJB50=;
        b=uy7iSHws8QJlH2OIPuDxtxRqUPcagcivIv2iPdlsV+MumRglXRHWq5eeU3uy3AByv/
         ZwN9uspZfhyGL2FWrYeN2D1b1uBoEOpWV4Xwvyk6LVldJvZNOl0193t7Yl0MV1U+2Vim
         fZsT7FDPzqrFrEEOqMlpzvya45PbafSHIyH+GOQjt+B/SnT0tzN3Z10+3tNNvazK/xDU
         26xlbtiFaNBBiyeEFE7qMNwG+sfYobVyQOfPXbkvDnJNZPli0eHAWhxLWf1yaEPjseB1
         zXfqc1tescWT8EDTnreY9CSJMY6ZUsOdhTorGmRIG0F5OeboElvAk4/MD9fuH52TDlpW
         y7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iITVmmu5F1v+iFfIuLRs81s+K0iMXUs2nHXl8cgJB50=;
        b=SrNyrLH0UyvuEJ9HbYQPv1lXdTSpsgkCVuMpBhdDOuxLrmVMJFLYMYhZzLomloDmH3
         j67XasVLty8s+XWqkuRDxBv4GSeoNYT3744oT/7gfNXGMD//HNS4oS2AEsXITzdmarq5
         GOubZcMGKwnsJ39j7OuzDloWZdHWqn8SDSWtAad40DsE0+LOQXxvIQwqCnhBoC8sB9sX
         vQCaCzCp3gz8keRUUJaLZIbKwjXEgtjXB10AT0YxgFikY8Xw59c/MwX0oQs+dS7HmJp2
         LaVcP7fSo8aPp/aWlvmuhwpqOxqAJvPpMvkfuBC33vhdErs4HLsCAJY9wppSErCvOqCf
         aJTw==
X-Gm-Message-State: AOAM531vyK7BnFnJUDrh/FQ87EYN79I7MHGBppXYsPSc6assTMiJw1rG
        5D8UtW/aU9Yq8yoH9t18ReGELmLJy2gYhFeW3qM=
X-Google-Smtp-Source: ABdhPJxHW3P48zYk8f8mc/UUwTyYIhmmTX1pyklbu8A1w2KH5Tmw78GkHcjFUMXT9WemjmzZ+54pyuGyapkq4P1L7Yk=
X-Received: by 2002:a05:6638:1690:: with SMTP id f16mr19835741jat.91.1598537276190;
 Thu, 27 Aug 2020 07:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002540.3351-1-yu-cheng.yu@intel.com> <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com> <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com> <20200826170841.GX6642@arm.com>
 <87tuwow7kg.fsf@oldenburg2.str.redhat.com> <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
 <873648w6qr.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <873648w6qr.fsf@oldenburg2.str.redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 27 Aug 2020 07:07:20 -0700
Message-ID: <CAMe9rOqpLyWR+Ek7aBiRY+Kr6sRxkSHAo2Sc6h0YCv3X3-3TuQ@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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

On Thu, Aug 27, 2020 at 6:36 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * H. J. Lu:
>
> > On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> wrote:
> >>
> >> * Dave Martin:
> >>
> >> > You're right that this has implications: for i386, libc probably pulls
> >> > more arguments off the stack than are really there in some situations.
> >> > This isn't a new problem though.  There are already generic prctls with
> >> > fewer than 4 args that are used on x86.
> >>
> >> As originally posted, glibc prctl would have to know that it has to pull
> >> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
> >> then the u64 argument is a problem for arch_prctl as well.
> >>
> >
> > Argument of ARCH_X86_CET_DISABLE is int and passed in register.
>
> The commit message and the C source say otherwise, I think (not sure
> about the C source, not a kernel hacker).

It should read:

arch_prctl(ARCH_X86_CET_DISABLE, unsigned long features)

-- 
H.J.
