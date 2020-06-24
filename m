Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8B209740
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbgFXXvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 19:51:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:34743 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387959AbgFXXvp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 19:51:45 -0400
IronPort-SDR: 6bUtqBjrs5r3Q6hd6HO10rsF2QBhhBW7nqIP4BFE5JSMtcGkS+AUvjdbRAIpjSJkLnxv9bRI6F
 HHlRGb+LAKKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133107161"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="133107161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 16:51:44 -0700
IronPort-SDR: aIRwRfjfYOdQKt3phW/InEgXxtOGI/IQstcHLZdz056+zuNv6rXZAztOwLlpT5Cd5ScDQD9lHH
 /YX4kqyPmgHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="423544015"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2020 16:51:44 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 463F2301BA1; Wed, 24 Jun 2020 16:51:44 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:51:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Message-ID: <20200624235144.GD818054@tassilo.jf.intel.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com>
 <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <CAKwvOdm_EBfmV+GvDE-COoDwpEm9snea4_KtuFyorA5KEU6FbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm_EBfmV+GvDE-COoDwpEm9snea4_KtuFyorA5KEU6FbQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 02:09:40PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 24, 2020 at 1:58 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Filter out CC_FLAGS_LTO for the vDSO.
> >
> > Just curious about this patch (and the following one for x86's vdso),
> > do you happen to recall specifically what the issues with the vdso's
> > are?
> 
> + Andi (tangential, I actually have a bunch of tabs open with slides
> from http://halobates.de/ right now)
> 58edae3aac9f2
> 67424d5a22124
> $ git log -S DISABLE_LTO

I think I did it originally because the vDSO linker step didn't do
all the magic needed for gcc LTO. But it also doesn't seem to be
very useful for just a few functions that don't have complex
interactions, and somewhat risky for violating some assumptions.

-Andi
