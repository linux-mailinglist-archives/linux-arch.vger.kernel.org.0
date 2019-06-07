Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB3391C9
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfFGQWx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 12:22:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:57740 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFGQWx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 12:22:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 09:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,563,1557212400"; 
   d="scan'208";a="182719233"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 09:22:52 -0700
Message-ID: <388e702bfa4ed38f460327ae09ebc9b18b582bb5.camel@intel.com>
Subject: Re: [PATCH v7 05/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
Date:   Fri, 07 Jun 2019 09:14:50 -0700
In-Reply-To: <20190607070725.GN3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-6-yu-cheng.yu@intel.com>
         <20190607070725.GN3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 09:07 +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 01:06:24PM -0700, Yu-cheng Yu wrote:
> > Intel Control-flow Enforcement Technology (CET) introduces the
> > following MSRs.
> > 
> >     MSR_IA32_U_CET (user-mode CET settings),
> >     MSR_IA32_PL3_SSP (user-mode shadow stack),
> >     MSR_IA32_PL0_SSP (kernel-mode shadow stack),
> >     MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack),
> >     MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack).
> > 
> > Introduce them into XSAVES system states.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  arch/x86/include/asm/fpu/types.h            | 22 +++++++++++++++++++++
> >  arch/x86/include/asm/fpu/xstate.h           |  4 +++-
> >  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
> >  arch/x86/kernel/fpu/xstate.c                | 10 ++++++++++
> >  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> And yet, no changes to msr-index.h !?

You are right.  I will move msr-index.h changes to here.

Yu-cheng
