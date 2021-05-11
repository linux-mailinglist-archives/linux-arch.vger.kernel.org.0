Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89D537AE8B
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhEKSgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 14:36:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:42688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhEKSgS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 May 2021 14:36:18 -0400
IronPort-SDR: VLN+z1pa7BfBiZJFHMOFrVeCfEv5JbOkgdQlsnnA1nGJAlBdL1oVdqZxfGjUtF8HgYMk4kM4vn
 lQB5w4qYtIhA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="260779848"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="260779848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:35:06 -0700
IronPort-SDR: 2KWMocZbxX5tyqZAg7OsM0mkEVoJfqigNIZiG7v7OmxmAmJ4UREKqpCUEnT+ESKdjh0nogGOde
 b12AZro4a4Mg==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="537136995"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.34.147]) ([10.212.34.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:35:04 -0700
Subject: Re: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
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
        Haitao Huang <haitao.huang@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-24-yu-cheng.yu@intel.com> <YJlADyc/9pn8Sjkn@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a645aefc-632f-b1eb-4f4e-1c5b0f9e75d5@intel.com>
Date:   Tue, 11 May 2021 11:35:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJlADyc/9pn8Sjkn@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/10/2021 7:15 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:43:08PM -0700, Yu-cheng Yu wrote:
>> @@ -181,6 +184,12 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>>   	if (clone_flags & CLONE_SETTLS)
>>   		ret = set_new_tls(p, tls);
>>   
>> +#ifdef CONFIG_X86_64
> 
> IS_ENABLED
> 
>> +	/* Allocate a new shadow stack for pthread */
>> +	if (!ret)
>> +		ret = shstk_setup_thread(p, clone_flags, stack_size);
>> +#endif
>> +
> 
> And why is this addition here...
> 
>>   	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
>>   		io_bitmap_share(p);
> 
> ... instead of here?
> 
> <---
> 

io_bitmap_share() does refcount_inc(&current->thread.io_bitmap->refcnt), 
and the function won't fail.  However, shadow stack allocation can fail. 
  So, maybe leave io_bitmap_share() at the end?

Thanks,
Yu-cheng
