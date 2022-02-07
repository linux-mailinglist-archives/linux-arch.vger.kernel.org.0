Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5F4ACC4B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 23:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiBGWts (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 17:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiBGWts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 17:49:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F52C061355;
        Mon,  7 Feb 2022 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644274187; x=1675810187;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=kCrDIOrEFsaqkXzsZbh8yWB/DwYaGsvCXUnA57EV60o=;
  b=WJXmPv2BjjL6DfXYwYsIBdAdfdhF9CFbHiMIAZtBYux70MVKmBgz83ZS
   Ny6HdO/W7RljLfbi5MYWYuMy/fdFBrjAjAoQl4LfchVXzWww7mRXUhyjd
   M6fEvyrtC/AHHYxKhC/aQb5YJQhyi+GKbyTrHW3JpOfZ1iRahdws+N4O3
   9vmyP2MrFDsM3MITWnod+HZCKDdFpROaZaXcaD0kMPXJbxxh+RpZP6YwC
   0THtEHQRgMlgp38sOg3abYKTfzn+3mzicF0R5KuP67Ldl225p7vg5Gmlb
   KkNgfyESWnAYd5OBXn5EyxMLJatP1v7M/WfvjPeRvJrFiE/4XtENEO65c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248772691"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248772691"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:49:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525309179"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:49:45 -0800
Message-ID: <d53abb4b-2459-e1f7-3b7f-a8017cdd3757@intel.com>
Date:   Mon, 7 Feb 2022 14:49:45 -0800
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
 <20220130211838.8382-5-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 04/35] x86/cpufeatures: Introduce CPU setup and option
 parsing for CET
In-Reply-To: <20220130211838.8382-5-rick.p.edgecombe@intel.com>
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

>   * Some CPU features depend on higher CPUID levels, which may not always
>   * be available due to CPUID level capping or broken virtualization
> @@ -1261,6 +1269,9 @@ static void __init cpu_parse_early_param(void)
>  	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>  		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>  
> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);

Given this:

	https://lore.kernel.org/all/20220127115626.14179-2-bp@alien8.de/

I'd probably yank the command-line option out of this series, or stick
it in a separate patch that you tack on to the end.
