Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0751322B3FE
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGWQ4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 12:56:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:29441 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQ4u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 12:56:50 -0400
IronPort-SDR: 6ngY6kwxquf10seVEM1Dr3129Yr6MR7tDTC2zNDQXLnuts63EI0XSD8mLkOjyKA2wOdwZPZqaY
 SsK3IYcZZdsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148505366"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="148505366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:56:49 -0700
IronPort-SDR: bJkHNGZQ1Hw3s5PdfbxZHNQOHZvHasSr4ggVzJ7OtBVpzlwhX06x7G1RkGsRivKVd1QUPc7qbj
 t8mvhax6Z8pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="288710474"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2020 09:56:49 -0700
Date:   Thu, 23 Jul 2020 09:56:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Message-ID: <20200723165649.GG21891@linux.intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200723162531.GF21891@linux.intel.com>
 <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 09:41:37AM -0700, Dave Hansen wrote:
> On 7/23/20 9:25 AM, Sean Christopherson wrote:
> > How would people feel about taking the above two patches (02 and 03 in the
> > series) through the KVM tree to enable KVM virtualization of CET before the
> > kernel itself gains CET support?  I.e. add the MSR and feature bits, along
> > with the XSAVES context switching.  The feature definitons could use "" to
> > suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
> > to userspace.
> > 
> > AIUI, there are ABI issues that need to be sorted out, and that is likely
> > going to drag on for some time. 
> > 
> > Is this a "hell no" sort of idea, or something that would be feasible if we
> > can show that there are no negative impacts to the kernel?
> 
> Negative impacts like bloating every task->fpu with XSAVE state that
> will never get used? ;)

Gah, should have qualified that with "meaningful or measurable negative
impacts".  E.g. the extra 40 bytes for CET XSAVE state seems like it would
be acceptable overhead, but noticeably increasing the latency of XSAVES
and/or XRSTORS would not be acceptable.

> I thought KVM had its own vcpu->arch.guest_fpu buffers which mirrored
> the size and format of task->fpu.  Can we have KVM support today without
> task->fpu support?  I see some XSS munging in the KVM code so I think
> this might be *possible*, but I don't see all of the plumbing that would
> make it actually work.

It'd be possible, but long term I don't think it's a good idea for KVM to
diverge from the kernel's FPU support, i.e. fully converting KVM to it's own
implementation will likely lead to pain and maintenance problems.  Without
fully converting KVM to a custom implementation, adding one off support for
CET would be a massive hack job.
