Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E763A5A43
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhFMUCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 16:02:24 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:44711 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhFMUCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 16:02:24 -0400
Received: by mail-lf1-f42.google.com with SMTP id r198so17416086lff.11
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmFk46LbfcB3tAW54oV0NNBNWVA8tw96uj/nEJbZX8c=;
        b=a8Ut4B9E3xQKleA2HYV5SURYsoc9doZ0SmKgf7wFF5ZvDPBJRRSuLis0laAkUgqZm3
         0p9iNre0QjG8xFiWbULLQ4CrdXfHRBnqL8pDuUWAfL03X4Xd4pGGJfJ8UbTXwVoK1cz3
         tA6ONd50v/3mnPhHfr2vLOGXKEJxcJxOUlWR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmFk46LbfcB3tAW54oV0NNBNWVA8tw96uj/nEJbZX8c=;
        b=hIa/pNuujbK5/vC/8zXc9LSLqlaHJtq1aesg5uOULPAEIs+IrlJ97Svrhzi1Y90ObU
         jkY5Q7+HKkwtgRE+8y5pvBw5oeML1pWkvSPqDCQzNcbarzqPIsIeZmvC8HzB/KnQzFKk
         KsH23z+ABX3gYwxuARnq4g8hK48r+7Aa3rHjDLnMsfKj5dmMYN1Jo476tuIi7xvSHXak
         8WvOFh2M6Wv0LOo3frAabUisQ8uJloAJYMi4xFFhgM8abytqYk77RDrzJnPkl4S6xatQ
         VCFyFwdsB/WEKBuZbBoOQ2+3RUzOlldIFd7NhYd7zR6P3yB0alguhZL1pOusSE5VuBTw
         eGiw==
X-Gm-Message-State: AOAM532BDL/Yw862ILv8Lkh9XmkADoCJI7sVSxOTny69EM7vkuefumAZ
        /wxXPwKPKx+EPnzW0XgW/hugszvxIZkCPH07
X-Google-Smtp-Source: ABdhPJw3wfVpnu04+kYpX7MVtDCgv+djzThxdFS+sG/inSJjU5lyD1KE/buwWgc2IQDvdpw+IIqbkQ==
X-Received: by 2002:a05:6512:23a0:: with SMTP id c32mr1677792lfv.554.1623614361259;
        Sun, 13 Jun 2021 12:59:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id x11sm1264540lfn.137.2021.06.13.12.59.20
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 12:59:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id l4so4610059ljg.0
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 12:59:20 -0700 (PDT)
X-Received: by 2002:a2e:b618:: with SMTP id r24mr5955872ljn.48.1623614360273;
 Sun, 13 Jun 2021 12:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Jun 2021 12:59:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com>
Message-ID: <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com>
Subject: Re: [PATCH v1] m68k: save extra registers on sys_exit and
 sys_exit_group syscall entry
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 12, 2021 at 4:38 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> do_exit() calls prace_stop() which may require access to all saved
> registers. We only save those registers not preserved by C code
> currently.
>
> Provide a special syscall entry for exit and exit_group syscalls
> similar to that used by clone and clone3, which have the same
> requirements.

ACK, this looks correct to me.

It might be a good idea to generate a test-case for this - some
"ptrace child, catch exit of it, show registers" kind of thing - just
to show what the effects of the bug was (and to show it's fixed). But
maybe it's not worth the effort.

                  Linus
