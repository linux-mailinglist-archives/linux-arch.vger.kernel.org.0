Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0854ACC34
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 23:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiBGWpb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 17:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiBGWpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 17:45:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79CC061355;
        Mon,  7 Feb 2022 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644273930; x=1675809930;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/kRBeLG+E+e8Fa1In5ioSuQHyPxsmnGL5vggy8pd18g=;
  b=L6SMl1Wzjc6+j7JJ1y2Lgf+pB80PjC4QCBiQIGcT7m2EFERHHhcShqyV
   9D4gdeJfpBJSVBZAbYcemgwB0uixZsXj/Amp+x8enWsiixH/pz6QINWLv
   hCNqVK714QoFAYPa4suZwB22t1JHIqlLYXolXjUUrJhN3qCQ/U+Bk+n4U
   c7mB8IoZ48yAGiu4XP9VPxw+o3bOmyUKkSOLvpebKRIhvE3j2wZe9Droi
   S2yF9vARnm5aVXVLEK05G2DFvtTm5bnwu7pD+d/vCM2b1sHzsOOSzZ7lu
   iaGpoSXYfoBTwFg2ERt9AFrFhbZB3hh7JkoBpeN0QT9Zl9y0/u4dCo7Q2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248772082"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248772082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:45:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525308323"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:45:29 -0800
Message-ID: <b9d48ed0-699b-585c-a52c-46d789c11dc9@intel.com>
Date:   Mon, 7 Feb 2022 14:45:26 -0800
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
 <20220130211838.8382-4-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 03/35] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
In-Reply-To: <20220130211838.8382-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -78,6 +78,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
>  	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
>  	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
> +	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>  	{}
>  };

Please add a chunk to the changelog that explains the dependency.  This
would suffice:

	To protect shadow stack state from malicious modification, the
	registers are only accessible in supervisor mode.  This
	implementation context-switches the registers with XSAVES.  Make
	X86_FEATURE_SHSTK depend on XSAVES.

The XSAVES dependency is touched on in the documentation, but it's a bit
buried in there.
