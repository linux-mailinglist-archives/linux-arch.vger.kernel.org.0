Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A4308DE1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhA2Tzf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 14:55:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:23678 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233130AbhA2Txv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 14:53:51 -0500
IronPort-SDR: zjf70VXaAEIUV36ih8JId+3Rp4ydDgb8CEOqNeIzlRUeuGGDKEZM2xsRKzmQQcATOQqZ/3o+Xs
 uFlRFG62DaNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="176968696"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="176968696"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 11:53:08 -0800
IronPort-SDR: +mj39OBP743gPD+7++bzmhvPPBqDOqmZztGCGnQxxTqwCoqylBM8mo9huhwBKWmuMHuPIE18m+
 pKgnaNZAm7ew==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="410848169"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.214]) ([10.212.73.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 11:53:02 -0800
Subject: Re: [PATCH v18 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
 <20210127212524.10188-25-yu-cheng.yu@intel.com>
 <ba39586d-25b6-6ea5-19c3-adf17b59f910@intel.com>
 <761ae8ce-0560-24cc-e6f7-684475cb3708@intel.com>
 <179fe87e-8fd1-9a26-e4f6-a508b45a54d4@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <8d8bccab-12f3-0ecb-f2b2-91c26f82958a@intel.com>
Date:   Fri, 29 Jan 2021 11:53:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <179fe87e-8fd1-9a26-e4f6-a508b45a54d4@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/29/2021 11:15 AM, Dave Hansen wrote:
> On 1/29/21 10:56 AM, Yu, Yu-cheng wrote:
>> On 1/29/2021 9:07 AM, Dave Hansen wrote:
>>> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
[...]
>>> What's the point of doing copy_status_to_user() if the processor doesn't
>>> support CET?  In other words, shouldn't this be below the CPU feature
>>> check?
>>
>> The thought was to tell the difference between the kernel itself does
>> not support CET and the system does not have CET.  And, if the kernel
>> supports it, show CET status of the thread.
> 
> Why would that matter to userspace?
> 
> If they want to know if the processor has CET support there are existing
> ways to do it.  I don't think this should be part of the ABI.
> 

Ok, I will make it:

if (!cpu_feature_enabled(X86_FEATURE_CET))
	...
