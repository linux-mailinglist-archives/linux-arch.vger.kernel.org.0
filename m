Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6925C698
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgICQVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 12:21:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:3943 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgICQVR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 12:21:17 -0400
IronPort-SDR: SBu/OVMwEM4iqnI+P+Z0V5LKrshiHqNKrOA6f07eDzqW9DMm2LlRL+0fKRLJjsGWWS4S/fswi/
 4XwYE9x7PqGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145348301"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145348301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:21:15 -0700
IronPort-SDR: +Pe0zUpW7n8ydj/YOVTaKR79uc3vTuh90uRyD5Hw3BPUUqT/NnJucVFtliTUbdOkPMAUiK4O9f
 Kyp5qF3qstzg==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="503120164"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.173.133]) ([10.209.173.133])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:21:11 -0700
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
 <88261152-2de1-fe8d-7ab0-acb108e97e04@intel.com>
 <1b51d89c-c7de-2032-df23-e138d1369ffa@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3967f126-f7ea-36fd-bec0-dfbbc46ef221@intel.com>
Date:   Thu, 3 Sep 2020 09:21:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1b51d89c-c7de-2032-df23-e138d1369ffa@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/3/2020 9:11 AM, Dave Hansen wrote:
> On 9/3/20 9:09 AM, Yu, Yu-cheng wrote:
>> If the debugger is going to write an MSR, only in the third case would
>> this make a slight sense.  For example, if the system has CET enabled,
>> but the task does not have CET enabled, and GDB is writing to a CET MSR.
>>   But still, this is strange to me.
> 
> If this is strange, then why do we even _implement_ writes?
> 

For example, if the task has CET enabled, and it is in a control 
protection fault, the debugger can clear the task's IBT state, or unwind 
the shadow stack, etc.  But if the task does not have CET enabled (its 
CET MSRs are in INIT state), it would make sense for the PTRACE call to 
return failure than doing something else, right?
