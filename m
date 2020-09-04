Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB025D449
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIDJJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgIDJJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 05:09:07 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4072C061244;
        Fri,  4 Sep 2020 02:09:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d189so5853299oig.12;
        Fri, 04 Sep 2020 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=B1F8lj9Fqbo8dezZg1rybU9KGFv88k33ECwbjR1JZPg=;
        b=uerSpXIeuW8egdvhrBOxgSI4H2+MkV6nfqmwsSTgZe47kr+R4dT9esdHyC+dIzFWew
         7S+NReQ4tqsuASIVsTid6SoMhFv18Dm09UPS/qI9ygjssIKXTsOtlwtyAblWnz+QXIgA
         XQQyxE3czHKcKJKUZ38sgdUxKt0maQcuOKpyq2SZKMU/7x+b94LGhX1XcsxaCNmnRvOl
         nPRurPAzNxzekagJqkvPL+Ofo0aliDeqFYpMz7bAYCg64CVXz5kDbgHqmkKjkI2jPB7P
         rZSI8t3k4BggoJ7slMx/Y6IRXo20nj5bsW+eHMiIiwKCsAiMbBD1Pc5EydUQO1BwRsTd
         /ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=B1F8lj9Fqbo8dezZg1rybU9KGFv88k33ECwbjR1JZPg=;
        b=hDJeq65df35qgD4FQYh0zEhWQoIqjat9i0QriidCX/U4spyF7DXMowGyh1X5cV8qCO
         cQUZUltl1Yac+V9y6df6SkLLg6Acmo4XKgjXC7z3/yR4EOVhuAk+GLxj0gyBQFH3dVxK
         HMLI2KotD96rimjZpVZlqQlwB+Et7JorzYZsTpVYryIv3UuMAS9aiUaNQFlAjl01Ix1O
         Re9HV9wTzLDA5TSAQJvPAUD1z+ICb4cMfnDf06/zwEg5JFRT/M1AIoQfcV6kZDGdMGq/
         wOGWofsN4q+pH1AAo93O9gP7bvuJN+HWFjW6dmrjsqQr9Ul2csN7xHP+WGsnKovqB5CT
         jhdg==
X-Gm-Message-State: AOAM531Ygq3CSqrHYGb5iSHUnh7wdvvaJRYuzvf82zuBqTPKdd8zjoE1
        iAvtxNkgnXemrH+AaBgXVVH0OuyRMHmroeHePeY=
X-Google-Smtp-Source: ABdhPJzj5BSTE3f88vS3BroKAd3o5SJIpsD68NdbolonePhBudgEeFDjp+JjeTdgozVDGzH6QYZ+34EfW5ujOYGl078=
X-Received: by 2002:aca:d409:: with SMTP id l9mr4407752oig.70.1599210545701;
 Fri, 04 Sep 2020 02:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200904085520.GN2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200904085520.GN2674@hirez.programming.kicks-ass.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Sep 2020 11:08:54 +0200
Message-ID: <CA+icZUVzWZZ=CCKEWiwsaMXM2Xy1F1NLNRS_2D15NeNZUGqquA@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
To:     peterz@infradead.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 4, 2020 at 10:55 AM <peterz@infradead.org> wrote:
>
>
> Please don't nest series!
>
> Start a new thread for every posting.
>

You are right Peter, my apologies.

- Sedat -
