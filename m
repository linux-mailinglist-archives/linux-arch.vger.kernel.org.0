Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAED313E0B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhBHSvX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 13:51:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:19742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhBHSvA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 13:51:00 -0500
IronPort-SDR: jtO57MKjPDT2Hi85PUtM1GHO3bFumY+0XQqEcMQmoqatUfBm/XjK/o76hIlLmzIye30poOffZq
 IyRhZY/ccS1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="178251561"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="178251561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 10:50:11 -0800
IronPort-SDR: RKBHoDdAWK2blnUYN00Qk4/M1GPezTS0E9lZ/If3NWriwtfE4VnzSdkvSBoLQzNvY2P1WCjvA+
 SuIcuc84nSYQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="487522995"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.11.33]) ([10.251.11.33])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 10:50:08 -0800
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
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
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <20210205135927.GH17488@zn.tnic>
 <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
 <20210208182009.GE18227@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <690bc3b9-2890-e68d-5e4b-cda5c21b496b@intel.com>
Date:   Mon, 8 Feb 2021 10:50:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208182009.GE18227@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/8/2021 10:20 AM, Borislav Petkov wrote:
> On Fri, Feb 05, 2021 at 10:00:21AM -0800, Yu, Yu-cheng wrote:
>> The ratelimit here is only for #CP, and its rate is not counted together
>> with other types of faults.  If a task gets here, it will exit.  The only
>> condition the ratelimit will trigger is when multiple tasks hit #CP at once,
>> which is unlikely.  Are you suggesting that we do not need the ratelimit
>> here?
> 
> I'm trying to first find out why is it there.
> 
> Is this something you've hit during testing and thought, oh well, this
> needs a ratelimit or was it added just because?
> 

I have not run into the situation.  Initially it was there because other 
faults have it.  When you asked, I went through it and put out my 
reasoning.  I think it still makes sense to keep it.

--
Yu-cheng
