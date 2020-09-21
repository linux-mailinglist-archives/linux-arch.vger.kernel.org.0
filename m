Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6702735F3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIUWrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 18:47:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:20176 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWrx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 18:47:53 -0400
IronPort-SDR: 6+t3HFiFJTADTQPyi2oYCkBlRmLSAFxM4x2/geF+KrTBdmzyXMeD5fiBfFW/MSDBHrbvKGVrSl
 q7pAP2ubeNnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="161413478"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="161413478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 15:47:52 -0700
IronPort-SDR: gycAem7Xa6ebdzaySf5YhbAulUIpxadRgZqjyY2BtOc6mPeDk0qKrkJkSx9M/el7HVu4AykyIt
 /przTO84r3ag==
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="346716477"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.102.78]) ([10.212.102.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 15:47:51 -0700
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Dave Hansen <dave.hansen@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org>
 <20200918205933.GB4304@duo.ucw.cz>
 <019b5e45-b116-7f3d-f1f2-3680afbd676c@intel.com>
 <20200918214020.GF4304@duo.ucw.cz>
 <c2b5d697-634d-a5cb-2728-cead44a221c9@intel.com>
 <c91021a9-adb0-8733-2423-f78dbea5c88a@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3a0b0baf-a0f5-fd15-3af1-0059a807100b@intel.com>
Date:   Mon, 21 Sep 2020 15:47:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c91021a9-adb0-8733-2423-f78dbea5c88a@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/21/2020 3:41 PM, Dave Hansen wrote:
> On 9/21/20 3:30 PM, Yu, Yu-cheng wrote:
>> +config X86_INTEL_BRANCH_TRACKING_USER
>> +    prompt "Intel Indirect Branch Tracking for user-mode"
> 
> Take the "Intel " and "INTEL_" out, please.  It will only cause us all
> pain later if some of our x86 compatriots decide to implement this.
> 
>> If the kernel is to be used only on older systems that do not support
>> IBT, and the size of the binary is important, you can save 900 KB by
>> disabling this feature.
>>
>> Otherwise, if unsure, say Y.
> 
> 900k seems like a *lot*.  Where the heck does that come from?
> 
> Also, comments like that don't age very well.  Consider:
> 
> 	Support for this feature is only known to be present on Intel
> 	processors released in 2020 or later.  This feature is also
> 	known to increase kernel text size substantially.
> 
> 	If unsure, say N.
> 

Thanks!

> The 900KB is probably wrong today in a lot of configurations, and will;
> only get *more* wrong over time.
> 

I was talking about the vmlinux file, and probably should have said 
bzImage size, which has 14 KB increase when CET is enabled.

Yu-cheng
