Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0732C869
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhCDAtT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244869AbhCCSNR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 13:13:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A1064EDC;
        Wed,  3 Mar 2021 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614793169;
        bh=7MVw5UDEd1Xvs+II9tNU1UACiyEi/PQdUEbmoIFcK6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XENxLR/0Wum5UkY2MnJTucpt2FDgT/0cITCxXkBT1SmguNemOxTJR7z3vpRT6GexG
         OhkxkpgSVSkw1mCsleAFoNDbOldAVdI7hFx9PvgkglRoBOKJtYo6ASvgGk0fB/H6N4
         QGP3PIB7sd+LG6lmPmjjPk1F6feMc5NGQrKdjfKaCeUmIE4cR5G1LFE9aLMJIDZzGu
         Xie+YDBcOIes+S0L1l+fg1XYmkzNmN1Zzc7eazCNYYfjjySr5vjPbdn5CbRRKb8CXX
         zwGV34z/YzVLb79eujME7s3rxBqfmwn24opeawzXD2+BpwLT3RJYewNl+nK9WSHC5X
         wgQ9dTUwA5Fng==
Date:   Wed, 3 Mar 2021 17:39:24 +0000
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
Message-ID: <20210303173923.GB19713@willie-the-truck>
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

Sorry, spotted a couple of other things...

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

length is unsigned

> +
> +	dest[0] = 0;
> +
> +#ifdef CONFIG_CMDLINE
> +	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src || !src[0]) {
> +		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
> +		return;
> +	}
> +#endif
> +	if (dest != src)

The kernel-doc says that @src "Must not equal dest".

Will
