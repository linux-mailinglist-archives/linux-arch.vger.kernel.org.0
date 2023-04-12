Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1C6DF9C9
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDLPVp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjDLPVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 11:21:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B293FD;
        Wed, 12 Apr 2023 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681312877; x=1712848877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ue5FuMgskg3zbh2X+bvZ/sBZqu92kRDdqi3iT72T2HQ=;
  b=Hl0UR8PEeugcepa//CrxxMBRFunlcMCrqzUZq46qbJoKgnivielIWSLx
   mte5kbnsZm8yovuKIMcp0a+08hbfL7oTOKzTftnqvK18cU6bSYlKfT/Ag
   YTRJRiF0yT7rae7+jwvkyPiQPfZZuQXMDaES3eZRM3rTbNXJ6JibGgMSy
   1nYzmtFsHMNByzU4jsyrxtq1L0aHIH6ZdBy7E8R/1oIzkAhG7hF8+oIGM
   Wvy5aVtlVKLUzbg2eDM+zqY9k9iIcycJNAxigQZi0oWq55WUjFj9a5tQJ
   F/016EpRZGoi+sdeII+iwDz5XZbZi/Nng+Hn3B31FP2+xMPX0SMrcV93t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324289046"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324289046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719411724"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719411724"
Received: from swengsoo-mobl.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.56.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:20:42 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8552610B93C; Wed, 12 Apr 2023 18:20:37 +0300 (+03)
Date:   Wed, 12 Apr 2023 18:20:37 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH v4 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20230412152037.upiciyn5zhmilw3r@box>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-3-decui@microsoft.com>
 <BYAPR21MB16885F59B6F5594F31AE957AD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16885F59B6F5594F31AE957AD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 11, 2023 at 04:28:20PM +0000, Michael Kelley (LINUX) wrote:
> Does anyone know if there is a reason to use one vs. the other?
> slow_virt_to_phys() is x86-only, but that's not a problem here.

slow_virt_to_phys() is more generic as it works for non-vmalloc addresses,
but generally they are equivalent for the use.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
