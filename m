Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E6259D99
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIARtH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:49:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:25772 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIARtF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 13:49:05 -0400
IronPort-SDR: 8xYUkwzS5RGQxRNpzA4TfvXqpHFnHkKLean5tJoO5sRxZnFGn4UFyrIEqJvjS6r++DOKZszxTU
 O0uiuVpY2hsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="175279019"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="175279019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 10:49:04 -0700
IronPort-SDR: r00JZG/t68wMPpNfXe75+DLGZCVTowqwBSk2AwAfB6zDiW3JoLhHW2vWrhS7SndNyloTjPKNse
 74BX/suNlhDg==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="477291046"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.241.30]) ([10.212.241.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 10:49:02 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
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
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
 <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
 <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com> <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <20200826170841.GX6642@arm.com> <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
 <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
 <873648w6qr.fsf@oldenburg2.str.redhat.com>
 <CAMe9rOqpLyWR+Ek7aBiRY+Kr6sRxkSHAo2Sc6h0YCv3X3-3TuQ@mail.gmail.com>
 <CAMe9rOpuwZesJqY_2wYhdRXMhd7g0a+MRqPtXKh7wX5B5-OSbA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3c12b6ee-7c93-dcf4-fbf7-2698003386dd@intel.com>
Date:   Tue, 1 Sep 2020 10:49:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMe9rOpuwZesJqY_2wYhdRXMhd7g0a+MRqPtXKh7wX5B5-OSbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/27/2020 7:08 AM, H.J. Lu wrote:
> On Thu, Aug 27, 2020 at 7:07 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Thu, Aug 27, 2020 at 6:36 AM Florian Weimer <fweimer@redhat.com> wrote:
>>>
>>> * H. J. Lu:
>>>
>>>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> wrote:
>>>>>
>>>>> * Dave Martin:
>>>>>
>>>>>> You're right that this has implications: for i386, libc probably pulls
>>>>>> more arguments off the stack than are really there in some situations.
>>>>>> This isn't a new problem though.  There are already generic prctls with
>>>>>> fewer than 4 args that are used on x86.
>>>>>
>>>>> As originally posted, glibc prctl would have to know that it has to pull
>>>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
>>>>> then the u64 argument is a problem for arch_prctl as well.
>>>>>
>>>>
>>>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
>>>
>>> The commit message and the C source say otherwise, I think (not sure
>>> about the C source, not a kernel hacker).
>>
>> It should read:
>>
>> arch_prctl(ARCH_X86_CET_DISABLE, unsigned long features)
>>
> 
> Or
> 
> arch_prctl(ARCH_X86_CET_DISABLE, unsigned int features)
> 

Like other arch_prctl()'s, this parameter was 'unsigned long' earlier. 
The idea was, since this arch_prctl is only implemented for the 64-bit 
kernel, we wanted it to look as 64-bit only.  I will change it back to 
'unsigned long'.

Yu-cheng
