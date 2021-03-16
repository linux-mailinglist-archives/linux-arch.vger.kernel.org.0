Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8933DB22
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhCPRme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 13:42:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:20268 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237187AbhCPRmS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 13:42:18 -0400
IronPort-SDR: Luog/eSVuE5Y+9t2kD8gIGsPke0RSA2R+bWEHH3+qs4U66PyRPq+nfWvwdk62E0UPASxtEsxno
 V2XPEV+WdS2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="250669011"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="250669011"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 10:42:16 -0700
IronPort-SDR: f0SxOICmOaiqZef26nO4Kc3WGs3J9QmZNrSTvmBXF7jKu2OphHw5eAmOtpcaUMChMLK5TMjVIh
 v5zl69QEwFdw==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="439200689"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 10:42:14 -0700
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
 <20210316173032.GE18003@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b0de1933-29ca-6c18-5a11-e293e9415f19@intel.com>
Date:   Tue, 16 Mar 2021 10:42:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316173032.GE18003@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 10:30 AM, Borislav Petkov wrote:
> On Tue, Mar 16, 2021 at 10:12:39AM -0700, Yu, Yu-cheng wrote:
>> Alternatively, there is another compiler-defined macro _CET_ENDBR that can
>> be used.  We can put the following in calling.h:
> 
> Not calling.h - this is apparently needed in vdso code only so I guess
> some header there, arch/x86/include/asm/vdso.h maybe? In the
> 
> #else /* __ASSEMBLER__ */
> 
> branch maybe...
> 
>> #ifdef __CET__
>> #include <cet.h>
>> #else
>> #define _CET_ENDBR
>> #endif
>>
>> and then use _CET_ENDBR in other files.  How is that?
> 
> What does that macro do? Issue an ENDBR only?
> 

Yes, issue endbr32, endbr64, or nothing when cet is not enabled.
