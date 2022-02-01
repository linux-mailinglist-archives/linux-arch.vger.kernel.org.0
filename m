Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76EB4A54BE
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 02:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiBABml (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 20:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBABmk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 20:42:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089AC061714;
        Mon, 31 Jan 2022 17:42:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c9so14088677plg.11;
        Mon, 31 Jan 2022 17:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x+LYH2iPIeKKje/ufsIUVXC3BxeZP1r+kt3hjcgKoLs=;
        b=CkTnfAHyY5FJHvtNOJa+0L/alYm0p/MA+Dx7a+8pqGgSJO6/41qdDJ8ACb13gVw7qX
         whdkAg3YT/f1JReraTCvz3BVoiZhfSTLJGbTJMF7v8hNIOHrmPW5q+gKe4YmzEHqt1H2
         PmjNVAkRAVxD2YfCk1EogJ4AO0iwhfJll0jmQkqcWIl10TzM2V3KJzgqvgTW5CbuZyhN
         DgfI2TAEVB6ScYpaf39JexI6lqb96XeGpd3qJqHRMjMjmeXVHiaUlHiJNWH8hkfROZ6P
         8qglNJ4BD88JtAIKbD26UzsgrPKe9I54ww00oSunKHjWeSfW6N30acoZKDkbgLej9gVF
         Xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x+LYH2iPIeKKje/ufsIUVXC3BxeZP1r+kt3hjcgKoLs=;
        b=EwQJJQvOK15OL8dJw0ImcxZarhjVlOKxDHf6E7mw/UeeZ1SfG/XIZ2tNyckuE1wx07
         LCbSFCNT06b5yOcrhQxbNzc13wp7gIgANQSRWj5MoSOKxALN2X21k2OCS2or0Lk9b+9r
         h9EraJPS2i0QwQR+0V0On/jTvKb4AUbhXCKBgUU4kx3sulm8WZGq09zkAPsbqWZa/dDH
         ze+bP/Y1YoW4cNj5bSmDv3XmnwGsfcAkdbhUNUu4V3ANy1CkGWwrVCj1C/92qtE4Jms/
         574ef8x4Q6YOKQ/A4chSNA+5fWZDj5PzK6Q6dWCtw/fQxTYFyNikxY6yA2xKn1eA5GUJ
         IYAg==
X-Gm-Message-State: AOAM530PuvdkY328RI8Jq+c9VeOZylG8T0KcT8GXvcoizJdCz3pbzIzJ
        WVVVexiGuYg5tD0OjbK8dokxcP4ty47Pow==
X-Google-Smtp-Source: ABdhPJxeGAwbuj7OSEeOuIpCOS6L43io94K5qy/Qyb0sbU4tquiDPcXv2J3SmI05AnhXKaffXg+Ziw==
X-Received: by 2002:a17:903:41c8:: with SMTP id u8mr3550265ple.81.1643679759981;
        Mon, 31 Jan 2022 17:42:39 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ga21sm1071682pjb.2.2022.01.31.17.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 17:42:39 -0800 (PST)
Message-ID: <fbfc338c-e35e-17c4-b97c-87838dfa4bf2@gmail.com>
Date:   Tue, 1 Feb 2022 10:42:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tools/memory-model: Explain syntactic and semantic
 dependencies
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Paul_Heidekr=c3=bcger?= <paul.heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
References: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
 <YfBk265vVo4FL4MJ@rowland.harvard.edu>
 <YfJ7Rr9Kdk4u78lt@Pauls-MacBook-Pro.local>
 <YfLQmgsXp6pg0XIy@rowland.harvard.edu>
 <YfMFQ5IZiGBRw7SH@Pauls-MacBook-Pro.local>
 <YfMKlLInsK0Qr77f@rowland.harvard.edu>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <YfMKlLInsK0Qr77f@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, 27 Jan 2022 16:11:48 -0500,
Alan Stern wrote:
> Paul Heidekr=C3=BCger pointed out that the Linux Kernel Memory Model
> documentation doesn't mention the distinction between syntactic and
> semantic dependencies.  This is an important difference, because the
> compiler can easily break dependencies that are only syntactic, not
> semantic.
>=20
> This patch adds a few paragraphs to the LKMM documentation explaining
> these issues and illustrating how they can matter.
>=20
> Suggested-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> ---
>=20
>=20
> [as1970]
>=20
>=20
>  tools/memory-model/Documentation/explanation.txt |   47 ++++++++++++++=
+++++++++
>  1 file changed, 47 insertions(+)
>=20
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -485,6 +485,53 @@ have R ->po X.  It wouldn't make sense f
>  somehow on a value that doesn't get loaded from shared memory until
>  later in the code!
> =20
> +Here's a trick question: When is a dependency not a dependency?  Answe=
r:
> +When it is purely syntactic rather than semantic.  We say a dependency=

> +between two accesses is purely syntactic if the second access doesn't
> +actually depend on the result of the first.  Here is a trivial example=
:
> +
> +	r1 =3D READ_ONCE(x);
> +	WRITE_ONCE(y, r1 * 0);
> +
> +There appears to be a data dependency from the load of x to the store =
of
> +y, since the value to be stored is computed from the value that was
> +loaded.  But in fact, the value stored does not really depend on
> +anything since it will always be 0.  Thus the data dependency is only
> +syntactic (it appears to exist in the code) but not semantic (the seco=
nd
> +access will always be the same, regardless of the value of the first
> +access).  Given code like this, a compiler could simply eliminate the
> +load from x, which would certainly destroy any dependency.
> +
> +(It's natural to object that no one in their right mind would write co=
de
> +like the above.  However, macro expansions can easily give rise to thi=
s
> +sort of thing, in ways that generally are not apparent to the
> +programmer.)
> +
> +Another mechanism that can give rise to purely syntactic dependencies =
is
> +related to the notion of "undefined behavior".  Certain program behavi=
ors
> +are called "undefined" in the C language specification, which means th=
at
> +when they occur there are no guarantees at all about the outcome.
> +Consider the following example:
> +
> +	int a[1];
> +	int i;
> +
> +	r1 =3D READ_ONCE(i);
> +	r2 =3D READ_ONCE(a[r1]);
> +
> +Access beyond the end or before the beginning of an array is one kind =
of
> +undefined behavior.  Therefore the compiler doesn't have to worry abou=
t
> +what will happen if r1 is nonzero, and it can assume that r1 will alwa=
ys
> +be zero without actually loading anything from i.  (If the assumption
> +turns out to be wrong, the resulting behavior will be undefined anyway=

> +so the compiler doesn't care!)  Thus the load from i can be eliminated=
,
> +breaking the address dependency.
> +
> +The LKMM is unaware that purely syntactic dependencies are different
> +from semantic dependencies and therefore mistakenly predicts that the
> +accesses in the two examples above will be ordered.  This is another
> +example of how the compiler can undermine the memory model.  Be warned=
=2E
> +
> =20
>  THE READS-FROM RELATION: rf, rfi, and rfe
>  -----------------------------------------

FWIW,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

