Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CD32436B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhBXR5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 12:57:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:40330 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhBXR5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 12:57:09 -0500
IronPort-SDR: /nEY0p/EBP6zLAHj2QtZac80hNgV6oBY2nUEYm2CDKPkAMxmEsULw1gsPI8moPRPt4XcEfzBVW
 CZHwnJHAh0PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="185310653"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="185310653"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 09:56:15 -0800
IronPort-SDR: YqNXWLdfdbMrk/tJAmUlXvygcJmEDG35gmknOvPRHqoirvT4udUb1v+3bX1fFs6ZUJKV/Imeip
 XRSLDAYPVYUw==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="391684126"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.35.50]) ([10.212.35.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 09:56:14 -0800
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-7-yu-cheng.yu@intel.com>
 <20210224161343.GE20344@zn.tnic>
 <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
 <20210224165332.GF20344@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <db493c76-2a67-5f53-29a0-8333facac0f5@intel.com>
Date:   Wed, 24 Feb 2021 09:56:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224165332.GF20344@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/24/2021 8:53 AM, Borislav Petkov wrote:
> On Wed, Feb 24, 2021 at 08:44:45AM -0800, Yu, Yu-cheng wrote:
>>>> +	force_sig_fault(SIGSEGV, SEGV_CPERR,
>>>> +			(void __user *)uprobe_get_trap_addr(regs));
>>>
>>> Why is this calling an uprobes function?
>>>
>>
>> I will change it to error_get_trap_addr().
> 
> "/*
>    * Posix requires to provide the address of the faulting instruction for
>    * SIGILL (#UD) and SIGFPE (#DE) in the si_addr member of siginfo_t.
>    ..."
> 
> Is yours SIGILL or SIGFPE?
> 

No.  Maybe I am doing too much.  The GP fault sets si_addr to zero, for 
example.  So maybe do the same here?
