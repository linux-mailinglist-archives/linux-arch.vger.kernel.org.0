Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79A4472D22
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 14:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhLMNX5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 08:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhLMNX4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 08:23:56 -0500
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Dec 2021 05:23:56 PST
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612BC061574;
        Mon, 13 Dec 2021 05:23:56 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 13 Dec 2021 14:23:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639401834; bh=UL7R1cXd59fb63aQbLKzvJrfMdZNkVMOW+WjYF0O2lE=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=LnK1S9W2lDaDMjL3JsmNWe9zklp+3oEQVGRoQCFweNE4VX6vQSINp1cWtnCBMjqfl
         k5VtwaDpOSp4oAVihVCDLpemqAU9VGojeZwCuCNkE2RJWeOF3Dxc7ktXKkNxjnnek0
         F12tlSyg8aIgzo5po4noAQQhTkG65l+6RjNoGpYY=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 66EAA8048E;
        Mon, 13 Dec 2021 14:23:54 +0100 (CET)
Received: from mail.avm.de ([212.42.244.120])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021121314075056-9118 ;
          Mon, 13 Dec 2021 14:07:50 +0100 
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail.avm.de (Postfix) with ESMTP
        for <n.schier@avm.de>; Mon, 13 Dec 2021 14:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639400870; bh=UL7R1cXd59fb63aQbLKzvJrfMdZNkVMOW+WjYF0O2lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFcXzraGo7wfo7p42UVDEm65E53pV5/RXMFap05JhCIVmT/kfabzzDcGY/Kv3HjEL
         u3wSoGScAoWmxB+y7e7Mro1QiGwKTX7liXgERsBEotrwOUJj+S9Ca7OSL1C94sfU1d
         YeaYvShhYmfGDnCEmvsETeu4UpL7VfTtW7peWl2E=
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 6CE28181273; Mon, 13 Dec 2021 14:07:50 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:07:50 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 02/10] certs: unify duplicated cmd_extract_certs and
 improve the log
Message-ID: <YbdFplCZHvzeOON+@buildd.core.avm.de>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-3-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212192941.1149247-3-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01,
 2021) at 13.12.2021 14:07:50,  Serialize by http on ANIS1/AVM(Release
 11.0.1FP4|October 01, 2021) at 13.12.2021 14:09:57,    Serialize complete at
 13.12.2021 14:09:57
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Notes-UNID: 43EAD04059685BA508288FD257D3054C
X-purgate-ID: 149429::1639401834-0000060F-81CC5DBE/0/0
X-purgate-type: clean
X-purgate-size: 2784
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 04:29:33AM +0900, Masahiro Yamada wrote:
> cmd_extract_certs is defined twice. Unify them.
> 
> The current log shows the input file $(2), which might be empty.
> You cannot know what is being created from the log, "EXTRACT_CERTS".
> 
> Change the log to show the output file with better alignment.
> 
> [Before]
> 
>   EXTRACT_CERTS   certs/signing_key.pem
>   CC      certs/system_keyring.o
>   EXTRACT_CERTS
>   AS      certs/system_certificates.o
>   CC      certs/common.o
>   CC      certs/blacklist.o
>   EXTRACT_CERTS
>   AS      certs/revocation_certificates.o
> 
> [After]
> 
>   CERT    certs/signing_key.x509
>   CC      certs/system_keyring.o
>   CERT    certs/x509_certificate_list
>   AS      certs/system_certificates.o
>   CC      certs/common.o
>   CC      certs/blacklist.o
>   CERT    certs/x509_revocation_list
>   AS      certs/revocation_certificates.o
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  certs/Makefile | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index 97fd6cc02972..945e53d90d38 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -12,6 +12,9 @@ else
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>  endif
>  
> +quiet_cmd_extract_certs  = CERT    $@
> +      cmd_extract_certs  = scripts/extract-cert $(2) $@
> +
>  ifeq ($(CONFIG_SYSTEM_TRUSTED_KEYRING),y)
>  
>  $(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
> @@ -22,9 +25,6 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>  # Cope with signing_key.x509 existing in $(srctree) not $(objtree)
>  AFLAGS_system_certificates.o := -I$(srctree)
>  
> -quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
> -      cmd_extract_certs  = scripts/extract-cert $(2) $@
> -
>  targets += x509_certificate_list
>  $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
>  	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
> @@ -98,9 +98,6 @@ $(eval $(call config_filename,SYSTEM_REVOCATION_KEYS))
>  
>  $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
>  
> -quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
> -      cmd_extract_certs  = scripts/extract-cert $(2) $@
> -
>  targets += x509_revocation_list
>  $(obj)/x509_revocation_list: scripts/extract-cert $(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(SYSTEM_REVOCATION_KEYS_FILENAME) FORCE
>  	$(call if_changed,extract_certs,$(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_REVOCATION_KEYS))
> -- 
> 2.32.0
> 
