Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA75302ED2
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbhAYWT3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 17:19:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:45039 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732358AbhAYWTZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 17:19:25 -0500
IronPort-SDR: iBtGRh4x4jC5jQqTwbFKNe/Si9NZfLZhB3Z5LYMK934cFoz8jumtgrXvTdOBxuFv93xCaZI1J0
 aEL7jfW35ITQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="167485735"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="167485735"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 14:18:39 -0800
IronPort-SDR: DugOZsV+ToMjSGqjsXLvGijFi0PtI0XJE4I4LV/dYgGFrabp02LiqxEDb9/wwuIe3v5gJVNFfF
 HGVTIeRsiaLA==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="393535238"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.60.232]) ([10.212.60.232])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 14:18:38 -0800
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c000e1fa-5da8-9316-ef9e-565d79308296@intel.com>
Date:   Mon, 25 Jan 2021 14:18:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125215558.GK23070@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/25/2021 1:55 PM, Borislav Petkov wrote:
> On Mon, Jan 25, 2021 at 01:27:51PM -0800, Yu, Yu-cheng wrote:
>>> Maybe I'm missing something but those two can happen outside of the
>>> loop, no? Or is *ptep somehow changing concurrently while the loop is
>>> doing the CMPXCHG and you need to recreate it each time?
>>>
>>> IOW, you can generate upfront and do the empty loop...
>>
>> *ptep can change concurrently.
> 
> Care to elaborate?
> 

For example, when a thread reads a W=1, D=0 PTE and before changing it 
to W=0,D=0, another thread could have written to the page and the PTE is 
W=1, D=1 now.  When try_cmpxchg() detects the difference, old_pte is 
read again.
