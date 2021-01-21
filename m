Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51F02FF778
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 22:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAUVlr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 16:41:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:49386 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbhAUVlb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 16:41:31 -0500
IronPort-SDR: OGhMR9Rk/bgECFutorlR+55TQQLiyl5C7hVx35FZf8eTbKrQzIn96rvNOqElguH7raWHtuL6L+
 SNWEJvgg209g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243425919"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="243425919"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:40:50 -0800
IronPort-SDR: u+JpUjjQSXfUXGLMAXw5NU/pwznQ/bNs8S+w5N5NH/wdP5atFQQCvDp7F07Fk3vKwlzciE8b70
 SLxX92CVOZxg==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="571851418"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.46.254]) ([10.209.46.254])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:40:47 -0800
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
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
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
 <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
 <20210121204113.GG32060@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <56a7b904-dddc-d92c-b74f-552f9738b8ac@intel.com>
Date:   Thu, 21 Jan 2021 13:40:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121204113.GG32060@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/2021 12:41 PM, Borislav Petkov wrote:
> On Thu, Jan 21, 2021 at 12:16:23PM -0800, Yu, Yu-cheng wrote:
>> It clears _PAGE_DIRTY and sets _PAGE_COW.  That is,
>>
>> if (pte.pte & _PAGE_DIRTY) {
>> 	pte.pte &= ~_PAGE_DIRTY;
>> 	pte.pte |= _PAGE_COW;
>> }
>>
>> So, shifting makes resulting code more efficient.
> 
> Efficient for what? Is this a hot path?
> 
> If not, I'd take readable code any day of the week.
> 

Ok, I will change it to the more readable code as stated earlier.

--
Yu-cheng
