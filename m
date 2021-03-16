Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4077133DE63
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhCPUGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 16:06:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:65418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhCPUFf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 16:05:35 -0400
IronPort-SDR: 4nFwkHvubkgrKg3A1Q3m3Y7LXdF4dAcJ2S4PWXlt3CeZYRYAzi8p+lrHo1sOC+nUjEeesgupoP
 JMpjs8go4kYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186949277"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186949277"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 13:05:32 -0700
IronPort-SDR: m87m/iHLU9EGKxPObdn8zkRbbHBN/x4XyXUxDoK7CHfHQ6aT6A+9dSBc2gLhbCMWwCeQhSvuLA
 tT0wbHj/S9dA==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="372095298"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 13:05:31 -0700
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
 <YFENvgrR8JSYq1ae@hirez.programming.kicks-ass.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <65845773-6cf0-1bdc-1ecf-168de74cc283@intel.com>
Date:   Tue, 16 Mar 2021 13:05:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFENvgrR8JSYq1ae@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 12:57 PM, Peter Zijlstra wrote:
> On Tue, Mar 16, 2021 at 10:12:39AM -0700, Yu, Yu-cheng wrote:
>> Alternatively, there is another compiler-defined macro _CET_ENDBR that can
>> be used.  We can put the following in calling.h:
>>
>> #ifdef __CET__
>> #include <cet.h>
>> #else
>> #define _CET_ENDBR
>> #endif
>>
>> and then use _CET_ENDBR in other files.  How is that?
>>
>> In the future, in case we have kernel-mode IBT, ENDBR macros are also needed
>> for other assembly files.
> 
> Can we please call it IBT_ENDBR or just ENDBR. CET is a horrible name,
> seeing how it is not specific.
> 

_CET_ENDBR is from the compiler and we cannot change it.  We can do:

#define ENDBR _CET_ENDBR

How is that?
