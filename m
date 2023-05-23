Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DFD70E925
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 00:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjEWWiI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 18:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEWWiI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 18:38:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28783;
        Tue, 23 May 2023 15:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684881487; x=1716417487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gUq6OTp43q7yrCgbODMPtcvwV6RzL93J4vFVG6eMf9U=;
  b=Sb9nvcj/cymo3kqYzB82x++k+w2qThEoPv4LDDT2qfc1frg8cy8oi84R
   YB9qPhHWiBiKvH4vk9nMxtF2vSQ1Xt1yiO0xnDEn+CiTTCPUB2juzYBAk
   Gzwi09ob8mLbAJkDeerNcM7xw2F/ArzZGf6RPpK+72QrJzPNzdfWaWV28
   8MnrmK7Hgb9HP+mHHR9D0AMN/2aD4IM11ru1Lkt9XvWvFIBJpOS37n1ww
   Ee+92rYSxH9ebwNE1lgZ09r2JiTJUVkXDkvMSe8AnyOfRN5bUd4wqIo/9
   Bpsto4r8nZhdc5tuv/XkJ/YtBXnJb98dPHjfIN7aBBskxC2vAvJtU42l0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416843103"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="416843103"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="769165068"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="769165068"
Received: from novermar-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.223.182])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:37:52 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3094310D009; Wed, 24 May 2023 01:37:50 +0300 (+03)
Date:   Wed, 24 May 2023 01:37:50 +0300
From:   kirill.shutemov@linux.intel.com
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20230523223750.botogigv6ht7p2zg@box.shutemov.name>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-3-decui@microsoft.com>
 <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 23, 2023 at 01:39:11PM -0700, Dave Hansen wrote:
> On 5/4/23 15:53, Dexuan Cui wrote:
> > When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> > allocates buffers using vzalloc(), and needs to share the buffers with the
> > host OS by calling set_memory_decrypted(), which is not working for
> > vmalloc() yet. Add the support by handling the pages one by one.
> 
> I think this sets a bad precedent.
> 
> There are consequences for converting pages between shared and private.
> Doing it on a vmalloc() mapping is guaranteed to fracture the underlying
> EPT/SEPT mappings.
> 
> How does this work with load_unaligned_zeropad()?  Couldn't it be
> running around poking at one of these vmalloc()'d pages via the direct
> map during a shared->private conversion before the page has been accepted?

Alias processing in __change_page_attr_set_clr() will change direct
mapping if you call it on vmalloc()ed memory. I think we are safe wrt
load_unaligned_zeropad() here.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
