Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBFD472D28
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 14:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhLMNYn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 08:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLMNYn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 08:24:43 -0500
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540FAC061574;
        Mon, 13 Dec 2021 05:24:42 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 13 Dec 2021 14:24:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639401880; bh=rpBcTbI89fdBl8Id1HhmqKBB4mdlBjF/nWszlx5+mX0=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=eVg07f0shr+WDqgkJ7l7NHO/styfyiQfmPflL+xw3ljwG3ndimOpoT50WkpOuLfzB
         mrkDCTcbWFJBSuiJAa4atPJvKWEo7BrGdziww4bCmM3zPfJTGtZDlIyhZjEUTIVzYz
         LICv/Yj+VZHcA+tgObYV5giG6dg8TJs7w9kwTHM8=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 56C568048E;
        Mon, 13 Dec 2021 14:24:40 +0100 (CET)
Received: from mail.avm.de ([212.42.244.120])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021121314082259-9123 ;
          Mon, 13 Dec 2021 14:08:22 +0100 
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail.avm.de (Postfix) with ESMTP
        for <n.schier@avm.de>; Mon, 13 Dec 2021 14:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639400902; bh=rpBcTbI89fdBl8Id1HhmqKBB4mdlBjF/nWszlx5+mX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKDie9yId/tqCAmheDRidUDbXA3WZH2/aNOr9r+2WBv9Rjevrpw2bsrlQ7luSb039
         9ys5KSTOyBLZ7s7wQiltoF9a4Ejv2OdBMxotk/lApz7tFi+IR5m9zIjc0zpwow3HqD
         OpKTQApV2Vacoe5MjL3jvuzWGXBhVLRlIyWl5mMs=
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 39FDF18176D; Mon, 13 Dec 2021 14:08:22 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:08:22 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 04/10] certs: refactor file cleaning
Message-ID: <YbdFxjAH1bhsgY2n@buildd.core.avm.de>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-5-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212192941.1149247-5-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01,
 2021) at 13.12.2021 14:08:22,  Serialize by http on ANIS1/AVM(Release
 11.0.1FP4|October 01, 2021) at 13.12.2021 14:09:57,    Serialize complete at
 13.12.2021 14:09:57
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Notes-UNID: F5EE2750E2920655303506B402BE995B
X-purgate-ID: 149429::1639401880-00001F4B-58A04AD6/0/0
X-purgate-type: clean
X-purgate-size: 2957
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 04:29:35AM +0900, Masahiro Yamada wrote:
> 'make clean' removes files listed in 'targets'. It is redundant to
> specify both 'targets' and 'clean-files'.
> 
> Move 'targets' assignments out of the ifeq-conditionals so
> scripts/Makefile.clean can see them.
> 
> One effective change is that certs/certs/signing_key.x509 is now
> deleted by 'make clean' instead of 'make mrproper. This certificate
> is embedded in the kernel. It is not used in any way by external
> module builds.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>
> 
>  Makefile       | 2 +-
>  certs/Makefile | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 0a6ecc8bb2d2..4e8ac0730f51 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1503,7 +1503,7 @@ MRPROPER_FILES += include/config include/generated          \
>  		  debian snap tar-install \
>  		  .config .config.old .version \
>  		  Module.symvers \
> -		  certs/signing_key.pem certs/signing_key.x509 \
> +		  certs/signing_key.pem \
>  		  certs/x509.genkey \
>  		  vmlinux-gdb.py \
>  		  *.spec
> diff --git a/certs/Makefile b/certs/Makefile
> index e7d6ee183496..0dc523e8ca7c 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -22,12 +22,11 @@ $(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
>  # GCC doesn't include .incbin files in -MD generated dependencies (PR#66871)
>  $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>  
> -targets += x509_certificate_list
>  $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
>  	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
>  endif # CONFIG_SYSTEM_TRUSTED_KEYRING
>  
> -clean-files := x509_certificate_list .x509.list x509_revocation_list
> +targets += x509_certificate_list
>  
>  ifeq ($(CONFIG_MODULE_SIG),y)
>  	SIGN_KEY = y
> @@ -84,18 +83,20 @@ endif
>  # GCC PR#66871 again.
>  $(obj)/system_certificates.o: $(obj)/signing_key.x509
>  
> -targets += signing_key.x509
>  $(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
>  	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
>  endif # CONFIG_MODULE_SIG
>  
> +targets += signing_key.x509
> +
>  ifeq ($(CONFIG_SYSTEM_REVOCATION_LIST),y)
>  
>  $(eval $(call config_filename,SYSTEM_REVOCATION_KEYS))
>  
>  $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
>  
> -targets += x509_revocation_list
>  $(obj)/x509_revocation_list: scripts/extract-cert $(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(SYSTEM_REVOCATION_KEYS_FILENAME) FORCE
>  	$(call if_changed,extract_certs,$(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_REVOCATION_KEYS))
>  endif
> +
> +targets += x509_revocation_list
> -- 
> 2.32.0
> 
