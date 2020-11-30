Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB372C839D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 13:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgK3L7u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 06:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgK3L7u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 06:59:50 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62772073C;
        Mon, 30 Nov 2020 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606737549;
        bh=jcKRnTY2A7tTxLUEBA4FhjDB78+vG8Uu58hBCNu3Qs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbGPLq/Gdk/ASCNBy/7/E3wrn5zqLDESpvoy2UNHGZHuuXFZQPCXO7FbliCo+KTjL
         dcpgEk4JxaUXIYiMKN86igCiutZADLzLXf9whER7tpQ4rNqnS6qJKWRrApd0RwpCLA
         mDCVfehaZ+02umT+yBR6tKxGFcK/pkEQRrCuPSVg=
Date:   Mon, 30 Nov 2020 11:59:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 16/17] arm64: disable recordmcount with
 DYNAMIC_FTRACE_WITH_REGS
Message-ID: <20201130115902.GD24563@willie-the-truck>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118220731.925424-17-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 18, 2020 at 02:07:30PM -0800, Sami Tolvanen wrote:
> DYNAMIC_FTRACE_WITH_REGS uses -fpatchable-function-entry, which makes
> running recordmcount unnecessary as there are no mcount calls in object
> files, and __mcount_loc doesn't need to be generated.
> 
> While there's normally no harm in running recordmcount even when it's
> not strictly needed, this won't work with LTO as we have LLVM bitcode
> instead of ELF objects.
> 
> This change selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY, which
> disables recordmcount when patchable function entries are used instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..c7f07978f5b6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -158,6 +158,8 @@ config ARM64
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
>  		if $(cc-option,-fpatchable-function-entry=2)
> +	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
> +		if DYNAMIC_FTRACE_WITH_REGS

I don't really understand why this is in the arch header file, rather
than have the core code check for "fpatchable-function-entry=2" and expose
a CC_HAS_PATCHABLE_FUNCTION_ENTRY, but in the interest of making some
progress on this series:

Acked-by: Will Deacon <will@kernel.org>

Will
