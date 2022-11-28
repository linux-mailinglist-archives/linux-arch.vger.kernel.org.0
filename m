Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A563B40F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 22:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiK1VP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 16:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiK1VPZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 16:15:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9823BC1B;
        Mon, 28 Nov 2022 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669670124; x=1701206124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GDtvlFXVIz+MUUTkkt7MlCDbX+4pSMO3dFyH3uDkyPs=;
  b=Rx7UKykRQIPMfALmnRqdAhf32nytzu2PlZ5TXof+luAw0EeXn8flMUhX
   SNqHdN93n/ZgTJaCSiXuehrPJLcFpSwKrad54oSJB6G8jXchqneBdsISa
   6TDwTATqX/pMaVnDXmP+qNYrpH3S9PFqz+/5H8CF9GL0FYNucPndEycLi
   FdWNwsZBA/wCXFqj/2y/DByKzv+z7OXlqpUtH/xZ8RyrZ+JoQyq4DmMVl
   GAzu4rGSZ9qIOzhx+Gz9TTxAUvCpfk1jh9EYRWsXQwplMUQrHJ1YBJjr6
   iNhGAEqjAzBOfm7weULWr/T6pbXpzAc0pOQKUfHz1ysVF3oHSORVq0FmE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341864502"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="341864502"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 13:15:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972422588"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="972422588"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.212.209.4]) ([10.212.209.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 13:15:22 -0800
Message-ID: <8547f6b1-8dd6-1319-5c44-1440f54026f8@intel.com>
Date:   Mon, 28 Nov 2022 13:15:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
 <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
 <SA1PR21MB13357B3CC486514D2DF50A4DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <f6d27366-e083-b362-b44c-eaf4d3365b53@intel.com>
 <SA1PR21MB1335BA75F51964636745E486BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR21MB1335BA75F51964636745E486BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/28/22 12:36, Dexuan Cui wrote:
>> From: Dave Hansen <dave.hansen@intel.com>
>> Sent: Monday, November 28, 2022 11:48 AM
>>
>> On 11/28/22 11:37, Dexuan Cui wrote:
>>>> From: Dave Hansen <dave.hansen@intel.com>
>> ...
>>>> How do we know, for instance, that no hypercall using this interface
>>>> will *ever* take the 0x0 physical address as an argument?
>>>
>>> A 0x0 physical address as an argument still works: the 0 is passed
>>> to the hypervisor using GHCI. I believe Hyper-V interprets the 0 as
>>> an error (if the param is needed), and returns an "invalid parameter"
>>> error code to the guest.
>>
>> I don't see any data in the public documentation to support the claim
>> that 0x0 is a special argument for either the input or output GPA
>> parameters.
> 
> Sorry, I didn't make it clear. I meant: for some hypercalls, Hyper-V
> doesn't really need an "input" param or an "output" param, so Linux
> passes 0 for such a "not needed" param. Maybe Linux can pass any
> value for such a "not needed" param, if Hyper-V just ignores the
> "not needed" param. Some examples:
> 
> arch/x86/hyperv/hv_init.c: hv_get_partition_id():
>     status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> 
> drivers/pci/controller/pci-hyperv.c:
>     res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
>                       params, NULL);
> 
> 
> If a param is needed and is supposed to be a non-zero memory address,
> Linux running as a TDX guest must pass "cc_mkdec(address)" rather than
> "address", otherwise I suspect the result is undefined, e.g. Hyper-V might
> return an error to the guest, or Hyper-V might just terminate the guest,
> especially if Linux passes 0 or cc_mkdec(0).

This is the point where the maintainer gets a wee bit grumpy.  The page
I just pointed you to (twice) has this nice quote:

	If the hypercall involves no input or output parameters, the
	hypervisor ignores the corresponding GPA pointer.

So, bravo to your colleagues who nicely documented this.  But,
unfortunately, you didn't take advantage of their great documentation.
Instead, you made me search for it to provide actual facts to combat the
weak conjecture you offered above.

>> This is despite some actual discussion on things like their alignment
>> requirements[1] and interactions with overlay pages.
>>
>> So, either you are mistaken about that behavior, or it looks like the
>> documentation needs updating.
> 
> The above is just my conjecture. I don't know how exactly Hyper-V works.

I do!  I literally Googled "HV HYPERCALL FAST BIT" and the first page
that came up told me all I needed to know.

I could be merrily merging your patches.  But, instead, I'm reading
documentation that can be trivially found and repeatedly regurgitating it.

Please, slow down.  Take some time to answer emails and do it more
deliberately.  This isn't a race.
