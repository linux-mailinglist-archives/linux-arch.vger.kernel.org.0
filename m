Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5813489792
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 12:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbiAJLe5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 06:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbiAJLdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 06:33:43 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9EC06173F;
        Mon, 10 Jan 2022 03:33:43 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 12:33:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1641814422; bh=XG9BZJmAJm/7NC3n+YXym4mKShOcMCyZvVKbkJznbIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPCpmBo+XP5CP09wWHzdop+3U3TFZeaD4fIDt4PAXAKLcsyIflGoDboHs2kzenQqZ
         p0tuL4+jPtAqUnfgIE53YZuw5qXDlukJj7ZMrKHuA1/murRQ0fIh6OZ6By8y/Vx7C9
         yLHnDl/lubk0WYzKwOvbwyDQUhNH3WPVAFR32YBw=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id B22A680514;
        Mon, 10 Jan 2022 12:33:41 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:33:40 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/5] kbuild: add cmd_file_size
Message-ID: <YdwZlGx8+6BtkE22@buildd.core.avm.de>
References: <20220109181529.351420-1-masahiroy@kernel.org>
 <20220109181529.351420-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109181529.351420-5-masahiroy@kernel.org>
X-purgate-ID: 149429::1641814422-00001F4B-25A467EF/0/0
X-purgate-type: clean
X-purgate-size: 1589
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 03:15:29AM +0900, Masahiro Yamada wrote:
> Some architectures support self-extracting kernel, which embeds the
> compressed vmlinux.
> 
> It has 4 byte data at the end so the decompressor can know the vmlinux
> size beforehand.
> 
> GZIP natively has it in the trailer, but for the other compression
> algorithms, the hand-crafted trailer is added.
> 
> It is unneeded to generate such _corrupted_ compressed files because
> it is possible to pass the size data separately.
> 
> For example, the assembly code:
> 
>      .incbin "compressed-vmlinux-with-size-data-appended"
> 
> can be transformed to:
> 
>      .incbin "compressed-vmlinux"
>      .incbin "size-data"
> 
> My hope is, after some reworks of the decompressors, the macros
> cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22} will go away.
> 
> This new macro, cmd_file_size, will be useful to generate a separate
> size-data file.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  scripts/Makefile.lib | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 4207a72d429f..05ca77706f6b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -394,6 +394,9 @@ printf "%08x\n" $$dec_size |						\
>  	}								\
>  )
>  
> +quiet_cmd_file_size = GEN     $@
> +      cmd_file_size = $(size_append) > $@
> +
>  quiet_cmd_bzip2 = BZIP2   $@
>        cmd_bzip2 = cat $(real-prereqs) | $(KBZIP2) -9 > $@
>  
> -- 
> 2.32.0
> 
