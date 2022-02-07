Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE74ACC24
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 23:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbiBGWkE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 17:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbiBGWkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 17:40:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E021C0612A4;
        Mon,  7 Feb 2022 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644273602; x=1675809602;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=9YOiN21DFWOvsXWRc0EIImHeT95XLZnWE4OurJAm4GA=;
  b=SR8WqVVQz99gERWJTyxsNki2ow4mrUHdUweOUx7MR2pw/gLE5alEmvso
   yi0auCejG205DR6Rpib3/vfCnidH4DtIT4ZQpw6qYqfMa/EC9s+xwwQXx
   oO+4KA4gSBnGFk8W+QjkPSjqgwQQ++3RaieVJUoKx0WkdvJGC13dfmXSQ
   dGstVL92X2/ArEsX5ejtHi2blas834vX56X99PNoUULFKEMmV83V07s+o
   lV/jUIONI95eq6vF3Wj4hNLrSrECRHwWav1Bk0ESKB7tHr0mEFVyU8yWp
   NatH/C0/YVSwmN8l70Mr/PN3dhmzNy9TumRN5d7VKWjMFtdpmnYh64Nix
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232388972"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232388972"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:40:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525306836"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:40:00 -0800
Message-ID: <248ef880-025d-54ce-f3ce-fed0e50a0445@intel.com>
Date:   Mon, 7 Feb 2022 14:39:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-3-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 02/35] x86/cet/shstk: Add Kconfig option for Shadow Stack
In-Reply-To: <20220130211838.8382-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> +config X86_SHADOW_STACK
> +	prompt "Intel Shadow Stack"
> +	def_bool n
> +	depends on AS_WRUSS
> +	depends on ARCH_HAS_SHADOW_STACK
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	help
> +	  Shadow Stack protection is a hardware feature that detects function
> +	  return address corruption.  This helps mitigate ROP attacks.
> +	  Applications must be enabled to use it, and old userspace does not
> +	  get protection "for free".
> +	  Support for this feature is present on Tiger Lake family of
> +	  processors released in 2020 or later.  Enabling this feature
> +	  increases kernel text size by 3.7 KB.

I guess the "2020" comment is still OK.  But, given that it's on AMD and
a could of other Intel models, maybe we should just leave this at:

	CPUs supporting shadow stacks were first released in 2020.

If we say anything.  We mostly want folks to just go read the
documentation if they needs more details.
