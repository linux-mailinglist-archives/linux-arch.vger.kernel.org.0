Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973C128E9D8
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbgJOBUB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbgJOBTi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD738C051106
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:53:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b1so1256283lfp.11
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9u2mhHcY3pY9y0h1f1D8mjxBc1UDKO7lgh+0IH/jA4Y=;
        b=E/v5G5HV93+1W4ZpS/VEGR4XVjhJ1Cziliaq421Y1vNYDKnUMeDn1lSbhTCyjPD4qn
         Ycb0GIFY8dVLWimGD6jGpxITZrHhe7xQpjsbikl7AnWc4mhoCouYfkP7/f4PH+VA3clz
         Cv+uRw1kdI5CfME+yVKJXQCOBYRkOHRUVhiFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9u2mhHcY3pY9y0h1f1D8mjxBc1UDKO7lgh+0IH/jA4Y=;
        b=gz+4IJ/L1DDPmABRyBlsWXGHdLgrGg6XRZXw7gM1y7L7FBL8eruxMTtwyUWUc5mIfz
         WVVFSQmNJzU0tZVpGz+4jgH2NnSsldNAZkeOhsi+rhJ2NPhKaBTs/y3Svxoi9PCkQKrJ
         m6QPXvMblPIuHtj5L1I3jse5Tu31rRCWWrnj5baXZyq2Nj9T0tqAABXO30u/FGq5u+Mj
         Kgopfbfz0nTe/W+AZe62YFfo5prvvFunupkL1jw2PNrEsF90C6FKwByIUwH5GdGn0jSo
         lDxFVE/IhX1D9ZxaR7FRrIvt3nSlRwztdrBxKYQI3YC/TQ34SboZ52ZyiKJbgBL2V2Dh
         /v5Q==
X-Gm-Message-State: AOAM5309cTXpRLpYW9dKYFz8aTOEUzgG8gw7rS5lQO8+o7/wLlsfPlMS
        TkCYziDQLxj5hoGNpalYvJZ30v2DQKDcIA==
X-Google-Smtp-Source: ABdhPJw/zx+ZeuYBQgw/qq7vAjTnfeWHVLNbGVRCZvPSZiURUkntAic0nN3n7GOII2Vy6Dx5WBOXBA==
X-Received: by 2002:a19:c786:: with SMTP id x128mr86232lff.478.1602715998936;
        Wed, 14 Oct 2020 15:53:18 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z9sm445364ljn.27.2020.10.14.15.53.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 15:53:17 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id l28so1267038lfp.10
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:53:17 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr94354lfa.603.1602715996898;
 Wed, 14 Oct 2020 15:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200724012512.GK2786714@ZenIV.linux.org.uk> <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-20-viro@ZenIV.linux.org.uk> <20201014222650.GA390346@zx2c4.com>
 <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 15:53:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_rmS+kQvC9DccZy=UiUFJVFG9=fQajtfSCSP1h0Rofw@mail.gmail.com>
Message-ID: <CAHk-=wj_rmS+kQvC9DccZy=UiUFJVFG9=fQajtfSCSP1h0Rofw@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] ppc: propagate the calling conventions change
 down to csum_partial_copy_generic()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000abfabd05b1a965d0"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--000000000000abfabd05b1a965d0
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 14, 2020 at 3:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think it's this instruction:
>
>         addi    r1,r1,16
>
> that should be removed from the function exit, because Al removed the
>
> -       stwu    r1,-16(r1)
>
> on function entry.
>
> So I think you end up with a corrupt stack pointer and basically
> random behavior.
>
> Mind trying that? (This is obviously all in
> arch/powerpc/lib/checksum_32.S, the csum_partial_copy_generic()
> function).

Patch attached to make it easier to test.

NOTE! This is ENTIRELY untested. My ppc asm is so rusty that I might
be barking entirely up the wrong tree, and I just made things much
worse.

                 Linus

--000000000000abfabd05b1a965d0
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kg9zpmo10>
X-Attachment-Id: f_kg9zpmo10

IGFyY2gvcG93ZXJwYy9saWIvY2hlY2tzdW1fMzIuUyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbGliL2NoZWNrc3VtXzMyLlMg
Yi9hcmNoL3Bvd2VycGMvbGliL2NoZWNrc3VtXzMyLlMKaW5kZXggZWM1Y2QyZGVkZTM1Li4yN2Q5
MDcwNjE3ZGYgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9saWIvY2hlY2tzdW1fMzIuUworKysg
Yi9hcmNoL3Bvd2VycGMvbGliL2NoZWNrc3VtXzMyLlMKQEAgLTIzNiw3ICsyMzYsNiBAQCBfR0xP
QkFMKGNzdW1fcGFydGlhbF9jb3B5X2dlbmVyaWMpCiAJc2x3aQlyMCxyMCw4CiAJYWRkZQlyMTIs
cjEyLHIwCiA2NjoJYWRkemUJcjMscjEyCi0JYWRkaQlyMSxyMSwxNgogCWJlcWxyKwljcjcKIAly
bHdpbm0JcjMscjMsOCwwLDMxCS8qIG9kZCBkZXN0aW5hdGlvbiBhZGRyZXNzOiByb3RhdGUgb25l
IGJ5dGUgKi8KIAlibHIK
--000000000000abfabd05b1a965d0--
