Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4807636ED7A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhD2Pf6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhD2Pf6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 11:35:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615DC06138B;
        Thu, 29 Apr 2021 08:35:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x19so75156955lfa.2;
        Thu, 29 Apr 2021 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NcAkcgWUhfxgZwil5d8C3vRdyW/yDoNbS/ihCZUtDM4=;
        b=gujyDldbIafpjCimIN5d1oENjXlRpBWPx6LbKIXCQSDhlrS+TZ1n3P2wnv2s9TXmiB
         /zDxN+HA+ip3dvVmO/HsBctLmcqv6JiDGBPNT4N2qe9T+c/v/FOs22OCDgDo6Z51bq+1
         QllZw3QlORuv/QvbmkaeWgllFTa+6fblPPMw/5C/OU/uVQQKRdufUVttV6LBGmyzHBkF
         6DqTz03iKvIetEhU68isxMyvs44VdBH3g4dn0TmzSYuLZ1Z2toONJdQjYYx2hdsjtyOm
         bn+g/vkg5MmmtSGsK/A/G4MIkTWRJv9cx5/CmjQoXGEWHZfUnCzoD6blNINXBiJUbHQ5
         M3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NcAkcgWUhfxgZwil5d8C3vRdyW/yDoNbS/ihCZUtDM4=;
        b=Yc9aBz7Nvt9RKo3k/xAhaSH+vRntsiG0N4gtJYiGIyUbrWOVf8kzBy8M9cagOEgif+
         pu8raCtN0bCkQSep3EfwvS6RDFNidtSnEvlAjxEu6dzm7gQdY8aINUozZoNbFREk33+/
         Ip3pL3dXU8aBfl+g0DbxVR9XAd720ixs1MZfzV4dqB981nXTIyl3ENAvllXAqZrprWXB
         demlnvBoMtTQ2YTnNsw01HdqRGcFrb2Sn4jjXi73DVehJyn5VsI72E++5XMuXthml+FY
         Cx/yW7mw+H4sNz7PcT1f5T3p31ujyJRgCGoMtDqJcl6Skis+pbnwSqk/1WtNpb0dj+5x
         gsWQ==
X-Gm-Message-State: AOAM533BWjECDzZxBPkkLRb3r7yUcbTdocxMK4zc+y8yzkSVeRCI7AUz
        TGJusZkfBFp/lqvY5vSYO+4=
X-Google-Smtp-Source: ABdhPJzqldjYe0p+Yng3Oa3HkrP38wvsJi9/BzwznvqWoGnyPNmtPP1L5ewv/JuJVjcwSTrLuhzYVg==
X-Received: by 2002:a19:9103:: with SMTP id t3mr67215lfd.471.1619710509903;
        Thu, 29 Apr 2021 08:35:09 -0700 (PDT)
Received: from grain.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id d11sm10455lfv.263.2021.04.29.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:35:08 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id D1D14560156; Thu, 29 Apr 2021 18:35:06 +0300 (MSK)
Date:   Thu, 29 Apr 2021 18:35:06 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Andrey Vagin <avagin@gmail.com>
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
Message-ID: <YIrSKlGmH84A/RF5@grain>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
 <YIpgB5HbnNPWX4FP@grain>
 <CALCETrW27rTeaymtuJYJCyNgHfuCqA90KinvzNzwBg_vCnZLTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW27rTeaymtuJYJCyNgHfuCqA90KinvzNzwBg_vCnZLTw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 29, 2021 at 07:44:03AM -0700, Andy Lutomirski wrote:
> On Thu, Apr 29, 2021 at 12:28 AM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> >
> > On Wed, Apr 28, 2021 at 04:03:55PM -0700, Andy Lutomirski wrote:
> > > On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > >
> > > > When shadow stack is enabled, a task's shadow stack states must be saved
> > > > along with the signal context and later restored in sigreturn.  However,
> > > > currently there is no systematic facility for extending a signal context.
> > > > There is some space left in the ucontext, but changing ucontext is likely
> > > > to create compatibility issues and there is not enough space for further
> > > > extensions.
> > > >
> > > > Introduce a signal context extension struct 'sc_ext', which is used to save
> > > > shadow stack restore token address.  The extension is located above the fpu
> > > > states, plus alignment.  The struct can be extended (such as the ibt's
> > > > wait_endbr status to be introduced later), and sc_ext.total_size field
> > > > keeps track of total size.
> > >
> > > I still don't like this.
> > >
> > > Here's how the signal layout works, for better or for worse:
> > >
> > > The kernel has:
> > >
> > > struct rt_sigframe {
> > >     char __user *pretcode;
> > >     struct ucontext uc;
> > >     struct siginfo info;
> > >     /* fp state follows here */
> > > };
> > >
> > > This is roughly the actual signal frame.  But userspace does not have
> > > this struct declared, and user code does not know the sizes of the
> > > fields.  So it's accessed in a nonsensical way.  The signal handler
> >
> > Well, not really. While indeed this is not declared as a part of API
> > the structure is widely used for rt_sigreturn syscall (and we're using
> > it inside criu thus any change here will simply break the restore
> > procedure). Sorry out of time right now, I'll read your mail more
> > carefully once time permit.
> 
> I skimmed the CRIU code.  You appear to declare struct rt_sigframe,
> and you use the offset from the start of rt_sigframe to uc.  You also
> use the offset to the /* fp state follows here */ part, but that's
> unnecessary -- you could just as easily have put the fp state at any
> other address -- the kernel will happily follow the pointer you supply
> regardless of where it points.  So the only issues I can see are if

Yes, since rt_sigreturn is a very late stage of restore we've to preallocate
memory early and surely doing it in one slab is a way more convenient, thus
that's why fp context follows the structure declaration (well, it was at
least I didn't touch this code for years already). Anyway, I meant that
assuming "user code does not know the sizes of the fields" is not exactly
true and strictly speaking current layout became a part of nondeclared api
(simply because kernel use this structure run-time only and even if something
get changed in kernel declaration for this structure the kernel itself will
be fine because it doesn't save it on disk between kernel updates) but for
tools like criu such change might require update. IOW, I mean that changing
rt_sigreturn structure itself is not safe and we can't reorder the members
and theirs size.

Or I misunderstood you, and you meant only the fact that fp may be arbitrary,
pointing for any place in userspace? If so then indeed, fp can be pointing
to context placed anywere since kernel will fetch it from the address during
rt_sigreturn processing.

> you write the fp state on top of something else or if you
> inadvertently fill in the proposed extension part of uc_flags.  Right
> now you seem to be ignoring uc_flags, which I presume means that you
> are filling it in as zero.  Even if the offset of the fp state in the

yes

> kernel rt_sigframe changes, the kernel should still successfully parse
> the signal frame you generate.
> 
> I suppose there is another potential issue: would CRIU have issues if
> the *save* runs on a kernel that uses this proposed extension
> mechanism?  Are you doing something with the saved state that would
> get confused?

You know, actually I guess criu may not work with new extensions, we have
a predefined max xsave frame size and any new extensions to cpu states
will require additional support.

I must confess I didn't follow much on CET internals yet so I must be simply
wrong. CC'ing Anrew just in case.

	Cyrill
