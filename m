Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC95334C72
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 00:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhCJXWx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 18:22:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:65011 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233271AbhCJXWr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 18:22:47 -0500
IronPort-SDR: V/Xx3Laz1EeK68MgBufPlwnSrDu7IaaXsJjbEO7DjSjBmuuPLnOtjpi8xKOn3ohdPhluCq7Cvn
 YrJV5pAlws3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188680184"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="188680184"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 15:22:45 -0800
IronPort-SDR: 0IDkoEO2HQZNiV1iZJn7oQUIDlBiMFDNIBXwwNfIe/p83TkZr4G7JQyi9y+5tOLg+e/KoeoVJ7
 SITLPWfab66A==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="509838912"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.23.206]) ([10.209.23.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 15:22:42 -0800
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com> <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
 <c2bfe707-2ef6-213a-f02c-4689726a473a@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <727fed3a-f7da-a947-4221-56ab39deefe4@intel.com>
Date:   Wed, 10 Mar 2021 15:22:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <c2bfe707-2ef6-213a-f02c-4689726a473a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/10/2021 3:20 PM, Dave Hansen wrote:
> On 3/10/21 2:55 PM, Yu, Yu-cheng wrote:
>> On 3/10/2021 2:39 PM, Jarkko Sakkinen wrote:
>>> On Wed, Mar 10, 2021 at 02:05:19PM -0800, Yu-cheng Yu wrote:
>>>> When CET is enabled, __vdso_sgx_enter_enclave() needs an endbr64
>>>> in the beginning of the function.
>>>
>>> OK.
>>>
>>> What you should do is to explain what it does and why it's needed.
>>>
>>
>> The endbr marks a branch target.  Without the "no-track" prefix, if an
>> indirect call/jmp reaches a non-endbr opcode, a control-protection fault
>> is raised.  Usually endbr's are inserted by the compiler.  For assembly,
>> these have to be put in manually.  I will add this in the commit log if
>> there is another revision.  Thanks!
> 
> This is close, but it's missing a detail or two that I think is
> important for someone like Jarkko trying to figure out what it means for
> his subsystem or driver.
> 
> I'd probably say:
> 
> ENDBR is a special new instruction for the Indirect Branch Tracking
> (IBR) component of CET.  IBT prevents attacks by ensuring that (most)
> indirect branches and function calls may only land at ENDBR
> instructions.  Branches that don't follow the rules will result in
> control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually, like this one.
> 

Ok, I will update.  Thanks!

--
Yu-cheng
