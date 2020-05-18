Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF50D1D7FC9
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERRNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 13:13:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERRNW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 13:13:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00012106F;
        Mon, 18 May 2020 10:13:21 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C9C13F305;
        Mon, 18 May 2020 10:13:20 -0700 (PDT)
Date:   Mon, 18 May 2020 18:13:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200518171317.GK9862@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-24-catalin.marinas@arm.com>
 <20200429164705.GF30377@arm.com>
 <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514113722.GA1907@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 14, 2020 at 12:37:22PM +0100, Catalin Marinas wrote:
> On Wed, May 13, 2020 at 04:48:46PM +0100, Dave P Martin wrote:
> > On Mon, May 11, 2020 at 05:40:19PM +0100, Catalin Marinas wrote:
> > > On Mon, May 04, 2020 at 05:46:17PM +0100, Dave P Martin wrote:
> > > > On Thu, Apr 30, 2020 at 05:23:17PM +0100, Catalin Marinas wrote:
> > > > > On Wed, Apr 29, 2020 at 05:47:05PM +0100, Dave P Martin wrote:
> > > > > > On Tue, Apr 21, 2020 at 03:26:03PM +0100, Catalin Marinas wrote:
> > > > > > > +excludes all tags other than 0. A user thread can enable specific tags
> > > > > > > +in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
> > > > > > > +flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
> > > > > > > +in the ``PR_MTE_TAG_MASK`` bit-field.
> > > > > > > +
> > > > > > > +**Note**: The hardware uses an exclude mask but the ``prctl()``
> > > > > > > +interface provides an include mask. An include mask of ``0`` (exclusion
> > > > > > > +mask ``0xffff``) results in the CPU always generating tag ``0``.
> > > > > > 
> > > > > > Is there no way to make this default to 1 rather than having a magic
> > > > > > meaning for 0?
> > > > > 
> > > > > We follow the hardware behaviour where 0xffff and 0xfffe give the same
> > > > > result.
> > > > 
> > > > Exposing this through a purely software interface seems a bit odd:
> > > > because the exclude mask is privileged-access-only, the architecture
> > > > could amend it to assign a different meaning to 0xffff, providing this
> > > > was an opt-in change.  Then we'd have to make a mess here.
> > > 
> > > You have a point. An include mask of 0 translates to an exclude mask of
> > > 0xffff as per the current patches. If the hardware gains support for one
> > > more bit (32 colours), old software running on new hardware may run into
> > > unexpected results with an exclude mask of 0xffff.
> > > 
> > > > Can't we just forbid the nonsense value 0 here, or are there other
> > > > reasons why that's problematic?
> > > 
> > > It was just easier to start with a default. I wonder whether we should
> > > actually switch back to the exclude mask, as per the hardware
> > > definition. This way 0 would mean all tags allowed. We can still
> > > disallow 0xffff as an exclude mask.
> [...]
> > The only configuration that doesn't make sense is "no tags allowed", so
> > I'd argue for explicity blocking that, even if the architeture aliases
> > that encoding to something else.
> > 
> > If we prefer 0 as a default value so that init inherits the correct
> > value from the kernel without any special acrobatics, then we make it an
> > exclude mask, with the semantics that the hardware is allowed to
> > generate any of these tags, but does not have to be capable of
> > generating all of them.
> 
> That's more of a question to the libc people and their preference.
> We have two options with suboptions:
> 
> 1. prctl() gets an exclude mask with 0xffff illegal even though the
>    hardware accepts it:
>    a) default exclude mask 0, allowing all tags to be generated by IRG
>    b) default exclude mask of 0xfffe so that only tag 0 is generated
> 
> 2. prctl() gets an include mask with 0 illegal:
>    a) default include mask is 0xffff, allowing all tags to be generated
>    b) default include mask 0f 0x0001 so that only tag 0 is generated
> 
> We currently have (2) with mask 0 but could be changed to (2.b). If we
> are to follow the hardware description (which makes more sense to me but
> I don't write the C library), (1.a) is the most appropriate.

As Peter pointed out on Friday (call), 2.b doesn't work as it breaks the
existing prctl() for turning on the tagged address ABI. So we have to
accept 0 as the tag mask field.

Dave, if you feel strongly about avoiding the exclude mask confusion
with 0xffff equivalent to 0xfffe, I'll go for 1.a. I have not changed
this in the v4 series of the patches (no ABI change in there apart from
some minor ptrace tweaks).

-- 
Catalin
