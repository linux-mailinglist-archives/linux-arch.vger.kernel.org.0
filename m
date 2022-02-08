Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8561E4ACD06
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbiBHBFe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 20:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241527AbiBHANv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 19:13:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259AC061355;
        Mon,  7 Feb 2022 16:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644279231; x=1675815231;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BPhMCShSVCOniHzYsoSxv9XqF3MkYnnOdHCV78VWtYE=;
  b=WoUOH0XueyPf6viG/SvNCzthgcBzOXDApLFisYC5ny5vXAcSqYlCTzUY
   MWg57ImYiaTSm4bnYeJjVaiG6ej90jV4hUuRogP0+LAdgAwB/zTdo+02I
   oxzrGZVDcyaQmYlHrc0/kyIlRkXe4SScCA2oXcGKs1GOXcghBxFv8aMXS
   Pp25DJ33kDdvEKwthR19EGC7zF8TJvK/ZVi+jJZMpgg/8uWq+y56JuGty
   LDI+UmF6bbZCrUxPiswXn29mRbkt/qfWqGxAeIPxqLzdolV0GoKdoesNZ
   jyCu+7ngti/x3fFuLLCRNJxBHhUrOsbZWEbqUG0Bzq1Gf8ZI6+cPdZAak
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="312134685"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="312134685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:13:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525332786"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:13:48 -0800
Message-ID: <672fa390-c88c-4e2a-aa42-52d171acfd62@intel.com>
Date:   Mon, 7 Feb 2022 16:13:45 -0800
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-8-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 07/35] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
In-Reply-To: <20220130211838.8382-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> The x86 family of processors do not directly create read-only and Dirty
> PTEs.  These PTEs are created by software.

That's not strictly correct.

There's nothing in the architecture today to prevent the CPU from
creating Write=0,Dirty=1 PTEs.  In fact, some CPUs do this in weird
situations.  It wouldn't be wrong to say:

	Processors sometimes directly create read-only and Dirty PTEs.

which is the opposite of what is written above.  This is why the CET
spec has the blurb about shadow-stack-supporting CPUs promise not to do
this any more.

> One such case is that kernel
> read-only pages are historically setup as Dirty.

				   ^ set up

> New processors that support Shadow Stack regard read-only and Dirty PTEs as
> shadow stack pages.

This also isn't *quite* correct.  It's not just having a new processor,
it includes enabling shadow stacks.

> This results in ambiguity between shadow stack and kernel read-only
> pages.  To resolve this, removed Dirty from kernel read- only pages.
One thing that's not clear from the spec: does this cause an *actual*
problem?  For instance, does setting:

	IA32_U_CET.SH_STK_EN=1
but
	IA32_S_CET.SH_STK_EN=0

means that shadow stacks are enforced in user *MODE* or on
user-paging-permission (U=0) PTEs?

I think it's modes, but it would be nice to be clear.  *BUT*, if this is
accurate, doesn't it also mean that this patch is not strictly necessary?

Don't get me wrong, the patch is probably still a good idea, but let's
make sure we get the exact reasoning clear.
