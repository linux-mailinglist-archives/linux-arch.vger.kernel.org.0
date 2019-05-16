Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD420FA1
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfEPUeQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 16:34:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34167 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPUeQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 16:34:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id j20so3175363qke.1;
        Thu, 16 May 2019 13:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXMvY0G3v5gUX7EQ/Z5aIWKjEPl/AGLnGBSf3p0o4lk=;
        b=MS7Ht3Vn0W0gAqP/z3Hxo8IIKVUEa9TDLoBB8bzT+b/y2OCFL9P1u2WNynvrE0OBjN
         ZA7fuCFkuyOhOGQPYWgdZguf64xon2CkYLJtRonFer2fk2o/ICf5Mn3JyvqwXwVJcJSx
         QoIVhWTVRc/EEK9ZMx35QEKoZXDQpspDnK4guu4ONVd0Flhf/TOl/Tmsx2CaGv9xVcuN
         Y3sOwCJaGdK/s35v/9y4j7/ovN9J6ES6DwgqCJwMJ4Oha8KKuPpft4HQhzaDs12Oi4LJ
         U4biBtzvIKP4v0gZqT9Vf/M1AXHA8GTmANg//VUTEmP9iv3k4x6g31wcfYC2p9oBNbuY
         ROPw==
X-Gm-Message-State: APjAAAUWvCNnugyhH12LF26e1yfRk8Cf12yQ2qEybnrnWsTADD7PFIG2
        uw/LsajvEi1MaUsMbX64UfuwfmSe3ySY9rdZcQs=
X-Google-Smtp-Source: APXvYqx5ALmLhbiFLrZNEF380YSU8dgyGgV6muKZ0e/Ile/gyuU/mTdYBq4bG+k48BHmwY1zD4KIAbHFI2B/tDE+FRM=
X-Received: by 2002:a37:3ce:: with SMTP id 197mr40456259qkd.14.1558038855738;
 Thu, 16 May 2019 13:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
In-Reply-To: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 22:33:59 +0200
Message-ID: <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 16, 2019 at 8:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 16, 2019 at 5:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> > tags/asm-generic-nommu
>
> Interesting. I haven't seen this error before:
>
>   # gpg: Signature made Tue 23 Apr 2019 12:54:49 PM PDT
>   # gpg:                using RSA key 60AB47FFC9095227
>   # gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
> (0x00, 0x4)
>   # gpg: Can't check signature: Wrong key usage
>
> I think it means that you signed it with a key that was marked for
> encryption only or something like that.
>
> But gpg being the wonderful self-explanatory great UX that it is, I
> have no effin clue what it really means.

Same here.

> Looking at the git history, it turns out this has happened a before
> from you, and in fact goes back to pull requests from 2012.
>
> Either I just didn't notice - which sounds unlikely for something that
> has been going on for 7+ years - or the actual check and error is new
> to gpg, and I only notice it this merge window because I've upgraded
> to F30.

I have reconfigured it locally now and pushed an identical tag with a
new signature. Can you see if that gives you the same warning if you
try to pull that?

      Arnd
