Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99D633DB2E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhCPRpN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 13:45:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:27651 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhCPRox (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 13:44:53 -0400
IronPort-SDR: xPwmdyHycA4CP1DQ9zd6g3uRzySltVrBbEKbcH33xyBTQCDhQTqKVCmLbWWpJRJCOkbQinQL16
 xORI8b9JOEuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="189400399"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="189400399"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 10:44:52 -0700
IronPort-SDR: MZjiMp03UYJamI4W2nRjnkJKXjIRKPIm2imBomEuZSibBREq9EtVM4UkPwqWtXondLmupytRjs
 9OxkjGvzBGxw==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="439201248"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 10:44:46 -0700
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
 <0c0b3663-3c01-c166-03fa-a3dbfb250da3@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <1cbd8068-60e3-3fc9-9618-3262b179182d@intel.com>
Date:   Tue, 16 Mar 2021 10:44:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <0c0b3663-3c01-c166-03fa-a3dbfb250da3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 10:28 AM, Dave Hansen wrote:
> On 3/16/21 10:12 AM, Yu, Yu-cheng wrote:
>> On 3/16/2021 8:49 AM, Dave Hansen wrote:
> ...
>>> Is "#ifdef __i386__" the right thing to use here?  I guess ENDBR only
>>> ends up getting used in the VDSO, but there's a lot of
>>> non-userspace-exposed stuff in calling.h.  It seems a bit weird to have
>>> the normally userspace-only __i386__ in there.
>>>
>>> I don't see any existing direct use of __i386__ in arch/x86/entry/vdso.
>>
>> Good point.  My thought was, __i386__ comes from the compiler having the
>> -m32 command-line option, and it is not dependent on anything else.
>>
>> Alternatively, there is another compiler-defined macro _CET_ENDBR that
>> can be used.  We can put the following in calling.h:
>>
>> #ifdef __CET__
>> #include <cet.h>
>> #else
>> #define _CET_ENDBR
>> #endif
>>
>> and then use _CET_ENDBR in other files.  How is that?
>>
>> In the future, in case we have kernel-mode IBT, ENDBR macros are also
>> needed for other assembly files.
> 
> First of all, I think putting the macro in calling.h is wrong if it will
> be used exclusively in the VDSO.  If it's VDSO-only, please put it in a
> local header in the vdso/ directory, maybe even a new cet.h.
> 
> Also, Boris asked for two *different* macros for 32 and 64-bit:
> 
> https://lore.kernel.org/linux-api/20210310231731.GK23521@zn.tnic/
> 
> Could you do that in the next version, please?
> 

Yes, we can do two macros, probably in arch/x86/include/asm/vdso.h.
