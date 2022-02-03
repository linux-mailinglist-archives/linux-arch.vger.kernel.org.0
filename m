Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE734A90C2
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 23:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiBCWmj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 17:42:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:43030 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbiBCWmi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Feb 2022 17:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643928158; x=1675464158;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hy/RLCWe0cRSgQ/BO6pCCoutmThN1jchwoR0BruyloE=;
  b=leB0RL3GfKNKebEDBDo29GGL0HfgCF+KPiBZjDwfRijzdSsnExH+sW5/
   T0lQe1FQfoqR6xZWySe56wulk2Ej5SaH2ctEvdk/N4B1lAdBknL/MB87P
   0gvzYwLMZ786pAqLNbxx1Xf+lVt9faIkOCIYLfCf/By3JFxB5D96eT/ot
   4SBI70Lu1vCOTmbafdV1furIdMZxDIRok6AbPwXvlGukayHUO/1OM6je4
   rr2j6SGih/61dQB1fEglwU+q4PQ9vAwX5qboxM0acwMNQ0/W2Rm4oFjOR
   fCpIe3HSgCIBkb0UukhKR4CLZut8+4K35KujLqsIl0Hi8AfmET91MXWNI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="311573272"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="311573272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 14:42:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="498307414"
Received: from oshoron-mobl.amr.corp.intel.com (HELO [10.209.125.125]) ([10.209.125.125])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 14:42:35 -0800
Message-ID: <e8e1501a-fdb4-0b8b-21a6-3bea1c6d9016@intel.com>
Date:   Thu, 3 Feb 2022 14:42:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu@linux.intel.com, Yu-cheng <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-34-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 33/35] selftests/x86: Add map_shadow_stack syscall test
In-Reply-To: <20220130211838.8382-34-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> Add a simple selftest for exercising the new map_shadow_stack syscall.

This is a good start for the selftest.  But, it would be really nice to
see a few additional smoke tests in here that are independent of the
library support.

For instance, it would be nice to have tests that:

1. Write to the shadow stack with normal instructions (and recover from
   the inevitable SEGV).  Make sure the siginfo looks like we expect.
2. Corrupt the regular stack, or maybe just use a retpoline
   do induce a shadow stack exception.  Ditto on checking the siginfo
3. Do enough CALLs that will likely trigger a fault and an on-demand
   shadow stack page allocation.

That will test the *basics* and should be pretty simple to write.

