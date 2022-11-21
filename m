Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C98632E3B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 21:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKUU4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 15:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiKUU4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 15:56:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AA5CB969;
        Mon, 21 Nov 2022 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669064163; x=1700600163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WJB6p1YpOlRJQWXN28HsfDRojkmZzw+c2qGQk3AkCqM=;
  b=AUncNM0IT/y5UW9Uv+h+TGJQ6WIugqLa+fQkFL79Shrx9/tOHcvKuQCj
   JAOQ5833e3jY9i2ee8Qt2cMY+EiKJBhjgk2M6jBYI9xuvdKlMePaGBqk/
   5vYmXoZU9S7FfEZwoG5vcMi4M2sxwZPMVCLfW5OYfgKsg76j+QtXSfBJw
   SsVHImpyVb3meYwMKpXc6G+gBDvwQGevG/Zga4QSclKLKNt8ZRuAWSPJb
   99kFMfPpHRfOl/xy9+f/+PMC/D4qUpcIM6r5m2qepK40XCXkwhgUSeh2V
   zgK3cuLDl/CJNBz+iuLiC25ior9evckRdYMbIwixu6VvKc1xmUuQ+8cO5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315481921"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315481921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:56:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783587774"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="783587774"
Received: from ticela-or-327.amr.corp.intel.com (HELO [10.209.6.63]) ([10.209.6.63])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:55:59 -0800
Message-ID: <6bb65614-d420-49d3-312f-316dc8ca4cc4@intel.com>
Date:   Mon, 21 Nov 2022 12:55:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
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
 <20221121195151.21812-3-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221121195151.21812-3-decui@microsoft.com>
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

On 11/21/22 11:51, Dexuan Cui wrote:
> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> +{
> +	u64 ret, r11;

'r11' needs a real, logical name.

> +	while (1) {
> +		ret = _tdx_hypercall_output_r11(TDVMCALL_MAP_GPA, start,
> +						end - start, 0, 0, &r11);
> +		if (!ret)
> +			break;
> +
> +		if (ret != TDVMCALL_STATUS_RETRY)
> +			break;
> +
> +		/*
> +		 * The guest must retry the operation for the pages in the
> +		 * region starting at the GPA specified in R11. Make sure R11
> +		 * contains a sane value.
> +		 */
> +		if ((r11 & ~cc_mkdec(0)) < (start & ~cc_mkdec(0)) ||
> +		    (r11 & ~cc_mkdec(0)) >= (end  & ~cc_mkdec(0)))
> +			return false;

This statement is, um, a wee bit ugly.

First, it's not obvious at all why the address masking is necessary.

Second, it's utterly insane to do that mask to 'r11' twice.  Third, it's
silly do logically the same thing to start and end every time through
the loop.

This also seems to have built in the idea that cc_mkdec() *SETS* bits
rather than clearing them.  That's true for TDX today, but it's a
horrible chunk of code to leave around because it'll confuse actual
legitimate cc_enc/dec() users.

The more I write about it, the more I dislike it.

Why can't this just be:

		if ((map_fail_paddr < start) ||
		    (map_fail_paddr >= end))
			return false;

If the hypervisor returns some crazy address in r11 that isn't masked
like the inputs, just fail.

> +		start = r11;
> +
> +		/* Set the shared (decrypted) bit. */
> +		if (!enc)
> +			start |= cc_mkdec(0);

Why is only one side of this necessary?  Shouldn't it need to be
something like:

		if (enc)
			start = cc_mkenc(start);
		else
			start = cc_mkdec(start);

??

> +	}
> +
> +	return !ret;
> +}
> +
>  /*
>   * Inform the VMM of the guest's intent for this physical page: shared with
>   * the VMM or private to the guest.  The VMM is expected to change its mapping
> @@ -707,12 +765,7 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  		end   |= cc_mkdec(0);
>  	}
>  
> -	/*
> -	 * Notify the VMM about page mapping conversion. More info about ABI
> -	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> -	 * section "TDG.VP.VMCALL<MapGPA>"
> -	 */
> -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +	if (!tdx_map_gpa(start, end, enc))
>  		return false;
>  
>  	/* private->shared conversion  requires only MapGPA call */

