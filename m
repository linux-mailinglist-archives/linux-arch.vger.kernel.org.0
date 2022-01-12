Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3950E48BF51
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 08:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiALHzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 02:55:40 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:42760 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiALHzh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 02:55:37 -0500
Received: by mail-vk1-f180.google.com with SMTP id m57so1090766vkf.9;
        Tue, 11 Jan 2022 23:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxRXtvjLv5dyZ8SH85L5LQavbuogqUJq1KHgO/SS6/I=;
        b=7rTK3ZIxX1oAsp7coIN8vn2RdRMNbtS5/YwTVhUU3+SniIVEULw5nIwAAyy8PfMeyp
         3JhjkpHrrUgs3Uz63FsBzUupYYT8bFzZ417c/6Ke4EXWVEYmAMAn+DPmdaiCioliHoOe
         2i9TZGY+xqAB6rujM3TFdrw3tY1wxmoRx00dbI3X4Zoq0utovFyXe5emfNC4c+AIn3Wq
         sB4LOcbaCpIL1iz3ZdTCOCBvIMT9DUUvvLBl3Z4meHXSYjqhQopbOV/jBMEZ7FEZPhdS
         RtyAfOJyjinaPs12kfwHdWmpiigyJHQkECufKXoQ4C3W06BpDuuEsoU8zStRqGVVLDgb
         c7UA==
X-Gm-Message-State: AOAM5325X+dkYDkGYleVoo1SGyYh0Z9bveuN2xwmLBYcE6xZjkEyZ+8Z
        szdngekkNBVzrjN/+2X+psfyILvNc3U5zg==
X-Google-Smtp-Source: ABdhPJwPnKfFD82cNBDQWO+q54QdRPVymagKcEYDtZpF+xa36+LW9K2CQYeouvXbTzv72xO25Z6CFA==
X-Received: by 2002:a05:6122:d84:: with SMTP id bc4mr3754259vkb.22.1641974136637;
        Tue, 11 Jan 2022 23:55:36 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id h25sm1603268vsl.30.2022.01.11.23.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 23:55:36 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id n9so136436vkq.8;
        Tue, 11 Jan 2022 23:55:36 -0800 (PST)
X-Received: by 2002:a1f:5702:: with SMTP id l2mr3790303vkb.33.1641974135789;
 Tue, 11 Jan 2022 23:55:35 -0800 (PST)
MIME-Version: 1.0
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com> <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
 <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk> <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
 <acf7b627-2dec-c76c-2aa0-6b4c6addd793@gmail.com> <d660267-ce4f-e598-9b40-5cdbb4566c7@linux-m68k.org>
 <6060f799-d0c5-e4c2-a81c-2bd872ce3d5a@gmail.com>
In-Reply-To: <6060f799-d0c5-e4c2-a81c-2bd872ce3d5a@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jan 2022 08:55:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJLfOKk-+gMbzVvG50vn8RBVsCdJAaysYWph01Ef-WrA@mail.gmail.com>
Message-ID: <CAMuHMdXJLfOKk-+gMbzVvG50vn8RBVsCdJAaysYWph01Ef-WrA@mail.gmail.com>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On Wed, Jan 12, 2022 at 1:20 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 12.01.2022 um 11:42 schrieb Finn Thain:
> > On Tue, 11 Jan 2022, Michael Schmitz wrote:
> >>> In fact Michael did so in "[PATCH v7 1/2] m68k/kernel - wire up
> >>> syscall_trace_enter/leave for m68k"[1], but that's still stuck...
> >>>
> >>> [1]
> >>> https://lore.kernel.org/r/1624924520-17567-2-git-send-email-schmitzmic@gmail.com/
> >>
> >> That patch (for reasons I never found out) did interact badly with
> >> Christoph Hellwig's 'remove set_fs' patches (and Al's signal fixes which
> >> Christoph's patches are based upon). Caused format errors under memory
> >> stress tests quite reliably, on my 030 hardware.
> >>
> >
> > Those patches have since been merged, BTW.
>
> Yes, that's why I advised caution with mine.
>
> >
> >> Probably needs a fresh look - the signal return path got changed by Al's
> >> patches IIRC, and I might have relied on offsets to data on the stack
> >> that are no longer correct with these patches. Or there's a race between
> >> the syscall trap and signal handling when returning from interrupt
> >> context ...
> >>
> >> Still school hols over here so I won't have much peace and quiet until
> >> February.
> >>
> >
> > So the patch works okay with Aranym 68040 but not Motorola 68030? Since
>
> Correct - I seem to recall we also tested those on your 040 and there
> was no regression there, but I may be misremembering that.
>
> > there is at least one known issue affecting both Motorola 68030 and Hatari
> > 68030, perhaps this patch is not the problem. In anycase, Al's suggestion
>
> I hadn't ever made that connection, but it might be another explanation,
> yes.
>
> > to split the patch into two may help in that testing two smaller patches
> > might narrow down the root cause.
>
> That's certainly true.
>
> What's the other reason these patches are still stuck, Geert? Did we
> ever settle the dispute about what return code ought to abort a syscall
> (in the seccomp context)?

IIRC, some (self)tests were still failing?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
