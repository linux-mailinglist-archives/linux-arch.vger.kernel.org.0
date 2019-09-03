Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D09A771F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2019 00:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfICWil (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 18:38:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:26578 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfICWil (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 18:38:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 15:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,464,1559545200"; 
   d="scan'208";a="189969649"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2019 15:38:40 -0700
Message-ID: <59052137a61bab9e8d312d51644aade3953ba339.camel@intel.com>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 03 Sep 2019 15:29:10 -0700
In-Reply-To: <20190902092816.GK27757@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
         <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
         <201908292224.007EB4D5@keescook> <20190830083415.GI27757@arm.com>
         <5ddd0306f42c2b53ffbd8ee8c9b948c1d529cf98.camel@intel.com>
         <20190902092816.GK27757@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-09-02 at 10:28 +0100, Dave Martin wrote:
> On Fri, Aug 30, 2019 at 06:03:27PM +0100, Yu-cheng Yu wrote:
> > On Fri, 2019-08-30 at 09:34 +0100, Dave Martin wrote:
> > > On Fri, Aug 30, 2019 at 06:37:45AM +0100, Kees Cook wrote:
> > > > On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> > > > > ELF program properties will needed for detecting whether to enable
> > > > > optional architecture or ABI features for a new ELF process.
> > > > > 
> > > > > For now, there are no generic properties that we care about, so do
> > > > > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > > > > 
> > > > > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > > > > phdrs entry (if any), and notify each property to the arch code.
> > > > > 
> > > > > For now, the added code is not used.
> > > > > 
> > > > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > > 
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Thanks for the review.
> > > 
> > > Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> > > early-terminate the scan if we can, but my feeling so far was that the
> > > scan is cheap, the number of properties is unlikely to be more than a
> > > smallish integer, and the code separation benefits of just calling the
> > > arch code for every property probably likely outweigh the costs of
> > > having to iterate over every property.  We could always optimise it
> > > later if necessary.
> > > 
> > > I need to double-check that there's no way we can get stuck in an
> > > infinite loop with the current code, though I've not seen it in my
> > > testing.  I should throw some malformed notes at it though.
> > 
> > Here is my arch_parse_elf_property() and objdump of the property.
> > The parser works fine.
> 
> [...]
> 
> > int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> >           
> >                    bool compat, struct arch_elf_state *state)
> > {
> >         if (type
> > != GNU_PROPERTY_X86_FEATURE_1_AND)
> >                 return -ENOENT;
> 
> For error returns, I was following this convention:
> 
> 	EIO: invalid ELF file
> 
> 	ENOEXEC: valid ELF file, but we can't (or won't) support it
> 
> 	0: OK, or don't care

From errno-base.h, EIO is for I/O error; ENOEXEC is for Exec format error.
Is this closer to what is happening?

> 
> This function gets called for every property, including properties that
> the arch code may not be interested in, so for properties you don't care
> about here you should return 0.

Yes.

> 
> > 
> >         if (datasz < sizeof(unsigned int))
> >                 return -ENOEXEC;
> 
> Should this be != ?
> 
> According to the draft x86-64 psABI spec [1],
> X86_PROPERTY_FEATURE_1_AND (and all properties based on
> GNU_PROPERTY_X86_UINT32_AND_LO) has data consisting of a single 4-byte
> unsigned integer.
> 
> >         state->gnu_property = *(unsigned int *)data;
> >         return 0;
> > }

Yes, I will change it.

Thanks,
Yu-cheng
