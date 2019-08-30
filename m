Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E06A3CCB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3RMu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 13:12:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:14658 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3RMu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 13:12:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 10:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="265378402"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2019 10:12:49 -0700
Message-ID: <5ddd0306f42c2b53ffbd8ee8c9b948c1d529cf98.camel@intel.com>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 30 Aug 2019 10:03:27 -0700
In-Reply-To: <20190830083415.GI27757@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
         <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
         <201908292224.007EB4D5@keescook> <20190830083415.GI27757@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-08-30 at 09:34 +0100, Dave Martin wrote:
> On Fri, Aug 30, 2019 at 06:37:45AM +0100, Kees Cook wrote:
> > On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> > > ELF program properties will needed for detecting whether to enable
> > > optional architecture or ABI features for a new ELF process.
> > > 
> > > For now, there are no generic properties that we care about, so do
> > > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > > 
> > > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > > phdrs entry (if any), and notify each property to the arch code.
> > > 
> > > For now, the added code is not used.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for the review.
> 
> Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> early-terminate the scan if we can, but my feeling so far was that the
> scan is cheap, the number of properties is unlikely to be more than a
> smallish integer, and the code separation benefits of just calling the
> arch code for every property probably likely outweigh the costs of
> having to iterate over every property.  We could always optimise it
> later if necessary.
> 
> I need to double-check that there's no way we can get stuck in an
> infinite loop with the current code, though I've not seen it in my
> testing.  I should throw some malformed notes at it though.

Here is my arch_parse_elf_property() and objdump of the property.
The parser works fine.

Thanks,
Yu-cheng




int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
          
                   bool compat, struct arch_elf_state *state)
{
        if (type
!= GNU_PROPERTY_X86_FEATURE_1_AND)
                return -ENOENT;

        if (datasz < sizeof(unsigned int))
                return -ENOEXEC;

        state->gnu_property = *(unsigned int *)data;
        return 0;
}

Contents of section .note.gnu.property:
 400338 04000000 30000000 05000000 474e5500  ....0.......GNU.
 400348 020000c0 04000000 03000000 00000000  ................
 400358 000001c0 04000000 00000000 00000000  ................
 400368 010001c0 04000000 01000000 00000000  ................

