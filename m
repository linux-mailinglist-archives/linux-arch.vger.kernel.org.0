Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F97228A32
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGUUzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgGUUzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:55:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA9C0619DB
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:55:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r19so128947ljn.12
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KRiHv2XxTSwjqo2aYpnWdG35oO+7c1dy//AB5MhpN4=;
        b=Jj2v8BbF9aFwfyh4SlEc5xGD2Jkm85ro0pkQAN9Qh5SCte9chsHa0MTDGlrlrYOUnr
         qsrB/WGMv4QRtcmrjfHqV3qnwuFkg3bs24FSnkJ2Dr12TO2e4spYOc6bZ7QujxB0peZ5
         dJEib7JFK1g/8C0P5RZ8tSVuMh3jQsph/s/dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KRiHv2XxTSwjqo2aYpnWdG35oO+7c1dy//AB5MhpN4=;
        b=g+md6JoCMCt5OjtEQpEijcGNoIp/yo9NysCu8UqaC5xh/mbH40+sdQAm6UKP8ZlAO4
         EezRn+MtYDmV9dlQLiV4J0TiaxbUnVqX7l5i4ITgY95l2XWTDSt6Uyl1YKTIFa3uqe2w
         DWZEQqim/KmNUhkhSi+NnD3Dt/rsxzliRcz7rYOV7Dy6cay+y+8a69gwMZHU19Eon6kp
         +2JQ/HoTtDZihRQqhX5T4l/J0ALvysFqKQuxbPlW9el7ig6li+AHLGCmcrfYBTge06rU
         hql9u6hzqezdJF5y6w647xjoAtHO1I+IrnYw5vbMQpUsZR4bsxQ4TkmuLaD1MBbaNl8h
         vWig==
X-Gm-Message-State: AOAM530/DXHWPTpBp58VnhR7V0rcVIbP/ssSL6/7qTnmBuGJf+8W1klt
        mZpzI7R9mfPLYjKkkHQz5CQdAZVkGso=
X-Google-Smtp-Source: ABdhPJwb7SchpVfbnyJGMXpeLYwimS0+43TwcUEjZwSdEqwjDnzoxuKkvCqdLtqQAj2Veg+0+rTV9w==
X-Received: by 2002:a2e:9ed8:: with SMTP id h24mr7717415ljk.126.1595364933544;
        Tue, 21 Jul 2020 13:55:33 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x18sm5015635ljd.123.2020.07.21.13.55.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id i80so62600lfi.13
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr4244433lfo.31.1595364932160;
 Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 13:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Message-ID: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 1:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Preparation for the change of calling conventions; right now all
> callers pass 0 as initial sum.  Passing 0xffffffff instead yields
> the values comparable mod 0xffff and guarantees that 0 will not
> be returned on success.

This seems dangerous to me.

Maybe some implementation depends on the fact that they actually do
the csum 16 bits at a time, and never see an overflow in "int",
because they keep folding things.

You now break that assumption, and give it an initial value that the
csum code itself would never generate, and wouldn't handle right.

But I didn't check. Maybe we don't have anything that stupid in the kernel.

              Linus
