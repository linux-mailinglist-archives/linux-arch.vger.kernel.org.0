Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6871D19CA0D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbgDBTeZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 15:34:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40056 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBTeZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 15:34:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so5871892edu.7
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNVfYQcU5r7QqnygVgwbeTwWR3NWKnCIk7XJifmEK+g=;
        b=WFRj2oMOOBQ9Ye/JZJICZujrvRy2hkbOR9uXKlMdFDvf9Q5Lq80wgWioeP0e0rs0oj
         n0Wk/vH8ieHoUcWgLtyDYX5P7nJxjuAYNdlNyNknULgO81UVaZJ0LqdKLLefqzuqrqZf
         RMdkwJXPuZPoAbZGgiU6xp+RQahaYFh5oXLKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNVfYQcU5r7QqnygVgwbeTwWR3NWKnCIk7XJifmEK+g=;
        b=tU4lOyKao++XHIKd/6pABYwEW3Z0TY14gAq3MhLBo4TfkgJEOynU43UUh23w+9kLT2
         xEiy7TD2N9wgJA38uswvXij5IhTleMa6vBKSumH0RS98P36fD3U3pgPtAgM/fLlrit57
         OUC4lsH5zcul5xtRkND+TLuy6PPLg2/t8oL+taE/5vy2rDZ4OdGG1KW/FStG54crspTC
         KRs8qNJNef4pXSxazftYnUV2GguNfpJ7huZU7xbHtEFv+tQxqwtLJaQVRp1DnWKDDu+l
         KxVy9kq/nk3dCOS4E//b01zo6acxlSFsHh2CmWBPRSqaVGQuEEdkeoul+ZAN7/BTPyA7
         ChJw==
X-Gm-Message-State: AGi0PuZxKTeh7O7G5ogM2HVskQwzBnjVxZLnWvHrn0ntBSb28y1e/3Q5
        CAQfEHOjnVMERugki9gq7+jrwnbHjTs=
X-Google-Smtp-Source: APiQypLRiGaR15cGO3J4n0OPPRNs2IClo4DoUahZU917UdP6wzvKq0RkpET3P6fG2DmuH7w0X3T3WQ==
X-Received: by 2002:aa7:d78b:: with SMTP id s11mr4699970edq.226.1585856062947;
        Thu, 02 Apr 2020 12:34:22 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id s15sm1108154edu.97.2020.04.02.12.34.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:34:22 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h15so5632335wrx.9
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 12:34:22 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr2938169lji.16.1585855628859;
 Thu, 02 Apr 2020 12:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk> <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk> <202004021132.813F8E88@keescook>
In-Reply-To: <202004021132.813F8E88@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 12:26:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Message-ID: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and user_write_access_begin/end
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 2, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> Yup, I think it's a weakness of the ARM implementation and I'd like to
> not extend it further. AFAIK we should never nest, but I would not be
> surprised at all if we did.

Wel, at least the user_access_begin/end() sections can't nest. objtool
verifies and warns about that on x86.

> If we were looking at a design goal for all architectures, I'd like
> to be doing what the public PaX patchset

We already do better than PaX ever did. Seriously. Mainline has long
since passed their hacky garbage.

Plus PaX  and grsecurity should be actively shunned. Don't look at it,
don't use it, and tell everybody you know to not use that shit.

                Linus
