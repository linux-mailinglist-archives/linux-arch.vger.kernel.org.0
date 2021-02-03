Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4746930E537
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 22:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBCVzZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 16:55:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:31742 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBCVzY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 16:55:24 -0500
IronPort-SDR: dki/tcFY5jf6CsHBIUnCVpY1HYgNYNp7jLC4VREjng0wiB6+y/PkPMlAN8Aoue6jLUExiL9HMm
 Py7zDnXbcHRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160290204"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="160290204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 13:54:43 -0800
IronPort-SDR: cbNFcluLVt0agMFYdYPy9R/OKBGP7PxtHIJxAE2sR0GRhutjiRbmm0lsH8LRWO3x3Iolq9fwYN
 AW0O5oc+YcIA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="433627376"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.43.162]) ([10.212.43.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 13:54:41 -0800
Subject: Re: [PATCH v18 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
 <20210127212524.10188-25-yu-cheng.yu@intel.com>
 <ba39586d-25b6-6ea5-19c3-adf17b59f910@intel.com>
 <761ae8ce-0560-24cc-e6f7-684475cb3708@intel.com>
Message-ID: <6720b1a9-f785-dbbd-1f0e-8c9090be2069@intel.com>
Date:   Wed, 3 Feb 2021 13:54:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <761ae8ce-0560-24cc-e6f7-684475cb3708@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/29/2021 10:56 AM, Yu, Yu-cheng wrote:
> On 1/29/2021 9:07 AM, Dave Hansen wrote:
>> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>>> arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
>>>      Get CET feature status.
>>>
>>>      The parameter 'args' is a pointer to a user buffer.  The kernel 
>>> returns
>>>      the following information:
>>>
>>>      *args = shadow stack/IBT status
>>>      *(args + 1) = shadow stack base address
>>>      *(args + 2) = shadow stack size

[...]

>>> +int prctl_cet(int option, u64 arg2)
>>> +{
>>> +    struct cet_status *cet;
>>> +    unsigned int features;
>>> +
>>> +    /*
>>> +     * GLIBC's ENOTSUPP == EOPNOTSUPP == 95, and it does not recognize
>>> +     * the kernel's ENOTSUPP (524).  So return EOPNOTSUPP here.
>>> +     */
>>> +    if (!IS_ENABLED(CONFIG_X86_CET))
>>> +        return -EOPNOTSUPP;
>>
>> Let's ignore glibc for a moment.  What error code *should* the kernel be
>> returning here?  errno(3) says:
>>
>>         EOPNOTSUPP      Operation not supported on socket (POSIX.1)
>> ...
>>         ENOTSUP         Operation not supported (POSIX.1)
>>
> 
> Yeah, other places in kernel use ENOTSUPP.  This seems to be out of 
> line.  And since the issue is long-existing, applications already know 
> how to deal with it.  I should have made that argument.  Change it to 
> ENOTSUPP.

When I make the change, checkpatch says...

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#128: FILE: arch/x86/kernel/cet_prctl.c:33:
+		return -ENOTSUPP;

Do we want to reconsider?

[...]
