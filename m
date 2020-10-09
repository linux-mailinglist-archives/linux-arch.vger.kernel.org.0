Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BC289C2E
	for <lists+linux-arch@lfdr.de>; Sat, 10 Oct 2020 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgJIXmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 19:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgJIXka (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 19:40:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D7A2222E;
        Fri,  9 Oct 2020 23:38:44 +0000 (UTC)
Date:   Fri, 9 Oct 2020 19:38:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 00/29] Add support for Clang LTO
Message-ID: <20201009193759.13043836@oasis.local.home>
In-Reply-To: <20201009210548.GB1448445@google.com>
References: <20201009161338.657380-1-samitolvanen@google.com>
        <20201009153512.1546446a@gandalf.local.home>
        <20201009210548.GB1448445@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 9 Oct 2020 14:05:48 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> Ah yes, X86_DECODER_SELFTEST seems to be broken in tip/master. If you
> prefer, I have these patches on top of mainline here:
> 
>   https://github.com/samitolvanen/linux/tree/clang-lto
> 
> Testing your config with LTO on this tree, it does build and boot for
> me, although I saw a couple of new objtool warnings, and with LLVM=1,
> one warning from llvm-objdump.

Thanks, I disabled X86_DECODER_SELFTEST and it now builds.

I forced the objdump mcount logic with the below patch, which produces:

CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y

But I don't see the __mcount_loc sections being created.

I applied patches 1 - 6.

-- Steve

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 89263210ab26..3042619e21b7 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -606,7 +606,7 @@ config FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 
 config FTRACE_MCOUNT_USE_CC
 	def_bool y
-	depends on $(cc-option,-mrecord-mcount)
+	depends on $(cc-option,-mrecord-mcount1)
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on FTRACE_MCOUNT_RECORD
 
