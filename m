Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91D0369689
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 18:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbhDWQAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 12:00:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:62705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243177AbhDWQAf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Apr 2021 12:00:35 -0400
IronPort-SDR: zh+H+j+kZJ4l2ZIoYH4e2WsfrzAv6xIqJjmR3S1lemrIOVAA0uTsqIijtHWi7LjVp7m0tpZ2nx
 K/iIUiwSrMGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="281418077"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="281418077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 08:59:58 -0700
IronPort-SDR: w9MlMKEafsoA2GnJcPHYgHXbBDKJtAUy0Zz1rc7GGzWPVqI4elo3AjtBMWhPWCMiTLrQej0ran
 2vn64bGpfHGg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="603576576"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.37.160]) ([10.212.37.160])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 08:59:56 -0700
Subject: Re: [PATCH v25 21/30] mm: Re-introduce vm_flags to do_mmap()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Haitao Huang <haitao.huang@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-22-yu-cheng.yu@intel.com>
 <20210423103114.3hheurux4ixccrwv@box.shutemov.name>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a49d5fc5-03f8-511d-bf59-f2e56df33106@intel.com>
Date:   Fri, 23 Apr 2021 08:59:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423103114.3hheurux4ixccrwv@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/23/2021 3:31 AM, Kirill A. Shutemov wrote:
> On Thu, Apr 15, 2021 at 03:14:10PM -0700, Yu-cheng Yu wrote:
>> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
>> removed from the function's input by:
>>
>>      commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
>>
>> There is a new user now.  Shadow stack allocation passes VM_SHADOW_STACK to
>> do_mmap().  Thus, re-introduce vm_flags to do_mmap().
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Peter Collingbourne <pcc@google.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: linux-mm@kvack.org
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Thanks for reviewing.

Yu-cheng
