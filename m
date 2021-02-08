Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B5313ED6
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 20:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhBHTYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 14:24:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:47138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232482AbhBHTYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 14:24:06 -0500
IronPort-SDR: mugynaee8hkJ81+tKn1UPz3M5Ib0ZFXm2QY3/9PVI8Po0LQ05POnKzFTH+r+WVkdfrLR3DLrmG
 1ReXHy/cePBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168890238"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="168890238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:23:23 -0800
IronPort-SDR: hQ7EzHLh1XjKnGXhPuD/XToDkgJwmpEbNG7R0HZcj22PJbDNwj7jCGyg5PpGndMk2uHcpLhv2w
 rrglSOj3nHFg==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="377921602"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.11.33]) ([10.251.11.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:23:19 -0800
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
 <690bc3b9-2890-e68d-5e4b-cda5c21b496b@intel.com>
 <20210208185341.GF18227@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0e0c9e9d-aee1-ad1e-6c63-21b58a52163f@intel.com>
Date:   Mon, 8 Feb 2021 11:23:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208185341.GF18227@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/8/2021 10:53 AM, Borislav Petkov wrote:
> On Mon, Feb 08, 2021 at 10:50:07AM -0800, Yu, Yu-cheng wrote:
>> I have not run into the situation.  Initially it was there because other
>> faults have it.
> 
> Which other faults?

exc_general_protection() and do_trap() both call show_signal(), which 
then calls printk_ratelimit().

> 
>> When you asked, I went through it and put out my reasoning.
> 
> What does that mean?
> 

I went through my patch and check if ratelimit is necessary, and then 
describe the finding.

>> I think it still makes sense to keep it.
> 
> Because you have a hunch or you actually have an objective reason why?
> 

For example, if a shell script, in a loop re-starts an app when it 
exits, and the app is causing control-protection fault.  The log 
messages should be rate limited.
