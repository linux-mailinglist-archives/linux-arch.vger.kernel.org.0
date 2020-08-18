Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCB248D6A
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHRRo6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHRRo5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 13:44:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5932EC061389;
        Tue, 18 Aug 2020 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VUwmIR+lImU3NRAfKAiYvoX2F1rNIteoEgPghMUy3n4=; b=fICQlLgf7nqw1v5EVdw+y4UkgP
        kbIROvywOoijsDOmGkmor5zGA36mtA9nORnPdRV0+PY6SgIHRyUiYvquWKJzwh5dVSuVFAFvX3DME
        uAmwFhMRtuIsHO7AxjC/Hf6i4yUHlUCTV0VhFn4FHFVQ71s5gGsrDviphLM3xYp35OmWKPBpLVRcf
        hwpTdFcUGW3d/jWbjCTyNWqqxGNmLCqcnEhJLRysG1hkTFskpa06/7toKpSoT4Zo3bffiyMFfe8De
        fS6X/+bj0bRKlbATWH2OR/lk0NRD8TCNYrCLq21TKS0tsjdfMcrFa8oUinpiBxN298K5q3iSTGAud
        JKE97/QA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k85fD-0006aT-In; Tue, 18 Aug 2020 17:44:47 +0000
Date:   Tue, 18 Aug 2020 18:44:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Message-ID: <20200818174447.GV17456@casper.infradead.org>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818173411.404104-1-christian.brauner@ubuntu.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
> The only remaining function callable outside of kernel/fork.c is
> _do_fork(). It doesn't really follow the naming of kernel-internal
> syscall helpers as Christoph righly pointed out. Switch all callers and
> references to kernel_clone() and remove _do_fork() once and for all.

My only concern is around return type.  long, int, pid_t ... can we
choose one and stick to it?  pid_t is probably the right return type
within the kernel, despite the return type of clone3().  It'll save us
some work if we ever go through the hassle of growing pid_t beyond 31-bit.
