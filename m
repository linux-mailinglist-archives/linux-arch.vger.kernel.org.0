Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B75ADDCF
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiIFDKu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiIFDKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 23:10:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5753C150;
        Mon,  5 Sep 2022 20:10:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so9458619pgs.3;
        Mon, 05 Sep 2022 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0q5/g2xqSDjoX1m4bFjC22V5UplGI4w9R+6ExEXxELc=;
        b=J64gz2KzhvRwufT6qI2yRk1QrpOGL4+Ijgce9yyEMrmDsic72KQqMzz5Vtc4Fp17KB
         JYbJSC+w+9TMU+8udxawWQFzbsaHx1PvO1a2lqKvpK7Oy6JR6KMnLAa/t4BvuIkKCcZf
         oW3s+shJ+7uFVdUw5KMdokaCSiPpmvQfxe7KRM73c/eT//gSF1M45r/hX4Ge2tLNi3H6
         15OuAmTNQmGf3JDjhn067whU+XpLJmdh21Z959SlZlIdkXRYYQ9r0K+CO07KZi8y+3Gw
         czBRXX0O2iXqJPmzz2eSFNcOThf7Qn32h5GyOyoJR8WDrYQqd5khKlwebxrgqP8ifdfX
         uT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0q5/g2xqSDjoX1m4bFjC22V5UplGI4w9R+6ExEXxELc=;
        b=PPfO4JB6NcowMPJOgsPepFjHFIa3DFhNFmsgjNrf3Vc3us+zw68bU1vSy1/pEo4UeE
         XamVNoGL5RTctesxbE2UrlG99QJMZsn57COhioJpj8PvPiMw00N60QawVKM9LXKl6t/W
         9acH0Ke80NOLg4rKDL76So9E5RyOqsDs2eT4zOZE9iETjBsygz+4sWKbkwu1x0Ue/HS5
         0DCFvuZ27oI/N71H9vUB0WLYXTeDLn93hA4rkSHn4k8sphp/WbuvkGRVQZfWLCcl3BRe
         cPv3755o0TE3dtsBIE8T2W3YB621TyAJaV1ZNyfIRpVcag7yD6BsCHfzh8OarAjNSNGt
         MQXg==
X-Gm-Message-State: ACgBeo1PIo4yiUUPZ3ZQ8sJyVvQRy6NrCs2VUwtmpfQUtGBmL9fCAQqv
        0rUR2jrn5BuxX49kUsyLafI=
X-Google-Smtp-Source: AA6agR4PNdGoLwzIJQfbmesd5qxQF8UnVgpaYg2wB/pPZTvea4YBq8MPq0UxBOfR2LAN/bZWntoBig==
X-Received: by 2002:a05:6a00:1145:b0:52b:78c:fa26 with SMTP id b5-20020a056a00114500b0052b078cfa26mr53065753pfm.27.1662433847595;
        Mon, 05 Sep 2022 20:10:47 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id k12-20020aa79d0c000000b00537d7cc774bsm8583585pfp.139.2022.09.05.20.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 20:10:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 79773103CFD; Tue,  6 Sep 2022 10:10:34 +0700 (WIB)
Date:   Tue, 6 Sep 2022 10:10:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 6/44] kmsan: add ReST documentation
Message-ID: <Yxa6Isgcii+EQWwX@debian.me>
References: <20220905122452.2258262-1-glider@google.com>
 <20220905122452.2258262-7-glider@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8SFVSXRZNTT5RY83"
Content-Disposition: inline
In-Reply-To: <20220905122452.2258262-7-glider@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--8SFVSXRZNTT5RY83
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2022 at 02:24:14PM +0200, Alexander Potapenko wrote:
> +Here is an example of a KMSAN report::
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +  BUG: KMSAN: uninit-value in test_uninit_kmsan_check_memory+0x1be/0x380=
 [kmsan_test]
> +   test_uninit_kmsan_check_memory+0x1be/0x380 mm/kmsan/kmsan_test.c:273
> +   kunit_run_case_internal lib/kunit/test.c:333
> +   kunit_try_run_case+0x206/0x420 lib/kunit/test.c:374
> +   kunit_generic_run_threadfn_adapter+0x6d/0xc0 lib/kunit/try-catch.c:28
> +   kthread+0x721/0x850 kernel/kthread.c:327
> +   ret_from_fork+0x1f/0x30 ??:?
> +
> +  Uninit was stored to memory at:
> +   do_uninit_local_array+0xfa/0x110 mm/kmsan/kmsan_test.c:260
> +   test_uninit_kmsan_check_memory+0x1a2/0x380 mm/kmsan/kmsan_test.c:271
> +   kunit_run_case_internal lib/kunit/test.c:333
> +   kunit_try_run_case+0x206/0x420 lib/kunit/test.c:374
> +   kunit_generic_run_threadfn_adapter+0x6d/0xc0 lib/kunit/try-catch.c:28
> +   kthread+0x721/0x850 kernel/kthread.c:327
> +   ret_from_fork+0x1f/0x30 ??:?
> +
> +  Local variable uninit created at:
> +   do_uninit_local_array+0x4a/0x110 mm/kmsan/kmsan_test.c:256
> +   test_uninit_kmsan_check_memory+0x1a2/0x380 mm/kmsan/kmsan_test.c:271
> +
> +  Bytes 4-7 of 8 are uninitialized
> +  Memory access of size 8 starts at ffff888083fe3da0
> +
> +  CPU: 0 PID: 6731 Comm: kunit_try_catch Tainted: G    B       E     5.1=
6.0-rc3+ #104
> +  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 0=
4/01/2014
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Are these table markers in the code block above part of kmsan output?

> +A use of uninitialized value ``v`` is reported by KMSAN in the following=
 cases:
> + - in a condition, e.g. ``if (v) { ... }``;
> + - in an indexing or pointer dereferencing, e.g. ``array[v]`` or ``*v``;
> + - when it is copied to userspace or hardware, e.g. ``copy_to_user(..., =
&v, ...)``;
> + - when it is passed as an argument to a function, and
> +   ``CONFIG_KMSAN_CHECK_PARAM_RETVAL`` is enabled (see below).

The sentence before the list above is rendered as definition list term
instead, so I add the blank line separator:

---- >8 ----

diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/km=
san.rst
index 2a53a801198cbf..55fa82212eb255 100644
--- a/Documentation/dev-tools/kmsan.rst
+++ b/Documentation/dev-tools/kmsan.rst
@@ -67,6 +67,7 @@ uninitialized in the local variable, as well as the stack=
 where the value was
 copied to another memory location before use.
=20
 A use of uninitialized value ``v`` is reported by KMSAN in the following c=
ases:
+
  - in a condition, e.g. ``if (v) { ... }``;
  - in an indexing or pointer dereferencing, e.g. ``array[v]`` or ``*v``;
  - when it is copied to userspace or hardware, e.g. ``copy_to_user(..., &v=
, ...)``;

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--8SFVSXRZNTT5RY83
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxa6FQAKCRD2uYlJVVFO
o5TjAP4pqdJtF2silbpITwEaYJyueteQAD2tnShYfmi4k/CwmwD+Kf2knjEANX/1
NS87UnfEtAMR4Gyq0gGFXh2B5ITIaww=
=3svA
-----END PGP SIGNATURE-----

--8SFVSXRZNTT5RY83--
