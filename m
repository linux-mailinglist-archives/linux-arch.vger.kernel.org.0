Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5034F992
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 09:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhCaHMu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 03:12:50 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhCaHMX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 03:12:23 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MlNYj-1ltOCO0s3R-00lkAd; Wed, 31 Mar 2021 09:12:21 +0200
Received: by mail-ot1-f41.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so18031279ota.9;
        Wed, 31 Mar 2021 00:12:20 -0700 (PDT)
X-Gm-Message-State: AOAM532bQTsnUGyigP0s3eh2YvOR3hUzUGBBUtc+R2nMMlYZyQAdxsdV
        GAQp7GxTR0iltHiQL5A5FPq35xW3UQgXop3xM+M=
X-Google-Smtp-Source: ABdhPJyDDdJN4bOkBUX/6z8TQTYJT7CTrMHBr52q+GIbBO0fps9qLwpUyqCwRyTxF2TfGzWqXN6oPJ/d9KksN2Qfcso=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr1622938otk.305.1617174739722;
 Wed, 31 Mar 2021 00:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
 <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
 <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
 <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com>
 <CAJF2gTSGLn7katm6YAtkKWJcQRqw36_yqn+aK1pKUSRM5V1zUg@mail.gmail.com> <CAJF2gTSXY1fCBSZ-Z=8_AcRxoiCOoaNu-5A_JximGJxZY18RzQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSXY1fCBSZ-Z=8_AcRxoiCOoaNu-5A_JximGJxZY18RzQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 Mar 2021 09:12:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3EXJorMNFpG0_M3W2KFNrEqyoYBU9Cp-Fr=HJAZ9KGNA@mail.gmail.com>
Message-ID: <CAK8P3a3EXJorMNFpG0_M3W2KFNrEqyoYBU9Cp-Fr=HJAZ9KGNA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2DyaxPUAz+RptwI9Ku7FGAF0b+L3WKMSYl8jBJ7nLVS3NCFt+Y9
 epHIOuq46qnputgSXY2FeS4dWcLPByTIhUDdoucYGR55qnhqdGF8KZ4TUp/VHDAqssKTCjs
 ctlkF0Edf6qfF2IDITbj05lXESoRCSZPpRmdSntuPHXMPyV0bfjm5bEUmWDrwsZRQ/B86hz
 BJarld8qxKWiI4nfn9GxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zY+hQ+YCRp4=:jzbxuh3vaXmenlvenWzG78
 MqJiAj/Pzm9HebecbpFAAZRcXo0UNzKcbuOSuHXGycgczQjIplWoC/36afoY6h4DvOgIeaxN7
 3hd8BPK5TlUz4pEIVjs+q7y+LUL2vCgdXyUTUK5A83sSCs4A+D+keJ4Cu0Z+f3uQimR+8Fwdw
 mrf9J3125qbeCUXB2jYIFzBHZ+isc5Eyi+MsyqYG0p0Wv52r2X4nKfVJp24iuzjiCcLExfWjC
 gH48IH8fjc8NaQEoTBBUUiI/+tEqBmUhUIW5TAUBXJMkQYEO9zwS5+7IdiKEshLIH/eUylBnI
 BlxQb76AZ2q3pkkxYYXpkIklGymtUEo/HOqkubssgKtIfBjG9IkdwLSTcu4DTiLuuH85tKndL
 qp/hQaNFL9e5m37HddR3PcQMu5TXqFWKs6JGZDZepc5TvxVJ3fM3sfqjYRzN8I+7rlsHoLlN3
 +y9PFwyRyUCfHZ5ZvDzoRrjkBcp8vZEomCwNf9QYVve/M1NOxUI/WL6N4xLsYnXPuBSrXn6UA
 pBbt3GQytgocHC2+tgHkgIrgb4f2cM8hYTtALYi5duKA6GVKYS3HjeHS5rsKWq+4L1N22asqC
 QU+dajR66w2zs1lC2yoywaighhIDKL9ab8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 8:44 AM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Mar 31, 2021 at 12:18 PM Guo Ren <guoren@kernel.org> wrote:
> > On Tue, Mar 30, 2021 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Mar 30, 2021 at 4:26 AM Guo Ren <guoren@kernel.org> wrote:

> > > As I understand, this example must not cause a deadlock on
> > > a compliant hardware implementation when the underlying memory
> > > has RsrvEventual behavior, but could deadlock in case of
> > > RsrvNonEventual
> > Thx for the nice explanation:
> >  - RsrvNonEventual - depends on software fall-back mechanisms, and
> > just I'm worried about.
> >  - RsrvEventual - HW would provide the eventual success guarantee.
> In riscv-spec 8.3 Eventual Success of Store-Conditional Instructions
>
> I found:
> "As a consequence of the eventuality guarantee, if some harts in an
> execution environment are
> executing constrained LR/SC loops, and no other harts or devices in
> the execution environment
> execute an unconditional store or AMO to that reservation set, then at
> least one hart will
> eventually exit its constrained LR/SC loop. *** By contrast, if other
> harts or devices continue to
> write to that reservation set, it ***is not guaranteed*** that any
> hart will exit its LR/SC loop.*** "
>
> Seems RsrvEventual couldn't solve the code's problem I've mentioned.

Ok, got it.

        Arnd
