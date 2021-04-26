Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178436B86C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbhDZR46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 13:56:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:31190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237681AbhDZR46 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 13:56:58 -0400
IronPort-SDR: B8aO52X430f/pBsWcn102yppHQnco6lEUE+47Gv7Y2ry3AOwEhkJiu9FVRI02wPinginsYzdEH
 8JPHck26mz8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195932719"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195932719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 10:56:16 -0700
IronPort-SDR: 1sFm/xgmzUAr4alO+noRJjjdcUA+BwSswC61DGQQKhMYK7WbIJvRSAcnZmSi7MGyL25NKxfPCD
 fF20YtrXYBQQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="422743315"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.213]) ([10.212.73.213])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 10:56:15 -0700
Subject: Re: [PATCH v25 29/30] mm: Update arch_validate_flags() to include vma
 anonymous
To:     Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-30-yu-cheng.yu@intel.com>
 <20210426064056.bqbeekpsogd32yvm@box.shutemov.name>
 <20210426111114.GF4985@arm.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <eff52cb8-021a-3a52-eb7e-84473b3dfd0c@intel.com>
Date:   Mon, 26 Apr 2021 10:56:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210426111114.GF4985@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/26/2021 4:11 AM, Catalin Marinas wrote:
> On Mon, Apr 26, 2021 at 09:40:56AM +0300, Kirill A. Shutemov wrote:
>> On Thu, Apr 15, 2021 at 03:14:18PM -0700, Yu-cheng Yu wrote:
>>> When newer VM flags are being created, such as VM_MTE, it becomes necessary
>>> for mmap/mprotect to verify if certain flags are being applied to an
>>> anonymous VMA.
>>>
>>> To solve this, one approach is adding a VM flag to track that MAP_ANONYMOUS
>>> is specified [1], and then using the flag in arch_validate_flags().
>>>
>>> Another approach is passing vma_is_anonymous() to arch_validate_flags().
>>> To prepare the introduction of PROT_SHSTK, which creates a shadow stack
>>> mapping and can only be applied to an anonymous VMA, update arch_validate_
>>> flags() to include anonymous VMA information.
>>
>> I would rather pass down whole vma. Who knows what else
>> arch_validate_flags() would need to know about the VMA tomorrow:
>>
>> 	arch_validate_flags(vma, newflags);
>>
>> should do the trick.
> 
> A reason why we added a separate VM_MTE_ALLOWED flag was that we wanted
> MTE on other RAM-based based mappings, not just anonymous pages. See
> 51b0bff2f703 ("mm: Allow arm64 mmap(PROT_MTE) on RAM-based files").
> 
> Anyway, the above change doesn't get in the way.
> 

Thanks a lot for the clarification!

Yu-cheng
