Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7411021F63C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbgGNPdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgGNPdl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 11:33:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03348C061794
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:33:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so23330607ljl.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rYU4sbMcFdjvk+wenfKOdKBg9lSiSVy3qR8AsDWIT4=;
        b=IobWZMZ2K4lfIlp2s0OMaugN8Nr0+nroGDJtXkiC4e/XOIRS/xcHqGwEs/K6W4JaY9
         vx/FIjFLSo1MrfLf/XK1RlzcMb1/WLsHEyRjvsEhdixC9gGSR6G0trgFj5aiUsbt1zRC
         5VvJnSve8NLK8sjeRHlLk7K93NUoBQ/sk2+O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rYU4sbMcFdjvk+wenfKOdKBg9lSiSVy3qR8AsDWIT4=;
        b=eWlonWhbzqADGMWAn/+1nf/8qqN7xYlh2znRheYA2TIBkratoXChfCtWwCLJnGKYw9
         NTArkuYm7OwaYS9TZVaKL+xkHpD5n0YFYiEOn+JKN3UXMS+12nLf9dFAJgwOp8tv4YSk
         03FB16NNoW5m5bkcHPheW2KWkgCx+6qaZ3KjKoeaiz1n/lE94xnVZ9xVEXvwrb0swm0a
         vCnC5et/iMbsJLvysa6Djymy3yL7y2kRqKwzxIrH4+AZtRQq6C4TR++byu3tNhpxcH9z
         v2MfTziv+JjpgTyVLaPovkEkvk/1btlmVJY35MVm5UreFNKA9KUGX3WwlapGEH1LfWcc
         W8HQ==
X-Gm-Message-State: AOAM530nxLy1p51AUfBL9craMmUvOdTJlsgUXOY7PMiYdtIvTb7NXpzW
        9Dnp6ESXvcKJtfb8xxaZ5jm8Mt4F/oY=
X-Google-Smtp-Source: ABdhPJyXA1P55nqyUGwmUaYI+E5pprflVZ7Q/FxhSc5T+TOwVurxmSYdmnEuVzQBV9mtOICSgz0kIQ==
X-Received: by 2002:a2e:b164:: with SMTP id a4mr2750993ljm.151.1594740818705;
        Tue, 14 Jul 2020 08:33:38 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v24sm5363379lfo.4.2020.07.14.08.33.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:33:37 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e4so23315444ljn.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:33:37 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr2542103lji.371.1594740817078;
 Tue, 14 Jul 2020 08:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
 <20200714070955.GB776@lst.de>
In-Reply-To: <20200714070955.GB776@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:33:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibed1S5_XMgjrUTOgUf0UOy1djm3e14c3YOm1Loj2vzw@mail.gmail.com>
Message-ID: <CAHk-=wibed1S5_XMgjrUTOgUf0UOy1djm3e14c3YOm1Loj2vzw@mail.gmail.com>
Subject: Re: clean up address limit helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 14, 2020 at 12:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 10, 2020 at 08:25:35AM -0700, Linus Torvalds wrote:
> >
> > Ack. All the patches looked like no-ops to me, but with better naming
> > and clarity.
>
> Is that a formal Acked-by?

Yup, the patch series looks fine to me, and it looks like you fixed up
the things people noticed about off m68k behavior.

              Linus
