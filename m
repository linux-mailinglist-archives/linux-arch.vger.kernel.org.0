Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A074E472D4D
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhLMNaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 08:30:20 -0500
Received: from mail.avm.de ([212.42.244.119]:38384 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237587AbhLMNaU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Dec 2021 08:30:20 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 08:30:18 EST
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 13 Dec 2021 14:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639401757; bh=IVPImOOLXtr/Bn2m+I26RzZTtMbzBbmsOEwwcqioxxo=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=VLb85zUezabo88THimlI3id0NIrAyDCPJJCOGTrjAd6uIFUo14e4lWwTeez/9KUC7
         6y0GtRl0pZDFcQ/Cv635QAbCyPlPrOS3HpZrCS0WgMRQUSlZ8+mh7nq7fWXlvh9pzy
         /9Nq3fYiTRa+cSIuDtbIWsjD3n39QY8uo7D/6/PA=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 399788048E;
        Mon, 13 Dec 2021 14:22:37 +0100 (CET)
Received: from mail.avm.de ([212.42.244.120])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021121314003867-8912 ;
          Mon, 13 Dec 2021 14:00:38 +0100 
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail.avm.de (Postfix) with ESMTP
        for <n.schier@avm.de>; Mon, 13 Dec 2021 14:00:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639400438; bh=IVPImOOLXtr/Bn2m+I26RzZTtMbzBbmsOEwwcqioxxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL4r0nRquDQ+ddGSE1BE1PtTnjKm6Sr3T/QuLT/lpiUmI0fOmPyV8cu03YK4F8Zxj
         1kHC5tnmyYjo4dvkw/jHpWB+fkEvE/Tcl6Cx3hzga4L8BgE+a+KZFKHdK8pg5f7Uyd
         ugem8/PEv+kjvc9NIGSRuW7vzEt+bsDPjtZKftyY=
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 854321844C6; Mon, 13 Dec 2021 14:00:38 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:00:38 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 01/10] certs: use $@ to simplify the key generation rule
Message-ID: <YbdD9nnoZnK0QKeg@buildd.core.avm.de>
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-2-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212192941.1149247-2-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01,
 2021) at 13.12.2021 14:00:38,  Serialize by http on ANIS1/AVM(Release
 11.0.1FP4|October 01, 2021) at 13.12.2021 14:00:56,    Serialize complete at
 13.12.2021 14:00:56
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Notes-UNID: 4203A2D34AAB4B4A231BFAD29A795EC7
X-purgate-ID: 149429::1639401757-0000056E-E50412BF/0/0
X-purgate-type: clean
X-purgate-size: 1038
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 04:29:32AM +0900, Masahiro Yamada wrote:
> Do not repeat $(obj)/signing_key.pem
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  certs/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index a702b70f3cb9..97fd6cc02972 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -61,8 +61,7 @@ keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_c
>  quiet_cmd_gen_key = GENKEY  $@
>        cmd_gen_key = openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
>  		-batch -x509 -config $(obj)/x509.genkey \

Don't you want to replace $< too?

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> -		-outform PEM -out $(obj)/signing_key.pem \
> -		-keyout $(obj)/signing_key.pem $(keytype-y) 2>&1
> +		-outform PEM -out $@ -keyout $@ $(keytype-y) 2>&1
>  
>  $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
>  	$(call if_changed,gen_key)
> -- 
> 2.32.0
> 
