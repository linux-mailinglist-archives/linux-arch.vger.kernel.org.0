Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA00027DD41
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 02:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgI3ANB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 20:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI3ANB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 20:13:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5580B20739;
        Wed, 30 Sep 2020 00:12:59 +0000 (UTC)
Date:   Tue, 29 Sep 2020 20:12:57 -0400
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
Subject: Re: [PATCH v4 06/29] tracing: move function tracer options to
 Kconfig
Message-ID: <20200929201257.1570aadd@oasis.local.home>
In-Reply-To: <20200929214631.3516445-7-samitolvanen@google.com>
References: <20200929214631.3516445-1-samitolvanen@google.com>
        <20200929214631.3516445-7-samitolvanen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 29 Sep 2020 14:46:08 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> +++ b/kernel/trace/Kconfig
> @@ -595,6 +595,22 @@ config FTRACE_MCOUNT_RECORD
>  	depends on DYNAMIC_FTRACE
>  	depends on HAVE_FTRACE_MCOUNT_RECORD
>  
> +config FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> +	bool
> +	depends on FTRACE_MCOUNT_RECORD
> +
> +config FTRACE_MCOUNT_USE_CC
> +	def_bool y
> +	depends on $(cc-option,-mrecord-mcount)

Does the above get executed at every build? Or does a make *config need
to be done? If someone were to pass a .config to someone else that had
a compiler that didn't support this, would it be changed if the person
just did a make?

-- Steve


> +	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> +	depends on FTRACE_MCOUNT_RECORD
> +
> +config FTRACE_MCOUNT_USE_RECORDMCOUNT
> +	def_bool y
> +	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> +	depends on !FTRACE_MCOUNT_USE_CC
> +	depends on FTRACE_MCOUNT_RECORD
> +
>  config TRACING_MAP
>  	bool
>  	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
