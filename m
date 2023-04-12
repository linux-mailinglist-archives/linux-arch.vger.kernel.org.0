Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E783E6DF9C3
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDLPVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDLPVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 11:21:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E39747;
        Wed, 12 Apr 2023 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681312846; x=1712848846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=82vzrTsaISkLwTxHX1xig08A6dbNj0D3USYYKg0gUoo=;
  b=ljfThzLfAJrrUL2X/03CUUa2efqoQw+boh1Vm+K2oagP/3djJZA0EwK5
   cvDH2xhXAnsUqGehLLg8IAutlpjwB27q6UUazoMzpL1Fr6yNk5HDtyvVY
   bPmgt06fjXF7UKoFffScpjGMlcAgsYoIzQZ5JXszAUG24rKu3XvrbvMBm
   +6ubZKqxbfrpbHr94W0BiHJkuUBJgGOw9og6XqJJ+pOqe0FFGQEQiOzE/
   ecLeMd2BwzBrr0l+iGzwRcXlyrEO4f7aU80JCXZPQvvK3YTB+gTLb6u5W
   Z4I8MI4RJiOZqpQb894kQboaB49LTc6d8qd8EGk4xBkBQKqD5jFH0ld9a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346603930"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="346603930"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863348025"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863348025"
Received: from swengsoo-mobl.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.56.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:19:44 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0533310B93C; Wed, 12 Apr 2023 18:19:38 +0300 (+03)
Date:   Wed, 12 Apr 2023 18:19:37 +0300
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
Message-ID: <20230412151937.pxfyralfichwzyv6@box>
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
> From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 1:48 PM
> > 
> > When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> > allocates buffers using vzalloc(), and needs to share the buffers with the
> > host OS by calling set_memory_decrypted(), which is not working for
> > vmalloc() yet. Add the support by handling the pages one by one.
> > 
> > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Co-developed-by requires[1] Signed-off-by. You can use mine, if you want.

[1] Documentation/process/submitting-patches.rst

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
