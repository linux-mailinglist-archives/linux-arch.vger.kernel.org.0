Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBB473A6B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 02:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbhLNBqN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 20:46:13 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:33611 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLNBqM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 20:46:12 -0500
X-Greylist: delayed 108911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 20:46:11 EST
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 1BE1jwdd025815;
        Tue, 14 Dec 2021 10:45:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1BE1jwdd025815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639446358;
        bh=8T5YBD0SbT8hN4Yx/A5u1O0M20Sl6k1S2CdKGVz6Y3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZfFrDE1reKOnJzvz0drTawAsKKTP+zomRYHMgD3cPDWF7NyO//w6c/APxI53ohhX1
         mcqo2rms66UlsJvljCalW8PWISakk4ghhWpwYlaOQLjgj6GyAIvjC1XmstxWT7RlTp
         0prmKUVhY0PVcMb31p7YvtpGqpfHBDC7HwTzTV2KjJiYV75IsDwXQUtZhLbmr+4/dd
         jGdpCGQB0qjJ6Agl7M5DAeINdDSFRrEuyCd8W+QFRt+JpVH5fXx1KDW4MHmthOxaCm
         Ewz+z1FadGyRz724kXGbk4tTuVDnqBMSgMdmMthJ1xWBJWE2DD9/lkp+ILlNZlMxiR
         TRCm5NZ6lQX5g==
X-Nifty-SrcIP: [209.85.215.181]
Received: by mail-pg1-f181.google.com with SMTP id r138so16053565pgr.13;
        Mon, 13 Dec 2021 17:45:58 -0800 (PST)
X-Gm-Message-State: AOAM531dujZrONsvDWUiRcH75Vc+VCRp2UHWCEElWK9AgDSGuzQGtfL+
        wSbC9q7qzoGyQHCBnd/DEP63wjFOH62Jg53lUUY=
X-Google-Smtp-Source: ABdhPJxrvr0qnfF5hod7LzeFLaiFe9CTKegtoDEceJuaJKt4xz74aC7K36R71IQSQm3XG4OTdgqZl05U7GLoxJBHw8c=
X-Received: by 2002:a65:430a:: with SMTP id j10mr1684265pgq.126.1639446357619;
 Mon, 13 Dec 2021 17:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20211212192941.1149247-1-masahiroy@kernel.org>
 <20211212192941.1149247-2-masahiroy@kernel.org> <YbdD9nnoZnK0QKeg@buildd.core.avm.de>
In-Reply-To: <YbdD9nnoZnK0QKeg@buildd.core.avm.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Dec 2021 10:45:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxvQ2U3y_eJi8EeO3SNbzVHWBmaAyEN_1rq-TMPfyLHw@mail.gmail.com>
Message-ID: <CAK7LNAQxvQ2U3y_eJi8EeO3SNbzVHWBmaAyEN_1rq-TMPfyLHw@mail.gmail.com>
Subject: Re: [PATCH 01/10] certs: use $@ to simplify the key generation rule
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 13, 2021 at 10:30 PM Nicolas Schier <n.schier@avm.de> wrote:
>
> On Mon, Dec 13, 2021 at 04:29:32AM +0900, Masahiro Yamada wrote:
> > Do not repeat $(obj)/signing_key.pem
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  certs/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/certs/Makefile b/certs/Makefile
> > index a702b70f3cb9..97fd6cc02972 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -61,8 +61,7 @@ keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_c
> >  quiet_cmd_gen_key = GENKEY  $@
> >        cmd_gen_key = openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
> >               -batch -x509 -config $(obj)/x509.genkey \
>
> Don't you want to replace $< too?

Ah, goot catch! Thanks.

I will change it as well.




> Reviewed-by: Nicolas Schier <n.schier@avm.de>
>
> > -             -outform PEM -out $(obj)/signing_key.pem \
> > -             -keyout $(obj)/signing_key.pem $(keytype-y) 2>&1
> > +             -outform PEM -out $@ -keyout $@ $(keytype-y) 2>&1
> >
> >  $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
> >       $(call if_changed,gen_key)
> > --
> > 2.32.0
> >



--
Best Regards
Masahiro Yamada
