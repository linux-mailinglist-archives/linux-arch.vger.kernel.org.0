Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEF472D39
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 14:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhLMN1R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 08:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhLMN1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 08:27:16 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADECC061574;
        Mon, 13 Dec 2021 05:27:16 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 13 Dec 2021 14:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639402033; bh=EQE8WzySYHcpssz4ldGn0q583iyG+myzil/ydlXGiOo=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=HGRKMpX8lQm0RM9G+HopxM/ecIsqyIaT5tdQ75CoV1bjD8hQLEM4eL+vbrWEonDy2
         2s3cN+0GxiML6b1wxBuxvr3Yt2Ltgy6bLboJO67I2UeH7TP2Leursj+H3OFXpoHwqX
         6ya7g3pOEHgase5GCPtXXFlON2YWmma73ISC+uTk=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id CA2B58048E;
        Mon, 13 Dec 2021 14:27:12 +0100 (CET)
Received: from mail.avm.de ([212.42.244.94])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021121314133553-9308 ;
          Mon, 13 Dec 2021 14:13:35 +0100 
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail.avm.de (Postfix) with ESMTP
        for <n.schier@avm.de>; Mon, 13 Dec 2021 14:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639401215; bh=EQE8WzySYHcpssz4ldGn0q583iyG+myzil/ydlXGiOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ6TaBOB7uLBmwlB8ACkvf5z4B1ao7J0rnQ8KnTFcPfBLjMwTbLQSXdvlZWuLGn5x
         iZRqY9BMhInu+Pue7wJAZvwJkeUCoUWKuEek7/90mnCCbr4CaN42uLm3TTloKnF0Qk
         vuA0AbKVoYbIVZMTlSlAlXG/zgeveniDFm5gaZtM=
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 500711815FD; Mon, 13 Dec 2021 14:13:35 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:13:35 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 06/10] kbuild: stop using config_filename in
 scripts/Makefile.modsign
Message-ID: <YbdG/ye08e5Hw/MH@buildd.core.avm.de>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-7-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212192941.1149247-7-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01,
 2021) at 13.12.2021 14:13:35,  Serialize by http on ANIS1/AVM(Release
 11.0.1FP4|October 01, 2021) at 13.12.2021 14:15:58,    Serialize complete at
 13.12.2021 14:15:58
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Notes-UNID: E2B300B1522848FD0B3ADAD0B4C77966
X-purgate-ID: 149429::1639402032-0000056E-1032BC0E/0/0
X-purgate-type: clean
X-purgate-size: 1326
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 04:29:37AM +0900, Masahiro Yamada wrote:
> Toward the goal of removing the config_filename macro, drop
> the double-quotes and add $(srctree)/ prefix in an ad hoc way.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>
> 
>  scripts/Makefile.modinst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index ff9b09e4cfca..df7e3d578ef5 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -66,9 +66,10 @@ endif
>  # Don't stop modules_install even if we can't sign external modules.
>  #
>  ifeq ($(CONFIG_MODULE_SIG_ALL),y)
> +CONFIG_MODULE_SIG_KEY := $(CONFIG_MODULE_SIG_KEY:"%"=%)
> +sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
>  quiet_cmd_sign = SIGN    $@
> -$(eval $(call config_filename,MODULE_SIG_KEY))
> -      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY) certs/signing_key.x509 $@ \
> +      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(sig-key) certs/signing_key.x509 $@ \
>                   $(if $(KBUILD_EXTMOD),|| true)
>  else
>  quiet_cmd_sign :=
> -- 
> 2.32.0
> 
