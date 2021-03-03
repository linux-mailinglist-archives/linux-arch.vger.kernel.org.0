Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645CF32C863
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhCDAtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240239AbhCCR3b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 12:29:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AD96600EF;
        Wed,  3 Mar 2021 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614792496;
        bh=zlg3djBmpPQX9HA9Tio/KvTAc3gzFSUjPMEmR7Drzyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSQTrq7mqSrGIDFdtUatUCDfw1IC6EyoOVr0Uj3b1E0wymegPLztI2ED6vcxu5C85
         UY60ZVdYnSuXJN3JzhG55Piik7aZ8B9E+K1A+FSoDiagqWM65C/fZI81O0MtFX5GkU
         yUft1a2F5wt6kV7eIsuS4bnBkC4qpzlxDS5+/Li2Xdkmu1wtESzUphUjRgv1i2DuQP
         L86JZ8VksAPpPB0GZMXfG7aFYiXs+x+Mlfg8tgnWmuDM5/65uHXjSYTApptiVRqnVP
         DKdLG5OBDF3pbNQHv3Ku+COBJ56gx+Bk0mQOP6S6LMBjqA63x+sYmeaty89WZBN7Tk
         nqvxMJ9ADAITw==
Date:   Wed, 3 Mar 2021 17:28:10 +0000
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command
 line.
Message-ID: <20210303172810.GA19713@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 05:25:17PM +0000, Christophe Leroy wrote:
> This code provides architectures with a way to build command line
> based on what is built in the kernel and what is handed over by the
> bootloader, based on selected compile-time options.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/cmdline.h | 62 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 include/linux/cmdline.h
> 
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..ae3610bb0ee2
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +static __always_inline size_t cmdline_strlen(const char *s)
> +{
> +	const char *sc;
> +
> +	for (sc = s; *sc != '\0'; ++sc)
> +		; /* nothing */
> +	return sc - s;
> +}
> +
> +static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_t count)
> +{
> +	size_t dsize = cmdline_strlen(dest);
> +	size_t len = cmdline_strlen(src);
> +	size_t res = dsize + len;
> +
> +	/* This would be a bug */
> +	if (dsize >= count)
> +		return count;
> +
> +	dest += dsize;
> +	count -= dsize;
> +	if (len >= count)
> +		len = count - 1;
> +	memcpy(dest, src, len);
> +	dest[len] = 0;
> +	return res;
> +}

Why are these needed instead of using strlen and strlcat directly?

> +/*
> + * This function will append a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dest: The destination of the final appended/prepended string.
> + * @src: The starting string or NULL if there isn't one. Must not equal dest.
> + * @length: the length of dest buffer.
> + */
> +static __always_inline void cmdline_build(char *dest, const char *src, size_t length)
> +{
> +	if (length <= 0)
> +		return;
> +
> +	dest[0] = 0;
> +
> +#ifdef CONFIG_CMDLINE
> +	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src || !src[0]) {
> +		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
> +		return;
> +	}
> +#endif

CONFIG_CMDLINE_FORCE implies CONFIG_CMDLINE, and even if it didn't,
CONFIG_CMDLINE is at worst an empty string. Can you drop the #ifdef?

> +	if (dest != src)
> +		cmdline_strlcat(dest, src, length);
> +#ifdef CONFIG_CMDLINE
> +	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && sizeof(CONFIG_CMDLINE) > 1)
> +		cmdline_strlcat(dest, " " CONFIG_CMDLINE, length);
> +#endif

Likewise, but also I'm not sure why the sizeof() is required.

Will
