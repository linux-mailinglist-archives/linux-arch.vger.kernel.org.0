Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57A36DCF2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 18:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhD1QZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 12:25:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:43430 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhD1QZn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 12:25:43 -0400
IronPort-SDR: +4Spkr0uMoBgdOlJU22Pw7WvkHr689r04aaJ69bXQmM4Y9gd7GeyXoKVaMHB7lzWk4Vuyst3js
 vh6uuJSbMsug==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="217503193"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="217503193"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 09:24:56 -0700
IronPort-SDR: iYKiWGUzmjWmi7osjPR7ovPDHt4e7Z5mHFxVw8uXJpANdfEyblOIG9sK3P803dR1wOybig8Imf
 nQ2aVbEXh9Zg==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="537022643"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.34]) ([10.209.133.34])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 09:24:53 -0700
Subject: Re: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch
 Tracking
To:     David Laight <David.Laight@ACULAB.COM>,
        'Andy Lutomirski' <luto@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
 <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
 <CAMe9rOp7FauoqQ0vx+ZVPGOE9+ABspheuGLc++Chj_goE5HvWA@mail.gmail.com>
 <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
 <0c6e1c922bc54326b1121194759565f5@AcuMS.aculab.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <7d857e5d-e3d3-1182-5712-813abf48ccba@intel.com>
Date:   Wed, 28 Apr 2021 09:24:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <0c6e1c922bc54326b1121194759565f5@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/28/2021 8:33 AM, David Laight wrote:
> From: Andy Lutomirski
>> Sent: 28 April 2021 16:15
>>
>> On Wed, Apr 28, 2021 at 7:57 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>>>
>>> On Wed, Apr 28, 2021 at 7:52 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>>
>>>> On Wed, Apr 28, 2021 at 7:48 AM David Laight <David.Laight@aculab.com> wrote:
>>>>>
>>>>> From: Yu-cheng Yu
>>>>>> Sent: 27 April 2021 21:47
>>>>>>
>>>>>> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
>>>>>> return/jump-oriented programming attacks.  Details are in "Intel 64 and
>>>>>> IA-32 Architectures Software Developer's Manual" [1].
>>>>> ...
>>>>>
>>>>> Does this feature require that 'binary blobs' for out of tree drivers
>>>>> be compiled by a version of gcc that adds the ENDBRA instructions?
>>>>>
>>>>> If enabled for userspace, what happens if an old .so is dynamically
>>>>> loaded?
>>>
>>> CET will be disabled by ld.so in this case.
>>
>> What if a program starts a thread and then dlopens a legacy .so?
> 
> Or has shadow stack enabled and opens a .so that uses retpolines?
> 

When shadow stack is enabled, retpolines are not necessary.  I don't 
know if glibc has been updated for detection of this case.  H.J.?

>>>>> Or do all userspace programs and libraries have to have been compiled
>>>>> with the ENDBRA instructions?
>>>
>>> Correct.  ld and ld.so check this.
>>>
>>>> If you believe that the userspace tooling for the legacy IBT table
>>>> actually works, then it should just work.  Yu-cheng, etc: how well
>>>> tested is it?
>>>>
>>>
>>> Legacy IBT bitmap isn't unused since it doesn't cover legacy codes
>>> generated by legacy JITs.
>>>
>>
>> How does ld.so decide whether a legacy JIT is in use?
> 
> What if your malware just precedes its 'jump into the middle of a function'
> with a %ds segment override?
> 

Do you mean far jump?  It is not tracked by ibt, which tracks near 
indirect jump.  The details can be found in Intel SDM.

> I may have a real problem here.
> We currently release program/library binaries that run on Linux
> distributions that go back as far as RHEL6 (2.6.32 kernel era).
> To do this everything is compiled on a userspace of the same vintage.
> I'm not at all sure a new enough gcc to generate the ENDBR64 instructions
> will run on the relevant system - and may barf on the system headers
> even if we got it to run.
> I really don't want to have to build multiple copies of everything.

This is likely OK.  We have tested many combinations.  Should you run 
into any issue, please let glibc people know.

Thanks!

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

