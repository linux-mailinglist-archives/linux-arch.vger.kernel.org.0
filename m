Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B92D342D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgLHUcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 15:32:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:9234 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgLHUcD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 15:32:03 -0500
IronPort-SDR: LzMBVq1Ey1fd9+7nnwuV7N7TpPXukRIUFX1KZZYRNs07xl2z6Mrf4c8o9wQYWclU4moncwkBQz
 HZQ1cJEVA6KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="258665284"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="258665284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 11:24:17 -0800
IronPort-SDR: uTi/Mmkl/xKuBC/AXfiazJdiwWLlLG6xSH3fWQdFdTUbXRcuwFtEp5b5pUVtQ+yM50I5q+Vvf8
 X9TzX8nXSQNQ==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="317940844"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.139.184]) ([10.209.139.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 11:24:16 -0800
Subject: Re: [PATCH v15 08/26] x86/mm: Introduce _PAGE_COW
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
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-9-yu-cheng.yu@intel.com>
 <20201208175014.GD27920@zn.tnic>
 <218503f6-eec1-94b0-8404-6f92c55799e3@intel.com>
 <20201208184727.GF27920@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <cddc2cc5-a04e-ce9c-6fdf-2e7a29346cf7@intel.com>
Date:   Tue, 8 Dec 2020 11:24:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208184727.GF27920@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/8/2020 10:47 AM, Borislav Petkov wrote:
> On Tue, Dec 08, 2020 at 10:25:15AM -0800, Yu, Yu-cheng wrote:
>>> Both are "R/O + _PAGE_COW". Where's the difference? The dirty bit?
>>
>> The PTEs are the same for both (a) and (b), but come from different routes.
> 
> Do not be afraid to go into detail and explain to me what those routes
> are please.

Case (a) is a normal writable data page that has gone through fork(). 
So it has W=0, D=1.  But here, the software chooses not to use the D 
bit, and instead, W=0, COW=1.

Case (b) is a normal read-only data page.  Since it is read-only, fork() 
won't affect it.  In __get_user_pages(), a copy of the read-only page is 
needed, and the page is duplicated.  The software sets COW=1 for the new 
copy.

>>>> (e) A page where the processor observed a Write=1 PTE, started a write, set
>>>>       Dirty=1, but then observed a Write=0 PTE.
>>>
>>> How does that happen? Something changed the PTE's W bit to 0 in-between?
>>
>> Yes.
> 
> Also do not scare from going into detail and explaining what you mean
> here. Example?

Thread-A is writing to a writable page, and the page's PTE is becoming 
W=1, D=1.  In the middle of it, Thread-B is changing the PTE to W=0.

>>> Does _PAGE_COW mean dirty too?
>>
>> Yes.  Basically [read-only & dirty] is created by software.  Now the
>> software uses a different bit.
> 
> That convention:
> 
> "[read-only & dirty] is created by software."
> 
> needs some prominent writeup somewhere explaining what it is.
> 
> Thx.
> 

I will put these into the comments.

--
Yu-cheng
