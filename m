Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73438166A9C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgBTW4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 17:56:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33641 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgBTW4t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 17:56:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so221620lji.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 14:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPKDe6yRRFJGUnIwSU2OwVdWr6D/nSY2qyTGzzCBHYQ=;
        b=g52x6jfoclKMmzoDFsItZqupm/1XbxO96MhH+R0k3RS07HgaUyCwcGY2OQkLyiZEGS
         HeYbZrTNT4ygcHbgFok2GwM1MWDRWE1rWgHw90nB1fVTrKRtnxVYM68htw6dBXxWj+3F
         UhZPwMEXtTOtA6b4b76Pnl2fv6iWYWogA+Ul4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPKDe6yRRFJGUnIwSU2OwVdWr6D/nSY2qyTGzzCBHYQ=;
        b=Zmt4X57UTuAgFBbgy8gXH/8rifG/w3kbE0KA9Wmtnc1o8ukRonidC1qmpz1h8x5JdN
         KCgqD/fUV2XGkyX/j9et+KPH/lWrJE/dw03PSxpwjUvkJaHPWKHF4sQndo2eb5RYCfxs
         cOwbsaHfTIwOQJRrJapv2FgwIpI1mDeQkGQ7ye6VjwhdL7BYT0Cq9ejOYoDBB5ibvIGX
         qTAvaHB/30hLK/dR548DUsprDOYabYBJOy1SELmNUcJYONlzTaBQYed3L7GNHisYey1f
         6LQmmn1dbkfK0eFo+n1bOhmSKUrJ66Xp1ESDW3ghwuFSLrETNZ0KwDps7NJyUPkfZ0kS
         Sjbg==
X-Gm-Message-State: APjAAAXzzy3yR0KvQAeAp5D4GyzGXDyQgunxK7u8M0EU5v3agQhnVRgC
        e+H/d6yVnZ6bVZ73oD2xSVS0qxp4DQY=
X-Google-Smtp-Source: APXvYqzCjV2x/395gxvUKvnP0XzpqE78GYSEzFsPT4UiiL11a24qOHSKmAoSsgFFVZr7JgCfTRa+pw==
X-Received: by 2002:a2e:3619:: with SMTP id d25mr19691494lja.231.1582239405548;
        Thu, 20 Feb 2020 14:56:45 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f9sm434946ljp.62.2020.02.20.14.56.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:56:44 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id c23so29738lfi.7
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 14:56:44 -0800 (PST)
X-Received: by 2002:ac2:490e:: with SMTP id n14mr3027836lfi.142.1582239404138;
 Thu, 20 Feb 2020 14:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217183340.GI23230@ZenIV.linux.org.uk> <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220224707.GQ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:56:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
Message-ID: <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
Subject: Re: [RFC] regset ->get() API
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 2:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 19, 2020 at 12:01:54PM -0800, Linus Torvalds wrote:
>
> > I don't mind it, but some of those buffers are big, and the generic
> > code generally doesn't know how big.
>
> That's what regset_size() returns...

Yes, but the code ends up being disgusting. You first have to call
that indirect function just to get the size, then do a kmalloc, and
then call another indirect function to actually fill it.

Don't do that. Not since we know how retpoline is a bad thing.

And since the size isn't always some trivial constant (ie for x86 PFU
it depends on the register state!), I think the only sane model is to
change the interface even more, and just have the "get()" function not
only get the data, but allocate the backing store too.

So you'd never pass in the result pointer - you'd get a result area
that you can then free.

Hmm?

The alternative is to pick a constant size that is "big enough", and
just assume that one page (or whatever) is sufficient:

> > Maybe even more. I'm not sure how big the FPU regset can get on x86...
>
> amd64:
>         REGSET_GENERAL  =>      sizeof(struct user_regs_struct) (216)
>         REGSET_FP       =>      sizeof(struct user_i387_struct) (512)
>         REGSET_XSTATE   =>      sizeof(struct swregs_state) or
>                                 sizeof(struct fxregs_state) or
>                                 sizeof(struct fregs_state) or
>                                 XSAVE insn buffer size (max about 2.5Kb, AFAICS)
>         REGSET_IOPERM64 =>      IO_BITMAP_BYTES (8Kb, that is)

Yeah, so apparently one page isn't sufficient.


> FWIW, what I have in mind is to start with making copy_regset_to_user() do
>         buf = kmalloc(size, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>         err = regset->get(target, regset, offset, size, buf, NULL);

See above. This doesn't work. You don't know the size. And we don't
have a known maximum size either.

>         if (!err && copy_to_user(data, buf, size))
>                 err = -EFAULT;
>         kfree(buf);
>         return err;

But if you change "->get()" to just return a kmalloc'ed buffer, I'd be
ok with that.

IOW, something like

        buf = regset->get(target, regset, &size);
        if (IS_ERR(buf))
                return PTR_ERR(bug);
        err = copy_to_user(data, buf, size);
        kfree(buf);
        return err;

or something like that. Just get rid of the "ubuf" entirely.

Wouldn't that be nicer?

            Linus
