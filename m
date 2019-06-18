Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA04A610
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFRQBj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 12:01:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:30374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRQBi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 12:01:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 09:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="357901271"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2019 09:01:38 -0700
Message-ID: <1ca57aaae8a2121731f2dcb1a137b92eed39a0d2.camel@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 18 Jun 2019 08:53:29 -0700
In-Reply-To: <87pnna7v1d.fsf@oldenburg2.str.redhat.com>
References: <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
         <20190611114109.GN28398@e103592.cambridge.arm.com>
         <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
         <20190612093238.GQ28398@e103592.cambridge.arm.com>
         <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
         <alpine.DEB.2.21.1906171418220.1854@nanos.tec.linutronix.de>
         <20190618091248.GB2790@e103592.cambridge.arm.com>
         <20190618124122.GH3419@hirez.programming.kicks-ass.net>
         <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
         <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
         <20190618133223.GD2790@e103592.cambridge.arm.com>
         <d54fe81be77b9edd8578a6d208c72cd7c0b8c1dd.camel@intel.com>
         <87pnna7v1d.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-06-18 at 17:49 +0200, Florian Weimer wrote:
> * Yu-cheng Yu:
> 
> > The kernel looks at only ld-linux.  Other applications are loaded by ld-
> > linux. 
> > So the issues are limited to three versions of ld-linux's.  Can we somehow
> > update those??
> 
> I assumed that it would also parse the main executable and make
> adjustments based on that.

Yes, Linux also looks at the main executable's header, but not its
NT_GNU_PROPERTY_TYPE_0 if there is a loader.

> 
> ld.so can certainly provide whatever the kernel needs.  We need to tweak
> the existing loader anyway.
> 
> No valid statically-linked binaries exist today, so this is not a
> consideration at this point.

So from kernel, we look at only PT_GNU_PROPERTY?

Yu-cheng

