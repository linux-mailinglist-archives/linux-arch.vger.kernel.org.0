Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2935257EBD
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgHaQ1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHaQ1d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 12:27:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1DC061573;
        Mon, 31 Aug 2020 09:27:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so9283244eje.10;
        Mon, 31 Aug 2020 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SjkPVYxB5yDQozKKyg93dD4UPzuBbpy4hriw+7/zkq8=;
        b=pPEKhd5I64Z33bNVBkySIMIUVIUdu2NT2tC0PfPkxG+YVVYOD5GRDZoaff9qsD5XIF
         OdDFTf3Wp52WqDxtFZ0lp4uQT1BIrSWaNqui18ls5VEU9jf5xfajQhWA/M2Zun7CQXTX
         mxyPA51X6dLKWJWOrCYV7qdUXEWS4Kn8QiiKs0DQKkV6zoGeWiH0xiJ8IW14w+gj8EDa
         EwLvXE0SK6Lxb8V1KiYDSHZO/xWZhiR/Te4LBK2ocfQlWsbYtQzvI8dQ9O2/6xzUk599
         9UNcZRw+RGKic5l7qur3xVCFlqWdkNXytXVyywjsrhJ041aHMohuFAyzuS3iJj8bDiHP
         m/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SjkPVYxB5yDQozKKyg93dD4UPzuBbpy4hriw+7/zkq8=;
        b=Ib+aM3muAclET5B9sV68g6cU3PUwGTAq7JH61C+D10Z6/J60sOMOheC8cE8iGPYGsa
         EYJrZsthhEPufAVFCQfGqrcWsLBarjY0l27iGOeZL9bvvGRfVGRox4jqvsnjtPj7gY1F
         C1oSLCfYqZZmLDjMyoatulzYH4A/U7kOaIr3qzfcLoDqpT1i4+MCC5GIPqxvTbIUk4xq
         lqFURR+KPcVAN6ppur9gniWM55QR++J3MZpazpW8plvEy+KaKG3nmbmUYOQrymR65cE+
         Zod9/AL1LJHyNX+3hurpTrpBhC7Gil6BTvPmByuD1KHHj1z73OXApVRTuVwRcc3DlW66
         H5Vg==
X-Gm-Message-State: AOAM533LwYQHlEye6q5klDJnLfY+dml2L2Z7Z5LrKC/SZ5XKi+593PgH
        hIpsz2FsdhdgBPiMBA7Byz+G0HdN7QB7FFC6WjI=
X-Google-Smtp-Source: ABdhPJxROfV7irWAUtCcIY36o5yTISjHt9MdXbWU8Fo3Q4BCAYYYKod7r0vUB1j3HTy1SinnYCxpZLieWM+ASpVfniU=
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr1900867ejy.324.1598891251873;
 Mon, 31 Aug 2020 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141344.2277088-1-alinde@google.com> <CAC5umyiNw7FA__Y3HZ1UEG8Y6uQDgAWHTJpOVf7okERzpCjnRg@mail.gmail.com>
 <CAG_fn=XDTWYbxb1Hy1p0hdOtOejZPWvDXfitysK7wUOsPAE_XQ@mail.gmail.com>
In-Reply-To: <CAG_fn=XDTWYbxb1Hy1p0hdOtOejZPWvDXfitysK7wUOsPAE_XQ@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 1 Sep 2020 01:27:20 +0900
Message-ID: <CAC5umyhmZmM4+FVDsyDzaUOpFsqd=RTopEpFuuMgnpQ+rzb1ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] add fault injection to user memory access
To:     Alexander Potapenko <glider@google.com>
Cc:     Albert Linde <albert.linde@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andrew,

Could you take a look at this series, and consider taking in -mm tree?

2020=E5=B9=B49=E6=9C=881=E6=97=A5(=E7=81=AB) 0:49 Alexander Potapenko <glid=
er@google.com>:
>
> > This series looks good to me.
>
> Great!
>
> Which tree do fault injection patches normally go to?
>
> > Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> Reviewed-by: Alexander Potapenko <glider@google.com>
