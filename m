Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4858E19DA5E
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404298AbgDCPmH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 11:42:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:63660 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDCPmH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 11:42:07 -0400
IronPort-SDR: 9bfCzudLNj7uOORwNDviIt/Hb85RFrxUOY3StacdmABTB2FeqhMa9CL30RYs4RyQTyaStR6asA
 +BlnNW5kmggA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 08:42:06 -0700
IronPort-SDR: RJf5XcF3zEyRJ09/us8jp/H/8TQ45FeITNZoj6qmJvJZrpMyH+BeCLfEQNew/lqKhbG4wVGqnQ
 bEFlq2iNEhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="241150363"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2020 08:42:06 -0700
Message-ID: <0ddcfb2630456324203917b78297b00cf5111c9e.camel@intel.com>
Subject: Re: [RFC PATCH v9 11/27] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 03 Apr 2020 08:42:06 -0700
In-Reply-To: <34c83f97-f206-1b43-db40-7e6a7d0f6bb7@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-12-yu-cheng.yu@intel.com>
         <34c83f97-f206-1b43-db40-7e6a7d0f6bb7@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-02-26 at 14:04 -0800, Dave Hansen wrote:
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> > index 4b04af569c05..e467ca182633 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -1201,7 +1201,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
> >  	}
> >  
> >  	/* Clear dirty field. */
> > -	se->val64 &= ~_PAGE_DIRTY;
> > +	se->val64 &= ~_PAGE_DIRTY_BITS;
> >  
> >  	ops->clear_pse(se);
> >  	ops->clear_ips(se);
> 
> Are the i915 maintainers on cc?
> 
> Shouldn't this use pte_mkclean() instead of open-coding?

These functions look like a set of pte_* equivalent for the driver.  They all
use the bits directly.  Add its maintainers to cc.

Yu-cheng

