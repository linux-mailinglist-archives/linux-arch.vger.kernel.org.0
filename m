Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC238D2DB
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEVB7l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 21:59:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:6339 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhEVB7l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 21:59:41 -0400
IronPort-SDR: tHeQdk5oT7sL4UaAgu8mD6ZspjcLNbF8qkxf1f1A7erTV42XuBd3g7fxtKwZOh9msq3p3vo3W5
 usx89uXfcvww==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201660914"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201660914"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 18:58:16 -0700
IronPort-SDR: IS1a1WjJpDP/oMTDY7yRQl6/vLIwFp04ZRQAZ3ziPozZVC+dJYHKaJK5SF3eo2OzyVejVGMg9A
 Ua3eWG277zeg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="395558527"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.254.177.76]) ([10.254.177.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 18:58:14 -0700
Subject: Re: [PATCH v27 13/31] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
        Haitao Huang <haitao.huang@intel.com>,
        Peter Xu <peterx@redhat.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-14-yu-cheng.yu@intel.com>
 <CAJHvVcjsecq-nOVE1ew1ctG2UpK0F0d0MjNncUgK0L=R4eyDqA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <74057265-c148-98bf-9ada-21328b160227@intel.com>
Date:   Fri, 21 May 2021 18:58:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJHvVcjsecq-nOVE1ew1ctG2UpK0F0d0MjNncUgK0L=R4eyDqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/21/2021 3:25 PM, Axel Rasmussen wrote:
> This seems reasonable to me. The particular bit used isn't so
> important from my perspective. I can't think of a way this would break
> backward compatibility or such. So:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks!

Yu-cheng

> 
> On Fri, May 21, 2021 at 3:13 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
>> VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Axel Rasmussen <axelrasmussen@google.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   include/linux/mm.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c274f75efcf9..923f89b9f1b5 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -373,7 +373,7 @@ extern unsigned int kobjsize(const void *objp);
>>   #endif
>>
>>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>> -# define VM_UFFD_MINOR_BIT     37
>> +# define VM_UFFD_MINOR_BIT     38
>>   # define VM_UFFD_MINOR         BIT(VM_UFFD_MINOR_BIT)  /* UFFD minor faults */
>>   #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>>   # define VM_UFFD_MINOR         VM_NONE
>> --
>> 2.21.0
>>

