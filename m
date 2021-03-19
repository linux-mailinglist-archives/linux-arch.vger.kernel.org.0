Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B413420AA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 16:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCSPPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 11:15:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:57445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhCSPPj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 11:15:39 -0400
IronPort-SDR: mrmqTzXK/04Ycy+cJvBvbMh6+C0X2IJ6CXiJ+h0o86ZTDcAwvYukWsi713bJIrPAtLE5laoWiR
 3tw/BTl/mn5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="253912336"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="253912336"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 08:15:35 -0700
IronPort-SDR: xqCql09qCKZCcyUj9naOiIO6KtbsHf2bUgXg7u6ReJH6uqO28nq/GVC31qrzwCLql1HWkoZgk8
 EoNy+lU/ZQMQ==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="450895952"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.156.180]) ([10.209.156.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 08:15:33 -0700
Subject: Re: [PATCH v23 22/28] x86/cet/shstk: User-mode shadow stack support
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
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-23-yu-cheng.yu@intel.com>
 <20210318123215.GE19570@zn.tnic>
 <b05ee7eb-1b5d-f84f-c8f3-bfe9426e8a7d@intel.com>
 <20210319092806.GB6251@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3144b030-0f90-717b-b373-2d0b346010c8@intel.com>
Date:   Fri, 19 Mar 2021 08:15:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319092806.GB6251@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/19/2021 2:28 AM, Borislav Petkov wrote:
> On Thu, Mar 18, 2021 at 12:05:58PM -0700, Yu, Yu-cheng wrote:
>> Maybe I would add comments here.
> 
> Yap.
> 
> Also, looking forward in the set, I see prctl_set() and that is also
> done on current so should be ok.
> 
> In any case, yes, documenting the assumptions and expectations wrt
> current here is a good idea.
> 
>> If vm_munmap() returns -EINTR, mmap_lock is held by something else. That
>> lock should not be held forever.  For other types of error, the loop stops.
> 
> Ok I guess. The subsequent WARN_ON_ONCE() looks weird too but that
> should not fire, right? :)
> 
> Thx.
> 

That should not fire.

Yu-cheng
