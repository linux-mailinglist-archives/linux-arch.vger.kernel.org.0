Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4248978C
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 12:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiAJLeZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 06:34:25 -0500
Received: from mail.avm.de ([212.42.244.120]:52558 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244792AbiAJLdL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jan 2022 06:33:11 -0500
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 12:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1641814376; bh=S/wl00Xao0HVzJ52aNpht4KYTslyk0FTwR5JzlsZwy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIqnbQ4ihVbFXBy3q7sLNtB2QcQvhkD4KpMHcY7xAPw1u7KAMBDfFv6vb4uk+ShPk
         DBYnVgIutjPKzElJO2ragMF0cxqOjZI+MjS35mHSL+RkqwznctSrrtUqw3Spddd1j/
         NA3AfcV9nge1k5yTqHeX9pmSYIgYxphZJHOZLUAQ=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id B8DF480514;
        Mon, 10 Jan 2022 12:32:56 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:32:55 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/5] kbuild: drop $(size_append) from cmd_zstd
Message-ID: <YdwZZ+1RQ5tcQZrt@buildd.core.avm.de>
References: <20220109181529.351420-1-masahiroy@kernel.org>
 <20220109181529.351420-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109181529.351420-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1641814376-00000568-3793358D/0/0
X-purgate-type: clean
X-purgate-size: 1645
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 03:15:26AM +0900, Masahiro Yamada wrote:
> The appended file size is only used by the decompressors, which some
> architectures support.
> 
> As the comment "zstd22 is used for kernel compression" says, cmd_zstd22
> is used in arch/{mips,s390,x86}/boot/compressed/Makefile.
> 
> On the other hand, there is no good reason to append the file size to
> cmd_zstd since it is used for other purposes.
> 
> Actually cmd_zstd is only used in usr/Makefile, where the appended file
> size is rather harmful.
> 
> The initramfs with its file size appended is considered as corrupted
> data, so commit 65e00e04e5ae ("initramfs: refactor the initramfs build
> rules") added 'override size_append := :' to make it no-op.
> 
> As a conclusion, this $(size_append) should not exist here.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>


> 
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index d1f865b8c0cb..5366466ea0e4 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -473,7 +473,7 @@ quiet_cmd_xzmisc = XZMISC  $@
>  # be used because it would require zstd to allocate a 128 MB buffer.
>  
>  quiet_cmd_zstd = ZSTD    $@
> -      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } > $@
> +      cmd_zstd = cat $(real-prereqs) | $(ZSTD) -19 > $@
>  
>  quiet_cmd_zstd22 = ZSTD22  $@
>        cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
> -- 
> 2.32.0
> 
