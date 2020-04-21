Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFAD1B2F34
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDUSe2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgDUSe1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 14:34:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F58C0610D6
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:34:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so15081349ljl.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Sxsn5oS4nqpkBX5BqB24mfzH+Rga+VCB+qgnhYUWk=;
        b=EN4eMrfRCQ2BTajrHemVrZRGdfNv+VjF0Hxxcl6iPzUIc4bkpVZwbpHp6Y8qjqbOly
         NQiQcxT3IZhkG8k/a9SX63SzMRhr6smIcOvnSUCBWIYLh5jNRcmyHxwhZdGgJqJWyNtZ
         yrajiBGrLqcdHIip5S59MA6DWpMQ2o4gnwtCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Sxsn5oS4nqpkBX5BqB24mfzH+Rga+VCB+qgnhYUWk=;
        b=UPJZCLJj0N0Iwc1Efqie3jROvjoqfyrr4j5+yqrFV9zlSfh0v9LzAZG2UFStVT9l2i
         vtuSKBmEzdvh5Iu9wu3EgoqfYo2zxVputAx+CtsTjNyTP3WaVIvU+v7AM1EcdFvrOKkq
         U1clO3lZyYFJEUv3CrnugToQb2MOYTjIF87ENeLaNqUuhuys1NdUMrDuBKk8Hw1jQL5G
         +SfWhRfooWv6KfU/lzTDHoz/+M0oVraZYIP4V89ptfXX4ouIOC8jkQIuLHaZtGZwmeyc
         N9W9Ckd9fxXjj7IAO20kKQwzX9w7HGUcUIYi0msVXJgSQZSx96xsxBJxjJXgm5irI271
         FQ0A==
X-Gm-Message-State: AGi0PubAEwVg6bjcdifMCnhyTDditILefI0kU6SDdEPkm+tWe4mQW2b8
        1pzHi9ujzVKJ6KCw/AewjUUFXIJE9Io=
X-Google-Smtp-Source: APiQypJliLAKEtJ0GCKY5LTrXbRMQjeDjaE9Op/aSNL3Ex5byRHgTkTyjB9z9V2oSWnqdrO5tdfGEQ==
X-Received: by 2002:a2e:3813:: with SMTP id f19mr13783514lja.216.1587494063147;
        Tue, 21 Apr 2020 11:34:23 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r14sm2542856ljn.4.2020.04.21.11.34.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 11:34:22 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e25so15088543ljg.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:34:21 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr9624239lji.201.1587494060836;
 Tue, 21 Apr 2020 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
 <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
 <20200403205205.GK23230@ZenIV.linux.org.uk> <20200421024919.GA23230@ZenIV.linux.org.uk>
In-Reply-To: <20200421024919.GA23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 11:34:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuHxXwuPynLFh-fYjuUE3_HNPh79e_P6MFMbq4Ki+QCw@mail.gmail.com>
Message-ID: <CAHk-=wiuHxXwuPynLFh-fYjuUE3_HNPh79e_P6MFMbq4Ki+QCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to user_full_access_begin/end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 20, 2020 at 7:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The only source I'd been able to find speaks of >= 60 cycles
> (and possibly much more) for non-pipelined coprocessor instructions;
> the list of such does contain loads and stores to a bunch of registers.
> However, the register in question (p15/c3) has only store mentioned there,
> so loads might be cheap; no obvious reasons for those to be slow.
> That's a question to arm folks, I'm afraid...  rmk?

_If_ it turns out to be expensive, is there any reason we couldn't
just cache the value in general?

That's what x86 tends to do with expensive system registers. One
example would be "msr_misc_features_shadow".

But maybe that's something to worry about when/if it turns out to
actually be a problem?

                 Linus
