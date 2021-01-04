Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65782E9E99
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbhADUJK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:09:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:35243 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADUJK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jan 2021 15:09:10 -0500
IronPort-SDR: s5K+C27vyajcSgtzMVnYrTLDOOpnV7CQ717Anbodlk4hEBc58Jr90+l/mVWCNKMVWVq+xu0vZ2
 i68jNCNbwLcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="173494318"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="173494318"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 12:08:29 -0800
IronPort-SDR: urpI8d5B4JN9RjNmAOAUe5lL7HXhD3ElEk+4b7L539xEbw5mo/rkDiYv+M0N4sNtH00csg4QQ/
 mzFVpqGchYdw==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="360892786"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.103.116]) ([10.209.103.116])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 12:08:28 -0800
Subject: Re: [PATCH v17 00/26] Control-flow Enforcement: Shadow Stack
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Pengfei Xu <pengfei.xu@intel.com>, x86-patch-review@intel.com,
        "Schlobohm, Bruce" <bruce.schlobohm@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0a475c4c-58b0-0da7-8889-a0dbbc7d0fdc@intel.com>
Date:   Mon, 4 Jan 2021 12:08:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229213053.16395-1-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/29/2020 1:30 PM, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details are in "Intel 64 and
> IA-32 Architectures Software Developer's Manual" [1].
> 
> CET can protect applications and the kernel.  This series enables only
> application-level protection, and has three parts:
> 
>    - Shadow stack [2],
>    - Indirect branch tracking [3], and
>    - Selftests [4].
> 
> I have run tests on these patches for quite some time, and they have been
> very stable.  Linux distributions with CET are available now, and Intel
> processors with CET are already on the market.  It would be nice if CET
> support can be accepted into the kernel.  I will be working to address any
> issues should they come up.
> 
> Changes in v17:
> - Rebase to v5.11-rc1.

Hi Reviewers,

After a few revisions/re-bases, I have dropped some Reviewed-by tags. 
This revision is only a re-base to the latest Linus tree.  Please kindly 
comment if there are anything still not resolved, and I appreciate very 
much Reviewed-by/Acked-by tags to satisfactory patches.

--
Thanks,
Yu-cheng
