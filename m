Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E864248B737
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiAKTUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbiAKTUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 14:20:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3779C06175C
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 11:19:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c71so318536edf.6
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPEufsiWRxBxFa3x05EyMO915zm/zBjp5MyFqHNhJt0=;
        b=ERiX4Sa6hmrEflDwpKLYWFdH4eDxBQb8cmI+yn5DTykZAfrSCNR3ZM+K/1r1Hyz4WG
         c9CpxvgXHLNO0t9dA5xzgQl2mgLMUDOCQlkAPquuslr7eILu6G/mtCEOgGFNw2k5h/eH
         3cCRKxlYIYK2pE4hpJRpHpPUb0I91BhUci27U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPEufsiWRxBxFa3x05EyMO915zm/zBjp5MyFqHNhJt0=;
        b=gKbQ6MAUD16i524ekPH1VezUGdW2ZQuDoIP+ubRwfs03eTaB+JUjmN0U3LaaRkpP35
         lqVEPwrsojfzDivn9gz/2B6eVStdmME2sgTMpng619D8EVkhBfpZ7el0+1ckxdEdB+bx
         NiURqKe8v69Q7WDlE5ddVrKIYPK9HO4U3vyFBgGbYegkgcjZ4GHZMbZLuy2zb0tydecs
         w+ZDuxmtKcDg0hgGea41FwMdcn6++qeYkK5telA/NSfarfadRpOc5bJJFIO3xoYGnvhg
         E+Oy6kbBmrUvmlSB0qSm7NxqKTiH8+v9JKusPO5c3+rV9jxy7vbHLkyZSKFFfQOPIDVb
         r43Q==
X-Gm-Message-State: AOAM530egctnvi8BzMGDsRow6RjQkcpMLfJ6WZ6WkCPYMx/AATNWUOQy
        62r3QIaqhO0J/CeyXOpFJvZkg4osJgR77W0zZAg=
X-Google-Smtp-Source: ABdhPJxIjP2k4HsLcnRteh4OfpeHbc+xoreoTNEQR1XXOWcCoKBMq2dODBQIo2JlYYSTkO0LFiGQoA==
X-Received: by 2002:a17:906:ce44:: with SMTP id se4mr4877827ejb.209.1641928785059;
        Tue, 11 Jan 2022 11:19:45 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id k25sm3915349ejk.179.2022.01.11.11.19.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:19:43 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id p18so14451wmg.4
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 11:19:41 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr3682702wmq.8.1641928781521;
 Tue, 11 Jan 2022 11:19:41 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com> <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
 <87sfu3b7wm.fsf@email.froward.int.ebiederm.org> <YdniQob7w5hTwB1v@osiris>
 <87ilurwjju.fsf@email.froward.int.ebiederm.org> <87o84juwhg.fsf@email.froward.int.ebiederm.org>
 <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
 <87lezmrxlq.fsf@email.froward.int.ebiederm.org> <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:19:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
Message-ID: <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 11, 2022 at 10:51 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> +       while ((n == -ERESTARTSYS) && test_thread_flag(TIF_NOTIFY_SIGNAL)) {
> +               tracehook_notify_signal();
> +               n = __kernel_write(file, addr, nr, &pos);
> +       }

This reads horribly wrongly to me.

That "tracehook_notify_signal()" thing *has* to be renamed before we
have anything like this that otherwise looks like "this will just loop
forever".

I'm pretty sure we've discussed that "tracehook" thing before - the
whole header file is misnamed, and most of the functions in theer are
too.

As an ugly alternative, open-code it, so that it's clear that "yup,
that clears the TIF_NOTIFY_SIGNAL flag".

             Linus
