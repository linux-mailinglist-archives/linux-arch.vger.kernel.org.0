Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14245264F9
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2019 15:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfEVNsh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 09:48:37 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32908 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfEVNsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 09:48:37 -0400
Received: by mail-ua1-f68.google.com with SMTP id 49so886976uas.0
        for <linux-arch@vger.kernel.org>; Wed, 22 May 2019 06:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNth5U4VpnoOGp2MIw15Nbzgf/Pxzs8ZMasphDKc4to=;
        b=k41smxpJ5+iQw0gjo/bA5cIQySzp0vYmImPRNnW0kLy1tbaGSnK6gM2IHmMIbtVgx8
         W4+yF5mBs4FR71cnnNDxfUL7iGU60JBYONZDa87JPKDSviGQUP0DUKqKwTuvvy+b7EV/
         /cuz/U2ZjdE8+6ZxDuAGN61dE2vllL5jmHTG6WUybo/4Ql9OuHn38/48zaKm9MgJsqv7
         x6pmfGpHI3itfjXRZqLNtYCCAh9UTnQAy6RtVRFLrdIW+8RFWFzEh7MMEJV+cVeULsJ3
         ZFZnNBnHVXQf4dCtmZS0Fko/Hqy6+qULFB7psreHT6PC+MJbA1V7pTJaAj+fdWgPwy+4
         z3YQ==
X-Gm-Message-State: APjAAAXZSKk5zAswjPmq8MW8GglCpkKfnORMCSfKPgV2qyaWymRNRF9g
        kMgzDYeC06R4Pp9tp3Zn1Kpw5j1wIHyZbc2j/zk=
X-Google-Smtp-Source: APXvYqz3DyT94dapeJVWAZg9UCKvOQ5s6Qe3W339iXw99/vUQsKQCs0lrfG0Jet4tua9hvM0JXiDmzZ1NrKiZi7MiD0=
X-Received: by 2002:ab0:42e4:: with SMTP id j91mr22921892uaj.28.1558532916107;
 Wed, 22 May 2019 06:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190522132754.46640-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190522132754.46640-1-vincenzo.frascino@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 May 2019 15:48:22 +0200
Message-ID: <CAMuHMdXoUWHk-RvgwbDc0YZ+KnBSaL+1XE2n134oAVR7Y5jazg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Fix spdxcheck.py
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, jcline@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Wed, May 22, 2019 at 3:28 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> The LICENSE directory has recently changed structure and this makes
> spdxcheck fails as per below:
>
> FAIL: "Blob or Tree named 'other' not found"
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 240, in <module>
> spdx = read_spdxdata(repo)
>   File "scripts/spdxcheck.py", line 41, in read_spdxdata
> for el in lictree[d].traverse():
> [...]
> KeyError: "Blob or Tree named 'other' not found"
>
> Fix the script to restore the correctness on checkpatch License
> checking.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jeremy Cline <jcline@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks for your patch!

Looks the issue is already fixed in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/spdxcheck.py

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
