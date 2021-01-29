Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42B6308F1F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhA2VOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:14:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:55425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhA2VON (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 16:14:13 -0500
IronPort-SDR: rS4XURAalZkPgLpfToHZEgxrW0ZODLXsiMsafLs/DchGJd5pAOASHuXF79bZwMCqhmhG5KtA1G
 iVxmFblmwtcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199332505"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="199332505"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 13:13:31 -0800
IronPort-SDR: YKpYFCq+rRt4zqUspD1JImoQHJ9ODV3X6/aXQ4uP4iER2tVzPmgw/RbyRy3mSTJpd8CYqX9jRr
 r0VhB8vP9R9A==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="475532535"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.214]) ([10.212.73.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 13:13:29 -0800
Subject: Re: [PATCH v18 02/25] x86/cet/shstk: Add Kconfig option for user-mode
 control-flow protection
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <40a5a9b5-9c83-473d-5f62-a16ecde50f2a@intel.com>
 <86F8CE62-A94B-46BD-9A29-DBE1CC14AA83@amacapital.net>
 <58d5f029-ee8a-ca93-f0e6-0278db22e208@intel.com>
 <20210129204601.GG27841@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <9061f862-8711-2ca2-b737-8d171de2f0c2@intel.com>
Date:   Fri, 29 Jan 2021 13:13:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210129204601.GG27841@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/29/2021 12:46 PM, Borislav Petkov wrote:
> On Fri, Jan 29, 2021 at 12:33:43PM -0800, Dave Hansen wrote:
>> In that case is there any reason to keep the "depends on CPU_SUP_INTEL"?
> 
> Probably not. I haven't heard of the AMD implementation being somehow
> different from Intel's.
> 

Ok, I will remove it.
