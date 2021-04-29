Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22536EEEE
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 19:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbhD2Rc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 13:32:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:11003 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhD2Rc4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Apr 2021 13:32:56 -0400
IronPort-SDR: W63xBrubrE5qYXKY92Pr5EC2YJBuEW4rIM5d2YhyGp0vO49YvQjMvcwd8Q0cRBrOkLMbTc4Mrc
 nKquoGkpGEuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177177761"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177177761"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 10:32:08 -0700
IronPort-SDR: TnxOrJZEtmY/kB2S7cpaJ5lojTrPFtPea7GvvhLZQylZpLtTFuDPxCVdUaYmo5zd6GWwgEV5Z3
 XutSpmtVadTw==
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="430953584"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.75.159]) ([10.212.75.159])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 10:32:05 -0700
Subject: Re: [PATCH v26 00/30] Control-flow Enforcement: Shadow Stack
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
 <YIrpT1UxXqFtzySx@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <aa1ac406-84c8-b0f0-b70b-7224df4c8c77@intel.com>
Date:   Thu, 29 Apr 2021 10:32:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIrpT1UxXqFtzySx@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/29/2021 10:13 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:42:45PM -0700, Yu-cheng Yu wrote:
>> I have run tests on these patches for quite some time, and they have been
>> very stable.
> 
> While at it, how about adding a simple selftest too, so that people can
> play with it and perhaps it could even run a bunch of tests?
> 

I did send out some selftest patches (link is in the cover letter). 
However, those need to be updated to the Linux standard, and I would 
like to do it separately.

Yu-cheng
