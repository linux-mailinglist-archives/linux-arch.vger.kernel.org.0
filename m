Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77B9340974
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhCRP7x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 11:59:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:50906 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231927AbhCRP7d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Mar 2021 11:59:33 -0400
IronPort-SDR: h6IIETYp5BVASCxI0v9xPeSs/8Q1QRjwbc1f+FR7nY8DDrZ/zwGA5fERO1fQJzWZj3VkvLWjv0
 irj7+THjQoMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="177304282"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="177304282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 08:59:30 -0700
IronPort-SDR: kKWFS1pQmad2W49zFYAOG3ZxMvGCyh3Me0VkpNZIi7D+3z5rwfmc2LOnv0QgzMFM+kR/tdiT/+
 a9w/Ya8Irwgw==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="450527286"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.36.121]) ([10.209.36.121])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 08:59:29 -0700
Subject: Re: [PATCH v23 21/28] mm: Re-introduce vm_flags to do_mmap()
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
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-22-yu-cheng.yu@intel.com>
 <20210318114232.GD19570@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <af1f109b-c36e-b548-ae15-752f7af7c1d4@intel.com>
Date:   Thu, 18 Mar 2021 08:59:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318114232.GD19570@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/18/2021 4:42 AM, Borislav Petkov wrote:
> On Tue, Mar 16, 2021 at 08:10:47AM -0700, Yu-cheng Yu wrote:
>> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
>> removed from the function's input by:
>>
>>      commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
>>
>> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
>> do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
>> do_mmap_pgoff().
> 
> Why does this matter at all?
> 
> $ git grep do_mmap_pgoff
> $
> 

Right, do_mmap_pgoff() was removed by commit 45e55300f114.  This patch 
does not add back the wrapper.  Instead, add vm_flags to do_mmap(). 
Please advice if I misunderstand the question.

Thanks,
Yu-cheng
