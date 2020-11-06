Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978102A9BAE
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 19:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgKFSQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 13:16:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:18093 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgKFSQu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 13:16:50 -0500
IronPort-SDR: 0ERUQrx9svYpW7cxDnlGOyBPDgqwabT/Mxpx2119LGxuxRSsDfiMHHcGaPDVn5UNWECalwSQRR
 /B0psuxu4nCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="156581882"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="156581882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:16:49 -0800
IronPort-SDR: Ka0NRVjMOuYPOBeUcJOa8OIqahm5plMd42C7NVz8KqlA/ZUcuqINGfCTJyq5K5JLNcCLYM2dr9
 XzMj1I1VDiQg==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="472149838"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.221.127]) ([10.212.221.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:16:48 -0800
Subject: Re: [PATCH v14 01/26] Documentation/x86: Add CET description
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
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-2-yu-cheng.yu@intel.com>
 <20201106173410.GG14914@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <ebaff261-f8ad-d184-edd5-8efbd675deeb@intel.com>
Date:   Fri, 6 Nov 2020 10:16:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201106173410.GG14914@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/6/2020 9:34 AM, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 08:38:25AM -0700, Yu-cheng Yu wrote:
>> +[1] Overview
>> +============
>> +
>> +Control-flow Enforcement Technology (CET) is an Intel processor feature
>> +that provides protection against return/jump-oriented programming (ROP)
>> +attacks.  It can be set up to protect both applications and the kernel.
>> +Only user-mode protection is implemented in the 64-bit kernel, including
>> +support for running legacy 32-bit applications.
>> +
>> +CET introduces Shadow Stack and Indirect Branch Tracking.  Shadow stack is
>> +a secondary stack allocated from memory and cannot be directly modified by
>> +applications.  When executing a CALL, the processor pushes the return
> 				       ^
> 				    . .. instruction ...
> 

I will update it.

[...]

>> +
>> +[2] Application Enabling
>> +========================
>> +
>> +An application's CET capability is marked in its ELF header and can be
>> +verified from the following command output, in the NT_GNU_PROPERTY_TYPE_0
>> +field:
>> +
>> +    readelf -n <application>
> 
> Can be verified how? What does it say for a CET-enabled executable? Put
> it here in the doc pls.
> 

readelf -n <application> | grep SHSTK
	properties: x86 feature: IBT, SHSTK

I will add this.

[...]

>> +[3] Backward Compatibility
>> +==========================
>> +
>> +GLIBC provides a few tunables for backward compatibility.
>> +
>> +GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
>> +    Turn off SHSTK/IBT for the current shell.
> 
> For the current shell? How?
> 
> You mean, you execute the kernel shell with that variable set? So you
> set this variable in any executable's env which links with glibc in
> order to disable CET?
> 
> In any case, this needs clarification.
> 

In the current shell, if GLIBC_TUNABLES variable is set as such, 
applications started will have CET features disabled.  I can put more 
details here, or maybe a reference to the GLIBC man pages.

Thanks,
Yu-cheng
