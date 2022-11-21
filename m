Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1A632D9B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 21:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKUUFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 15:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKUUFH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 15:05:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778E26AE1;
        Mon, 21 Nov 2022 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669061106; x=1700597106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v4/dXwdobEr3YAeZGZ6dCnpN201n0xj1YOPpe7MPrB0=;
  b=JNoIE5h9LHvXdh5T/SzkCCCP7pGM1JbQPVSb0z46BMEZ/N6nEXLNH3kp
   hDOQLjtCgEcB9R8v70oQvOqC/E5XvgYX3aLvKsPtP2yIWu1L4sOKTkdDk
   UEfeJ2FrKnJm8O1af2DerNEHslngmW23JxFTXBQ81dbcWPDp1c0BmoKoL
   jiTYqHhdcWvRKBqM65LkUIomksjw9hGE1K6hIaBSSdLDs0ZrmLtNiKM2O
   SGdzdR9ByKfLtbNducy4hecYCVZ+n/AizhUejBhfYr6z+hjA5xdOR17xb
   IUHb/p+Rml+hkA757t7TS0JoNrvnzwTbaA3QSbcff0ziTfVQQiaMpjxA8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377911056"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377911056"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:05:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="709936413"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="709936413"
Received: from ticela-or-327.amr.corp.intel.com (HELO [10.209.6.63]) ([10.209.6.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:05:02 -0800
Message-ID: <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
Date:   Mon, 21 Nov 2022 12:05:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221121195151.21812-6-decui@microsoft.com>
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

>  #ifdef CONFIG_X86_64
> +#if CONFIG_INTEL_TDX_GUEST
> +	if (hv_isolation_type_tdx()) {

>  #ifdef CONFIG_X86_64
> +#if CONFIG_INTEL_TDX_GUEST
> +	if (hv_isolation_type_tdx())

>  #ifdef CONFIG_X86_64
> +#if CONFIG_INTEL_TDX_GUEST
> +	if (hv_isolation_type_tdx())
> +		return __tdx_ms_hv_hypercall(control, input2, input1);

See any common patterns there?

The "no #ifdef's in C files" rule would be good to apply here.  Please
do one #ifdef in a header.
