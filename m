Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755FF3313D5
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 17:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCHQwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 11:52:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:18037 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhCHQv6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 11:51:58 -0500
IronPort-SDR: RWbEuP4Jjbm1SJ/0pYMC8GqkKQB2hEImRPRu7UHuXYV57wiEDu/mKH0XmdtnV5Sf9HpL19TIhD
 EcBN+EeyLsEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249443244"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="249443244"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:51:58 -0800
IronPort-SDR: Ra6tLTStpq8dq36RZhKli0M2oVxfITFaaO3HQz+7ILvFtrtpvijqoqpCk6bbPegkcGxyt+LxRG
 15Q2Lh7fpluQ==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="385909914"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.186.31]) ([10.209.186.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:51:56 -0800
Subject: Re: [PATCH v21 10/26] x86/mm: Update pte_modify for _PAGE_COW
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
 <20210217222730.15819-11-yu-cheng.yu@intel.com>
 <20210305142940.GC2685@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b7105be2-d2de-c318-f6e2-2706e35dd7ce@intel.com>
Date:   Mon, 8 Mar 2021 08:51:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305142940.GC2685@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/5/2021 6:29 AM, Borislav Petkov wrote:
> On Wed, Feb 17, 2021 at 02:27:14PM -0800, Yu-cheng Yu wrote:
>> @@ -787,16 +802,34 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>   	 */
>>   	val &= _PAGE_CHG_MASK;
>>   	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
>> +	val = fixup_dirty_pte(val);
> 
> Do I see it correctly that you can do here and below:
> 
> 	/*
> 	 * Fix up potential shadow stack page flags because the RO, Dirty PTE is
> 	 * special.
> 	 */
> 	if (pte_dirty()) {
> 		pte_mkclean();
> 		pte_mkdirty();
> 	}
> 
> ?

Yes, this looks better.  Thanks!

> 
> That fixup thing looks grafted and not like a normal flow to me.
> 

