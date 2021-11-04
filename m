Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1644556C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKDOkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 10:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDOko (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Nov 2021 10:40:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE527611C1;
        Thu,  4 Nov 2021 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636036686;
        bh=rmBQFomXsrGJIILa2DpkQR/DR6Udwpk1v8Ga+r3mhRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdRsPlIzC3DXMGfaO49eYPa1kjF6w5MW46p2T5LprCRtloeAKcHgnbpmmcmPQMqLQ
         24Sh9cXgFvZnzW1masrSatXL1dl5g7xCqqdaJ7ZjcIiW8ss3N+cZl6vOqSJTKED6lc
         xprY8DN+sCYzUpXuP6InY2xY0G41jeJRT8MkPxiOpNj16gV4iZideY6As8r4x0cPAq
         2AhNC8T8PjGEbBag69o1gl0g2IIlF6ACCSIW0VKy6+FRWLglS0RYsUffl8lYlSj0nI
         khi5gInFQ46rAl8OHlC1oQ5jUFs1RDg0UmAtDnR/ShzTeEdVuV7EQ+xS5AgBEXTXSD
         VZYdY5qSCyTfw==
Date:   Thu, 4 Nov 2021 23:38:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Wasin Thonkaew <wasin@wasin.io>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH RESEND] include/asm-generic/error-injection.h: fix a
 spelling mistake, and a coding style issue
Message-Id: <20211104233801.6704f27a856b06242da80cc6@kernel.org>
In-Reply-To: <20211103194030.186361-1-wasin@wasin.io>
References: <20211103194030.186361-1-wasin@wasin.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 03 Nov 2021 19:42:36 +0000 (UTC)
Wasin Thonkaew <wasin@wasin.io> wrote:

> Fix a spelling mistake "ganerating" -> "generating".
> Remove trailing semicolon for a macro ALLOW_ERROR_INJECTION to fix a
> coding style issue.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Wasin Thonkaew <wasin@wasin.io>
> ---
>  include/asm-generic/error-injection.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index 7ddd9dc10ce9..fbca56bd9cbc 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -20,7 +20,7 @@ struct pt_regs;
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  /*
> - * Whitelist ganerating macro. Specify functions which can be
> + * Whitelist generating macro. Specify functions which can be
>   * error-injectable using this macro.
>   */
>  #define ALLOW_ERROR_INJECTION(fname, _etype)				\
> @@ -29,7 +29,7 @@ static struct error_injection_entry __used				\
>  	_eil_addr_##fname = {						\
>  		.addr = (unsigned long)fname,				\
>  		.etype = EI_ETYPE_##_etype,				\
> -	};
> +	}
>  
>  void override_function_with_return(struct pt_regs *regs);
>  #else
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
