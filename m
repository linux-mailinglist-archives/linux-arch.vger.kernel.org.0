Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92D382A0F
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhEQKq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 06:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236273AbhEQKq1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 06:46:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8047761028;
        Mon, 17 May 2021 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621248311;
        bh=MfBhlIm6ttO2xvDas63oVgDfnITP1qZCHrHI4sM+oEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=chyQwoC8q/NtCwZkNBAB/oJENFUdQzdsi/FL4WrkTko3bUjXY8PsHReKxlMUt8xV4
         VcWqWkXBV+3qBelh0O1jFAn4BlN2TdnEvIQ9WX+deZWijhrLkWvAdkyXzBDnF9oS20
         s13p2KAbEqwZtQGy6HcCLyReDdaxS8VvwCb/JRbMHKxsJcRRnvfLh2NNMHM6XTG87y
         EM9gFE1/A+AVvdFESMaopn2Irp0APzWTyBiF11Ic9JjbJITd4dqNMQeNo4R9Y+txEN
         Ar29Xv+KiQOrGSJ0jwdfokAufVd2SXCkkATJSOvZVJLPOdXR4aTHxgq0eX9fjoft0j
         aszM0dYdLoZxQ==
Received: by mail-wr1-f53.google.com with SMTP id d11so5844146wrw.8;
        Mon, 17 May 2021 03:45:11 -0700 (PDT)
X-Gm-Message-State: AOAM533tuvWb+Wp+no8NL5hrp0O05OLIpacXncw8ZicNpUjhu8YoUBAm
        UJiqtqQhaZ9d9C0pMkElzVoxV9Z7H7b3HHV099w=
X-Google-Smtp-Source: ABdhPJydTmJ+TdDoabnzD0bVCQmcH8J9rgJ9iTHN3z/Oaaf0fuuf+kmZkxWd76uWziFDIrctGAy+de2BQK2TxZTjth0=
X-Received: by 2002:adf:e589:: with SMTP id l9mr4904057wrm.361.1621248310197;
 Mon, 17 May 2021 03:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-9-arnd@kernel.org>
 <YKJFRBynJXoFtTyy@infradead.org>
In-Reply-To: <YKJFRBynJXoFtTyy@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 17 May 2021 12:44:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3kEy4SiZV1O3xW-Qzy=DYpJub93K4N8q=MWH8z1G31vQ@mail.gmail.com>
Message-ID: <CAK8P3a3kEy4SiZV1O3xW-Qzy=DYpJub93K4N8q=MWH8z1G31vQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] partitions: msdos: fix one-byte get_unaligned()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17, 2021 at 12:28 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, May 14, 2021 at 12:00:56PM +0200, Arnd Bergmann wrote:
> >  /* Borrowed from msdos.c */
> > -#define SYS_IND(p)           (get_unaligned(&(p)->sys_ind))
> > +#define SYS_IND(p)           ((p)->sys_ind)
>
> Please just kill this macro entirely.
>
> > -#define SYS_IND(p)   get_unaligned(&p->sys_ind)
> > +#define SYS_IND(p)   (p->sys_ind)
>
> Same here.

Done, thanks for taking a look.

       Arnd
