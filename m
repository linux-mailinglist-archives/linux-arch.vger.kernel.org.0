Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D7A306880
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 01:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhA1ARv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 19:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhA1ARG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:17:06 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D5C061573;
        Wed, 27 Jan 2021 16:16:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f11so4244001ljm.8;
        Wed, 27 Jan 2021 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+CxbgHhewFDtl0hOJkTr6YpKFMtg4E/89fwAacziT4=;
        b=lokt8B+aT6AZZ4Y+WCkvNtrsbuHGkAEJQlGCIEgflEnQ3LGImcMxouOprjGxes6Vtr
         /pWktiiGwtLaLNsd8/g/zC+60oeRNLWTgxo+mHWP1ZUY+InR+MJ0dek/qESoFZ/9A7ZB
         ctJLEw+G8Jxgabzu93hbB0Qgq8xc6HRMezeJEQcbDtT5v54Q11f0aHk5K93BDezniahG
         A74YZ9KB3hl0elnt7ly1nEjST4rRgUd0ce6gPxF+KlmOYqTYCS2zsNnUfWESeb0jiEcS
         shPG9u8W4j95H4INo090E3pGJ/CpVeWErEFWERJYhWHq9FipTLybnW41QKwQOS022ZAx
         uN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+CxbgHhewFDtl0hOJkTr6YpKFMtg4E/89fwAacziT4=;
        b=lVrrvKGfINRGbefsWMOuB9GmWcCttQ5DTOwjvvB3+CXGE6KxxvFrSHZnHufhg3JiQB
         rV4WCaS6567mt4wyGySrDa+Hmw3WAKFBIqnkAuYgevwROuZT3d4S428ZpH+qKbshwxKd
         a/DtpMgeK9Xe8wihMUsu+ykSuD4eaAtXg00eDAIKs6ORxlH0uRVFM2JV+4LkSZ1aOYDi
         zu5xp25dMfJe8XnKcDJuqklB7CADqoRmfN7voOp17Bu08N/gsbOGeerBFSxt3G88ZsRa
         be+ajyMofobCb9vUdIWgvF478TwqF0XaWZFSpz4Ti3TWVy7oE5EprCJvXvZDXMc8L1+G
         yRLw==
X-Gm-Message-State: AOAM530aIkpMjpI8pCiwL0Fvxf4wtCuIxidQs8bjZ7WydmDMMzySUy4k
        SD6Sg1TLSaMU4vZY0+1ZqjBsZ6C3JGfRRwHaUIs=
X-Google-Smtp-Source: ABdhPJyWf5ElHaPYB34dDkQrtN3rzXYK/Dm6sucUgk+DrAOGQH7th1fTMDJm/ux+DdvEMVeyDwmFlvEbcO7uBDtDt1A=
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr6938544ljc.46.1611792983966;
 Wed, 27 Jan 2021 16:16:23 -0800 (PST)
MIME-Version: 1.0
References: <877do3gaq9.fsf@m5Zedd9JOGzJrf0> <87zh0u540n.fsf@collabora.com>
In-Reply-To: <87zh0u540n.fsf@collabora.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 28 Jan 2021 00:16:12 +0000
Message-ID: <CAGqt0zxVN2HpXrY=L0D7+6p3Lr1rCt_z_Aa=O_-VxfCG18Wbkg@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore the previous single step reporting behavior
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel@collabora.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Wed, Jan 27, 2021 at 11:55 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Yuxuan Shui <yshuiv7@gmail.com> writes:
>
> > Commit 64eb35f701f04b30706e21d1b02636b5d31a37d2 changed when single step
> > is reported.
> >
> > Specifically, the report_single_step is changed so that single steps are
> > only reported when both SYSCALL_EMU and _TIF_SINGLESTEP are set, while
> > previously they are reported when _TIF_SINGLESTEP is set without
> > _TIF_SYSCALL_EMU being set.
> >
> > This behavior change breaks rr [1]
> >
> > This commit restores the old behavior.
> >
> > [1]: https://github.com/rr-debugger/rr/issues/2793
> >
> > Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
>
> Looks correct to me.
>
> To gather the right attention, you should directly CC the correct maintainers.

Thanks, will do.

>
> Fixes: 64eb35f701f0 ("ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag")
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> --
> Gabriel Krisman Bertazi



-- 

Regards
Yuxuan Shui
