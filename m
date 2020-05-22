Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88BB1DEE09
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgEVRSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 13:18:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:59514 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbgEVRSq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 13:18:46 -0400
IronPort-SDR: jO9IP0+y+Oznd/UltpuCkIyMoEeQg/vjvRcVi12o9A2rUYuPFSsuK6edUuUNNhP2ZUG6jeRB9+
 HBAwiqaGD6jA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 10:18:45 -0700
IronPort-SDR: NXUfNJ68BjtyRCcOBPmLk8Z0wQMkH7dKhewmdbuP2bGwLxETp4+qAGhtLYXEmKviVPQKYA5ptO
 aZJA38nl90ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="467245771"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 22 May 2020 10:18:45 -0700
Message-ID: <c9c9314374c7db0bf9b6e39670855afe5b0d4014.camel@intel.com>
Subject: Re: [PATCH v10 26/26] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Fri, 22 May 2020 10:17:43 -0700
In-Reply-To: <202005211528.A12B4AD@keescook>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-27-yu-cheng.yu@intel.com>
         <202005211528.A12B4AD@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-05-21 at 15:42 -0700, Kees Cook wrote:
> On Wed, Apr 29, 2020 at 03:07:32PM -0700, Yu-cheng Yu wrote:
[...]
> > +
> > +int prctl_cet(int option, u64 arg2)
> > +{
> > +	struct cet_status *cet;
> > +
> > +	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
> > +		return -EINVAL;
> 
> Using -EINVAL here means userspace can't tell the difference between an
> old kernel and a kernel not built with CONFIG_X86_INTEL_CET. Perhaps
> -ENOTSUPP?

Looked into this.  The kernel and GLIBC are not in sync.  So maybe we still use
EINVAL here?

Yu-cheng



In kernel:
----------

#define EOPNOTSUPP	95
#define ENOTSUPP 	524

In GLIBC:
---------

printf("ENOTSUP=%d\n", ENOTSUP);
printf("EOPNOTSUPP=%d\n", EOPNOTSUPP);
printf("%s=524\n", strerror(524));
 
ENOTSUP=95
EOPNOTSUPP=95
Unknown error 524=524

