Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F5B294A95
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437915AbgJUJcn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437910AbgJUJcm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 05:32:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77060C0613CE;
        Wed, 21 Oct 2020 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uqvkvvjoE5FAn6/BMAIUZQ+MmjJn2kzB19jYobhFRX8=; b=Lre+lL+7R9qcHEKT2oKPmuoix0
        8+LXkYHtQYHrO2Pz7aEHI7sV1vgZDrWHN+UyPxRTwXoL2QHKC6LZhqZ0NLRXOEfVpKRikeCq40Q5C
        atnuKL+sNqu+svyLk2dv9s9MF8hscvTiRHtwomK8MzcM1rFH6ZJKBnDE+ZSgAqeuI+PMs2YMEPsV9
        F+nrQvS9EGm7Co6vldjFlpa2BGab+OdtnGdrjyA8CbXLVbHMYEE+FY6dei4gPfLLcwu8JSKoRahxO
        uWnNBiAUOcWVy7viO9vcOo04lqSFPTD5SV3h441hcw1wOfJEretWPf/kkS656dTUVyPvbeRhsUUun
        wZ1xFJ3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVATf-00084o-G7; Wed, 21 Oct 2020 09:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD6EF3035D4;
        Wed, 21 Oct 2020 11:32:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5308214ECD61; Wed, 21 Oct 2020 11:32:13 +0200 (CEST)
Date:   Wed, 21 Oct 2020 11:32:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201021093213.GV2651@hirez.programming.kicks-ass.net>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 10:56:06AM +0200, Peter Zijlstra wrote:

> I do not see these in particular, although I do see a lot of:
> 
>   "sibling call from callable instruction with modified stack frame"

defconfig-build/vmlinux.o: warning: objtool: msr_write()+0x10a: sibling call from callable instruction with modified stack frame
defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x99: (branch)
defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x3e: (branch)
defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x0: <=== (sym)

$ nm defconfig-build/vmlinux.o | grep msr_write
0000000000043250 t msr_write
00000000004289c0 T msr_write
0000000000003056 t msr_write.cold

Below 'fixes' it. So this is also caused by duplicate symbols.

---
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 3bd905e10ee2..e36331f8f217 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -48,17 +48,6 @@ int msr_read(u32 msr, struct msr *m)
 	return err;
 }
 
-/**
- * Write an MSR with error handling
- *
- * @msr: MSR to write
- * @m: value to write
- */
-int msr_write(u32 msr, struct msr *m)
-{
-	return wrmsrl_safe(msr, m->q);
-}
-
 static inline int __flip_bit(u32 msr, u8 bit, bool set)
 {
 	struct msr m, m1;
@@ -80,7 +69,7 @@ static inline int __flip_bit(u32 msr, u8 bit, bool set)
 	if (m1.q == m.q)
 		return 0;
 
-	err = msr_write(msr, &m1);
+	err = wrmsr_safe(msr, m1.q);
 	if (err)
 		return err;
 
