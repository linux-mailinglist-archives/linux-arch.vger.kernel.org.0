Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93AA70E934
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 00:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjEWWnW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjEWWnR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 18:43:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E82DA;
        Tue, 23 May 2023 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684881796; x=1716417796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J+jN9q7cfTT3mtaA3PEXaYDQb1DYIjMPr3zxn/71cmw=;
  b=VMc3rVFLNymAOU36KMq7Jr2mP8nBKqBrgAX7xGBx66DA+vxMYgbstnyH
   yuc884XQ+gORx4uL0Hd7L8oz6umihB/rcan0FjXZE3cSB3jGKBMuroqd4
   hHQHl9K/qgQIDTCvBSygpUKdxTAVRTo3F2PB9TWC4veuTDtld6XnKKoRX
   49HJFCe59t+SFI+uriOvf9NaI2GiuiaX+mD0h8Vy4AIqCnC1tF45lNgY8
   5Y/m/sUzfF2gKit8UsKUfYRhlragKE3vuk0koSprJybLVsan/cj++G5Gl
   cvo8xZGmElhhM6UqR1IagUH+hARUWHSGlgIv7hY1wGmPBoeK2IMnSWIZR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="337967443"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="337967443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="848473138"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="848473138"
Received: from nalipour-mobl.amr.corp.intel.com (HELO [10.212.250.202]) ([10.212.250.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:43:14 -0700
Message-ID: <2d96a23f-a16a-50e1-7960-a2d4998ce52f@intel.com>
Date:   Tue, 23 May 2023 15:43:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Content-Language: en-US
To:     kirill.shutemov@linux.intel.com
Cc:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-3-decui@microsoft.com>
 <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
 <20230523223750.botogigv6ht7p2zg@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230523223750.botogigv6ht7p2zg@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/23/23 15:37, kirill.shutemov@linux.intel.com wrote:
>> How does this work with load_unaligned_zeropad()?  Couldn't it be
>> running around poking at one of these vmalloc()'d pages via the direct
>> map during a shared->private conversion before the page has been accepted?
> Alias processing in __change_page_attr_set_clr() will change direct
> mapping if you call it on vmalloc()ed memory. I think we are safe wrt
> load_unaligned_zeropad() here.

We're *eventually* OK:

>         /* Notify hypervisor that we are about to set/clr encryption attribute. */
>         x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
> 
>         ret = __change_page_attr_set_clr(&cpa, 1);

But what about in the middle between enc_status_change_prepare() and
__change_page_attr_set_clr()?  Don't the direct map and the
shared/private status of the page diverge in there?

