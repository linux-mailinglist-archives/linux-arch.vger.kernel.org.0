Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28379636885
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiKWSSn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbiKWSSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 13:18:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2810FC7;
        Wed, 23 Nov 2022 10:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669227490; x=1700763490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Yp5xFOMLGQYpWLQIiUQjZ0rsJHrk7HcR/XL9Lf6XoE=;
  b=ig9WopsCTbG+DLsVHXra9E8UMDkKkr5+MiOIlG7OJcAjz/MvMJCL5H5P
   EUFlGPmsHnPW1AFqodA9PfL40+7UEfucxIhrAi9qg9KX4s4wN6dmb037s
   A7EPC04BYPjb2camhzix7hutbQcDDQc53+e2yytKD9hrOLYySXSzPO2Pz
   htTcBqF7soxLK0a5Sc+TTBK5MdmPUhj4izhiLzpieENa+PV/bNG5KecS+
   YkZdfmXmOxeMMCtn5w+4EXPuqzTOIK//7WTIQNIRTVb7QkUGuBRTnvK2j
   4gWsiYM463insJOfpO/bdUlXwzpl4cCjA/g7Mgc+YZ7DMDw8qaSLCpzNK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="314166591"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="314166591"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:18:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="766817074"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="766817074"
Received: from htg1-mobl1.amr.corp.intel.com (HELO [10.209.96.66]) ([10.209.96.66])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:18:08 -0800
Message-ID: <73407b18-d878-48de-167d-c23fa7e13e31@linux.intel.com>
Date:   Wed, 23 Nov 2022 10:18:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dexuan Cui <decui@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
 <SA1PR21MB13359D878631F5C327DE8148BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221123144714.vjp6alujwgzdjz5v@box.shutemov.name>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221123144714.vjp6alujwgzdjz5v@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/23/22 6:47 AM, Kirill A. Shutemov wrote:
> On Wed, Nov 23, 2022 at 02:14:58AM +0000, Dexuan Cui wrote:
>>> From: Dave Hansen <dave.hansen@intel.com>
>>> Sent: Monday, November 21, 2022 12:05 PM
>>> [...]
>>>>  #ifdef CONFIG_X86_64
>>>> +#if CONFIG_INTEL_TDX_GUEST
>>>> +	if (hv_isolation_type_tdx()) {
>>>
>>>>  #ifdef CONFIG_X86_64
>>>> +#if CONFIG_INTEL_TDX_GUEST
>>>> +	if (hv_isolation_type_tdx())
>>>
>>>>  #ifdef CONFIG_X86_64
>>>> +#if CONFIG_INTEL_TDX_GUEST
>>>> +	if (hv_isolation_type_tdx())
>>>> +		return __tdx_ms_hv_hypercall(control, input2, input1);
>>>
>>> See any common patterns there?
>>>
>>> The "no #ifdef's in C files" rule would be good to apply here.  Please
>>> do one #ifdef in a header.
>>
>> Sorry, I should use #ifdef rather than #if. I'll fix it like the below.
> 
> No, can we hide preprocessor hell inside hv_isolation_type_tdx()?
> 
> Like make it return false for !CONFIG_INTEL_TDX_GUEST and avoid all
> #if/#ifdefs in C file.

There is a weak reference to hv_isolation_type_tdx() which returns false
by default. So defining the hv_isolation_type_tdx within
#ifdef CONFIG_INTEL_TDX_GUEST would be enough.

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
