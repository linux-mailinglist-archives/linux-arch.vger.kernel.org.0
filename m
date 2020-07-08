Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9902821941A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGHXOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGHXOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 19:14:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30DC08C5C1
        for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2020 16:14:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gc15so2595014pjb.0
        for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2020 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYR6IzEE3oz+7wpFFvhpcTfqtHDsZd22LZz7dy8Rcrs=;
        b=rTjGSjVlJBB4jdk6XG0IoWtkdWEPchWM3kX0LUZqK+QG3RfYTKSh1HcjjG4R+e1Age
         9wC+YLJjGetare/KcKfoZRMy2G7Y3XktJSg/EvKyT2Y0Dcj6NrjWSPA3QJfX794lFLzJ
         /msYFXN5tisnhghC2UgmzFTKkbh1sgTrRsEiNGAcG3Uu/ZH9rLBvjuVi0wkFfGqOpbiZ
         uHMwi/tUA3/BNrV9msotuLeSv/cUDRmQHtepVUmJNx/XBEjS8IXDLT3Y00kUUV8DB5yG
         /S6aAefIn9xwlJazqRIwL8sg67hvU9nQHC4L5U4IHQpVEsnQvNVfDnU+IltJjtCZYmap
         aL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYR6IzEE3oz+7wpFFvhpcTfqtHDsZd22LZz7dy8Rcrs=;
        b=PKunN5FgbfRL2X5yhd5ARspQsL3Wh7vjoFVAY1Vp9Q2mXyLcdHb6URBbylv0OCCxfv
         eMvdYflij2JwMdj4roUn6yc31B/KAjiY57ZdUl1tDZsP6kfwjfOG00DqOA7nxXoRjYAy
         bdySEgtegB0ssdCbKBoXRGp0EFmpgXi560blQftSQlJrhXU4Q9L5NvupfIsaCGQQnYex
         nW3fzykRXwfTXJHoF5zCsmoh1oZ1M5Tk8YIaYn/HWDYysSYlxT5gyIqnXVimXqJDn7uf
         9Vfmp3luYxFz+ZDP110B3CFwsU+gCso0bTeNGXT4kXl+edJCWpJjMhEeSc6kn6Zf259c
         ML0g==
X-Gm-Message-State: AOAM532kcTVcSvIEo/CfbwobAHSbCifZeHVkzSKBa1kvg2g3lOI+qD6g
        CK4ryL/sCRKz/QrcPn32ooVUYs4Z68vKXpZaZObjYA==
X-Google-Smtp-Source: ABdhPJyWcE2sHGr6AH9cytVw+nIBQUYGxbilZCX6xRQxheRVwQBKF7gOxauthBDHsPRnr2wxHNeDZOCqINBLQjHgsZ4=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr12309187pjc.101.1594250046373;
 Wed, 08 Jul 2020 16:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200622231536.7jcshis5mdn3vr54@google.com> <20200625184752.73095-1-ndesaulniers@google.com>
 <CAKwvOd=cum+BNHOk2djXx5JtAcCBwq2Bxy=j5ucRd2RcLWwDZQ@mail.gmail.com>
 <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com> <202007020856.78DDE23F4A@keescook>
In-Reply-To: <202007020856.78DDE23F4A@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Jul 2020 16:13:54 -0700
Message-ID: <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 2, 2020 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> This looks good to me. Do you want me to carry it as part of the orphan
> series? (It doesn't look like it'll collide, so that's not needed, but I
> can if that makes things easier.)
>
> Acked-by: Kees Cook <keescook@chromium.org>

If you would be so kind, I'd owe you yet another beer!
-- 
Thanks,
~Nick Desaulniers
