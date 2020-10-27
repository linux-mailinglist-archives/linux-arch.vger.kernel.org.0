Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4829BBA3
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808832AbgJ0QXI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 12:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1808828AbgJ0QXH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 12:23:07 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C062B22264;
        Tue, 27 Oct 2020 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603815786;
        bh=r7rQVF9LabIVD7nWmXvKsRhnaf835k2Wdgbqs+CkJTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rg1Hj1yb4XBiRX8YVgp30MC6dAekeTlenDxWOU6mVJ4Y1NXUsiI2jabdUjZmJECji
         d/gqU+xC8IGbMMULth+G1aVYKskM/6yQ1rB4KvNY2tE0LnTMcsePFkrNVkc8Mm9xEY
         odxv1fW6rH2J2WFc9278lQk0+ZyYiAam7cI0v5Wc=
Received: by mail-qv1-f46.google.com with SMTP id s1so916813qvm.13;
        Tue, 27 Oct 2020 09:23:06 -0700 (PDT)
X-Gm-Message-State: AOAM532/WeygaOT8RXCkIHhuEonbYfVRhnIS9rEXoJDreal8DVNwPmRm
        HUC36ENzrCDRfWz2CBXdT4eWhbaunrNTUJAe7L8=
X-Google-Smtp-Source: ABdhPJxsz9IgovQ0POJj/hyJTIMJyG/SHG3D287fQI+OPUkfvbn07uZDzhZ795PgfFU0fYqDJl6hab9mpFYefWxFIXA=
X-Received: by 2002:a0c:b58c:: with SMTP id g12mr3294297qve.16.1603815785774;
 Tue, 27 Oct 2020 09:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201026165807.3724647-1-arnd@kernel.org> <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
 <20201027074726.GX2611@hirez.programming.kicks-ass.net> <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
 <20201027103236.GZ2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201027103236.GZ2611@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 17:22:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3GqsXcdA59V7XGd_yFr_68yCaftdc-wMM6bHG8NEE1+g@mail.gmail.com>
Message-ID: <CAK8P3a3GqsXcdA59V7XGd_yFr_68yCaftdc-wMM6bHG8NEE1+g@mail.gmail.com>
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 11:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 27, 2020 at 09:33:32AM +0100, Arnd Bergmann wrote:
> > On Tue, Oct 27, 2020 at 8:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Mon, Oct 26, 2020 at 02:03:06PM -0400, Waiman Long wrote:
> > > > On 10/26/20 12:57 PM, Arnd Bergmann wrote:
> > > > Yes, it shouldn't really matter if the value is defined as int or u32.
> > > > However, the only caveat that I see is queued_spin_lock_slowpath() is
> > > > expecting a u32 argument. Maybe you should cast it back to (u32) when
> > > > calling it.
> > >
> > > No, we're not going to confuse the code. That stuff is hard enough as it
> > > is. This warning is garbage and just needs to stay off.
> >
> > Ok, so the question then becomes: should we drop -Wpointer-sign from
> > W=2 and move it to W=3, or instead disable it locally. I could add
> > __diag_ignore(GCC, 4, "-Wpointer-sign") in the couple of header files
> > that produce this kind of warning if there is a general feeling that it
> > still helps to have this for drivers.
>
> What is an actual geniune bug that this warning helps find?

I've gone through the git history to find something mentioning this
warning, but there was no evidence of a real bug that could
have been prevented with this warning, and lots of work wasted
on shutting up the compiler.

The best case was
https://lore.kernel.org/lkml/20201026213040.3889546-6-arnd@kernel.org/
where changing the types led to also making it 'const'.

> If you add that __diag_ignore() it should go in atomic.h I suppose,
> because all of atomic hard relies on this, and then the question becomes
> how much code is left that doesn't include that header and consequently
> doesn't ignore that warning.

I don't think it would work: the __diag_ignore() has to be in the caller,
not the function that is called.

> So, is it useful to begin with in finding actual problems? and given we
> have to annotate away a bucket-load, how much coverage will there remain
> if we squish the known false-positives?

In an x86 allmodconfig build, I see 113618 -Wpointer-sign warnings, 68318
of those in qspinlock.h and qrwlock.h. With the six patches I sent, the
total number goes down to 15201, which of course is still fairly pointless
to go through. Almost all of these are in drivers that have less than
10 warnings, and few of them are in headers included by other drivers.

I looked at the top remaining files, but couldn't find any actual bugs there.
If there are real bugs, they are certainly hard to find among the
false positives.

I have already sent patches to move -Wnested-externs and
-Wcast-align from W=2 to W=3, and I guess -Wpointer-sign
could be handled the same way to make the W=2 level useful
again.

      Arnd

----
   1764 ../drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
    810 ../drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
    411 ../include/linux/moduleparam.h
    230 ../drivers/net/ethernet/neterion/vxge/vxge-ethtool.h
    184 ../include/linux/nls.h
    150 ../drivers/scsi/esas2r/esas2r.h
    146 ../include/net/tls.h
    144 ../sound/soc/codecs/wm5100.c
    135 ../drivers/scsi/ufs/ufs-sysfs.c
    130 ../include/sound/hda_regmap.h
    125 ../drivers/scsi/myrs.c
    121 ../include/linux/fscrypt.h
    113 ../drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
    105 ../drivers/net/wireless/ath/ath9k/hw.h
     81 ../drivers/staging/media/allegro-dvt/nal-h264.c
     75 ../drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
     68 ../drivers/scsi/esas2r/esas2r_init.c
     56 ../sound/soc/sof/ipc.c
     56 ../drivers/staging/qlge/qlge_dbg.c
     50 ../sound/usb/mixer.c
     50 ../drivers/net/ethernet/brocade/bna/bnad_ethtool.c
     50 ../drivers/isdn/capi/capiutil.c
     47 ../fs/nfs/internal.h
     46 ../drivers/scsi/esas2r/esas2r_int.c
     45 ../drivers/scsi/qla2xxx/qla_init.c
     44 ../drivers/platform/x86/sony-laptop.c
     44 ../drivers/lightnvm/pblk.h
     43 ../drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
     43 ../drivers/media/pci/cx25821/cx25821-medusa-video.c
     42 ../sound/pci/au88x0/au88x0_core.c
