Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F494AF761
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 17:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiBIQ6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiBIQ6c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 11:58:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53DC043180;
        Wed,  9 Feb 2022 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644425908; x=1675961908;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=qBIG1Z9WmAaojnbocDOnq2HfqKAkZyB1quN1UVQeNOM=;
  b=DOtdJjJEkLKxTwXQlBYsPsD/uzUUaW0tXJO2khWuMqmnR7Zi2AFwnVkh
   Yr0OpOesqMJfTl7iUkiqwaRR4ZcHxpsB3pf5SaodZQRBnisGytFI8yPCl
   oIwVhXIOSOes9cUVaFfR4awP5g+hgp3yXhecNmVs1WNJQck6bfuuLKdKH
   XKZnDBMXAbLu0BTGwFryrReth+4dHO/iQ2Ik8KgLlHgbVd5ioz/LrtYIc
   RjWHWVXY0G/6YB9SyX6EYhH446UdQPZQNJVrYU3Z2hRuVjXCU4v31HSsK
   u/4eM/Z8HC2dgUz36syhCO99plSJ6istVqu1MKHIlBSOzSIvCC7KXohja
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236657725"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="236657725"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:58:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485309693"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:58:19 -0800
Message-ID: <a5bb32b8-8bd7-ac98-5c4c-5af604ac8256@intel.com>
Date:   Wed, 9 Feb 2022 08:58:16 -0800
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-11-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
In-Reply-To: <20220130211838.8382-11-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 99d1781fa5f0..75ce4e823902 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1210,7 +1210,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
>  	}
>  
>  	/* Clear dirty field. */
> -	se->val64 &= ~_PAGE_DIRTY;
> +	se->val64 &= ~_PAGE_DIRTY_BITS;
>  
>  	ops->clear_pse(se);
>  	ops->clear_ips(se);

Are these x86 CPU page table values?  I see ->val64 being used like this:

        e->val64 &= ~GEN8_PAGE_PRESENT;
and
	se.val64 |= GEN8_PAGE_PRESENT | GEN8_PAGE_RW;

where we also have:

#define GEN8_PAGE_PRESENT               BIT_ULL(0)
#define GEN8_PAGE_RW                    BIT_ULL(1)

Which tells me that these are probably *close* to the CPU's page tables.
 But, I honestly don't know which format they are.  I don't know if
_PAGE_COW is still a software bit in that format or not.

Either way, I don't think we should be messing with i915 device page tables.

Or, are these somehow magically shared with the CPU in some way I don't
know about?

[ If these are device-only page tables, it would probably be nice to
  stop using _PAGE_FOO for them.  It would avoid confusion like this. ]
