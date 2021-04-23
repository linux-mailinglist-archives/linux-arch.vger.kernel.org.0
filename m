Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601E836998C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWS1d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhDWS1c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 14:27:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C595C061574;
        Fri, 23 Apr 2021 11:26:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g38so56668754ybi.12;
        Fri, 23 Apr 2021 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usW4K6lNB80DxgPMKXGwbs60wwBIL6B9yLZGCMNyXto=;
        b=RKHxCjbwiYoJu18YQepeMR8QGc0vnj8LX0se6valfLiMgyRphjvbPmL0/miLszk4wy
         z8tHgiA3gETAtwHTPdV93LWLoMHjYHk+gRJR76OiSloyQROuaRPl++UT9+2kM24a8uc5
         LfKflQoIm5HxQdstQmWvcZkpVOMJ4su1hHKqtdIcyzVix9lixDGLdwVeCD5O4CadZBJv
         DSKoFI4gJ/3XmgLvdhLCGs8sMIEscghdw6ZaEfmAg3pIC20MQxLAa7nSxD3DBeEmPGKM
         duvnUePvxjVei1WzXrXRSjG7+aSto5yuVXAt2Tz0MfAG/AJBPUH0d6+2b2nGVYgspUFx
         Pqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usW4K6lNB80DxgPMKXGwbs60wwBIL6B9yLZGCMNyXto=;
        b=a2NSff+9vH2ekdMqb2qBFpIWe8kvXIVBWItDMYWxi4xiZ/HnBd1cTjs91MabqY8vt7
         Y4Z1RfQXDisTpdBajLZufeSaohhtlNOP3J77Gdwx1icKxftue9MdF1tVjYDbc9Mmi+Dj
         mHcJGd5BbJNfYSqU87owIrvPLXzSMLCyayIjz9zmIbXH5cp1FDqoNQ7mHkb9gZdn/eNJ
         KNZp7sCb3uGu/85lIB/eTY5kaILRA2b1C5ksEy3AkYgQ6A0yfMEU8KoDrolgp2HP98HD
         7+bDFrHCdP2G1ru7PTxcE/zLsF3pevkFGnIDXA3IHGD/+HUGYU5WnroU8HYC8cC0RAOO
         iu1Q==
X-Gm-Message-State: AOAM531dJZ+RlpC5U7mv0pyrMfAlTrFX7NSJeYMhGBFQbTW+zCekiURE
        y9ywPy98ACT15dUpF9t346HDEhF+BtQNe8TqNOs=
X-Google-Smtp-Source: ABdhPJzDy2BHUKe38AJkXoVl5skypgLMZejlaNr6k/YTvsD6VVijOpBgEiZHh9b9Di56K05jwiSkGuSHla/qYSlWrKY=
X-Received: by 2002:a25:818f:: with SMTP id p15mr6881986ybk.135.1619202414411;
 Fri, 23 Apr 2021 11:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
 <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
In-Reply-To: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 23 Apr 2021 20:26:43 +0200
Message-ID: <CANiq72kNVDAiT+=SDuFNkC90=cJFqOYfHy60oiqsht6mcEDeYA@mail.gmail.com>
Subject: Re: ARCH=hexagon unsupported?
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 23, 2021 at 8:18 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Correct, as I understand it , work on gcc was stopped after the 4.6 release and
> any testing internally to Qualcomm was done using a patched clang. A few years
> ago this was said to be (almost?) entirely upstream, but as Nick points out
> it has never been possible to build an upstream hexagon kernel with an upstream
> clang.

It is pretty much dead code then. It would be a good idea to be a bit
more strict on this, i.e. not let archs linger in mainline if not
properly maintained. I would go even as far as requiring some public
CI logs for all architectures building -next/-rc as proof that some
configuration actually builds with some compiler, even if the compiler
is not an upstream one.

Cheers,
Miguel
