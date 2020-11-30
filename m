Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524B52C917D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbgK3WtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 17:49:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:46892 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgK3Wsw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 17:48:52 -0500
IronPort-SDR: g13egRQdLtV+Yhrv0gnFase0h4G3sN3HK9XEH1dlgYHiStplNP17DOC+jet0Ky01PdNhlXguaZ
 u5h3/enR6IXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="257434948"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="257434948"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 14:48:11 -0800
IronPort-SDR: gGmBV20c4rH3tKsfMA6R/DzXOXz5E14WS3EFzsab7Ro/qdraHqv2e0F0knX05IFHfHG/BGFvSw
 NZ7MQjWMozHA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404888251"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 14:48:10 -0800
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for user-mode
 Shadow Stack
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
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-6-yu-cheng.yu@intel.com>
 <20201127171012.GD13163@zn.tnic>
 <98e1b159-bf32-5c67-455b-f798023770ef@intel.com>
 <20201130181500.GH6019@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <1db3d369-734e-9925-fa14-e799a19ac30c@intel.com>
Date:   Mon, 30 Nov 2020 14:48:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201130181500.GH6019@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/2020 10:15 AM, Borislav Petkov wrote:
> On Sat, Nov 28, 2020 at 08:23:59AM -0800, Yu, Yu-cheng wrote:
>> We have X86_BRANCH_TRACKING_USER too.  My thought was, X86_CET means any of
>> kernel/user shadow stack/ibt.
> 
> It is not about what it means - it is what you're going to use/need. You have
> ifdeffery both with X86_CET and X86_SHADOW_STACK_USER.
> 
> This one
> 
> +#ifdef CONFIG_X86_SHADOW_STACK_USER
> +#define DISABLE_SHSTK	0
> +#else
> +#define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
> +#endif
> 
> for example, is clearly wrong and wants to be #ifdef CONFIG_X86_CET, for
> example. Unless I'm missing something totally obvious.

Logically, enabling IBT without shadow stack does not make sense, but 
these features have different CPUIDs, and CONFIG_X86_SHADOW_STACK_USER 
and CONFIG_X86_BRANCH_TRACKING_USER can be selected separately.

Do we want to have only one selection for both features?  In other 
words, we turn on both or neither.

Thanks,
Yu-cheng

> 
> In any case, you need to analyze what Kconfig defines the code will
> need and to what they belong and add only the minimal subset needed.
> Our Kconfig symbols space is already nuts so adding more needs to be
> absolutely justified.
> 
> Thx.
> 
