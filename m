Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE220F9E3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbgF3Qxd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jun 2020 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgF3Qxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2020 12:53:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFFC061755
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2020 09:53:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so18833854lji.12
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2020 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXhwNHUbt6390YwktKffDdYHBSIVcgUbNP65DA7M3A0=;
        b=YMxx5tmKReY0G4VCKq7dPV+KYWq8YMTtgf6DfgbvR0/q13+4ttOunbsr+WSE+ofeb/
         r3a0G5HpoHjV5n3v6+nWCRNTnxYHJcu8FXl7c/4/iRgcSKImTR4CfCW4aybv77HLiBJo
         rAox9lSf8Z1KnYQLFVFltvKxte2/w24THOXww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXhwNHUbt6390YwktKffDdYHBSIVcgUbNP65DA7M3A0=;
        b=H2g8+2Kq/vDWqW1sSUyh14xGckQuNtZLlvS8jkpPqsv3+KvU1OvMe3e+NeDN6aFrGz
         BV5cR2PqFfqCC/AJxFI0DBD77fenINmhGre1EI1BWcR2JAUkJt7Vd27XA+PzwZw7vU+k
         dicUEHl3foGaPsHPFI6KgMaHADaA+CgIDDNULvBnRZm0RnBcVwET59ZyXrrrYVcarOeq
         Sub1R73WAj2uK2G503BGlaZtzqVWUcDm8aCirVo9hg9IYsEDdwzRKK7KT53yhoxwvFvO
         mPjgJcBO0tjSXXj17QgHyWmklat2uIk2bpt5amo0E8Me5ePhq4lX5TYHHBU1sxm8bKbZ
         YVTA==
X-Gm-Message-State: AOAM530Xaequw28O4S4VOvHqf2WT6EXCj3XNNzbc2w7NidW4Ikuv0j6B
        un304zvOsVfYq0SIxSsUWLX27nMueys=
X-Google-Smtp-Source: ABdhPJz8Bw5ixUR+E/PqVO4vlSwvfTw6UuYryZByiAUzriNZX5YKxu7Nf2JG67EPJXtuUg+Z+YaqaQ==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr7985734ljg.105.1593536010676;
        Tue, 30 Jun 2020 09:53:30 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h15sm894536ljk.24.2020.06.30.09.53.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d21so11796566lfb.6
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr12519698lfn.30.1593536009235;
 Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk> <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
 <20200629203028.GB2786714@ZenIV.linux.org.uk> <20200630132508.GF2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200630132508.GF2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 09:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
Message-ID: <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 30, 2020 at 6:25 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How about ->regset_get()?

Sounds good to me. And if you ever do something similar for 'set', you
have a natural name to pick.

No need to repost as far as I'm concerned if it's just the name change
and some minor nots found by the bots.

                     Linus
