Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726FB33EE2B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 11:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhCQKPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 06:15:46 -0400
Received: from casper.infradead.org ([90.155.50.34]:57244 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhCQKPa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 06:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GbFSfPvAGSrYmcgjy1/jiFvVWTiImeZT/N+n10CQYO8=; b=K/KBfR1lYuJIbFmu1hfj4ix8Jn
        em4xUzlucCoj6dtG0B0LlJmZrrSdTywCapOny9m8bf0LhsIJR6smrTPigMfjkJTWb7+/6bXwxQyI1
        fSgsrI6fG4w8L6QtBYV71XY39G/clhb/nivLkMUQaciYMDFrNnxm0ez3Jwi+qYgfmmU/10ymuYnal
        s14JDtuNqJtjTCiVuMLnE7KAW5BFIJ66gTT5tl0N0EG+DvuOrMfKIQcIntXUv7LQHmr7IveCyAh2O
        t1sQ6hBj4yVh5Vz1sQyRFlF7b5PKE+LFa0o7yVrfQusilBrwT7Xli35PPfbSqpZhnkJmuEFnOtc6H
        vpx1alMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMTC5-001MbO-GD; Wed, 17 Mar 2021 10:14:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44F923012DF;
        Wed, 17 Mar 2021 11:14:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3537F2C3C233C; Wed, 17 Mar 2021 11:14:24 +0100 (CET)
Date:   Wed, 17 Mar 2021 11:14:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
Message-ID: <YFHWgOAEWrOZ+zPf@hirez.programming.kicks-ass.net>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316211552.GU4746@worktop.programming.kicks-ass.net>
 <90e453ee-377b-0342-55f9-9412940262f2@intel.com>
 <20210317091800.GA1461644@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317091800.GA1461644@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 17, 2021 at 10:18:00AM +0100, Ingo Molnar wrote:
> 
> * Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> 
> > On 3/16/2021 2:15 PM, Peter Zijlstra wrote:
> > > On Tue, Mar 16, 2021 at 08:10:26AM -0700, Yu-cheng Yu wrote:
> > > > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > > > return/jump-oriented programming attacks.  Details are in "Intel 64 and
> > > > IA-32 Architectures Software Developer's Manual" [1].
> > > > 
> > > > CET can protect applications and the kernel.  This series enables only
> > > > application-level protection, and has three parts:
> > > > 
> > > >    - Shadow stack [2],
> > > >    - Indirect branch tracking [3], and
> > > >    - Selftests [4].
> > > 
> > > CET is marketing; afaict SS and IBT are 100% independent and there's no
> > > reason what so ever to have them share any code, let alone a Kconfig
> > > knob.
> > 
> > We used to have shadow stack and ibt under separate Kconfig options, but in
> > a few places they actually share same code path, such as the XSAVES
> > supervisor states and ELF header for example.  Anyways I will be happy to
> > make changes again if there is agreement.
> 
> I was look at:
> 
>   x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
> 
> didn't see any IBT logic - it's essentially all shadow stack state.
> 
> Which is not surprising, forward call edge integrity protection (IBT) 
> requires very little state, does it?

They hid the IBT enable bit in the U_CET MSR, which is in the XSAVE
thing.

