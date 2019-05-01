Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26E910EE4
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 00:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEAWBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 18:01:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:31714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfEAWBy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 May 2019 18:01:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 15:01:53 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2019 15:01:49 -0700
Message-ID: <1c69263279be0b2f6582e58a0bf28bc213d94693.camel@intel.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Dave Martin <Dave.Martin@arm.com>
Date:   Wed, 01 May 2019 14:54:23 -0700
In-Reply-To: <20190501213709.GD28500@bombadil.infradead.org>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
         <20190501213709.GD28500@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2019-05-01 at 14:37 -0700, Matthew Wilcox wrote:
> On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> > +++ b/fs/Kconfig.binfmt
> > @@ -35,6 +35,10 @@ config COMPAT_BINFMT_ELF
> >  config ARCH_BINFMT_ELF_STATE
> >  	bool
> >  
> > +config ARCH_USE_GNU_PROPERTY
> > +	bool
> > +	depends on 64BIT
> 
> I don't think this is right.  I think you should get rid of the depends line
> and instead select the symbol from each of argh64 and x86 Kconfig files.

That makes sense.  Thanks!

Yu-cheng
