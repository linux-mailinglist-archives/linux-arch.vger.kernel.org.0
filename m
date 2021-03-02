Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5932B4E6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhCCFa7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:4468 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231838AbhCBXtk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 18:49:40 -0500
IronPort-SDR: cpvKoa2amG/VNtTsYZeuoTrtQbqRKEk5UWbojAfbEIGfxODZQkeeC34u0XQ+eWqi1OY78DX5kn
 JDeTt6hVbfag==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166281817"
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="166281817"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 15:46:35 -0800
IronPort-SDR: hv/iD/ygCIE8H3t1ule/ZVIvikOyUAjmtov+tEKECJNvBd4KKG97ozZ+KyDdeZWNtPmhqWwCMy
 sPoFp9TN6UxQ==
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="406967876"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.177.76]) ([10.212.177.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 15:46:32 -0800
Subject: Re: [PATCH v21 08/26] x86/mm: Introduce _PAGE_COW
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
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-9-yu-cheng.yu@intel.com>
 <20210301155234.GF6699@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <167f58a3-20ef-7210-1d66-cf25f4a9bbef@intel.com>
Date:   Tue, 2 Mar 2021 15:46:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301155234.GF6699@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/1/2021 7:52 AM, Borislav Petkov wrote:
> On Wed, Feb 17, 2021 at 02:27:12PM -0800, Yu-cheng Yu wrote:

[...]

>>   static inline pmd_t pmd_mkdirty(pmd_t pmd)
>>   {
>> -	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>> +	pmdval_t dirty = _PAGE_DIRTY;
>> +
>> +	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))
> 
> 						      !(pmd_write(pmd))
> 

There is a problem of doing that: pmd_write() is defined after this 
function.  Maybe we can declare it first, or leave this as-is?

--
Yu-cheng
