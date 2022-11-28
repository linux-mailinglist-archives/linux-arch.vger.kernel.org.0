Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013F263AC17
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiK1PWi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiK1PWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 10:22:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0CCCF;
        Mon, 28 Nov 2022 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669648955; x=1701184955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a/sB1/393ytlRa8eYq2hsxfrWcpUuWZKXU8+lFf1uQE=;
  b=acDRL2OuxWUAKbYxt1n4S0z0n05IchgwpVhelNBySGQnwgS8uF9+xjJe
   Re3nvklAPBjKqBfCG0DO0Skt/WP1H4Ea+GTIASG/v7eocirdJZ30/y57I
   bc985sBimgevpfRVtkQQNaDHtuQFmarYIDcQ0qwyyhWfBG4ZTLr3604c5
   edsWeIZAxqkg3VAD2BvyOvHoXi9dcYw+7VaaKHAp9xkpzLKAZ1o22QQg4
   R+8bnJUBVsPHmseKceUf9+RQTGT5xJGPURxG5BBjoD7y5BORL4OPxHcyz
   EQddhk/tdJKiej/tcEHxp9FgkryniYXKszvZQhS/r3bVKX4g5gayLqMvG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="302440513"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="302440513"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:22:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="621086442"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="621086442"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.212.209.4]) ([10.212.209.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:22:28 -0800
Message-ID: <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
Date:   Mon, 28 Nov 2022 07:22:27 -0800
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/27/22 16:58, Dexuan Cui wrote:
> +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
> +{
> +	struct tdx_hypercall_args args = { };
> +
> +	if (!(control & HV_HYPERCALL_FAST_BIT)) {
> +		if (input_addr)
> +			input_addr += ms_hyperv.shared_gpa_boundary;
> +
> +		if (output_addr)
> +			output_addr += ms_hyperv.shared_gpa_boundary;
> +	}

This:

>
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface

makes it sound like HV_HYPERCALL_FAST_BIT says whether arguments go in
registers (fast) or memory (slow).  But this hv_tdx_hypercall() function
looks like it takes addresses only.

*Is* there a register based calling convention to make Hyper-V
hypercalls when running under TDX?

Also, is this the output address manipulation fundamentally different from:

	output_addr = cc_mkdec(output_addr);

?  Decrypted addresses are the shared ones, right?

