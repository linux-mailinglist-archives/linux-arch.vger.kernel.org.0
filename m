Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9805B25C631
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgICQJE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 12:09:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:42295 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgICQJE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 12:09:04 -0400
IronPort-SDR: 1NhuyrsD94GV8ZMw89w7t0V1xuNWB8VuXgSJVnoettkb83VcOdd55dOpGtC+ZON/LuG7CYlF6c
 b7y8ofnHa3Fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137127466"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="137127466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:09:03 -0700
IronPort-SDR: +C92qNo6vPQliFbZvRVoLeCI4c58RtTTyJZLqSfKqMdZx/NGqhVaiuZEkTHCzNP6ihEpbCixYB
 VQvGXEsgZUUQ==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="503116307"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.173.133]) ([10.209.173.133])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:09:01 -0700
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <88261152-2de1-fe8d-7ab0-acb108e97e04@intel.com>
Date:   Thu, 3 Sep 2020 09:09:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b3809dd7-8566-0517-2389-8089475135b7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/3/2020 7:26 AM, Dave Hansen wrote:
> On 9/2/20 9:35 PM, Andy Lutomirski wrote:
>>>>>>> +       fpu__prepare_read(fpu);
>>>>>>> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>>>>>>> +       if (!cetregs)
>>>>>>> +               return -EFAULT;
>>>>>> Can this branch ever be hit without a kernel bug? If yes, I think
>>>>>> -EFAULT is probably a weird error code to choose here. If no, this
>>>>>> should probably use WARN_ON(). Same thing in cetregs_set().
>>>>> When a thread is not CET-enabled, its CET state does not exist.  I looked at EFAULT, and it means "Bad address".  Maybe this can be ENODEV, which means "No such device"?
>> Having read the code, I’m unconvinced. It looks like a get_xsave_addr() failure means “state not saved; task sees INIT state”.  So *maybe* it’s reasonable -ENODEV this, but I’m not really convinced. I tend to think we should return the actual INIT state and that we should permit writes and handle them correctly.
> 
> PTRACE is asking for access to the values in the *registers*, not for
> the value in the kernel XSAVE buffer.  We just happen to only have the
> kernel XSAVE buffer around.

When get_xsave_addr() returns NULL, there are three possibilities:
- XSAVE is not enabled or not supported;
- The kernel does not support the requested feature;
- The requested feature is in INIT state.

If the debugger is going to write an MSR, only in the third case would 
this make a slight sense.  For example, if the system has CET enabled, 
but the task does not have CET enabled, and GDB is writing to a CET MSR. 
  But still, this is strange to me.

> 
> If we want to really support PTRACE we have to allow the registers to be
> get/set, regardless of what state they are in, INIT state or not.  So,
> yeah I agree with Andy.
> 

GDB does not have a WRMSR mechanism.  If GDB is going to write an MSR, 
it will call arch_prctl or an assembly routine in memory.

Yu-cheng
