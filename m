Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198853A7951
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOIts (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 04:49:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFOIts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 04:49:48 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MdwRi-1lLfir10Eg-00b5Va; Tue, 15 Jun 2021 10:47:43 +0200
Received: by mail-wm1-f53.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1170424wmh.4;
        Tue, 15 Jun 2021 01:47:43 -0700 (PDT)
X-Gm-Message-State: AOAM5330EjP6WWHsltiDv2xyBKLUHYXumQJ69RM7gt6B5CQR0P9Gueu8
        GK/322yCMRloyydR1dO01cyYQQ54boSikRHb9J8=
X-Google-Smtp-Source: ABdhPJwlOlvyBnTmdbYYrL60W15jGBG2tOZQL5Qf0MNgMdBpE8tHfalX5VQTsaiojZvIPdI3ABttEP6/qcGwH98RFS8=
X-Received: by 2002:a1c:28a:: with SMTP id 132mr2715045wmc.120.1623746862894;
 Tue, 15 Jun 2021 01:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210614153712.313707-1-marcin@juszkiewicz.com.pl> <20210614164454.GC29751@quack2.suse.cz>
In-Reply-To: <20210614164454.GC29751@quack2.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Jun 2021 10:45:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3XbbJ8WnzdsE5f4Uk-O5Z_mBsjc21E6AKuVavvF-_3Cw@mail.gmail.com>
Message-ID: <CAK8P3a3XbbJ8WnzdsE5f4Uk-O5Z_mBsjc21E6AKuVavvF-_3Cw@mail.gmail.com>
Subject: Re: [PATCH] quota: finish disable quotactl_path syscall
To:     Jan Kara <jack@suse.cz>
Cc:     Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KkbO7KzbEuX4jWx+R8lfjIckfLNoYmrZriVAoSBECDqAS6Qw2V4
 Czt9hWtaGxBHVSTq+6fBoVxr7WqCmy8XZRLeC2s14kjAsvmQ83qmCP0t45OQRXNZ4XosLjX
 QHY2ygrefDUekWJpjwg40Nz7g9QIEPtFzXZjQ68XLNYqVep/cBnFFf4OZg5C4pqt72viWBi
 QF9B8iR77171claJHQJ+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0cL1T0iGeE=:q0VTqCjwi2OsH24nZIEnmn
 q5doy+eIaGss//hXX8FMoG+Kun0t6FEZK6WTkd1H0Wkzg6WTJah051KK845DcBkXoAh9z1guK
 hWbrs5Z8o5rlT7UaGl3E0qQQxYE4wvxfTkl8UH2S3SX7S7rtJYjkjZnlYrNowv4JDej29ZbKR
 j+9IvVPLzLzQtGXucju5VAf8MaRhEQlB0mgwzV8udqzPZbB9CcjJDYHFQqYuE9H2npXFcaHX+
 cop+6l1dHCfyOKfgAKyvODVTYwKuX8Sz2fxHYSSsPHs6qp78BBgYIo6Voglh418HHxMzZex4B
 3ypuUybf3bDqg4Qh0KYn43N7h6JG+WIDgvt4A0BN1nktB6sVH5qSoEwgBw4p0T1SWV9IwI0nA
 XfAuohviQDrbAQ6E7IBW+R6bWV78CXglTpeFntTjX2ubvawooyFctzQ/u+oldR+nCZd7pcFFJ
 vLVD/gJE3IpPuwKh+K+h/bCKtlf/3VYr5qiqGIS3LGv9CBu3I9xW0t9dikkUWT3OCoDALUfkd
 SF1gf+De13CJxhATbIWfnB2fA8tmvpoPYuvyrzd/eVMTRVVI0jBjjA6GMMQUgd0tynHbrRyV3
 gJgJ8dvNwWxKkLZYlDoGZ2m6nmzY6f8kuuh9/7eiVEV3QEexE3g6dLZpCjzEceNTBsPeJ/Db/
 pjkU=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 14, 2021 at 6:45 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-06-21 17:37:12, Marcin Juszkiewicz wrote:
> > In commit 5b9fedb31e47 ("quota: Disable quotactl_path syscall") Jan Kara
> > disabled quotactl_path syscall on several architectures.
> >
> > This commit disables it on all architectures using unified list of
> > system calls:
> >
> > - arm64
> > - arc
> > - csky
> > - h8300
> > - hexagon
> > - nds32
> > - nios2
> > - openrisc
> > - riscv (32/64)
> >
> > CC: Jan Kara <jack@suse.cz>
> > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > Link: https://lore.kernel.org/lkml/20210512153621.n5u43jsytbik4yze@wittgenstein
> >
> > Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
>
> Aha, I've missed that one. Thanks for catching this. Arnd, will you take
> this patch or should I take it through my tree?

I don't have any other fixes for 5.13 at the moment, so I would prefer it if
you could pick it up.

       Arnd
