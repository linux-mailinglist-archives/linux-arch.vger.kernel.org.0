Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB553F8CE5
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbhHZRXx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhHZRXx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2021 13:23:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB93C061757;
        Thu, 26 Aug 2021 10:23:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fz10so2710129pjb.0;
        Thu, 26 Aug 2021 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wH3hjz5Y0Xv45SIfl4mx52bhrdxx31yKbdxzt4w/j8Q=;
        b=O8img967zJnwZjYSbKm2y9nE2f5NAiup6+YiKzlbxApebuTStRcqBF5n2aNgfUKRoW
         5oBh29+jF1/+4A0JMGrT5lxW4UYXxdcKvHXe03zJ+prbWmjl1YWAYy1d/3uc/vgFavbi
         25btJb3NiF3ewfDY6f4pUP+66eUnTaiS/At7ripDnE3wBzIIemsVCoE9z92uoREez6Mn
         pyvJuwPh4/VHcxv66Pi4pOc6A2s1u8SlcbG5TO61JS30jMW3KqLsLajiCXD8eqeOy5SR
         A/LxxA5omWZ72vQVFtV22PQ2w0r6ApA1FAdnAM1WYrIci0ugb+w8PnkQbUjvPdzeXieH
         IeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wH3hjz5Y0Xv45SIfl4mx52bhrdxx31yKbdxzt4w/j8Q=;
        b=ewfNSz6CglXkYqpxblhZchqHV88FKO260ZmnBTAnsyeMsv4Vimcm8GTF8WBu8JusYH
         u7D3hSIFdy1OjF4OPPAxCh+R78wdDi8JCeNY7jlN/7bmiQGybYD+lOn9s2Tr0WFLpbyj
         LzjsQJmygjfE9TvFwcxUqyoMeuChEM/R04BIvxPh67Bztlhrhd/1TZtrAHeaEDsMAH8V
         Mb8uPDrt3jTToZA0ONbczVFlw83EUdmHaNO0xO77fBUzrGE8E2mWmXbh7LjvhhpwWvgT
         2JzrifmL4VZkLMQbSwTMIVeNSIBPD0g982XQmyaBmhpCmdohvjbggMUYwXxHzW4Qm3Np
         NsYA==
X-Gm-Message-State: AOAM5302qH+/zCuRaqA+VcO2EuL8RZToB3kmCf8yM86Fe93UpjZlFlb9
        mietd3BrA7uBpINwa0+6xFdzOn6G7jrFcC6X4e8=
X-Google-Smtp-Source: ABdhPJwJOWtbpTIuf1nV9PyAQQEEdDBk4aNy6OueVH9Kqnzqxo1RxNzQPIxgTc4FI2n/4NJ+QBmguIsoZ0wwsVopTTA=
X-Received: by 2002:a17:90a:1917:: with SMTP id 23mr4407685pjg.136.1629998585112;
 Thu, 26 Aug 2021 10:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210820181201.31490-1-yu-cheng.yu@intel.com> <20210820181201.31490-26-yu-cheng.yu@intel.com>
 <YSfGUlGJdV/5EcBs@zn.tnic>
In-Reply-To: <YSfGUlGJdV/5EcBs@zn.tnic>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 26 Aug 2021 10:22:29 -0700
Message-ID: <CAMe9rOoo5wC7AWbo3WO_GWvT5CXV3r3ysZ2qB8ZPi=giRBDetg@mail.gmail.com>
Subject: Re: [PATCH v29 25/32] x86/cet/shstk: Handle thread shadow stack
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 26, 2021 at 9:49 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Aug 20, 2021 at 11:11:54AM -0700, Yu-cheng Yu wrote:
> > diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> > index 5993aa8db338..7c1ca2476a5e 100644
> > --- a/arch/x86/kernel/shstk.c
> > +++ b/arch/x86/kernel/shstk.c
> > @@ -75,6 +75,61 @@ int shstk_setup(void)
> >       return err;
> >  }
> >
> > +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> > +                          unsigned long stack_size)
> > +{
> > +     struct thread_shstk *shstk = &tsk->thread.shstk;
> > +     struct cet_user_state *state;
> > +     unsigned long addr;
> > +
> > +     if (!shstk->size)
> > +             return 0;
> > +
> > +     /*
> > +      * Earlier clone() does not pass stack_size.  Use RLIMIT_STACK and
>
> What is "earlier clone()"?

clone() doesn't have stack size info which was added to clone3().

> > +      * cap to 4 GB.
> > +      */
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
H.J.
