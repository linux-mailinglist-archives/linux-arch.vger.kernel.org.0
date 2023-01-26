Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0767C2C8
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 03:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAZCX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 21:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZCX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 21:23:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79D5AB72;
        Wed, 25 Jan 2023 18:23:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k18so713718pll.5;
        Wed, 25 Jan 2023 18:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdzDiMhd5Z4Kbptw7LbpvnJl2K3L0BK+iFAqX7khznk=;
        b=cWKQ3LoRkq2yJUejFpLnrkED2LKr3msUYmGPeKxn1zz9oXsR2Q5y+uBNeQcluKW+Hb
         t3RYOIc3ExQTYLpI6hzcuYBj/SWWdUhatpoaAZ1lhjyniEeSuRQsANu6geJhcoezuexn
         2p4A6kFID76IX/8Y0c6UDG+PgC275wJuLtxBwwzp0N9TIvOMGwDZt1yO+zWAr6VRegI4
         Q+v50gsZDo6AJTpm1LmXUDfg/+diQibnpxpLW84XH+nCkK6Du1urF3rgBfcAwQdqN/aI
         3mBdOgOt2SPx8npCj1G242UNu68EiGAJQ5Ss3rfAVKGpu98B2MekgUQYevlSzX65x4h2
         M5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdzDiMhd5Z4Kbptw7LbpvnJl2K3L0BK+iFAqX7khznk=;
        b=1LLJGuGGU7V55SR3OpCapJYeSOZf7Yq6lMLmKrowklW14+lry/JVPLqUNk25XGf8nu
         jOCcXErI2fiNK8W6SOODXGNJINILtBFZHoP5Pg90zFC3PQ75bt17rE4ITlq2qnN4MLnV
         EURqlPOfb+8Tbe/6c5AY3kxU6+sLgAePl7QkFR6nT2QmKfQQcQnYgZCUbwbp4rwSCuzO
         9cIQleMkEEPU1ZvwbGNNThYa1zcDlETWMS+m34CZU4e+8ebg2s/Ud4HqrMG6yWEPNfTb
         eYVOmoGlaYnHQY75gCSM9s8PrRqLrlSwI5/3v4AcR4LA0M8s6zkGjKBODoyh4LP7tJew
         y1JA==
X-Gm-Message-State: AO0yUKWbbE5DGrd6yAtrm1cKM1Rs3BlxjAFoVgLYExLZK0aZJ9YIxHA2
        1nxM4q6wFJnzDyrqhlXwKTE=
X-Google-Smtp-Source: AK7set928mFCsBjzluN+Hn1fMUpkX7L+xOL83MZOoHVwK3h3Rnfl0pQuSPbhnC4JnUGrnGbjsxX7hA==
X-Received: by 2002:a17:902:6b89:b0:193:6520:739a with SMTP id p9-20020a1709026b8900b001936520739amr171911plk.46.1674699834095;
        Wed, 25 Jan 2023 18:23:54 -0800 (PST)
Received: from debian.me (subs02-180-214-232-79.three.co.id. [180.214.232.79])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001960706141fsm72958plg.149.2023.01.25.18.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 18:23:53 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8EE9110544A; Thu, 26 Jan 2023 09:23:50 +0700 (WIB)
Date:   Thu, 26 Jan 2023 09:23:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?B?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/31] Documentation: kvx: Add basic documentation
Message-ID: <Y9HkNpD7iQG9WErv@debian.me>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-2-ysionneau@kalray.eu>
 <Y8z7v53A/UDKFd7j@debian.me>
 <20230125182820.GD5952@tellis.lin.mbt.kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zOhV12uQumLCQ78f"
Content-Disposition: inline
In-Reply-To: <20230125182820.GD5952@tellis.lin.mbt.kalray.eu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--zOhV12uQumLCQ78f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2023 at 07:28:20PM +0100, Jules Maselbas wrote:
> Hi Bagas,
>=20
> Thanks for taking your time and effort to improve the documentation.
> We not only need to clean the documention syntax and wording but also
> its content. I am tempted to apply all your proposed changes first and
> then work on improving and correcting the documentation.
>=20
> However I am not very sure on how to integrate your changes and give
> proper contribution attributions. Any insights on this would be greatly
> appreciated.
>=20

Hi Jules,

The reword diff can be squashed into the doc patch (here, [01/31]).

For the attribution, since the reword is significant,

Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zOhV12uQumLCQ78f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9HkLwAKCRD2uYlJVVFO
ownGAQCyX0e5qWZ8KCgW6jQ0b0lEDmtwh+WnXNpCfwV6NxpnGgD+ISGQ0LnDB1sd
Rr3pPueL92j0yk6OhCDekI4gR23BOwo=
=1//R
-----END PGP SIGNATURE-----

--zOhV12uQumLCQ78f--
