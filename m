Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF663B1EC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 20:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiK1TLM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 14:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiK1TLL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 14:11:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC5D27937;
        Mon, 28 Nov 2022 11:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669662669; x=1701198669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zTgmYKgO75Lve7MV3Q2C6BWy8I6LIC0zD/4hqS76Z50=;
  b=BvTaxNPP+Vt7r/4CPUZvM3joaOlfuidHeJbFaC/RsF+wj1fmsv3+t67s
   DYQJKXEFKnUgWTzHJj2fsD2aLoj+xz36aLHbZwrgFZ/tpRfC2+ihCf+LX
   zC630ZmSCJa7S8NJv4p1JEqRFwTy/52s6sDYLI87bhEGX3AGwEx9NGJDk
   mdPppfqATaI8PmvWD+BaD4WUsCQ3ye8PhZ8kLi6AzAELyzEgGIvmN61mO
   lUt86jH3pVSuO+F6zLKKJOUCdVkO7j8nPlVeCeUX0aDcF5MyPTF1i+AJR
   i0MJRHLygJFPpIzsaizmDk/lhGXFK3IpFs9QJ/nQWD7byGSBSnGmTz4Qa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313631536"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313631536"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:11:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712086678"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="712086678"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.212.209.4]) ([10.212.209.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:11:06 -0800
Message-ID: <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
Date:   Mon, 28 Nov 2022 11:11:05 -0800
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/28/22 11:03, Dexuan Cui wrote:
...
> u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
> {
>         struct tdx_hypercall_args args = { };
> 
>         if (!(control & HV_HYPERCALL_FAST_BIT)) {
>                 if (param1)
>                         param1 = cc_mkdec(param1);
> 
>                 if (param2)
>                         param2 = cc_mkdec(param2);
>         }
> 
>         args.r10 = control;
>         args.rdx = param1;
>         args.r8  = param2;
> 
>         (void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> 
>         return args.r11;
> }

I still think this is problematic.

The cc_mkdec() should be done on the parameters when the code still
*knows* that they are addresses.

How do we know, for instance, that no hypercall using this interface
will *ever* take the 0x0 physical address as an argument?


