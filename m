Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537C3236D8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 06:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhBXF22 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 00:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhBXF21 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 00:28:27 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C71C061574;
        Tue, 23 Feb 2021 21:27:47 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id q85so1118520qke.8;
        Tue, 23 Feb 2021 21:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aw/UR5s2IwQPzSQ407eWj98h5EXFMZRfL8iJNo841y4=;
        b=Zo/TLZUriQC1JcSj0ZK1KudC5T/rV0z51TalrrECdksS/wvnLachxYf/kEUxQ1jIZv
         veZQlyebujp5Rz3SR8SGVZAAxW3kps1Mmk8qG8C/Xyxg8G56/U/PkZqGesNyr219j2Uk
         e/DiuwDcAGKcgvKNXcsc+EewxzAMpmelOD5PQeIaIxPWW2IOmhd3fqvF4JYS/IkXrKME
         02ZrR5GCJWsQ4/7Bn0mF3Bh8q5N/mIb693SpgDTNzE/KZnpcZgF++y9CPCPUCqx2ShF8
         +ipDvNuim7jAGitwzsslxHE0pwhiVdeOuNRHTjkcYaA5gm2oEbgB5f5hZO2xMOhHyBmt
         T50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aw/UR5s2IwQPzSQ407eWj98h5EXFMZRfL8iJNo841y4=;
        b=Glps2qBM3yuM2KoFSTG/u/FmvVdOiJLajZorJ90ZLKRdvTlKt8cFW/C/Mcg3+CCsUJ
         tpfSjK8CzopOcl4eDKoDG/CQD5UDJoG+sOd5ccz4xqfN120q0ccz5ZvMqHEyNTjqxBKu
         l93QbSgQ7l8CwKTOPhm6lGiUikcpjuVGERTTz/MJ91gstgKp6g6/Vu0oVAel369pANuj
         5bRCUH7ZyZkQ9Kno0JrKu7hBbtWu7sYeIH49XBTqKYsa+9r9js/beKwTTTXHaiyub3Xe
         vqFlY+FWpjwSIgSvb5uX4eyTZjBsIBA56szDPAynzXUpgbQwcymqAMWZLans00E3wajs
         fUOA==
X-Gm-Message-State: AOAM5320ntTvgYqlFAM0QjXMccNI8XXPLHX80EKCXjSyXebd+l/v6vd0
        GWCC2yVvrii97lZfYZ8HnvI=
X-Google-Smtp-Source: ABdhPJx39bkgG69E4mrnlUr3nUMK+9eV9c6HxdyY8sMqYv6jTsxP9WRvHfhPzPoeMF1fdlClPjsefA==
X-Received: by 2002:a37:a654:: with SMTP id p81mr29167625qke.354.1614144466099;
        Tue, 23 Feb 2021 21:27:46 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id r17sm620719qta.78.2021.02.23.21.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 21:27:45 -0800 (PST)
Date:   Tue, 23 Feb 2021 21:27:44 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH] arm64: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210224052744.GA1168363@yury-ThinkPad>
References: <20201205165406.108990-1-yury.norov@gmail.com>
 <20201207112530.GB4379@willie-the-truck>
 <CAAH8bW-fb0wPwwvo8P8VW33zV=Wi_LPWxdJH8y2wdGGqPE+3nA@mail.gmail.com>
 <20201208103549.GA5887@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208103549.GA5887@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 08, 2020 at 10:35:50AM +0000, Will Deacon wrote:
> On Mon, Dec 07, 2020 at 05:59:16PM -0800, Yury Norov wrote:
> > (CC: Alexey Klimov)
> > 
> > On Mon, Dec 7, 2020 at 3:25 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Sat, Dec 05, 2020 at 08:54:06AM -0800, Yury Norov wrote:
> > > > ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> > > > enable it in config. It leads to using find_next_bit() which is less
> > > > efficient:
> > >
> > > [...]
> > >
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 1515f6f153a0..2b90ef1f548e 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -106,6 +106,7 @@ config ARM64
> > > >       select GENERIC_CPU_AUTOPROBE
> > > >       select GENERIC_CPU_VULNERABILITIES
> > > >       select GENERIC_EARLY_IOREMAP
> > > > +     select GENERIC_FIND_FIRST_BIT
> > >
> > > Does this actually make any measurable difference? The disassembly with
> > > or without this is _very_ similar for me (clang 11).
> > >
> > > Will
> > 
> > On A-53 find_first_bit() is almost twice faster than find_next_bit(),
> > according to
> > lib/find_bit_benchmark. (Thanks to Alexey for testing.)
> 
> I guess it's more compiler dependent than anything else, and it's a pity
> that find_next_bit() isn't implemented in terms of the generic
> find_first_bit() tbh, but if the numbers are as you suggest then I don't
> have a problem selecting this on arm64.

Ping?

