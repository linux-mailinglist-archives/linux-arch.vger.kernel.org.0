Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48152736A1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 01:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgIUX16 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 19:27:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:62727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUX16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 19:27:58 -0400
IronPort-SDR: qX2EM5rH77KzBq9rqHoCxTEz6yAPEO8oFj3KSBSP6V4oB8k89KIxO94kjuxI9MnIP71u/iO7+J
 kAr40tTonI7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222090913"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="222090913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 16:27:57 -0700
IronPort-SDR: s70dQPnrd9HnchA+yXDoMTCvVLXkQq9CMRN7cT6JqAIAicSh1zFZJSN7KpwAh8O9Z6jiqlhUlW
 Jd+/61SFkjow==
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="510929617"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.102.78]) ([10.212.102.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 16:27:56 -0700
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
 <3a0b0baf-a0f5-fd15-3af1-0059a807100b@intel.com>
 <9cf234db-d0f7-0466-be2c-afe04eb76759@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <5e0a4005-45e3-3e88-e6e0-4ec31aad7eb9@intel.com>
Date:   Mon, 21 Sep 2020 16:27:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9cf234db-d0f7-0466-be2c-afe04eb76759@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/21/2020 3:54 PM, Dave Hansen wrote:
> On 9/21/20 3:47 PM, Yu, Yu-cheng wrote:
>>> The 900KB is probably wrong today in a lot of configurations, and will;
>>> only get *more* wrong over time.
>>
>> I was talking about the vmlinux file, and probably should have said
>> bzImage size, which has 14 KB increase when CET is enabled.
> 
> Well, vmlinux size is important too.  1 page of vmlinux size means one
> fewer page of memory available for real use.
> 
> I would really encourage you when you write to try to be specific and
> use as much plain language as possible without being verbose.  Most
> people understand things like "this feature increases kernel text size".
>   I wouldn't expect most folks who can type "make oldconfig; make
> install" to understands the difference between vmlinux and bzImage.
> 

Ok, thanks!

Yu-cheng
