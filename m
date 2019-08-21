Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679DB97DBD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfHUOzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 10:55:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:41312 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfHUOzk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 10:55:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 07:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186252384"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2019 07:55:38 -0700
Message-ID: <8d2e5bc4496075032393ff9ae81a26f7fbc711e6.camel@intel.com>
Subject: Re: [PATCH v8 02/27] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Wed, 21 Aug 2019 07:46:32 -0700
In-Reply-To: <20190821102052.GD6752@zn.tnic>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
         <20190813205225.12032-3-yu-cheng.yu@intel.com>
         <20190821102052.GD6752@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2019-08-21 at 12:20 +0200, Borislav Petkov wrote:
> On Tue, Aug 13, 2019 at 01:52:00PM -0700, Yu-cheng Yu wrote:
> > Add CPU feature flags for Control-flow Enforcement Technology (CET).
> > 
> > [...]
> > diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-
> > deps.c
> > index b5353244749b..9bf35f081080 100644
> > --- a/arch/x86/kernel/cpu/cpuid-deps.c
> > +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> > @@ -68,6 +68,8 @@ static const struct cpuid_dep cpuid_deps[] = {
> >  	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
> >  	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
> >  	{ X86_FEATURE_AVX512_BF16,	X86_FEATURE_AVX512VL  },
> > +	{ X86_FEATURE_SHSTK,		X86_FEATURE_XSAVES    },
> > +	{ X86_FEATURE_IBT,		X86_FEATURE_XSAVES    },
> 
> This hunk needs re-tabbing after:
> 
> 1e0c08e3034d ("cpu/cpuid-deps: Add a tab to cpuid dependent features")

Thanks, I will fix it.

Yu-cheng
