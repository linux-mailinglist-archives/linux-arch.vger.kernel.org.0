Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C104E25C850
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgICR7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 13:59:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:1301 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgICR7R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 13:59:17 -0400
IronPort-SDR: Zey8bhnXoWmUpAaat3pVpAK6f3SZOPQBi8xZwhy83WX+eZ99nSpcrQVUuI5IJ8uZmy+pQ3cntM
 26sdud4xUmZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145329662"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145329662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 10:59:16 -0700
IronPort-SDR: X6hOgUBXuT53zGBETVRIl8Y3udPYgeOjMvy4EgfTvR+oR8iOyOvL0gprGjnPMNJMYyxw+50upa
 fFrRD+sU+TdQ==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="334548855"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.173.133]) ([10.209.173.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 10:59:15 -0700
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
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
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
References: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
 <40BC093A-F430-4DCC-8DC0-2BA90A6FC3FA@amacapital.net>
 <b3809dd7-8566-0517-2389-8089475135b7@intel.com>
 <88261152-2de1-fe8d-7ab0-acb108e97e04@intel.com>
 <1b51d89c-c7de-2032-df23-e138d1369ffa@intel.com>
 <CALCETrUq3xiHV2xOZV-FD_de_P_TL-Bs91XT+F+79psBfigCSg@mail.gmail.com>
 <21491d05-6306-0a6f-58a7-8bf29feae8c7@intel.com>
 <CALCETrXJkXXDF=tdu3KBHgzDO+E-HhqMk9Ttixgk4WX_PLPDJw@mail.gmail.com>
 <8fcde9bb-284f-f089-96d3-702f501a6258@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <2a58982b-8a69-1280-86ec-d0b70ede4453@intel.com>
Date:   Thu, 3 Sep 2020 10:59:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8fcde9bb-284f-f089-96d3-702f501a6258@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/3/2020 9:42 AM, Dave Hansen wrote:
> On 9/3/20 9:32 AM, Andy Lutomirski wrote:
>>> Taking the config register out of the init state is illogical, as is
>>> writing to SSP while the config register is in its init state.
>> What's so special about the INIT state?  It's optimized by XSAVES, but
>> it's just a number, right?  So taking the register out of the INIT
>> state is kind of like saying "gdb wanted to set xmm0 to (0,0,0,1), but
>> it was in the INIT state to begin with", right?
> 
> Yeah, that's a good point.  The init state shouldn't be special, as the
> hardware is within its right to choose not to use the init optimization
> at any time.
> 
Then, I would suggest changing get_xsave_addr() to return non-null for 
the INIT state case.  For the other two cases, it still returns NULL. 
But this also requires any write to INIT states to set xstate_bv bits 
properly.  This would be a pitfall for any code addition later on.

Looking at this another way.  Would it be better for the debugger to get 
an error and then to set the MSR directly first (vs. changing the XSAVES 
INIT state first)?
