Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0560C2A99C1
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFQpi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 11:45:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44418 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKFQph (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 11:45:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id s9so291654ljo.11;
        Fri, 06 Nov 2020 08:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NXRtqHffFnsMIzZ6TAmIGSVk+62VdYhbYjy8LdH8vo=;
        b=n2cTT9i01R04gKL3QHa7HdqS4U6EpjXRAvScLIXPWblsVwdsJ9CX9si6d7f05wvrIZ
         SGo7yYo8+sUtIVFWXE5yXzynjoH9NdxloW5qXd7GgIfCW/anCD7xSjcI57PvIjbrJEOU
         jWQMumhd0SPObtuZxWmc/29l4zvoaHVyAgx/+c1XIuShK6R2KYYQP/9t3rQgIlcWin42
         VQeYqaeRILkDkwpNuu5Gb4yw+mcJSFXFr01Cn2NyfjOhqFGJyt6XzWVhHzKXIcq2xa8p
         vtWApqnEIxPT1eT09KZVR4CQrLsS2R8Y8Eq+zJopXr5xVnKF+QOUD+h5fbAil/DBGMOf
         SVUw==
X-Gm-Message-State: AOAM533OnczpSBd7i6/7eFpI8y63PKxWLAhj7zqcW8eH779u+kaJLrqR
        fG4eTgiTnw1XdRcDx2nkzGE=
X-Google-Smtp-Source: ABdhPJzQDc4igKg3ddTAUZAeM/D96jrzN/OvKFYB6yCypvurl1JtTkTAMCaE+gtMQy6S8MKMYrvbbA==
X-Received: by 2002:a2e:5705:: with SMTP id l5mr1006042ljb.93.1604681135209;
        Fri, 06 Nov 2020 08:45:35 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q14sm220476lfb.281.2020.11.06.08.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:45:34 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kb4rp-0000Ae-NT; Fri, 06 Nov 2020 17:45:38 +0100
Date:   Fri, 6 Nov 2020 17:45:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <20201106164537.GD4085@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106160344.GA12184@linux-8ccs.fritz.box>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 05:03:45PM +0100, Jessica Yu wrote:
> +++ Johan Hovold [03/11/20 18:57 +0100]:
> >We rely on the linker to create arrays for a number of things including
> >kernel parameters and device-tree-match entries.
> >
> >The stride of these linker-section arrays obviously needs to match the
> >expectations of the code accessing them or bad things will happen.
> >
> >One thing to watch out for is that gcc is known to increase the
> >alignment of larger objects with static extent as an optimisation (on
> >x86), but this can be suppressed by using the aligned attribute when
> >declaring entries.
> >
> >We've been relying on this behaviour for 16 years for kernel parameters
> >(and other structures) and it indeed hasn't changed since the
> >introduction of the aligned attribute in gcc 3.1 (see align_variable()
> >in [1]).
> >
> >Occasionally this gcc optimisation do cause problems which have instead
> >been worked around in various creative ways including using indirection
> >through an array of pointers. This was originally done for tracepoints
> >[2] after a number of failed attempts to create properly aligned arrays,
> >and the approach was later reused for module-version attributes [3] and
> >earlycon entries.
> 
> >[2] https://lore.kernel.org/lkml/20110126222622.GA10794@Krystal/

> So unfortunately, I am not familiar enough with the semantics of gcc's
> aligned attribute. AFAICT from the patch you linked in [2], the
> original purpose of the pointer indirection workaround was to avoid
> relying on (potentially inconsistent) compiler-specific behavior with
> respect to the aligned attribute. The main concern was potential
> up-alignment being done by gcc (or the linker) despite the desired
> alignment being specified. Indeed, the gcc documentation also states
> that the aligned attribute only specifies the *minimum* alignment,
> although there's no guarantee that up-alignment wouldn't occur.
>
> So I guess my question is, is there some implicit guarantee that
> specifying alignment by type via __alignof__ that's supposed to
> prevent gcc from up-aligning? Or are we just assuming that gcc won't
> increase the alignment? The gcc docs don't seem to clarify this
> unfortunately.

It's simply specifying alignment when declaring the variable that
prevents this optimisation. The relevant code is in the function
align_variable() in [1] where DATA_ALIGNMENT() is never called in case
an alignment has been specified (!DECL_USER_ALIGN(decl)).

There's no mention in the documentation of this that I'm aware of, but
this is the way the aligned attribute has worked since its introduction
judging from the commit history.

As mentioned above, we've been relying on this for kernel parameters and
other structures since 2003-2004 so if it ever were to change we'd find
out soon enough.

It's about to be used for scheduler classes as well. [2]

Johan

[1] https://github.com/gcc-mirror/gcc/blob/master/gcc/varasm.c
[2] https://lore.kernel.org/r/160396870486.397.377616182428528939.tip-bot2@tip-bot2
