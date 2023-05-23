Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3783A70E69D
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbjEWUjP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbjEWUjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 16:39:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A6FA;
        Tue, 23 May 2023 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684874354; x=1716410354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OWSHPRO5HnlWet7EfvINZiwK0k+1sxDkGfdhBdgkUzI=;
  b=kem5xjOuEtFfSDh1iiXybWq2WZoHYKp+mWUDroCbAKm9CnAd5MKpfL5V
   X7UeViHgG/xHbGXb3F25DL3oD3rxGORwMTm0VSumYrTetPvAhZ46aO80E
   52k3ZUEgsS3pDmtdSHrk5t0eVY2M3wXJY/pTNJ+gSPRQM4GhC8ralXkfw
   Ag/knK6HQJ+pqMHFCflVfVVrPzaotN/9eQ2Ay0DXY9d+8/8qKWvrRkTgh
   KKvG1V9sWVSkI4Rud5sTuGZ0c2cliHTI1MYCiazlyVHZ6QiSvSVWux9OP
   37bwpA5mOf5/nIpsjoyTtyhVVz1i9ISgd496jGGlujghArhNIxhlLykjD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="419068151"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="419068151"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 13:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="793868392"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="793868392"
Received: from kroconn-mobl2.amr.corp.intel.com (HELO [10.251.1.84]) ([10.251.1.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 13:39:11 -0700
Message-ID: <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
Date:   Tue, 23 May 2023 13:39:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
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
 <20230504225351.10765-3-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230504225351.10765-3-decui@microsoft.com>
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
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with the
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.

I think this sets a bad precedent.

There are consequences for converting pages between shared and private.
Doing it on a vmalloc() mapping is guaranteed to fracture the underlying
EPT/SEPT mappings.

How does this work with load_unaligned_zeropad()?  Couldn't it be
running around poking at one of these vmalloc()'d pages via the direct
map during a shared->private conversion before the page has been accepted?
