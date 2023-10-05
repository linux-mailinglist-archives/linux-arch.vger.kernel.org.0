Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E97B9929
	for <lists+linux-arch@lfdr.de>; Thu,  5 Oct 2023 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjJEAN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 20:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjJEAN2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 20:13:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3FD8;
        Wed,  4 Oct 2023 17:13:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692c02adeefso324927b3a.3;
        Wed, 04 Oct 2023 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696464804; x=1697069604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqakhanUkyXE0xPicMEDIve3RCLeYDmd6tYI+qxvuGI=;
        b=jQCxzsZFDI/kG0/1a1abjao+wn3b3n5FL0E06jkXNvgj/HeYUayTgWWNUU0AhKBP62
         iH94Kn2rDJlwiat3xA17SUuJ3BBVRVS76VYLJXUZI1QI5c3KN3tjEf1yUG9Q6eN7V3VI
         bhB0GIvll114RHUuuURieo5zRs90+n5aAiw4hBi2UzhyFdgTQwWPdpxkEabz8Vct4kUZ
         C/Z3vk111e5TfpfQCRaUdtjL01auQMuMUPOYL2cGX5zOWdzCQPlAIcumFiaX2Dn2f+lp
         dsn8QJbdENYtzN/V2g2E+Ut8M3L7W1NN+uRZ4IXe+FsT1CB3Vf+LLrTQcAMbJ8wO7u2r
         l5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696464804; x=1697069604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqakhanUkyXE0xPicMEDIve3RCLeYDmd6tYI+qxvuGI=;
        b=VfFaO08zInF5GnPFF+EHeemTWbOQ34IKHJS+0AOTOTmXK3CSjs1Gsgjh1bMgcg2qvR
         5C8a7LW2Vpx4t8t1w+8oEGf9O6BV08gXUMVSvKbwnNjEWEYLfIM/nn4+ED+R2067CvOH
         CYkOtfcIWT1wXnunnhf9GyKDrbMQyybTQFzZd1oSgZTdCINfE1KG1cxtg+t1dObd1UQJ
         54tYeJWJebKIYhqH66gPLkqFK9DsTvp8RQcidC9zFIEA9lzt0tAJ3FCdIDaZ0ysm2LZ/
         N7FMJBiobFMuTwIHgybXWWv0hAmTaFZY1z/ZO4JyL7i8xGQZfyI/zORSSQfizJLxT+8o
         TTYw==
X-Gm-Message-State: AOJu0YxCZQSWiG2wQu7zeyHJKNSv5UyRGf0E6zifcnVHdG6pX0oVjC38
        4gQ7H2iqH4zpdXdhjHVLMJWsXYkIbVk=
X-Google-Smtp-Source: AGHT+IHIwFlvB45+yzceWHMTWIgLMaG0BJtUWIPRq5vAnAJGf8k4ZlJVldPc1gAL5tyGmDlxeKYlBw==
X-Received: by 2002:a05:6a20:32aa:b0:15e:10e:2cc3 with SMTP id g42-20020a056a2032aa00b0015e010e2cc3mr2952450pzd.60.1696464803576;
        Wed, 04 Oct 2023 17:13:23 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001b891259eddsm154267pls.197.2023.10.04.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 17:13:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4E388A6F5E91; Thu,  5 Oct 2023 07:13:19 +0700 (WIB)
Date:   Thu, 5 Oct 2023 07:13:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "KaiLong Wang" <wangkailong@jari.cn>, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds.h: Clean up errors in vmlinux.lds.h
Message-ID: <ZR3_nt646ijkV3UJ@debian.me>
References: <72e80688.8a8.18ad9bba905.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bEqKWIA1685n+LKp"
Content-Disposition: inline
In-Reply-To: <72e80688.8a8.18ad9bba905.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--bEqKWIA1685n+LKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:01:08AM +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
>=20
> ERROR: spaces required around that ':' (ctx:WxV)
> ERROR: space required after that ',' (ctx:VxO)
> ERROR: need consistent spacing around '*' (ctx:VxW)
>=20
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>  include/asm-generic/vmlinux.lds.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 9c59409104f6..9e19234bbf97 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -63,8 +63,8 @@
>   * up in the PT_NOTE Program Header.
>   */
>  #ifdef EMITS_PT_NOTE
> -#define NOTES_HEADERS		:text :note
> -#define NOTES_HEADERS_RESTORE	__restore_ph : { *(.__restore_ph) } :text
> +#define NOTES_HEADERS : text : note
> +#define NOTES_HEADERS_RESTORE	__restore_ph : { *(.__restore_ph) } : text

Personally I prefer macro arguments to be aligned.

>  #else
>  #define NOTES_HEADERS
>  #define NOTES_HEADERS_RESTORE
> @@ -98,10 +98,10 @@
>   */
>  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_=
CLANG)
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundlit=
eral* .data.$__unnamed_* .data.$L*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_] * .data..L * .data..compoundl=
iteral * .data.$__unnamed_ * .data.$L*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> -#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
> -#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> +#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_] * .rodata..L*
> +#define BSS_MAIN .bss .bss.[0-9a-zA-Z_] * .bss..compoundliteral*
>  #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*

Is it taking a pointer or changing to multiplication?

>  #else
>  #define TEXT_MAIN .text
> @@ -462,7 +462,7 @@
>  	. =3D ALIGN((align));						\
>  	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
>  		__start_rodata =3D .;					\
> -		*(.rodata) *(.rodata.*)					\
> +		*(.rodata) * (.rodata.*)					\
>  		SCHED_DATA						\
>  		RO_AFTER_INIT_DATA	/* Read only after init */	\
>  		. =3D ALIGN(8);						\
> @@ -494,28 +494,28 @@
>  	/* Kernel symbol table: Normal symbols */			\
>  	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
>  		__start___ksymtab =3D .;					\
> -		KEEP(*(SORT(___ksymtab+*)))				\
> +		KEEP(*(SORT(___ksymtab+ *)))				\
>  		__stop___ksymtab =3D .;					\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-only symbols */			\
>  	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
>  		__start___ksymtab_gpl =3D .;				\
> -		KEEP(*(SORT(___ksymtab_gpl+*)))				\
> +		KEEP(*(SORT(___ksymtab_gpl+ *)))			\
>  		__stop___ksymtab_gpl =3D .;				\
>  	}								\
>  									\
>  	/* Kernel symbol table: Normal symbols */			\
>  	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
>  		__start___kcrctab =3D .;					\
> -		KEEP(*(SORT(___kcrctab+*)))				\
> +		KEEP(*(SORT(___kcrctab+ *)))				\
>  		__stop___kcrctab =3D .;					\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-only symbols */			\
>  	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
>  		__start___kcrctab_gpl =3D .;				\
> -		KEEP(*(SORT(___kcrctab_gpl+*)))				\
> +		KEEP(*(SORT(___kcrctab_gpl+ *)))			\
>  		__stop___kcrctab_gpl =3D .;				\
>  	}								\

Same here.

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--bEqKWIA1685n+LKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZR3/mAAKCRD2uYlJVVFO
oxvuAQCkXx9+njnvII0+xKHGRERMrYm8sxrQQXTQ3J6EHyC8dQEAlc3kXaAJwrV9
I8WIium3NvzhTHvv8hayacA5UwGjgAA=
=dqD1
-----END PGP SIGNATURE-----

--bEqKWIA1685n+LKp--
