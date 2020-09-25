Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7B278E71
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIYQaG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 12:30:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:63060 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYQaG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 12:30:06 -0400
IronPort-SDR: 9UctMn/qR+OAiVHYpuiLo9eMOQO76MGajNKL8gFqQPrxLzkXNHPxQs85gc02sq8nQu1cRP05Mw
 6fMH53X314Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="141595760"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="141595760"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:24:04 -0700
IronPort-SDR: vHdifD14J84gl8JjAmKSDE2KtjS/2Giltym9R13pNYrr/NHuWS2H57QxhxDK7TQVW7t78AKulw
 y+D7DjrH2MJw==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="455901501"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.161.229]) ([10.213.161.229])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:24:02 -0700
Subject: Re: [PATCH v13 7/8] x86/vdso: Insert endbr32/endbr64 to vDSO
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
References: <20200925145804.5821-1-yu-cheng.yu@intel.com>
 <20200925145804.5821-8-yu-cheng.yu@intel.com>
 <CALCETrUyLfbodgH3vWqneFgpJb0DEiqRs-ZikhrhhVUR_13xjQ@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <9473b1ef-2e05-4faa-1eb7-b0e22560b267@intel.com>
Date:   Fri, 25 Sep 2020 09:24:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUyLfbodgH3vWqneFgpJb0DEiqRs-ZikhrhhVUR_13xjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/25/2020 9:18 AM, Andy Lutomirski wrote:
> On Fri, Sep 25, 2020 at 7:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>
>> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
>> called indirectly, and must have ENDBR32 or ENDBR64 as the first
>> instruction.  The compiler must support -fcf-protection=branch so that it
>> can be used to compile vDSO.
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 

Thanks!

Yu-cheng
