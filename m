Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B8304E05
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 01:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbhAZXhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:37:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:32786 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390022AbhAZRHz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Jan 2021 12:07:55 -0500
IronPort-SDR: isjOqGRmE+Gj09JWKuSW4ysyj2galbHoL0hDTd34/M77BOaU+ELtAd8P7qWk1Fa1dWy/AyOnfJ
 Ai5edlTS6KOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177361862"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="177361862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:45:08 -0800
IronPort-SDR: 1lnn6dLSjZsvUzYC004Zq7WqDUJ9wbWzfZnjJqc+oti7kBC5bOxEJBmTc6AjJx2iQxG+v3AvmN
 6R/gTSu1RsbQ==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="504586158"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.153.84]) ([10.212.153.84])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:45:07 -0800
Subject: Re: [PATCH v17 11/26] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
 <20210125182709.GC23290@zn.tnic>
 <8084836b-4990-90e8-5c9a-97a920f0239e@intel.com>
 <20210125215558.GK23070@zn.tnic>
 <c000e1fa-5da8-9316-ef9e-565d79308296@intel.com>
 <20210126102404.GA6514@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <5f8da4cc-9c5c-73f9-7426-924c77797995@intel.com>
Date:   Tue, 26 Jan 2021 08:45:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126102404.GA6514@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/26/2021 2:24 AM, Borislav Petkov wrote:
> On Mon, Jan 25, 2021 at 02:18:37PM -0800, Yu, Yu-cheng wrote:
>> For example, when a thread reads a W=1, D=0 PTE and before changing it to
>> W=0,D=0, another thread could have written to the page and the PTE is W=1,
>> D=1 now.  When try_cmpxchg() detects the difference, old_pte is read again.
> 
> None of that is mentioned in the comment above it and if anything,
> *that* is what should be explained there - not some guarantee about some
> processors which doesn't even apply here.
> 
> Also, add the fact that try_cmpxchg() will update old_pte with any
> modified bits - D=1 for example - when it fails. As Peter just explained
> to me on IRC.
> 
> Thx.
> 

Yes, I will fix it.  Thanks!
