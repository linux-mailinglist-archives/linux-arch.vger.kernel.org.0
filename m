Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9F70E9A4
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 01:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbjEWXbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 19:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbjEWXbj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 19:31:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CACE9;
        Tue, 23 May 2023 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684884658; x=1716420658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5bY1QeWoEiGOfD0DEekVBjP+Ckt/t4qkOWsJzVvLLS4=;
  b=EpBn0F7oUvyZhk7L4biGRJdHtVxjSsPphg9XwFPLsk+IAnTQWxWM29F6
   uziVe60e/tVARzOhfXM0EInOzC7BKlRNZbKteH2nx51BMyypHJYRp4xgv
   J8o27e0vF9zMracG3lDejb9sowMeOFytnj69DYAkJ7PrDIVgR0dm52BsO
   If6+vnfLoFb0ttmo0TOOfHLziJRVzQQktwn5KyuIT4NZg7nqTU+kAKoPp
   NHnv0TzM4pQBIHbU10gbViGdt8Uur3v8U5NE/rBwIlLevA88GY2L7ZDUT
   fH9CxPhcicxllHXj1iXuyltoYWwyDYJavgLxfJULhHUFD8WJa+w8L4nmZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="419103482"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="419103482"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 16:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="793904074"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="793904074"
Received: from mcgrathm-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.40.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 16:28:53 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1BEC5109F9C; Wed, 24 May 2023 02:28:51 +0300 (+03)
Date:   Wed, 24 May 2023 02:28:51 +0300
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
Message-ID: <20230523232851.a3djqxmpjyfghbvc@box.shutemov.name>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-3-decui@microsoft.com>
 <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
 <20230523223750.botogigv6ht7p2zg@box.shutemov.name>
 <2d96a23f-a16a-50e1-7960-a2d4998ce52f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d96a23f-a16a-50e1-7960-a2d4998ce52f@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 23, 2023 at 03:43:15PM -0700, Dave Hansen wrote:
> On 5/23/23 15:37, kirill.shutemov@linux.intel.com wrote:
> >> How does this work with load_unaligned_zeropad()?  Couldn't it be
> >> running around poking at one of these vmalloc()'d pages via the direct
> >> map during a shared->private conversion before the page has been accepted?
> > Alias processing in __change_page_attr_set_clr() will change direct
> > mapping if you call it on vmalloc()ed memory. I think we are safe wrt
> > load_unaligned_zeropad() here.
> 
> We're *eventually* OK:
> 
> >         /* Notify hypervisor that we are about to set/clr encryption attribute. */
> >         x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
> > 
> >         ret = __change_page_attr_set_clr(&cpa, 1);
> 
> But what about in the middle between enc_status_change_prepare() and
> __change_page_attr_set_clr()?  Don't the direct map and the
> shared/private status of the page diverge in there?

Hmm. Maybe we would need to go through making the range in direct mapping
non-present before notifying VMM about the change.

I need to look at this again in the morning.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
