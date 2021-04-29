Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9204336EDFD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhD2QR5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 12:17:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:12153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233480AbhD2QR5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Apr 2021 12:17:57 -0400
IronPort-SDR: u6RT5mR3NcX5bHVZOUpa+4AKjiaNPjx0dQF7RQ3RCA5o78NA04SE/8GxkXX2aKlplglR4vx5Wz
 zFOWWKdPUXgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="260990856"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="260990856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:17:08 -0700
IronPort-SDR: qpscS/NTPaNExpS/xy+h77DjUAj0MfSqWUBQ9aWY26+7MNzDWCTgXqKlTL6m4WaoZlZ1zH9tjB
 1WJjeFNQOWHQ==
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="458834640"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.75.159]) ([10.212.75.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:17:07 -0700
Subject: Re: [PATCH v26 22/30] x86/cet/shstk: Add user-mode shadow stack
 support
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
 <20210427204315.24153-23-yu-cheng.yu@intel.com> <YImg5hmBnTZTkYIp@zn.tnic>
 <3a0ed2e3-b13d-0db6-87af-fecd394ddd2e@intel.com> <YIp4c95E9/9DYR6z@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <bdd41e35-29f0-896a-72ec-8b1abeafda0d@intel.com>
Date:   Thu, 29 Apr 2021 09:17:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIp4c95E9/9DYR6z@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/29/2021 2:12 AM, Borislav Petkov wrote:
> On Wed, Apr 28, 2021 at 11:39:00AM -0700, Yu, Yu-cheng wrote:
>> Sorry about that.  After that email thread, we went ahead to separate shadow
>> stack and ibt into different files.  I thought about the struct, the file
>> names cet.h, etc.  The struct still needs to include ibt status, and if it
>> is shstk_desc, the name is not entirely true.  One possible approach is, we
>> don't make it a struct here, and put every item directly in thread_struct.
>> However, the benefit of putting all in a struct is understandable (you might
>> argue the opposite :-)).  Please make the call, and I will do the change.
> 
> /me looks forward into the patchset...
> 
> So this looks like the final version of it:
> 
> @@ -15,6 +15,7 @@ struct cet_status {
>   	unsigned long	shstk_base;
>   	unsigned long	shstk_size;
>   	unsigned int	locked:1;
> +	unsigned int	ibt_enabled:1;
>   };
> 
> If so, that thing should be simply:
> 
> 	struct cet {
> 		unsigned long shstk_base;
> 		unsigned long shstk_size;
> 		unsigned int shstk_lock : 1,
> 			     ibt	: 1;
> 	}
> 
> Is that ibt flag per thread or why is it here? I guess I'll find out.
> 
> /me greps...
> 
> ah yes, it is.
> 

The lock applies to both shadow stack and ibt.  So maybe just "locked"?

>> Yes, the comments are in patch #23: Handle thread shadow stack.  I wanted to
>> add that in the patch that takes the path.
> 
> That comes next, I'll look there.
> 
>>> vm_munmap() can return other negative error values, where are you
>>> handling those?
>>>
>>
>> For other error values, the loop stops.
> 
> And then what happens?
> 
>>>> +	cet->shstk_base = 0;
>>>> +	cet->shstk_size = 0;
> 
> You clear those here without even checking whether unmap failed somehow.
> And then stuff leaks but we don't care, right?
> 
> Someone else's problem, I'm sure.
> 

vm_munmap() returns error as the following:

(1) -EINVAL: address/size/alignment is wrong.
	For shadow stack, the kernel keeps track of it, this cannot/should not 
happen.  Should it happen, it is a bug.  The kernel can probably do WARN().

(2) -ENOMEM: when doing __split_vma()/__vma_adjust(), kmem_cache_alloc() 
fails.
	Not much we can do.  Perhaps WARN()?

(3) -EINTR: mmap_write_lock_killable(mm) fails.
	This should only happen to a pthread.  When a thread is existing, its 
siblings are holding mm->mmap_lock.  This is handled here.

Right now, in the kernel, only the munmap() syscall returns 
__vm_munmap() error code, otherwise the error is not checked.  Within 
the kernel and if -EINTR is not expected, this makes sense as explained 
above.

Thanks for questioning.  This piece needs to be correct.

Yu-cheng
