Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3162A3A4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 22:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiKOVBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 16:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiKOVAv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 16:00:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D82D1DB;
        Tue, 15 Nov 2022 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668546050; x=1700082050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xNXRQeFXYRAOm6+Xp0IR39SUwaBcxozLGg7herY21Uw=;
  b=lsMLP5YEmDLIiClnND4hhrp8X142NLIRYPufiX9WA9b534Zf0UmGZN49
   mIWgyOnz/rynybLDAqg6KzIXLUAnUJu/751Cj1c3uZlZtQ3ir7fczBcGN
   Z2vRCvdzgh2/I83jzrLhza50Of149TTYWeeyowHqINPUDHWl7AHXH6fe9
   W8SZf0TOCAhq1NFIaKdVDypN5IrdWrF01AgA7aQdxizIwcqGjqscU/wHR
   YpUc9f6UaX9qhvmrBemYy0m0dGQK4fBgEGReKXOZ1Ky00GiXJk/7lrA3O
   8p2Aoqt/lRdxCjlt1PWfAWd+di8q0WhHjaqaVbVKNteOeLXAr5tMG8sMr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314181085"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="314181085"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:00:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="813821204"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="813821204"
Received: from dn-intelpc-071822.amr.corp.intel.com (HELO [10.212.229.216]) ([10.212.229.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:00:40 -0800
Message-ID: <93029063-4a68-d275-b437-12930e119347@intel.com>
Date:   Tue, 15 Nov 2022 13:00:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 36/37] x86/cet/shstk: Add ARCH_CET_UNLOCK
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-37-rick.p.edgecombe@intel.com>
 <Y3OmaSjhCtjht1nS@hirez.programming.kicks-ass.net>
 <4273232513cd178be303d817b15e442703bda637.camel@intel.com>
 <Y3P9V1c0ytuC2/3g@hirez.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y3P9V1c0ytuC2/3g@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/15/22 12:57, Peter Zijlstra wrote:
> On Tue, Nov 15, 2022 at 08:01:12PM +0000, Edgecombe, Rick P wrote:
>>>> +	if (task != current) {
>>>> +		if (option == ARCH_CET_UNLOCK &&
>>>> IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)) {
>>> Why make this conditional on CRIU at all?
>> Kees asked for it, I think he was worried about attackers using it to
>> unlock and disable shadow stack. So wanted to lock it down to the
>> maximum.
> Well, distros will all have this stuff enabled no? So not much
> protection in practise.

Yeah, that's true for the distros.

But, I would imagine that our more paranoid friends like the ChromeOS
folks might appreciate this.
