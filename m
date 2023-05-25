Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE62F71174B
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbjEYTWe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbjEYTWP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 15:22:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59E1992;
        Thu, 25 May 2023 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685042322; x=1716578322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KuUKj4ttsJlL4wLcdbKLyn7tabEwUjXKipzD5i05Y4s=;
  b=lSK2/2k5bTLauJYJFdjo/h5/32Aq64DEwMlaZk5y8WtRZHN4LK+GYOQU
   VlXnGW+S8VUITO0yMQDxVys4r4C3th3olPteqQh7D011MZxOApJn+IGfH
   a1lCtmYOkaQDCC4zfFYGdnseJGw+3s3JLaBVkPtQBPW5IbtsVwC3mulG9
   CXsQhDV5VEiJSCVT1fnskdHc9CqPzzvabittgc90aYpzdKClg3gGUAam5
   OD9gvlkcCMBPDrCjTk/mXk5sr7iHUygc93NyUMlU0zexWzETrvkT/+6ej
   rhOjbLWjNDY9V77WBBrSY+Tu5r1d9W7d1t7S73y94w7Awrbw7NOY5N/pM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356378002"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="356378002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 12:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="794777026"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="794777026"
Received: from shuklaas-mobl1.amr.corp.intel.com (HELO [10.212.186.148]) ([10.212.186.148])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 12:18:35 -0700
Message-ID: <05bbef94-686e-e3cc-40d3-95acfbf45a5d@intel.com>
Date:   Thu, 25 May 2023 12:18:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, Dexuan Cui <decui@microsoft.com>,
        ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kys@microsoft.com, linux-arch@vger.kernel.org,
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
 <2d96a23f-a16a-50e1-7960-a2d4998ce52f@intel.com>
 <20230523232851.a3djqxmpjyfghbvc@box.shutemov.name>
 <20230525190812.bz5hg5k3uaibtcys@box>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230525190812.bz5hg5k3uaibtcys@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/25/23 12:08, Kirill A. Shutemov wrote:
> Shared->Private conversion is rare. I only see one call total during the
> boot in my setup. Worth fixing anyway.
...
> Any comments?

So the rules are:

 * Shared mapping of a private page: BAD
 * Private mapping of a shared page: OK

?

The patch seems OK, other than having zero comments in it.
