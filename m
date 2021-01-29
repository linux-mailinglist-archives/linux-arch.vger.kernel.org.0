Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3559B308E02
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhA2UDM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:03:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:19665 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhA2UCB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 15:02:01 -0500
IronPort-SDR: nl1VEiwq3vgV+9YCdwMvy2DbTvzqgHTJaJEIDJkKVoXm270/sc3/92M+OHuiA3LrnHYnOKPOX7
 PvrD7Xxryp6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="177914146"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="177914146"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:00:47 -0800
IronPort-SDR: c7w6gyxKcP32QMKgbQ7rCeCI3Gb7MxoZ3Mm5vf3g4Ta9XgJrcK7IZMEbWhNDXUP1fAoMRpPJG/
 9+qDpl84HO3Q==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="410850563"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.214]) ([10.212.73.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:00:46 -0800
Subject: Re: [PATCH v18 02/25] x86/cet/shstk: Add Kconfig option for user-mode
 control-flow protection
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
 <20210127212524.10188-3-yu-cheng.yu@intel.com>
 <40a5a9b5-9c83-473d-5f62-a16ecde50f2a@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <636174be-d49a-55bc-b996-79c7df9d5f1d@intel.com>
Date:   Fri, 29 Jan 2021 12:00:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <40a5a9b5-9c83-473d-5f62-a16ecde50f2a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/29/2021 11:42 AM, Dave Hansen wrote:
> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>> +	help
>> +	  Control-flow protection is a hardware security hardening feature
>> +	  that detects function-return address or jump target changes by
>> +	  malicious code.
> 
> It's not really one feature.  I also think it's not worth talking about
> shadow stacks or indirect branch tracking in *here*.  Leave that for
> Documentation/.
> 
> Just say:
> 
> 	Control-flow protection is a set of hardware features which
> 	place additional restrictions on indirect branches.  These help
> 	mitigate ROP attacks.
> 
> ... and add more in the IBT patches.
> 
>>   Applications must be enabled to use it, and old
>> +	  userspace does not get protection "for free".
>> +	  Support for this feature is present on processors released in
>> +	  2020 or later.  Enabling this feature increases kernel text size
>> +	  by 3.7 KB.
> 
> Did any CPUs ever get released that have this?  If so, name them.  If
> not, time to change this to 2021, I think.
> 

Ok.  I will update this.

Yu-cheng
