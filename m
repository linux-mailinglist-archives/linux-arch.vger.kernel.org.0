Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167202C83A5
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 13:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgK3MBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 07:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgK3MBI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 07:01:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179B52073C;
        Mon, 30 Nov 2020 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606737627;
        bh=HBOIO8GaCg6xuTGjJaH9CwIBSnKPzHwxyZUymO54yi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yzM9f+2t0xm2UaSKWFUKTi0QtGsVMKXqHXBS1Z7u81tBEmBY8l8f7Hsa1i2mw4qyd
         fvd85qZ6OMwkW1qqkN71XY+4V/XfXkDnI1y+duNB0L2COvyVv3mGOw0HVIw6ROw3sk
         6KhUBLTX11sbbhPwamUk+q9jexDlZ968PrKAzHsg=
Date:   Mon, 30 Nov 2020 12:00:21 +0000
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
Subject: Re: [PATCH v7 17/17] arm64: allow LTO_CLANG and THINLTO to be
 selected
Message-ID: <20201130120021.GE24563@willie-the-truck>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118220731.925424-18-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 18, 2020 at 02:07:31PM -0800, Sami Tolvanen wrote:
> Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c7f07978f5b6..56bd83a764f4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -73,6 +73,8 @@ config ARM64
>  	select ARCH_USE_SYM_ANNOTATIONS
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> +	select ARCH_SUPPORTS_LTO_CLANG
> +	select ARCH_SUPPORTS_THINLTO

Acked-by: Will Deacon <will@kernel.org>

Will
