Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5932B4E9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450174AbhCCFbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbhCCCC0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 21:02:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B83964E60;
        Wed,  3 Mar 2021 02:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614736875;
        bh=Jur4X8HCTuoWSA6SEQnGoXAlbGc8RXGw8vUAl2IcNgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=snvXgvysI7rw8itAuWcYvlRITi6A+0NIbX8esoK8IaCyrNTFTyAbwuZCYkHAbT6VF
         ocPA8ZJck2sD6BHLLwgMKUUdGu41SeNph2a62PxRRJNOrC3I60us+Z7gWH4NBZHxFK
         6OObxv4SlUoxjAuEAyLCEgxKF29+Bdzs+0i8mzbl0xwoE/UeDQRIrsvYYOfhwWy+dz
         rKCDVPd5i8/kHaad9ppohdz9xOz6SrndhaclIDLEM6eMwD1ZqOo6zITLRQdd5IS75y
         HtKDDDwj228Rtly0KGdbu9XX6wxjhV/4OiCJPgw4YlC7F/I1Nl1uGNYr9dZBt6mC4V
         kcjCkKFDHldJg==
Received: by mail-ej1-f44.google.com with SMTP id w1so39165545ejf.11;
        Tue, 02 Mar 2021 18:01:14 -0800 (PST)
X-Gm-Message-State: AOAM532YmkIqCHyrNxjSMkupIv9m0J6EU8EkBvk79/eAl9wW3xv6ddp7
        3PAYdh3/vtwoY6ffA9GFdvBcVvpzlKd9ABIyFg==
X-Google-Smtp-Source: ABdhPJxohvRCbrznJ/X8kN7mfJ5VeQer8Ncx3QZ8RwevKVFlLbwvKN2msIpiGUN46C0KJZPy2hIRCxqonbPI/JR/Ecs=
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr24122920eja.468.1614736873011;
 Tue, 02 Mar 2021 18:01:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614705851.git.christophe.leroy@csgroup.eu> <20210302173523.GE109100@zorba>
In-Reply-To: <20210302173523.GE109100@zorba>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Mar 2021 20:01:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
Message-ID: <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Improve boot command line handling
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+Will D

On Tue, Mar 2, 2021 at 11:36 AM Daniel Walker <danielwa@cisco.com> wrote:
>
> On Tue, Mar 02, 2021 at 05:25:16PM +0000, Christophe Leroy wrote:
> > The purpose of this series is to improve and enhance the
> > handling of kernel boot arguments.
> >
> > It is first focussed on powerpc but also extends the capability
> > for other arches.
> >
> > This is based on suggestion from Daniel Walker <danielwa@cisco.com>
> >
>
>
> I don't see a point in your changes at this time. My changes are much more
> mature, and you changes don't really make improvements.

Not really a helpful comment. What we merge here will be from whomever
is persistent and timely in their efforts. But please, work together
on a common solution.

This one meets my requirements of moving the kconfig and code out of
the arches, supports prepend/append, and is up to date.

Rob
