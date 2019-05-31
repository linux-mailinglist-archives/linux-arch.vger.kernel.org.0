Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF530A23
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaIVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:21:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaIVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=69CupxyG5Rlyr8SYoaqVqCnhz38WNqA+v67FqR5/kA4=; b=Py1T06+Wo7xMPlKFUiERWjzbv
        4c72RFv3/ROXRSF66bTCVr+EkGC6sZuioZ99pCQFjfZ27+Bx9YChKXZMOpm+IchXIHjfdY2VN2OaI
        3/c2WeHU6g9KJvxlKv3OBcJSGnckKLMx2r/E2CwJUI7dXDy9grF/CA1yy9M+v4Wo41I26lMZJEsN+
        iLy526y4tQXbawv107JkqCYMW0gefHicqzR18/krhuXs3pS8G9HZXFpF3qKXQmuYF07vMq05atpAU
        E00BtBHHTL65hUgUCFcNURZZbqy74Uho7oqzdRbs8PAFTbiGKQk7922Sm620B6h/zl8BwmeYmGJtO
        NpjS1yIiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWcmo-0006v5-IY; Fri, 31 May 2019 08:21:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7F1E201B8CFE; Fri, 31 May 2019 10:21:12 +0200 (CEST)
Date:   Fri, 31 May 2019 10:21:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Will Deacon <Will.Deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <20190531082112.GH2623@hirez.programming.kicks-ass.net>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 11:22:42AM -0700, Vineet Gupta wrote:
> Hi Peter,
> 
> Had an interesting lunch time discussion with our hardware architects pertinent to
> "minimal guarantees expected of a CPU" section of memory-barriers.txt
> 
> 
> |  (*) These guarantees apply only to properly aligned and sized scalar
> |     variables.  "Properly sized" currently means variables that are
> |     the same size as "char", "short", "int" and "long".  "Properly
> |     aligned" means the natural alignment, thus no constraints for
> |     "char", two-byte alignment for "short", four-byte alignment for
> |     "int", and either four-byte or eight-byte alignment for "long",
> |     on 32-bit and 64-bit systems, respectively.
> 
> 
> I'm not sure how to interpret "natural alignment" for the case of double
> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)

Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))

For any u64 type, that would give 8 byte alignment. the problem
otherwise being that your data spans two lines/pages etc..

> I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> be atomic unless 8-byte aligned
> 
> ARMv7 arch ref manual seems to confirm this. Quoting
> 
> | LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR,
> | VSTM, and VSTR instructions are executed as a sequence of word-aligned word
> | accesses. Each 32-bit word access is guaranteed to be single-copy atomic. A
> | subsequence of two or more word accesses from the sequence might not exhibit
> | single-copy atomicity
> 
> While it seems reasonable form hardware pov to not implement such atomicity by
> default it seems there's an additional burden on application writers. They could
> be happily using a lockless algorithm with just a shared flag between 2 threads
> w/o need for any explicit synchronization.

If you're that careless with lockless code, you deserve all the pain you
get.

> But upgrade to a new compiler which
> aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
> causing the code to suddenly stop working. Is the onus on them to declare such
> memory as c11 atomic or some such.

When a programmer wants guarantees they already need to know wth they're
doing.

And I'll stand by my earlier conviction that any architecture that has a
native u64 (be it a 64bit arch or a 32bit with double-width
instructions) but has an ABI that allows u32 alignment on them is daft.

