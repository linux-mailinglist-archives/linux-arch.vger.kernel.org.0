Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96C1C96F1
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEGQ7A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 May 2020 12:59:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:26106 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGQ7A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 May 2020 12:59:00 -0400
IronPort-SDR: D/gE71r4FfI1AEosNKpprj+SH70Jt/XTyS8VfucL33gKXCK2CTpOafqcXVZQmLr6e+m/i7R8WR
 Yo3rPR2FbsLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 09:58:59 -0700
IronPort-SDR: 4Xav02TGuF5KC6i/HlotdeCsEttQc+IxzROcQP0j4Tq6KHlbIN5CNm7pPTv7WRs0kZz3ZBJG+C
 TPHvQlt7iSEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="305171312"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2020 09:58:59 -0700
Message-ID: <e0bb75f71ccc7fdf5cd5012441536918a09a9322.camel@intel.com>
Subject: Re: [PATCH v10 05/26] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Thu, 07 May 2020 09:59:02 -0700
In-Reply-To: <f4329e8c-0b3a-2c52-2145-08ea4dcab26e@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-6-yu-cheng.yu@intel.com>
         <f4329e8c-0b3a-2c52-2145-08ea4dcab26e@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-05-07 at 08:55 -0700, Dave Hansen wrote:
> On 4/29/20 3:07 PM, Yu-cheng Yu wrote:
> > +config X86_INTEL_SHADOW_STACK_USER
> > +	prompt "Intel Shadow Stacks for user-mode"
> > +	def_bool n
> > +	depends on CPU_SUP_INTEL && X86_64
> > +	depends on AS_HAS_SHADOW_STACK
> > +	select ARCH_USES_HIGH_VMA_FLAGS
> > +	select X86_INTEL_CET
> > +	select ARCH_HAS_SHADOW_STACK
> 
> I called protection keys: X86_INTEL_MEMORY_PROTECTION_KEYS
> 
> AMD recently posted documentation which shows them implementing it as
> well.  The "INTEL_" is feeling now like a mistake.
> 
> Going forward, we should probably avoid sticking the company name on
> them, if for no other reason than avoiding confusion and/or churn in the
> future.
> 
> Shadow stacks, for instance, seem like something that another vendor
> might implement one day.  So, let's at least remove the "INTEL_" from
> the config option names themselves.  Mentioning Intel in the changelog
> and the Kconfig help text is fine.

Yes, sure.

Yu-cheng

