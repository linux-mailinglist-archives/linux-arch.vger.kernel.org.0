Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859C6632E11
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 21:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKUUim (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 15:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiKUUik (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 15:38:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B9B4F1E;
        Mon, 21 Nov 2022 12:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669063119; x=1700599119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AngCEqZLkvJQBI60RTdDbXikONezRgG/ST493lmNsDQ=;
  b=BKxiwR0cp7OvyGqK5lbAwmulj5pjx3W8gO1bvJpmkRgUAc2lMcH3LXiS
   VVRsX2AcCaKoVZhyEw7W0qyl1nYsALTOzkQCoHl2lNzKf01V4nObTYnbS
   JwjcsBYTAdR8tNtEwTq5+ycTtaiyaMrgE3TtVVo8VHuvS64I8nBGuIkL9
   o/ewRNghVxVt/wXUF4lMJ/icVT68dE7tkfiOM5iXvOmOBYMGj2WJm7jrA
   bZtyixjmNhNbCsiKGdlW+UTbHVqCTzkzhz91rDU3Fs9Vj7l/+HW0Te4GX
   RbfViETgqQvZivzVUCr80EangJcoq/q5xZxJb0L+3iwUoG9UlUGhEZ6Gg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313688049"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="313688049"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:38:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="886259322"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="886259322"
Received: from ticela-or-327.amr.corp.intel.com (HELO [10.209.6.63]) ([10.209.6.63])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:38:37 -0800
Message-ID: <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
Date:   Mon, 21 Nov 2022 12:38:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
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
 <20221121195151.21812-2-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221121195151.21812-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/21/22 11:51, Dexuan Cui wrote:
> __tdx_hypercall() doesn't work for a TDX guest running on Hyper-V,
> because Hyper-V uses a different calling convention, so add the
> new function __tdx_ms_hv_hypercall().

Other than R10 being variable here and fixed for __tdx_hypercall(), this
looks *EXACTLY* the same as __tdx_hypercall(), or at least a strict
subset of what __tdx_hypercall() can do.

Did I miss something?

Another way of saying this:  It seems like you could do this with a new
version of _tdx_hypercall() (and all in C) instead of a new
__tdx_hypercall().
