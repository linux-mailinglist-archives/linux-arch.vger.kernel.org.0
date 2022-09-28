Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF965ED993
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiI1JzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 28 Sep 2022 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiI1Jy4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 05:54:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F74AB420
        for <linux-arch@vger.kernel.org>; Wed, 28 Sep 2022 02:53:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-57-4AXFK-2tOtOGBa0m-7JKrw-1; Wed, 28 Sep 2022 10:53:29 +0100
X-MC-Unique: 4AXFK-2tOtOGBa0m-7JKrw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 28 Sep
 2022 10:53:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 28 Sep 2022 10:53:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michal Marek" <michal.lkml@markovi.net>
Subject: RE: [PATCH v3 6/8] modpost: use null string instead of NULL pointer
 for default namespace
Thread-Topic: [PATCH v3 6/8] modpost: use null string instead of NULL pointer
 for default namespace
Thread-Index: AQHY0wWSIlQw/El0SkCvsnOrFVUd1K30meQQ
Date:   Wed, 28 Sep 2022 09:53:26 +0000
Message-ID: <06cf88841dfb48d8ba89dd22adcd1db9@AcuMS.aculab.com>
References: <20220928063947.299333-1-masahiroy@kernel.org>
 <20220928063947.299333-7-masahiroy@kernel.org>
In-Reply-To: <20220928063947.299333-7-masahiroy@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada
> Sent: 28 September 2022 07:40
> 
> The default namespace is the null string, "".
> 
> When set, the null string "" is converted to NULL:
> 
>   s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
> 
> When printed, the NULL pointer is get back to the null string:
> 
>   sym->namespace ?: ""
> 
> This saves 1 byte memory allocated for "", but loses the readability.

The code size changes are far larger that any data sizes.

> In kernel-space, we strive to save memory, but modpost is a userspace
> tool used to build the kernel. On modern systems, such small piece of
> memory is not a big deal.
> 
> Handle the namespace string as is.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> 
> (no changes since v1)
> 
>  scripts/mod/modpost.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0bb5bbd176b4..29f30558a398 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -297,6 +297,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
>  {
>  	struct namespace_list *list;
> 
> +	/*
> +	 * The default namespace is null string "", which is always implicitly
> +	 * contained.
> +	 */
> +	if (!namespace[0])
> +		return true;
> +
>  	list_for_each_entry(list, head, list) {
>  		if (!strcmp(list->namespace, namespace))
>  			return true;
> @@ -366,7 +373,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
>  	s = alloc_symbol(name);
>  	s->module = mod;
>  	s->is_gpl_only = gpl_only;
> -	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
> +	s->namespace = NOFAIL(strdup(namespace));
>  	list_add_tail(&s->list, &mod->exported_symbols);
>  	hash_add_symbol(s);
> 
> @@ -1928,8 +1935,7 @@ static void check_exports(struct module *mod)
>  		else
>  			basename = mod->name;
> 
> -		if (exp->namespace &&
> -		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
> +		if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {

Do you still need to optimise/check for the default namespace?

	David

>  			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
>  				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
>  				    basename, exp->name, exp->namespace);
> @@ -2015,8 +2021,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
>  	list_for_each_entry(sym, &mod->exported_symbols, list)
>  		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
>  			   sym->is_func ? "FUNC" : "DATA", sym->name,
> -			   sym->is_gpl_only ? "_gpl" : "",
> -			   sym->namespace ?: "");
> +			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
> 
>  	if (!modversions)
>  		return;
> @@ -2284,7 +2289,7 @@ static void write_dump(const char *fname)
>  			buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
>  				   sym->crc, sym->name, mod->name,
>  				   sym->is_gpl_only ? "_GPL" : "",
> -				   sym->namespace ?: "");
> +				   sym->namespace);
>  		}
>  	}
>  	write_buf(&buf, fname);
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

