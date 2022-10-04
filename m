Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB05F3A5C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 02:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJDAJP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJDAJI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 20:09:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA182339B;
        Mon,  3 Oct 2022 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664842147; x=1696378147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aa9xL1h4AcH+tfPWyZLVKtFOv8x6EYzjVZIOkGJl5EU=;
  b=k1wsmHsff3H5IzKJNzpXQzzG05jYB1/xZ9MviwOep9TmP0O33QDKYoZt
   U7F0NtG6pAODqA3U2nv963lV8hb0vWVG7j1UKkmERLjiUJQpY5cfGoY7c
   3TQvIhfujHOFIYTA1+Ngp0PYgKhZmttUyOpH2oYNAUhgzBMw2hrKx55nz
   RnTemRMBQ+NTxc5Dl+U2yVMaYILqjxr8uUz9eDddFrLyo3OgpjrylDoIF
   lVXe0hSM3Ygwa28Zmtr48lEqxKxgLpbAU5ZgpbGp0TmXlyM12SDpOhiaP
   ltaCr2307uMO5DHbzKkAh0PL2sMwmrMehBQPXEaVOA/oq8BHA4txaEZKn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="290011189"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="290011189"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:09:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="952574919"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="952574919"
Received: from akashred-mobl.amr.corp.intel.com (HELO [10.212.139.217]) ([10.212.139.217])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:09:04 -0700
Message-ID: <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
Date:   Mon, 3 Oct 2022 17:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202210031656.23FAA3195@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 16:57, Kees Cook wrote:
> On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe wrote:
>> Shadow stack is supported on newer AMD processors, but the kernel
>> implementation has not been tested on them. Prevent basic issues from
>> showing up for normal users by disabling shadow stack on all CPUs except
>> Intel until it has been tested. At which point the limitation should be
>> removed.
>>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> So running the selftests on an AMD system is sufficient to drop this
> patch?

Yes, that's enough.

I _thought_ the AMD folks provided some tested-by's at some point in the
past.  But, maybe I'm confusing this for one of the other shared
features.  Either way, I'm sure no tested-by's were dropped on purpose.

I'm sure Rick is eager to trim down his series and this would be a great
patch to drop.  Does anyone want to make that easy for Rick?

<hint> <hint>
