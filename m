Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB63472D5F
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhLMNeJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 08:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbhLMNeJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 08:34:09 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800EC061574;
        Mon, 13 Dec 2021 05:34:08 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 13 Dec 2021 14:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639402447; bh=+dc+6tzjoJlOfZESnyJg2NqDO3PbqPjD88TylPg6x5k=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=SzZaJ5tLj1HxI2FEQih/A25O/XUYNpgVvBx52UGZbsOWfjqcebHpSptR3apELzcPv
         gxok7saAO/8r//Z3F1NcEo89laOi52XCD+942oGQaUgaku+TV87SSdroBal0Ce/UJ5
         DyErhYCLDjWl7SjoF4WU5gi2yPU9Tl7yMXwzZdzY=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 999C6804FF;
        Mon, 13 Dec 2021 14:34:06 +0100 (CET)
Received: from mail.avm.de ([212.42.244.94])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021121314180464-9437 ;
          Mon, 13 Dec 2021 14:18:04 +0100 
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail.avm.de (Postfix) with ESMTP
        for <n.schier@avm.de>; Mon, 13 Dec 2021 14:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639401484; bh=+dc+6tzjoJlOfZESnyJg2NqDO3PbqPjD88TylPg6x5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkxnHO7efqzBwu0hVQr4I/ucyG/8H1A5y14vlw5itwwwAZC5GL7ZPWXNvIbWvRc26
         aQlxV+E4eRK6Sl+9KWDSUG1Q6v6PmuZAoZcZupEuyxRRRzriX+p7xQbQI73RPlr9ud
         Vp/vQtgs7NnVDWh84tVo4n5Z0cVkDsAWvJdhFaXM=
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 7BD9A18176D; Mon, 13 Dec 2021 14:18:04 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:18:04 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 10/10] microblaze: use built-in function to get
 CPU_{MAJOR,MINOR,REV}
Message-ID: <YbdIDBIPz/Yyi2cw@buildd.core.avm.de>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-11-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212192941.1149247-11-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01,
 2021) at 13.12.2021 14:18:04,  Serialize by http on ANIS1/AVM(Release
 11.0.1FP4|October 01, 2021) at 13.12.2021 14:18:58,    Serialize complete at
 13.12.2021 14:18:58
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Notes-UNID: 07DBF18074CC90F87F10266110A523D0
X-purgate-ID: 149429::1639402447-0000056E-41EE63CB/0/0
X-purgate-type: clean
X-purgate-size: 1161
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 04:29:41AM +0900, Masahiro Yamada wrote:
> Use built-in functions instead of shell commands to avoid forking
> processes.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  arch/microblaze/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index a25e76d89e86..1826d9ce4459 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -6,9 +6,9 @@ UTS_SYSNAME = -DUTS_SYSNAME=\"Linux\"
>  # What CPU version are we building for, and crack it open
>  # as major.minor.rev
>  CPU_VER   := $(CONFIG_XILINX_MICROBLAZE0_HW_VER)
> -CPU_MAJOR := $(shell echo $(CPU_VER) | cut -d '.' -f 1)
> -CPU_MINOR := $(shell echo $(CPU_VER) | cut -d '.' -f 2)
> -CPU_REV   := $(shell echo $(CPU_VER) | cut -d '.' -f 3)
> +CPU_MAJOR := $(word 1, $(subst ., , $(CPU_VER)))
> +CPU_MINOR := $(word 2, $(subst ., , $(CPU_VER)))
> +CPU_REV   := $(word 3, $(subst ., , $(CPU_VER)))
>  
>  export CPU_VER CPU_MAJOR CPU_MINOR CPU_REV
>  
> -- 
> 2.32.0
> 
