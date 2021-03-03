Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A032C86B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbhCDAtU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhCCSTy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 13:19:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3362B64EE4;
        Wed,  3 Mar 2021 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614795549;
        bh=NjwTlWy1k6yXupvkqZegpDvzpV/TRs/7ew8URhwgtUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsC2fbS9rQAO2hD2Z/yCr9LuMJtbm2bfCzYX97TI419zAr/flPuPAHHc64agNY2ZB
         SV7PwlrUO/QiP1YrVCG82VfY2l5QBHA+eEDd3pR0LyfhdZsDZRCVwM1t+co/ujs0+s
         mgSXtct53qUHbmjbdVTh/nYOf9Iur+vqVP0tKD3PNSCpPp1r3pblTfALc9QJINy5Q8
         vM3nwe1p8O/oXPMt2mSb3NIxR3NDk8ZvGdnZ5OMkmdsXY544Aca10kMIH9UmaJks+p
         nYhxICCrjCWSjTn/fS2QGHONjATwtnRMakOfVvffjl3MJFYzAmJRXoLbvTGDjjWAYF
         YQcyyS57yAf6w==
Date:   Wed, 3 Mar 2021 18:19:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cmdline: Add capability to prepend the command
 line
Message-ID: <20210303181903.GF19713@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <e1a498d02d47ec2420b404bd5f3e4a00fc628532.1614705851.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a498d02d47ec2420b404bd5f3e4a00fc628532.1614705851.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 05:25:20PM +0000, Christophe Leroy wrote:
> This patchs adds an option of prepend a text to the command
> line instead of appending it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/cmdline.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> index ae3610bb0ee2..144346051e01 100644
> --- a/include/linux/cmdline.h
> +++ b/include/linux/cmdline.h
> @@ -31,7 +31,7 @@ static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_
>  }
>  
>  /*
> - * This function will append a builtin command line to the command
> + * This function will append or prepend a builtin command line to the command
>   * line provided by the bootloader. Kconfig options can be used to alter
>   * the behavior of this builtin command line.
>   * @dest: The destination of the final appended/prepended string.
> @@ -50,6 +50,9 @@ static __always_inline void cmdline_build(char *dest, const char *src, size_t le
>  		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
>  		return;
>  	}
> +
> +	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND) && sizeof(CONFIG_CMDLINE) > 1)
> +		cmdline_strlcat(dest, CONFIG_CMDLINE " ", length);

Same comment as the other patch: I don't think we need to worry about the
sizeof() here.

Will
