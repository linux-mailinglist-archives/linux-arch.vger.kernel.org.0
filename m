Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72E43110CA
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 20:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhBER25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 12:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhBER0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 12:26:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 022EA64E06;
        Fri,  5 Feb 2021 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612552117;
        bh=724MQJqAQF7oc36R/fYyo3wNqiT4pC1sx82OvhBGFMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkA3/HcZ/GmC3KoC5bXO08ehPJ9iRWkRvtKvpoEaMdC1xk2tJQESqq151U7YIGG5q
         Cbk6hZN/Y5MiXNjj+Q9leD51S74ow4CtFOY87Wnp1bZhqZWVHbNNlDAGv0UZR9Rgpq
         XprGCq/FXR19Td1GuWU23BgraFE/OIk6Bz/VDplG1EAaHNRmf+0zfK81WzXl/x85Fh
         t1BBaaFWGlbC2AsI2cXsdooe7A56ZTFo6C1hSXegKp8hsOCVHtDdAXwNWZkY1V46BL
         2mO/dJpYTurfLLXEBwi8unvloVvk8Krb/UPbLhPJmu/xQx4Alp1gXcL/rSBJxDZVai
         xehma5ufAq+4Q==
Date:   Fri, 5 Feb 2021 12:08:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v2] firmware_loader: Align .builtin_fw to 8
Message-ID: <20210205190834.GC461042@localhost>
References: <20201203202737.7c4wrifqafszyd5y@google.com>
 <20201208054646.2913063-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208054646.2913063-1-maskray@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 07, 2020 at 09:46:46PM -0800, Fangrui Song wrote:
> arm64 references the start address of .builtin_fw (__start_builtin_fw)
> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> relocations. The compiler is allowed to emit the
> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> include/linux/firmware.h is 8-byte aligned.
> 
> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> multiple of 8, which may not be the case if .builtin_fw is empty.
> Unconditionally align .builtin_fw to fix the linker error. 32-bit
> architectures could use ALIGN(4) but that would add unnecessary
> complexity, so just use ALIGN(8).
> 
> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nathan Chancellor <nathan@kernel.org>

Andrew, is there any way to get this picked up with the following tags
for 5.11?

Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

If not, please let me know and I can try to shuffle this along to Linus
next week.

> 
> ---
> Change in v2:
> * Use output section alignment instead of inappropriate ALIGN_FUNCTION()
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..b97c628ad91f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -459,7 +459,7 @@
>  	}								\
>  									\
>  	/* Built-in firmware blobs */					\
> -	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
> +	.builtin_fw : AT(ADDR(.builtin_fw) - LOAD_OFFSET) ALIGN(8) {	\
>  		__start_builtin_fw = .;					\
>  		KEEP(*(.builtin_fw))					\
>  		__end_builtin_fw = .;					\
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
