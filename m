Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2F3D500F
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhGYUUG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jul 2021 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGYUUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 16:20:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9AC061760
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 14:00:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u3so11717054lff.9
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s93PjnjW9/K/rkkoUe5HsggZSZ91WNZAKZYrclvIW4A=;
        b=UTAwUwmhVz95UmUWDa3BHDUg8VUs6qWZrq/JmP5to1aZRfT9wZ7yNVF+c7li4IejL2
         EWiocEUV/85e+2z0tMFMFMdN5il1kbITG6F9oelwaVncnfbS5Gyg9ijjkunjn2sbfVxN
         6PR1uH9IegTiTxnIQHMzsQSRej8GvmsAvkOgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s93PjnjW9/K/rkkoUe5HsggZSZ91WNZAKZYrclvIW4A=;
        b=bbNZfoIrgwVdLG51qmm0gmHtVuru52kOkGKURM/N0btTAJY1ojgixyJLYSFgphzKBi
         MZKFRqJ8xh8hvaP4ZsRewbCuxppI7wYeg4GkffKzxm/50zu7qZ0Lc4MdzYB6dyV0E1eX
         AKvAwRzhFdkR9RZE4AmFizz/zLVj9xc6sIRsfU1TttGwHurn5vexgvhTxmaUvCqT38rM
         KCThFvUd1CFmdl0x5MhsHWxDFIzYzvw2mv+CgdojEmxeSOODa60+6xSG9BsRgtM/4NqO
         FTNgHk8T/74X2q+9eFhU957y5mgP6h4yGWrPtGeHdfDnlh//K4LbIBBrxYKfRRv6CuE/
         uTeA==
X-Gm-Message-State: AOAM530ZWD0GAp2ZZXKmvMHV+BQRoUJjm3nZar3XJADnLcEZsY3Y25Mt
        DwoS4D9JbnEbWyrwF1zhGon00287KTmZBhEz
X-Google-Smtp-Source: ABdhPJygNpv1EL05bkFusuX397pzgTLHluhqjjrrXlDE/bGziiOmKlqhEThBKkHyNSApUIhCcgIOpg==
X-Received: by 2002:a05:6512:2283:: with SMTP id f3mr9110784lfu.400.1627246830762;
        Sun, 25 Jul 2021 14:00:30 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y3sm3994807ljj.121.2021.07.25.14.00.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 14:00:30 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f12so8888426ljn.1
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 14:00:30 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr9937992ljj.411.1627246829850;
 Sun, 25 Jul 2021 14:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <1624407696-20180-4-git-send-email-schmitzmic@gmail.com> <CAMuHMdVA5d7z6awGrpJ+Tb3PRxz7Nczd_SLXZ=cAwsS8tFU_vg@mail.gmail.com>
 <f99d3d82-150b-62fc-3b38-141710a4826e@gmail.com>
In-Reply-To: <f99d3d82-150b-62fc-3b38-141710a4826e@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jul 2021 14:00:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVFUJAD62jtpbbKddu1ZeGF+nR4VuTGzQjS_ncCa5nQQ@mail.gmail.com>
Message-ID: <CAHk-=wgVFUJAD62jtpbbKddu1ZeGF+nR4VuTGzQjS_ncCa5nQQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] m68k: track syscalls being traced with shallow
 user context stack
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 25, 2021 at 1:48 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Just out of interest - what would be the correct way to set/clear a
> single bit on Coldfire? Add/subtract the 1<<bit value?

I think BSET/BCLR are the way to go.

Or, alternatively, put the constant in a register, and use a longword
memory access. The arithmetic ops don't do immediates _and_ memory
operands in Coldfire, and they don't do byte ops.

Or something like that.

              Linus
