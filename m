Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6754F31109D
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBERSi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 12:18:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:24891 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233564AbhBERQy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 12:16:54 -0500
IronPort-SDR: uXqif6S7nFNP1YbwXUbPJGKLg83JpJKf+fKoBGiS3T6/UlSQ2xqGCWmlLGfIhKf27wo2Gqlm+N
 +Qve09QkS3rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="168593699"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="168593699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:58:36 -0800
IronPort-SDR: PKLSDoZriGTUaK7SMMGmhgy19dl1PLEvCUb5ekv5liqF4kTxmJEPaL5VV0T3jMRlLQvtxk1XlD
 jqrZlu7DH/0w==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="357790568"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.95.7]) ([10.212.95.7])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:58:34 -0800
Subject: Re: [PATCH v19 08/25] x86/mm: Introduce _PAGE_COW
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-9-yu-cheng.yu@intel.com>
 <202102041215.B54FCA552F@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <21b1e325-a17d-c859-973d-de66c1401f19@intel.com>
Date:   Fri, 5 Feb 2021 10:58:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102041215.B54FCA552F@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 12:19 PM, Kees Cook wrote:
> On Wed, Feb 03, 2021 at 02:55:30PM -0800, Yu-cheng Yu wrote:
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
> 
> What happens for "e" with/without CET? It sounds like direct writes to
> such pages will be (correctly) rejected by the MMU?
> 
>>
>> Define _PAGE_COW and update pte_*() helpers and apply the same changes to
>> pmd and pud.
>>
>> After this, there are six free bits left in the 64-bit PTE, and no more
>> free bits in the 32-bit PTE (except for PAE) and Shadow Stack is not
>> implemented for the 32-bit kernel.
> 
> Are there selftests to validate this change?
> 

I have some tests to verify, for example,

- After clone(), shadow stack pages are indeed copy-on-write,
- Shadow stack pages (i.e. Write=0, Dirty=1) cannot be directly written to,
- Shadow stack guard pages exist.

These tests are now on github, but kind of messy.  I can gradually clean 
up them and submit as selftests separately.

If you are asking for the detection of the potential hardware issue 
(that Dave Hansen talked about), then maybe we need to detect it from 
the kernel.

> I think it might be useful to more clearly describe what is considered
> "dirty" and "writeable" in comments above the pte_helpers.
> 

Yes, I will update it.  Thanks!

[...]
