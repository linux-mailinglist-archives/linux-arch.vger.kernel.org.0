Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A296317163
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhBJU30 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 15:29:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:38341 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231948AbhBJU3Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 15:29:25 -0500
IronPort-SDR: qH/w83vVi8Z8ZlMSvlEXRBknftDqaDEsjYy44oQyWURJ9jQMWM+MkGsdMUy0WY1hVZod7NU/IY
 aK7puWpyAc0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182283593"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="182283593"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 12:28:42 -0800
IronPort-SDR: C2gtxQF37nYHRLTyTbO97ptYfjx/bOJpnwR80Eqectr+d5v2RSeD7yjf1Uve6yLfo+U+QTX09R
 11FIsNyOKKfg==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="421193546"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.188.167]) ([10.212.188.167])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 12:28:40 -0800
Subject: Re: [PATCH v20 08/25] x86/mm: Introduce _PAGE_COW
To:     Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-9-yu-cheng.yu@intel.com>
 <202102101137.E109C9FE6@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <819b6d6a-64ea-d908-76ad-0a6366ed0d53@intel.com>
Date:   Wed, 10 Feb 2021 12:28:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102101137.E109C9FE6@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/10/2021 11:42 AM, Kees Cook wrote:
> On Wed, Feb 10, 2021 at 09:56:46AM -0800, Yu-cheng Yu wrote:
>> There is essentially no room left in the x86 hardware PTEs on some OSes
>> (not Linux).  That left the hardware architects looking for a way to
>> represent a new memory type (shadow stack) within the existing bits.
>> They chose to repurpose a lightly-used state: Write=0, Dirty=1.
>>
>> The reason it's lightly used is that Dirty=1 is normally set by hardware
>> and cannot normally be set by hardware on a Write=0 PTE.  Software must
>> normally be involved to create one of these PTEs, so software can simply
>> opt to not create them.
>>
>> In places where Linux normally creates Write=0, Dirty=1, it can use the
>> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY.  In other
>> words, whenever Linux needs to create Write=0, Dirty=1, it instead creates
>> Write=0, Cow=1, except for shadow stack, which is Write=0, Dirty=1.  This
>> clearly separates shadow stack from other data, and results in the
>> following:
>>
>> (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
>> (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
>>      The user page is in a R/O VMA, and get_user_pages() needs a writable
>>      copy.  The page fault handler creates a copy of the page and sets
>>      the new copy's PTE as Write=0 and Cow=1.
>> (c) A shadow stack PTE: (Write=0, Dirty=1)
>> (d) A shared shadow stack PTE: (Write=0, Cow=1)
>>      When a shadow stack page is being shared among processes (this happens
>>      at fork()), its PTE is made Dirty=0, so the next shadow stack access
>>      causes a fault, and the page is duplicated and Dirty=1 is set again.
>>      This is the COW equivalent for shadow stack pages, even though it's
>>      copy-on-access rather than copy-on-write.
>> (e) A page where the processor observed a Write=1 PTE, started a write, set
>>      Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
>>      will not happen on processors that support shadow stack.
>>
>> Define _PAGE_COW and update pte_*() helpers and apply the same changes to
>> pmd and pud.
> 
> I still find this commit confusing mostly due to _PAGE_COW being 0
> without CET enabled. Shouldn't this just get changed universally? Why
> should this change depend on CET?
> 

For example, in...

static inline int pte_write(pte_t pte)
{
	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
		return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY);
	else
		return pte_flags(pte) & _PAGE_RW;
}

There are four cases:

(a) RW=1, Dirty=1 -> writable
(b) RW=1, Dirty=0 -> writable
(c) RW=0, Dirty=0 -> not writable
(d) RW=0, Dirty=1 -> shadow stack, or not-writable if !X86_FEATURE_SHSTK

Case (d) is ture only when shadow stack is enabled, otherwise it is not 
writable.  With shadow stack feature, the usual dirty, copy-on-write PTE 
becomes RW=0, Cow=1.

We can get this changed universally, but all usual dirty, copy-on-write 
PTEs need the Dirty/Cow swapping, always.  Is that desirable?

--
Yu-cheng

[...]
