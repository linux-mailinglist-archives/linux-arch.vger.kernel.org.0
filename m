Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79E369932
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDWSS5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 14:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243465AbhDWSSu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Apr 2021 14:18:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1C0B6144E;
        Fri, 23 Apr 2021 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619201893;
        bh=e/Ao27bZlhQHDgXcpoTUwE3h91lxc91Kp/o0D/falf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWSeXmKddMok/JeoNc7XhYPNRdCwX9BwjS+uH7kQpypIdEzupPeL/8tfOHYhC6k+y
         gME/vCMND+DK7Hjmal5q11oxTx8UHHVMSVnCtp1GEjNqVfBt1or+r7yPMc4QFWwOfv
         dBobaW7W+ZzBlEDzl/JfUkoDoNwChbM6dLcqLPiJM6GNagj6L6P1UHOoG/fw0wX2KV
         z2x7qNLDe2fk83WgfYjCDKZWZUZmoxoYMsEiewJaajWeS0A+HC05FsJA/IURg/pLOS
         UfqFiZPNBwIugTfNtJnv/elxEke98rV6IdL8DyCPeLl4TwgKRXLgnE/a1B/+UcBOx0
         h1ZA1NCk0K5VQ==
Received: by mail-wr1-f50.google.com with SMTP id r7so37254829wrm.1;
        Fri, 23 Apr 2021 11:18:13 -0700 (PDT)
X-Gm-Message-State: AOAM532ifaEcYC1c0cRGM/r8sbM/dXmd6u7PXGzrtfOciLBde3BBhDtH
        HDPkQGqB7gv4b7R52qm+40ZmjFfaPU50ct799hA=
X-Google-Smtp-Source: ABdhPJyN9NpTvp/OImy1fiYKHwzZHkIPf6zp56815tXPY/JfAZvo/zXa/L7S7BMaY18Ob4RQcAWfF5e2HX5fhCfbBnw=
X-Received: by 2002:adf:db4f:: with SMTP id f15mr6209879wrj.99.1619201892354;
 Fri, 23 Apr 2021 11:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
In-Reply-To: <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 23 Apr 2021 20:17:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
Message-ID: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
Subject: Re: ARCH=hexagon unsupported?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 23, 2021 at 7:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 4/23/21 2:36 AM, Arnd Bergmann wrote:
> > [1] https://lore.kernel.org/lkml/04ca01d633a8$9abb8070$d0328150$@codeaurora.org/
>
> There is no current gcc C compiler in the 3 locations that I know of to look.
> The one I tried is v4.6 and it is too old to work with current makefiles.

Correct, as I understand it , work on gcc was stopped after the 4.6 release and
any testing internally to Qualcomm was done using a patched clang. A few years
ago this was said to be (almost?) entirely upstream, but as Nick points out
it has never been possible to build an upstream hexagon kernel with an upstream
clang.

       Arnd
