Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50039048E
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhEYPGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:06:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:43946 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhEYPGa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:06:30 -0400
IronPort-SDR: d2iXweram81x4jc/Oi1fEYxf8uKY0LUKKes+AtDFp4Q9CYnSKtmy/pzjHmykLzYdMS1ZRTaPy2
 cmVxXhmBTK7g==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189591924"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="189591924"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 08:03:24 -0700
IronPort-SDR: nrw6C2L0FRFrHa4m4gp1TR5TsTcNGmIi7bIhjT1Elk2IgJhHWKWAfx53xW84jcfLUrhsHWxgSk
 ZICHsDfzQsXQ==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="414061051"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.101]) ([10.209.133.101])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 08:03:21 -0700
Subject: Re: [PATCH v27 30/31] mm: Update arch_validate_flags() to test vma
 anonymous
To:     Catalin Marinas <catalin.marinas@arm.com>
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
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-31-yu-cheng.yu@intel.com>
 <20210525110011.GD15564@arm.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <908938ec-912b-9190-40e0-11ca88e8f0d7@intel.com>
Date:   Tue, 25 May 2021 08:03:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525110011.GD15564@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/25/2021 4:00 AM, Catalin Marinas wrote:
> On Fri, May 21, 2021 at 03:12:10PM -0700, Yu-cheng Yu wrote:
>> When newer VM flags are being created, such as VM_MTE, it becomes necessary
>> for mmap/mprotect to verify if certain flags are being applied to an
>> anonymous VMA.
>>
>> To solve this, one approach is adding a VM flag to track that MAP_ANONYMOUS
>> is specified [1], and then using the flag in arch_validate_flags().
>>
>> Another approach is passing the VMA to arch_validate_flags(), and check
>> vma_is_anonymous().
>>
>> To prepare the introduction of PROT_SHADOW_STACK, which creates a shadow
>> stack mapping and can be applied only to an anonymous VMA, update
>> arch_validate_flags() to pass in the VMA.
>>
>> [1] commit 9f3419315f3c ("arm64: mte: Add PROT_MTE support to mmap() and mprotect()"),
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> Cc: Will Deacon <will@kernel.org>
> 
> For arm64:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Thanks!
