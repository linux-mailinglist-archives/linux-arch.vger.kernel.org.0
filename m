Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A86641518
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 09:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLCI6P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Dec 2022 03:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLCI6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Dec 2022 03:58:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09E17AB0;
        Sat,  3 Dec 2022 00:58:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 4so6741398pli.0;
        Sat, 03 Dec 2022 00:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sadz1/CeqA5zMnNYCqP/lEzSjdg/kLkwU3QYovJoVo=;
        b=TCH+a02ERdRFnTf642Vs6jq9crhRaRo1PkxlU1yySN11VeAP+j9DkZ/e3z5G/uoeVs
         bOXCEs9OBEwem0ZKkvw6e6dmOY/iAHDTJqLxF//foTdrbbbqR/UqTJbNa45Rz86iZJ1R
         ZT98xw8b7fqFWyQM2gjHgoumxJpOwE6xg0CX0U7h3UN66Ti2+nvlttY14rX3zqCrb5B/
         Cf6iz0g2o4R2gKRPU1i6PhbrO3LuOXeXc/ADnGNxfFw17De1vpwVriU4QVvjKk8Ne5Bq
         YwKibxAOf1SMhiAtO206DGehkxjJRZanOsHbiwQEds3kLa+H3Ti+2JKipcb0AVdMsR0E
         75bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sadz1/CeqA5zMnNYCqP/lEzSjdg/kLkwU3QYovJoVo=;
        b=ujDGxkvV+4THvn137bFSrM7s6HFnCHdd51PE1WvnSGlhMAJ3+bTxQzqSS3sxZb5axC
         l9j/1TeD0jdwJW/6CChZ9HZiH0DvXtRLOEkoBYBLFFMXSwSDLeL+q4Mn2hi5DjfODEmc
         GI+Ygvi42AFRK+Lt0kcwxJw6mcZQ5DfoIwdLi3nAfjZbCucrR9GClJi2OdJjkMix5JVd
         Vr5gzhDX2gEgJCm39I/UrC+RV0MB9euBM424kCq+afVAIxepegtp4p5l+yiqh7S+kBnK
         5AXav5b1013WT4m0AnMN9/7Q0AqU286g0Vt90OCJUpW59xXuq9BCcBC7+95e2ozY48zc
         fgXg==
X-Gm-Message-State: ANoB5pnPkTjDCuo6ldBxH4/u6JYAN3cQxju2XxU3xRe5yJNf50wWHdRq
        i2+ylgDXwOvGUQ56A2Kgi4U=
X-Google-Smtp-Source: AA0mqf557Tf4hQ3ox+4h4L3bKmykRUVeioIulyBl3fgPqFmNheBWGxzj30flo9/NXH+QYMoZKV/pzQ==
X-Received: by 2002:a17:90a:a616:b0:219:6afd:24be with SMTP id c22-20020a17090aa61600b002196afd24bemr16172106pjq.0.1670057892468;
        Sat, 03 Dec 2022 00:58:12 -0800 (PST)
Received: from debian.me (subs03-180-214-233-30.three.co.id. [180.214.233.30])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a420800b0020a7d076bfesm5848220pjg.2.2022.12.03.00.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 00:58:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3CEE4104547; Sat,  3 Dec 2022 15:58:08 +0700 (WIB)
Date:   Sat, 3 Dec 2022 15:58:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 01/39] Documentation/x86: Add CET shadow stack
 description
Message-ID: <Y4sPn/EQgqQI/sSN@debian.me>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Y6TcVcN9xovNDyq"
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--4Y6TcVcN9xovNDyq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 04:35:28PM -0800, Rick Edgecombe wrote:
> +An application's CET capability is marked in its ELF note and can be ver=
ified
> +from readelf/llvm-readelf output:
> +
> +    readelf -n <application> | grep -a SHSTK
> +        properties: x86 feature: SHSTK

Shell commands should be inside literal code block (try double colon).
Above is rendered as definition lists instead.

> +The return values are as following:
> +    On success, return 0. On error, errno can be::

Drop indentation on the second line, or better yet, continue the line,
like "... as following. On success, ..."

Otherwise LGTM, thanks for review.=20

In any case,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--4Y6TcVcN9xovNDyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4sPlAAKCRD2uYlJVVFO
oxZmAQCvIsfDFABxypzVEB2ZMvgJzikdcI86EKjquJjkppkMVgD+INIDFYBh7cJP
AirZ9vPVfvl8ojgt9fx0uXFCNhiUvgA=
=CHdF
-----END PGP SIGNATURE-----

--4Y6TcVcN9xovNDyq--
