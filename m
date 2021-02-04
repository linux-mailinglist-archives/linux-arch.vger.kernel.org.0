Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998D330FDB6
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbhBDUEt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:04:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:33281 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239008AbhBDUE2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 15:04:28 -0500
IronPort-SDR: 2oE41L3fGN2kx+E1hX5iz4q/OhUL/M89yqB74o76uQzVlOzKksVvgfu0hBae9k5UHP54iUFvhc
 zgSEq0ZgMpNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161075742"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="161075742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 12:03:44 -0800
IronPort-SDR: XxFJSw5z4InLRHJDvib+k6U2jBKrIPHUKyL9l5TVt4Lag6RVTHcOlPWqu11Yum3Cw0qMdpwBZ1
 E3iX1OrjovMw==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="373001450"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.100.6]) ([10.209.100.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 12:03:42 -0800
Subject: Re: [PATCH v19 01/25] Documentation/x86: Add CET description
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-2-yu-cheng.yu@intel.com>
 <202102041152.E257D3E2BE@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <21717dd3-5b80-03a2-6858-d062ff81d7a5@intel.com>
Date:   Thu, 4 Feb 2021 12:03:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102041152.E257D3E2BE@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 11:52 AM, Kees Cook wrote:
> On Wed, Feb 03, 2021 at 02:55:23PM -0800, Yu-cheng Yu wrote:
>> Explain no_user_shstk/no_user_ibt kernel parameters, and introduce a new
>> document on Control-flow Enforcement Technology (CET).
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks for reviewing the series.

--
Yu-cheng
