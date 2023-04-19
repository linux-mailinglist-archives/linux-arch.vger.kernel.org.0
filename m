Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277E86E765A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjDSJdv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDSJdu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 05:33:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DAB13850;
        Wed, 19 Apr 2023 02:33:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6862e47b1so25507945ad.0;
        Wed, 19 Apr 2023 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681896801; x=1684488801;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHQjdr6xQX6rVc+yLxshGaDbTdbSdHT2A5ieawzy8mY=;
        b=L7HHRdtm8tgBW0B+XsbYJlMPFRMoc3tuD33L1yugeJrWVMynKi43fHHYNhs5rdzRse
         nagluNdkL8fB5FUbT2EyTnoK5lrKBm+6vMCv/qblPzJZzhMx7t4e3A+UQmYI06lUmfpx
         1qCAuxrVjcVxYgeYhs+QzlrHylL3Qw6trNIRUM1oNN3YQy5tsU6KEjmqJ0TsYb/CeWo+
         vgOiNWjWAu8EpD8tm8w95mueFG6J6XCdur3jztBY/OEXJEFb9f0wPy1vZnJ54zqFfzH0
         f+o3hs7WhOCCY1mle0lT7n1Ox+H5U3dhutHW9wVk6hyKiijgdS6CHIJRUOgzgs8yPf/v
         PcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896801; x=1684488801;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHQjdr6xQX6rVc+yLxshGaDbTdbSdHT2A5ieawzy8mY=;
        b=ls5Sq52kaWCbKwnbsGya7sns8+VSBMQl1ILlUyORW/XNf+dasmhlPSjbdS4OiLqfXK
         CZBiiQviahX98G5UeF2zyifp8J+gc6Puy6pJS0e833H629/C3V0l4pJfwXs54nT6dcbl
         jC6jW8lf1Dm/ou/bsJT6KaXkRI+476jWs47w68WMf87nusitMOCyV8YmSQCZorY+i39g
         KQldT5aUzNBRGV6lmZrN+SlQZlQ+xpxfmxmXCjfbd0mGh/SCXpBzYIzy69UBl4bTRAt4
         caSBwf5zTffPoMWdks4GkJ16iRBut+HRM1zZxs6NooDZ6yh8tiLZihPjtKY6T2hDb1D8
         jzXg==
X-Gm-Message-State: AAQBX9eoce/7KRSPjOz+PebumlfuttJM2u++h3s4iFrZzYPSE84Kgv0h
        0GsEZJIDgoYKYQfEXrfn+L8=
X-Google-Smtp-Source: AKy350Zpu0QjmvvLijeA9/SV64LadQ7oRxXhuupmTqLWGuSVtWk4lwX59ElpMMfD12Gm0ZMkGI3TCQ==
X-Received: by 2002:a17:902:d14d:b0:1a5:150f:8558 with SMTP id t13-20020a170902d14d00b001a5150f8558mr4200509plt.17.1681896801552;
        Wed, 19 Apr 2023 02:33:21 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b001a1ccb37847sm11032209plb.146.2023.04.19.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 02:33:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F0328106895; Wed, 19 Apr 2023 16:33:17 +0700 (WIB)
Date:   Wed, 19 Apr 2023 16:33:17 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux x86 <x86@kernel.org>,
        Linux Architectures <linux-arch@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Semantic conflict between x86 doc cleanup and CET shadow stack doc
Message-ID: <ZD+1XVjMvm8EvCzN@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C8K9WK0xaNmvRngq"
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--C8K9WK0xaNmvRngq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I see semantic conflict on next-20230418 between commit ff61f0791ce969 ("do=
cs:
move x86 documentation into Documentation/arch/") and 54759b257eadb0
("Documentation/x86: Add CET shadow stack description"), which isn't noticed
when both jc_docs and tip trees were merged. The conflict triggers Sphinx t=
able
of contents warnings:

Documentation/arch/x86/index.rst:7: WARNING: toctree contains reference to =
nonexisting document 'arch/x86/shstk'
Documentation/x86/shstk.rst: WARNING: document isn't included in any toctree

The fixup for the next merge window (when Linus pull both trees) should be
moving also CET shadow stack doc to Documentation/arch/x86/ (in line with
ff61f0791ce969).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--C8K9WK0xaNmvRngq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZD+1WAAKCRD2uYlJVVFO
oxEmAP4pz1M71LW/uTNJpoaZ2PWjYJndPoZmPbrQltqOyzSoywD+O79BWakhmcFO
s4Hos7cgTj6LY37TRdYe41P6m9AKJA4=
=8kH4
-----END PGP SIGNATURE-----

--C8K9WK0xaNmvRngq--
