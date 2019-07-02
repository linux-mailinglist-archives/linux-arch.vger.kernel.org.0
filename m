Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB76E5CDD0
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2019 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGBKqK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jul 2019 06:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfGBKqK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jul 2019 06:46:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49912089C;
        Tue,  2 Jul 2019 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562064369;
        bh=dOb4MTdKAgRzGQ+yE9sL+9KKQb2/t5teCLbYFvKOmYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmOIvgqYnhG6gcE4s/cT6vnAWChkKch0CdTkyDJV0+BS7qniUrgc23Phe5RJbw6LA
         WhbJFIEyA/+cY8ckrjvDHQ2okIpABjtyaPYorAnbvD8RfKiWkEWOHxbebbCC1LUVS4
         SgcDDwf0jt386rr72W5xAUO/Cy5BS4FWTKNGlAYY=
Date:   Tue, 2 Jul 2019 11:46:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <20190702104603.g3qssgfhfhvryhnu@willie-the-truck>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <73510bc7-8386-746c-ed1e-422fb5adaec5@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73510bc7-8386-746c-ed1e-422fb5adaec5@synopsys.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 01, 2019 at 08:05:51PM +0000, Vineet Gupta wrote:
> On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> > On Thu, May 30, 2019 at 11:22:42AM -0700, Vineet Gupta wrote:
> >> Had an interesting lunch time discussion with our hardware architects pertinent to
> >> "minimal guarantees expected of a CPU" section of memory-barriers.txt
> >>
> >>
> >> |  (*) These guarantees apply only to properly aligned and sized scalar
> >> |     variables.  "Properly sized" currently means variables that are
> >> |     the same size as "char", "short", "int" and "long".  "Properly
> >> |     aligned" means the natural alignment, thus no constraints for
> >> |     "char", two-byte alignment for "short", four-byte alignment for
> >> |     "int", and either four-byte or eight-byte alignment for "long",
> >> |     on 32-bit and 64-bit systems, respectively.
> >>
> >>
> >> I'm not sure how to interpret "natural alignment" for the case of double
> >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > 
> > Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))
> > 
> > For any u64 type, that would give 8 byte alignment. the problem
> > otherwise being that your data spans two lines/pages etc..
> > 
> >> I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> >> be atomic unless 8-byte aligned
> >>
> >> ARMv7 arch ref manual seems to confirm this. Quoting
> >>
> >> | LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR,
> >> | VSTM, and VSTR instructions are executed as a sequence of word-aligned word
> >> | accesses. Each 32-bit word access is guaranteed to be single-copy atomic. A
> >> | subsequence of two or more word accesses from the sequence might not exhibit
> >> | single-copy atomicity
> >>
> >> While it seems reasonable form hardware pov to not implement such atomicity by
> >> default it seems there's an additional burden on application writers. They could
> >> be happily using a lockless algorithm with just a shared flag between 2 threads
> >> w/o need for any explicit synchronization.
> > 
> > If you're that careless with lockless code, you deserve all the pain you
> > get.
> > 
> >> But upgrade to a new compiler which
> >> aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
> >> causing the code to suddenly stop working. Is the onus on them to declare such
> >> memory as c11 atomic or some such.
> > 
> > When a programmer wants guarantees they already need to know wth they're
> > doing.
> > 
> > And I'll stand by my earlier conviction that any architecture that has a
> > native u64 (be it a 64bit arch or a 32bit with double-width
> > instructions) but has an ABI that allows u32 alignment on them is daft.
> 
> So I agree with Paul's assertion that it is strange for 8-byte type being 4-byte
> aligned on a 64-bit system, but is it totally broken even if the ISA of the said
> 64-bit arch allows LD/ST to be augmented with acq/rel respectively.
> 
> Say the ISA guarantees single-copy atomicity for aligned cases (i.e. for 8-byte
> data only if it is naturally aligned) and in lack thereof programmer needs to use
> the proper acq/release

Apologies if I'm missing some context here, but it's not clear to me why the
use of acquire/release instructions has anything to do with single-copy
atomicity of unaligned accesses. The ordering they provide doesn't
necessarily prevent tearing, although a CPU architecture could obviously
provide that guarantee if it wanted to. Generally though, I wouldn't expect
the two to go hand-in-hand like you're suggesting.

Will
