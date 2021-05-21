Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A1238CAD6
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhEUQTZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 12:19:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:15226 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhEUQTZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 12:19:25 -0400
IronPort-SDR: o+9RwqpsqLpqJR+lZh/NwfeQcDXpXKspzArxamWJez+xKsrlFC9a7FSSpfGQJf+ztj4Q/mQdgD
 b3rvgdGraxDg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="199576048"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="199576048"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 09:17:35 -0700
IronPort-SDR: mZryhIX47sLJixgt8Qc9gLmzKgJ+SBzaiz6RVQKGwMt7tm3L2OaO0MqVZ1E/fkxF8q0Q1gVB29
 ebFTGGc09p/A==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="434344646"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.254.177.76]) ([10.254.177.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 09:17:27 -0700
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
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
        Haitao Huang <haitao.huang@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com> <YKIfIEyW+sR+bDCk@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c9121ca1-83cb-1c37-1a8e-edaafaa6fda2@intel.com>
Date:   Fri, 21 May 2021 09:17:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKIfIEyW+sR+bDCk@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/17/2021 12:45 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:43:09PM -0700, Yu-cheng Yu wrote:

[...]

>> +
>> +	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
> 
> Flip this logic:
> 
> 	if ((ia32 && !IS_ALIGNED(ssp, 4)) || !IS_ALIGNED(ssp, 8))

If !IS_ALIGNED(ssp, 4), then certainly !IS_ALIGNED(ssp, 8).
This has to be as-is, I think.

Thanks,
Yu-cheng
