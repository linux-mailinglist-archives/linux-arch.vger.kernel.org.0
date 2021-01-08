Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93AF2EF4D3
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbhAHP3i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 10:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbhAHP3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 10:29:37 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEABC061380;
        Fri,  8 Jan 2021 07:28:57 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k78so9650178ybf.12;
        Fri, 08 Jan 2021 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKw2HwUaUtTuIJ0w4dQuJ9PUiaN/gE1gb9ww9jkmSJ4=;
        b=UGAjSljF1NbCHhKeQJ46vxAucacTq2+5+BiSThFQnBGp772s7ziwerPXp7IhBGo8ig
         NwssfgYJSIkKa9oLNn3Z3zPaPwscDIXPXW4huWECqQRmNK0T36hT9nDGpM5IdHN5wbEE
         nkNDB/35zAWhXk+Nhku6kGnwIRv/HK67m04F/qEy2hXTwXMyxxEvY6xi0oaa3foZ1bW2
         2enSbY37CDQINmTro+j1trzcSAxc/aRULTiLYOi5uBpNv/Lv4xbb6iYcTOHFn03ceeEB
         0r4mLA6C84m9waq/eAFp7H7Kngjw/x5EYUpZI0SEv4SVzwCTpdiYc53WFSXBv804WBJT
         Z9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKw2HwUaUtTuIJ0w4dQuJ9PUiaN/gE1gb9ww9jkmSJ4=;
        b=BDiOPimoBygEiaODbqQT5aOAvbgy1e+dcP4frXn7mAQT/MmR7kB5OKPiKl3Pgac2BB
         Xlxhzaks7zyW09M1/xQuneSbw0EkznsB4O/abBdSzP1+y+MNr0BPBwp19vx8i1IAFYSi
         wV6JE2TkapUi6P7/x9hhMVV1aqbHOFCzKEs4s9M5kP1onKQ5GOZVqauXuHJBRqkptBuU
         u1jKs8plHEFap2ZoQGIrqQPEBwmiwti4OE0oI5BKOVYqZua+Cj9c0k2LP8jdRrlg88+2
         LvVm7jzyZNpA5/jIEMUCGax8UwyXJ+LI4dK5JQuJvYZsRLFg28SRRVuE9ZlTpVx/IUJv
         xhEA==
X-Gm-Message-State: AOAM530YjKBN/aLQP8guEr5qvL6evuywvQvPLsLq+opg2Sb9sQJTI53T
        tKMOUsTxrEm5vqWZVNCZzQWBpbhjWo+646NcmVw=
X-Google-Smtp-Source: ABdhPJy7dH1SNtTb48kyLG93hd3DqyXHCp0loq6obJ4fDoJ8H4pR3s5lMvRCbPGr25d3mv9AKyjus6IRcEWyY61UEHs=
X-Received: by 2002:a25:538a:: with SMTP id h132mr5844856ybb.247.1610119736822;
 Fri, 08 Jan 2021 07:28:56 -0800 (PST)
MIME-Version: 1.0
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
In-Reply-To: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Jan 2021 16:28:46 +0100
Message-ID: <CANiq72m32vW8qpUmC2sxxXb1+g61xPCVtOckYrzcQB9XoUyNVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
To:     Preeti Nagar <pnagar@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 8, 2021 at 10:52 AM Preeti Nagar <pnagar@codeaurora.org> wrote:
>
> We want to seek your suggestions and comments on the idea and the changes
> in the patch.

Cc'ing Nick manually since his email domain was (again :-) incorrect.

Cheers,
Miguel
