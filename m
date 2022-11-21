Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119B3632E55
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKUVBv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 16:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKUVBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 16:01:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDE1CE9DC;
        Mon, 21 Nov 2022 13:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669064509; x=1700600509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3t75xCbPOt53fS2xeDdBOCnLlbwj0UyTuVNUJMnvY48=;
  b=MZ6dmgsP9YnH3p/foQOfYZBHY0shXtgYRtuBq/Q5OK8Cnt3tu0kqESRA
   LK7o+LvEFp6i2hYcbW3FPubUYTUggf7mTQOX5JHB9MkUq7S6ipz6BKlQs
   B0fpgs9lG53tebj6lYz+OKJdWpunqGESKDtL90CgS6gnPH7cYGdXTlysh
   mkHKaoDHow+kuxQ/NFLZETy7flylnZRN/fhcyisJ0N0wwan2NaPl2wKw1
   5NTgMZfAg1swOT6Sh3es/XXkuP7I+f/4hMRj8FFuYpvq46fyftXohsxDf
   c/aWdq00zeadajQ/st89aTxgvsmsHUwUqh6mhUHx6JA8jKB7/2ZSMT2+p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="314810134"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="314810134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 13:01:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="766101930"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="766101930"
Received: from ticela-or-327.amr.corp.intel.com (HELO [10.209.6.63]) ([10.209.6.63])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 13:01:47 -0800
Message-ID: <d5f95b6b-df7f-416f-14c0-b4e284125d2a@intel.com>
Date:   Mon, 21 Nov 2022 13:01:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX
 guests
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
 <20221121195151.21812-5-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221121195151.21812-5-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/21/22 11:51, Dexuan Cui wrote:
> +			switch (hv_get_isolation_type()) {
> +			case HV_ISOLATION_TYPE_VBS:
> +			case HV_ISOLATION_TYPE_SNP:
>  				cc_set_vendor(CC_VENDOR_HYPERV);
> +				break;
> +
> +			case HV_ISOLATION_TYPE_TDX:
> +				static_branch_enable(&isolation_type_tdx);
> +				break;

This makes zero logical sense to me.

Running on Hyper-V, a HV_ISOLATION_TYPE_SNP is CC_VENDOR_HYPERV, but a
HV_ISOLATION_TYPE_TDX guest is *NOT* CC_VENDOR_HYPERV?
