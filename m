Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AEA20B0C2
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgFZLnX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFZLnW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 07:43:22 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4AC08C5C1;
        Fri, 26 Jun 2020 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dY6UukHlcZ+e82YPYVTQRIm6jOfXAELNJfA0ddnH3+0=; b=HW7pMPohMNzcNWBrOKQR8629sZ
        nWVaNWWPYIkUbTocP1X7DaVMrLJyG+42HOb3gYa31ahAN0A9SDdMsxfvrhpa2NhQm82vYxw9YspeO
        1M5y3dWrFnrmgzCjiVs8YhefAkoxs/xTmpxvoQ3Nbpz8Q+In7EI/KlCNxjmjP5rgTbfm6eBTBeF76
        vizq1+U5H2tltHhneBCOdiW/U+nLYPmp4Zav8pPi8++UvCfn9aFu2mm4se8UZowRKHXBhSuBX1exq
        mHY2ns73zDMjIkR2nTGxS88dg/TS6tMHFLQutMWIVA9O+RXcOX0QKMAQPFwX25yccxW0i76etxb+g
        WXnTya+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomkW-0001Sj-F5; Fri, 26 Jun 2020 11:42:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFB7D301DFC;
        Fri, 26 Jun 2020 13:42:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3EF429CC71EB; Fri, 26 Jun 2020 13:42:26 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:42:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        mhelsley@vmware.com
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Message-ID: <20200626114226.GH4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com>
 <20200626112931.GF4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626112931.GF4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 01:29:31PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 03:40:42PM -0700, Sami Tolvanen wrote:

> > Anyway, since objtool is run before recordmcount, I just left this unchanged
> > for testing and ignored the recordmcount warnings about __mcount_loc already
> > existing. Something is a bit off still though, I see this at boot:
> > 
> >   ------------[ ftrace bug ]------------
> >   ftrace failed to modify
> >   [<ffffffff81000660>] __tracepoint_iter_initcall_level+0x0/0x40
> >    actual:   0f:1f:44:00:00
> >   Initializing ftrace call sites
> >   ftrace record flags: 0
> >    (0)
> >    expected tramp: ffffffff81056500
> >   ------------[ cut here ]------------
> > 
> > Otherwise, this looks pretty good.
> 
> Ha! it is trying to convert the "CALL __fentry__" into a NOP and not
> finding the CALL -- because objtool already made it a NOP...
> 
> Weird, I thought recordmcount would also write NOPs, it certainly has
> code for that. I suppose we can use CC_USING_NOP_MCOUNT to avoid those,
> but I'd rather Steve explain this before I wreck things further.

Something like so would ignore whatever text is there and rewrite it
with ideal_nop.

---
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index c84d28e90a58..98a6a93d7615 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -109,9 +109,11 @@ static int __ref
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 			  const char *new_code)
 {
-	int ret = ftrace_verify_code(ip, old_code);
-	if (ret)
-		return ret;
+	if (old_code) {
+		int ret = ftrace_verify_code(ip, old_code);
+		if (ret)
+			return ret;
+	}
 
 	/* replace the text with the new text */
 	if (ftrace_poke_late)
@@ -124,9 +126,8 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
-	const char *new, *old;
+	const char *new;
 
-	old = ftrace_call_replace(ip, addr);
 	new = ftrace_nop_replace();
 
 	/*
@@ -138,7 +139,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(ip, old, new);
+		return ftrace_modify_code_direct(ip, NULL, new);
 
 	/*
 	 * x86 overrides ftrace_replace_code -- this function will never be used
