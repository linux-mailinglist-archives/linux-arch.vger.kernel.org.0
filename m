Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D010360D
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfKTIdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 03:33:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33517 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfKTIdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 03:33:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so20508131ote.0
        for <linux-arch@vger.kernel.org>; Wed, 20 Nov 2019 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PED6ZYCgPaRUxZYECcuhZmbEWK8QVrh8hGaeK/4Dmy0=;
        b=OGrrZDpatx6bnWp30f05n9y2GXrNbXiMo4e9QnZukpBs2mQBTMYpR68xirJL+yZqcb
         9sdnCPbGWC8kI+Cfxhyw/lPXYDeNYcaKH+DetkEa1FRbIkd8zXX73GJn0lDVma9Yn+DP
         P6ubPYauQ2q07e3JbhnQ03NsomnKDTD7KwaJlE13VEZ8iqI2Jq/KCqru5SQQ6i/f/8d0
         3rQNufU2Y4RZWJkAdK3paThpZyJKuucOdam3UrlGurxKo1MuSDntifUt38w141wp5c9v
         O/N6W558+sxx+m1/G9/XDUoUBRd0zOdZd98QHHgB5P+zsHbStOP8YVWSCC97LFS5QXpv
         AknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PED6ZYCgPaRUxZYECcuhZmbEWK8QVrh8hGaeK/4Dmy0=;
        b=uDq77ki9MBM49ixbj3RrQfoc7JEwlmPnde/I+o/VFEJo3sK018WS72w7vJdXZLRkw/
         VO6FpndWieKHTzdrTCdssT2+A3mE9FfVPIDJHQuNW1OIbD6z4STHOFtI+rV1J3Ia4rAv
         qUfftyq/0ic4quU1sxoLmYRvisLQCuGKR9977Xi1dj5c0rlo6K5DDyumTD5hkFpOHUVO
         qZWOwcVIZesFXqct69rlJsjtxc/wD0f85LkdbArzOepRxnVytdHNF4uJkXHaaFwRekxh
         kBLIOczd79besP2Zpd5mdNE5TnHTMiaYUZu7+RKffTZg39ocft/804H0XyPsornXkdu3
         ZVuA==
X-Gm-Message-State: APjAAAUCo0tDJIzGIwhju3LmyCD6Wri9dhifceaFDZanV9ytWYgWCwzY
        E3YxOm7WH6vhA/vZzSKJQ8Ykk2fMdpyUbaj8LKmpJw==
X-Google-Smtp-Source: APXvYqxkDqT6uw4KByP9K4bk7RdCzo7jskMlJLlwbVVqL/s87+pnLIejk259sfDec0B8L3KT9/52IYH0IkH9klKNnPo=
X-Received: by 2002:a9d:3d76:: with SMTP id a109mr1082964otc.233.1574238786622;
 Wed, 20 Nov 2019 00:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net>
 <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
 <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Nov 2019 09:32:55 +0100
Message-ID: <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
To:     Daniel Axtens <dja@axtens.net>
Cc:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 20 Nov 2019 at 08:42, Daniel Axtens <dja@axtens.net> wrote:
>
> > But the docs do seem to indicate that it's atomic (for whatever that
> > means for a single read operation?), so you are right, it should live in
> > instrumented-atomic.h.
>
> Actually, on further inspection, test_bit has lived in
> bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
> generic __{,test_and_}{set,clear,change}_bit() and test_bit()")
>
> So to match that, the wrapper should live in instrumented-non-atomic.h
> too.
>
> If test_bit should move, that would need to be a different patch. But I
> don't really know if it makes too much sense to stress about a read
> operation, as opposed to a read/modify/write...

That's fair enough. I suppose this can stay where it is because it's
not hurting anyone per-se, but the only bad thing about it is that
kernel-api documentation will present test_bit() in non-atomic
operations.

Thanks,
-- Marco
