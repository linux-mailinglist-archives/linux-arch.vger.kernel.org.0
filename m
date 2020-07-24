Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17BD22BC8E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 05:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXDle (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 23:41:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:43724 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgGXDle (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 23:41:34 -0400
IronPort-SDR: g0sMt2SwQmt0VM7OvQFv30hcc/mNggTIIm2IoioE2l71CmMn0aG5DfawyfOPFXqCWon8YmcI7R
 DAu6B2hAvDcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212190273"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="212190273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 20:41:32 -0700
IronPort-SDR: vZBCjDyBnbRpnpu2P81a/SKOPLVUIRzclKVaAwTsp4BON/vvAMoExoSxXrR5S5hf2e3C9xmFP+
 BEXI1a2QqAjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="288864767"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2020 20:41:31 -0700
Message-ID: <d15816d6172ea770b63e52443aced5607f1e35c1.camel@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Date:   Thu, 23 Jul 2020 20:40:33 -0700
In-Reply-To: <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200723162531.GF21891@linux.intel.com>
         <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
         <20200723165649.GG21891@linux.intel.com>
         <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-07-23 at 11:41 -0700, Dave Hansen wrote:
> On 7/23/20 9:56 AM, Sean Christopherson wrote:
> > On Thu, Jul 23, 2020 at 09:41:37AM -0700, Dave Hansen wrote:
> > > On 7/23/20 9:25 AM, Sean Christopherson wrote:
> > > > How would people feel about taking the above two patches (02 and 03 in the
> > > > series) through the KVM tree to enable KVM virtualization of CET before the
> > > > kernel itself gains CET support?  I.e. add the MSR and feature bits, along
> > > > with the XSAVES context switching.  The feature definitons could use "" to
> > > > suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
> > > > to userspace.
> > > > 
> > > > AIUI, there are ABI issues that need to be sorted out, and that is likely
> > > > going to drag on for some time. 
> > > > 
> > > > Is this a "hell no" sort of idea, or something that would be feasible if we
> > > > can show that there are no negative impacts to the kernel?
> > > Negative impacts like bloating every task->fpu with XSAVE state that
> > > will never get used? ;)
> > Gah, should have qualified that with "meaningful or measurable negative
> > impacts".  E.g. the extra 40 bytes for CET XSAVE state seems like it would
> > be acceptable overhead, but noticeably increasing the latency of XSAVES
> > and/or XRSTORS would not be acceptable.
> 
> It's 40 bytes, but it's 40 bytes of just pure, unadulterated waste.  It
> would have no *chance* of being used.  It's also quite precisely
> measurable on a given system:
> 
> 	cat /proc/slabinfo | grep task_struct | awk '{print $3 * 40}'

If there is value in getting these two patches merged first, we can move
XFEATURE_MASK_CET_USER to XFEATURE_MASK_SUPERVISOR_UNSUPPORTED for now, until
CET is eventually merged.  That way, there is no space wasted.

Yu-cheng


