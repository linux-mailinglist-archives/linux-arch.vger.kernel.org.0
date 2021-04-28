Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F200036DC48
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhD1Prj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 11:47:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:38165 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240489AbhD1Pr0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 11:47:26 -0400
IronPort-SDR: WDFuOCh4jFL+z6EiCWvxT3jzG8EXwRjrknnqD9+MTbfihsWwLYY5v5j8OKKcD+hVHlvpYpDfjO
 pNbLEWb9+Irw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="217489590"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="217489590"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 08:42:50 -0700
IronPort-SDR: /OWRlgjZ0wHSA6ggy60QZxgWW9o+HITbgQiS/XSvWmnow0pIOwN5tBgD9qTODMQKg/BS5HJIjd
 28fqMtnt2dsg==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="430359505"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.34]) ([10.209.133.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 08:42:48 -0700
Subject: Re: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch
 Tracking
To:     Andy Lutomirski <luto@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <9f7dbabe-f369-fef9-a303-53e94c5fa4ad@intel.com>
Date:   Wed, 28 Apr 2021 08:42:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/28/2021 8:14 AM, Andy Lutomirski wrote:
> On Wed, Apr 28, 2021 at 7:57 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Wed, Apr 28, 2021 at 7:52 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> On Wed, Apr 28, 2021 at 7:48 AM David Laight <David.Laight@aculab.com> wrote:
>>>>
>>>> From: Yu-cheng Yu
>>>>> Sent: 27 April 2021 21:47
>>>>>
>>>>> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
>>>>> return/jump-oriented programming attacks.  Details are in "Intel 64 and
>>>>> IA-32 Architectures Software Developer's Manual" [1].
>>>> ...
>>>>
>>>> Does this feature require that 'binary blobs' for out of tree drivers
>>>> be compiled by a version of gcc that adds the ENDBRA instructions?

David, do you mean kernel loadable drivers here?  Do not worry about it 
for now, since shadow stack/ibt is not enabled for kernel-mode yet.

>>>>
>>>> If enabled for userspace, what happens if an old .so is dynamically
>>>> loaded?
>>
>> CET will be disabled by ld.so in this case.
> 
> What if a program starts a thread and then dlopens a legacy .so?
> 
>>
>>>> Or do all userspace programs and libraries have to have been compiled
>>>> with the ENDBRA instructions?
>>
>> Correct.  ld and ld.so check this.
>>
>>> If you believe that the userspace tooling for the legacy IBT table
>>> actually works, then it should just work.  Yu-cheng, etc: how well
>>> tested is it?
>>>
>>
>> Legacy IBT bitmap isn't unused since it doesn't cover legacy codes
>> generated by legacy JITs.
>>
> 
> How does ld.so decide whether a legacy JIT is in use?
> 

Let me clarify.  IBT bitmap isn't used at all.  How dlopen() works 
depends entirely on the tunable of glibc.cpu.x86_ibt.  There are three 
values: on, off, permissive.  On is always on, and off is always off, 
regardless of the .so having ibt or not.  The default is "permissive," 
which turns off ibt upon dlopen a legacy .so.  I hope this also answers 
Andy's question above.

Yu-cheng
