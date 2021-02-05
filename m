Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08ED311037
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhBERCU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 12:02:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:46168 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhBERAQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 12:00:16 -0500
IronPort-SDR: Ke/YG5Sr9I7n8vd4favQ7vANhQYVpmv01iWW3rFZ64Ms6C3aG4z/4fBTE2HsLU+YptgajHPqr7
 W+gb628L+QZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="245543343"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="245543343"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:41:53 -0800
IronPort-SDR: fYIBCWf6F8YGiaVwigkg6COEp/BFyCf3VF9Mir7LXUkPJtAgu5VY9t1zFYzDqvdG8dSaeFpRJW
 k8iP9sQMMw5g==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="358363786"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.95.7]) ([10.212.95.7])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:41:52 -0800
Subject: Re: [PATCH v19 08/25] x86/mm: Introduce _PAGE_COW
To:     Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>
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
 <2e43bf0b-e1a9-99f6-8d5d-d6e6886b4217@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <7381d8c1-5e1c-2667-7cb8-0a99f2c79b6d@intel.com>
Date:   Fri, 5 Feb 2021 10:41:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2e43bf0b-e1a9-99f6-8d5d-d6e6886b4217@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 12:27 PM, Dave Hansen wrote:
> On 2/4/21 12:19 PM, Kees Cook wrote:
>>> (e) A page where the processor observed a Write=1 PTE, started a write, set
>>>      Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
>>>      will not happen on processors that support shadow stack.
>> What happens for "e" with/without CET? It sounds like direct writes to
>> such pages will be (correctly) rejected by the MMU?
> 
> A page fault would be generated regardless of CET support.
> 
> If CET were not around, the fault would be reported as a present, write
> fault.
> 
> If this happened and CET were around (which shouldn't happen in
> practice, it means we have a hardware issue) a page fault exception is
> generated. 

Thanks for the clarification.  With or without CET, direct write to 
Write=0, Dirty=1 PTE triggers page fault.

> Yu-cheng, I'm not sure there's enough debugging around to
> tell us if this happens.  Would we even notice?

That potential hardware issue is, on a CET-capable system, a processor 
writes to a Write=1, Dirty=0 page, and then observes the PTE is Write=0, 
Dirty=1.  Let me think about it...

Thanks!

--
Yu-cheng
