Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6419DD54
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgDCSBa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 14:01:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34459 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgDCSBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 14:01:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10so7915079ljn.1
        for <linux-arch@vger.kernel.org>; Fri, 03 Apr 2020 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJVFgRSGYKBnNbBPTVD/IukQXQa7rwPwND5Kh+NTBuo=;
        b=Ys0nLdOPaMPZHWrNpQG57PugKN6mkPGdJSUx/TQDpwY2GQmZdYkhxJaiTGDykgi3DV
         b9peyP0pK7wyoIA4rX92GpUwZxOJ1gL4WdkK8qsym8w0OHPBQz5LC8Pgsely+7R6EED/
         Y1qrLKu/XLubSi3S/jM7cWoFX4dK0Vuw/7IEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJVFgRSGYKBnNbBPTVD/IukQXQa7rwPwND5Kh+NTBuo=;
        b=TgAIAdQlDUfTDBZOpQ0h894PpXxKKpjqSIQt1OCvyQJEYAAhklIY+KF7y47ok5+UOw
         zhRgP6ovWuhLukz2OB2R0YSTne6iM7Wgq4xSlKEAWG8PJBTTOQXpQg9/MiCtPwkxBW4B
         XpViY6Hfi5pqYQabKDjsbpHhC1oJH/kezQpwzgGUCIeHhTBPZg5EQMHgSt3KeHH/LuKa
         liSwHkMFqv8ydX8Hqr/6YmjGUKp9ffBQufwPGXNGR5ZRoOc74ulwFggAmNG2TLMM6Hgy
         MGJtge+HYZcP4GoW872pL/KS/fwfnwQd8mn+0zQ/2r9zJ6J5Cc9zY3CeeNrJXzBSeNNC
         F6dA==
X-Gm-Message-State: AGi0PuaGa4QC4vec0/WMjSGdEHM68hTZ5wRcnGFmU8PHbkgA/9k2jiSb
        rNMNSnDSPBnV83MThsO6tzUh/lNanMQ=
X-Google-Smtp-Source: APiQypKw2CBcRiDHHoz2J6AJbUf7JyJAN8Y3R2JQ4Icjd4W3EHTvscQ+ibmjNbbOH6w4Oa+gmXreBw==
X-Received: by 2002:a2e:b446:: with SMTP id o6mr5597048ljm.80.1585936887733;
        Fri, 03 Apr 2020 11:01:27 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v21sm6132354lji.81.2020.04.03.11.01.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:01:27 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b1so7891820ljp.3
        for <linux-arch@vger.kernel.org>; Fri, 03 Apr 2020 11:01:27 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr5777613ljj.265.1585936886747;
 Fri, 03 Apr 2020 11:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
In-Reply-To: <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 11:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Message-ID: <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to user_full_access_begin/end()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 3, 2020 at 12:21 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Now we have user_read_access_begin() and user_write_access_begin()
> in addition to user_access_begin().

I realize Al asked for this, but I don't think it really adds anything
to the series.

The "full" makes the names longer, but not really any more legible.

So I like 1-4, but am unconvinced about 5 and would prefer that to be
dropped. Sorry for the bikeshedding.

And I like this series much better without the cookie that was
discussed, and just making the hard rule be that they can't nest.

Some architecture may obviously use a cookie internally if they have
some nesting behavior of their own, but it doesn't look like we have
any major reason to expose that as the actual interface.

The only other question is how to synchronize this? I'm ok with it
going through the ppc tree, for example, and just let others build on
that.  Maybe using a shared immutable branch with 5.6 as a base?

                   Linus
