Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4A2D648E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Dec 2020 19:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbgLJSLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Dec 2020 13:11:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:54660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391482AbgLJSLm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Dec 2020 13:11:42 -0500
IronPort-SDR: CkDiKM29bTZAQn/YnA0b7lONVEUzHv5JbGuT2csil7BtcirkcUmwOppGmYdQ6VECsgOEvtB7ll
 2VIgqKLpuDzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="171737410"
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="171737410"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 10:11:00 -0800
IronPort-SDR: Di/9GtzhnlMyvHk9Tbj4VdG3pvc+2+9r5Kol8VEIrCJbCHfuinQBHCqC6rUIi0EFWr2uGFAbgY
 PRCKHV9MbYzw==
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="364822613"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.137.62]) ([10.212.137.62])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 10:10:58 -0800
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
 <cddc2cc5-a04e-ce9c-6fdf-2e7a29346cf7@intel.com>
 <20201210174155.GD26529@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <2f9a0203-63eb-c808-d67f-11ad0c105531@intel.com>
Date:   Thu, 10 Dec 2020 10:10:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210174155.GD26529@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/10/2020 9:41 AM, Borislav Petkov wrote:
> On Tue, Dec 08, 2020 at 11:24:16AM -0800, Yu, Yu-cheng wrote:
>> Case (a) is a normal writable data page that has gone through fork(). So it
> 
> Writable >
>> has W=0, D=1.  But here, the software chooses not to use the D bit, and
> 
> But it has W=0. So not writable?

Maybe I will change to: A page in a writable vma, has been modified and 
gone through fork().

>> instead, W=0, COW=1.
> 
> So the "new" way of denoting that the page is modified is COW=1
> *when* on CET hw. The D=1 bit is still used on the rest thus the two
> _PAGE_DIRTY_BITS.
> 
> Am I close?

COW=1 is only used in copy-on-write situation (when CET is enabled).  If 
W=1, D bit is used.

>> Case (b) is a normal read-only data page.  Since it is read-only, fork()
>> won't affect it.  In __get_user_pages(), a copy of the read-only page is
>> needed, and the page is duplicated.  The software sets COW=1 for the new
>> copy.
> 
> That makes more sense.
> 
>> Thread-A is writing to a writable page, and the page's PTE is becoming W=1,
>> D=1.  In the middle of it, Thread-B is changing the PTE to W=0.
> 
> Yah, add that to the explanation pls.
> 

Sure.
