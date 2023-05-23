Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1889F70E72F
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 23:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEWVNT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEWVNT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 17:13:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDABDE5;
        Tue, 23 May 2023 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684876397; x=1716412397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X2yUb0a4gBJZ+7znaR+cJHqifySiylStHpWXt54Wbi8=;
  b=FEeh8qHsMzWcGMyO96Gwhm0dhneUWitZ6beRVKkEqeZ36oBfWuO2ma95
   oFOnI/acEYRJZT8FEc8N+yOS6yPWpEU0zYqRtCaGz8IB0FI1X1w7JUlVY
   XYGKo3JHT19M7IEMpUV0xzUePxpLa9O0dFjvJvupeS4u/reCTxsyjfwPY
   5OwnD/747MS4IWfQsSQ6DJRpW0GLiu21ju6PJ13j878iB2d1KsZxiIa3r
   EFcqRkxn/qgBwI18Df2IGELO3vm76m4PNuYaow1+HGRz3gRn4rTOcWJ4S
   KW50hny/H7NrikyAZwP3OrYQkpZs1KHWV/bLwl0KiKnRKvanl4kJ6mVzg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439712907"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="439712907"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 14:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950705471"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="950705471"
Received: from kroconn-mobl2.amr.corp.intel.com (HELO [10.251.1.84]) ([10.251.1.84])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 14:13:16 -0700
Message-ID: <949f953c-f36c-b421-5132-353e2d373413@intel.com>
Date:   Tue, 23 May 2023 14:13:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
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
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-2-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230504225351.10765-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/4/23 15:53, Dexuan Cui wrote:
> -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +	while (1) {
> +		memset(&args, 0, sizeof(args));
> +		args.r10 = TDX_HYPERCALL_STANDARD;
> +		args.r11 = TDVMCALL_MAP_GPA;
> +		args.r12 = start;
> +		args.r13 = end - start;
> +
> +		ret = __tdx_hypercall_ret(&args);
> +		if (ret != TDVMCALL_STATUS_RETRY)
> +			break;
> +		/*
> +		 * The guest must retry the operation for the pages in the
> +		 * region starting at the GPA specified in R11. Make sure R11
> +		 * contains a sane value.
> +		 */
> +		map_fail_paddr = args.r11;
> +		if (map_fail_paddr < start || map_fail_paddr >= end)
> +			return false;

This should probably also say: "r11" comes from the untrusted VMM.
Sanity check it.

Should this *really* be "map_fail_paddr >= end"?  Or is "map_fail_paddr
> end" sufficient.  In other words, is it really worth failing this if a
VMM said to retry a 0-byte region at the end?

> +		if (map_fail_paddr == start) {
> +			retry_cnt++;
> +			if (retry_cnt > max_retry_cnt)

I think we can spare two bytes in a few spots to make these 'count'
instead of 'cnt'.

> +				return false;
> +		} else {
> +			retry_cnt = 0;
> +			start = map_fail_paddr;
> +		}
> +	}

this fails the "normal operation should be at the lowest indentation"
rule.  How about this:

	while (retry_count < max_retries) {
		...

		/* "Consume" a retry without forward progress: */
		if (map_fail_paddr == start) {
			retry_count++;
			continue;
		}

		start = map_fail_paddr;
		retry_count = 0;
	}

	// plus maybe a wee bit different 'ret' processing


'max_retries' also ends up being a misnomer.  You can have as many
retries as there are pages plus 'max_retries'.  It's really "maximum
allowed consecutive failures".  Maybe it should be "max_retries_per_page".
