Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4D5EDE33
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiI1Nxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiI1Nxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 09:53:41 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C47786C9;
        Wed, 28 Sep 2022 06:53:36 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28SDrNKs023141;
        Wed, 28 Sep 2022 22:53:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28SDrNKs023141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664373204;
        bh=vkTBDrLr+gSufE4juAwoGOnL+v5TpMQd9Yf1dOOyAlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gi7dnhj2nQnit3b/guZ+qZAtmsI2UyVy5RJMJBfcbyuDZf5J96a04A6b/EjKYR4a8
         wXBy7ge82hp2ocrzXYCYKTPtzKteG/dVWZcH+XfH6wSUpWVqloOLiyWelWf0GCsjiK
         enmNCh8nGp9Ib0RDAVRmS09OgkSwNy2sUYrVj7vLu3L7wBXPkFQdBX/nNbhsAsyI3T
         BMOoyTL29Z//aWonBC/8UrrldVr/NZQRkLtk7DNaGVSInhv8gVsSbTLz/CxytsOMDI
         RXvuFn3Y2x+gCy1yWvRB23FQPvp1BkncOMkTkztFrxu5fhO+DRSNE+vNrpSZ31gX8O
         tXZkh8BFV2qTw==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12803ac8113so17350060fac.8;
        Wed, 28 Sep 2022 06:53:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ygWZyY0/An+0f3UICl8fwIMHFynLDbjTbMdCN0h9NdmT00H4t
        E17oxvH+91z55OEWa4H2ToT0NZR4EqFzACMAc8k=
X-Google-Smtp-Source: AMsMyM4SwXr39hWrhV2jlwLsIq7xsRglwAQ3lU3A0QYTQ6046/z0prPzH2+3QIrGInbvIoFsdlz7vAZB/75K7rBW+lw=
X-Received: by 2002:a05:6870:6326:b0:131:9200:c99d with SMTP id
 s38-20020a056870632600b001319200c99dmr3805771oao.194.1664373203265; Wed, 28
 Sep 2022 06:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220928063947.299333-1-masahiroy@kernel.org> <20220928063947.299333-7-masahiroy@kernel.org>
 <06cf88841dfb48d8ba89dd22adcd1db9@AcuMS.aculab.com>
In-Reply-To: <06cf88841dfb48d8ba89dd22adcd1db9@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 28 Sep 2022 22:52:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATo0uzbBy+90dX==jjwZ-0da=tS1FfvDJedQU0dSfW++A@mail.gmail.com>
Message-ID: <CAK7LNATo0uzbBy+90dX==jjwZ-0da=tS1FfvDJedQU0dSfW++A@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] modpost: use null string instead of NULL pointer
 for default namespace
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 28, 2022 at 6:53 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Masahiro Yamada
> > Sent: 28 September 2022 07:40
> >
> > The default namespace is the null string, "".
> >
> > When set, the null string "" is converted to NULL:
> >
> >   s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
> >
> > When printed, the NULL pointer is get back to the null string:
> >
> >   sym->namespace ?: ""
> >
> > This saves 1 byte memory allocated for "", but loses the readability.
>
> The code size changes are far larger that any data sizes.
>
> > In kernel-space, we strive to save memory, but modpost is a userspace
> > tool used to build the kernel. On modern systems, such small piece of
> > memory is not a big deal.
> >
> > Handle the namespace string as is.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >
> > (no changes since v1)
> >
> >  scripts/mod/modpost.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 0bb5bbd176b4..29f30558a398 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -297,6 +297,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
> >  {
> >       struct namespace_list *list;
> >
> > +     /*
> > +      * The default namespace is null string "", which is always implicitly
> > +      * contained.
> > +      */
> > +     if (!namespace[0])
> > +             return true;
> > +
> >       list_for_each_entry(list, head, list) {
> >               if (!strcmp(list->namespace, namespace))
> >                       return true;
> > @@ -366,7 +373,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
> >       s = alloc_symbol(name);
> >       s->module = mod;
> >       s->is_gpl_only = gpl_only;
> > -     s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
> > +     s->namespace = NOFAIL(strdup(namespace));
> >       list_add_tail(&s->list, &mod->exported_symbols);
> >       hash_add_symbol(s);
> >
> > @@ -1928,8 +1935,7 @@ static void check_exports(struct module *mod)
> >               else
> >                       basename = mod->name;
> >
> > -             if (exp->namespace &&
> > -                 !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
> > +             if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {
>
> Do you still need to optimise/check for the default namespace?



I am not sure if I understood your comment, but
I changed the contains_namespace() body so that
contains_namespace(&mod->imported_namespaces, "")
returns true.











>         David
>
> >                       modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
> >                                   "module %s uses symbol %s from namespace %s, but does not import it.\n",
> >                                   basename, exp->name, exp->namespace);
> > @@ -2015,8 +2021,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
> >       list_for_each_entry(sym, &mod->exported_symbols, list)
> >               buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
> >                          sym->is_func ? "FUNC" : "DATA", sym->name,
> > -                        sym->is_gpl_only ? "_gpl" : "",
> > -                        sym->namespace ?: "");
> > +                        sym->is_gpl_only ? "_gpl" : "", sym->namespace);
> >
> >       if (!modversions)
> >               return;
> > @@ -2284,7 +2289,7 @@ static void write_dump(const char *fname)
> >                       buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
> >                                  sym->crc, sym->name, mod->name,
> >                                  sym->is_gpl_only ? "_GPL" : "",
> > -                                sym->namespace ?: "");
> > +                                sym->namespace);
> >               }
> >       }
> >       write_buf(&buf, fname);
> > --
> > 2.34.1
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Best Regards
Masahiro Yamada
