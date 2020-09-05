Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9525E77F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgIEMRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 08:17:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIEMRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Sep 2020 08:17:35 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MG9wg-1kMIV72Ozc-00Gce2; Sat, 05 Sep 2020 14:17:33 +0200
Received: by mail-qt1-f172.google.com with SMTP id p65so6809967qtd.2;
        Sat, 05 Sep 2020 05:17:33 -0700 (PDT)
X-Gm-Message-State: AOAM531L3wcOG0kKI10+IDOrURHX6jGF8freQX4aXxv/KULJ02fKf7eu
        Ex9Z9Ut68cOnsf9l+XZ53FM+o58jgR2KV0/BMG8=
X-Google-Smtp-Source: ABdhPJztDqES+QOFNh8+jrK8cS2H3Wi+J6JBSp+Ig7JDd7R2GNL+D5UroPOmdx4gswuUtuIWyBP2UGRMtOCxTAirt/s=
X-Received: by 2002:ac8:5144:: with SMTP id h4mr1539656qtn.18.1599308252303;
 Sat, 05 Sep 2020 05:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165216.1799796-1-hch@lst.de> <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
 <20200905071735.GB13228@lst.de>
In-Reply-To: <20200905071735.GB13228@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 5 Sep 2020 14:17:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a13Xs7-oknJJ0D7HU1+g3fOcaNDr0YgrN-cdv78G5fqiA@mail.gmail.com>
Message-ID: <CAK8P3a13Xs7-oknJJ0D7HU1+g3fOcaNDr0YgrN-cdv78G5fqiA@mail.gmail.com>
Subject: Re: remove set_fs for riscv
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6PjKPuS+5BTBM2o0gbhr40Ls2hOMMTWoos5pqGvQpmmH4OYdXBM
 WLQ+sw4psu3/bkiIeFO2QUI4/5NbBqr1ThvoS06BF2nDB/7tyAObsDShC37CdWBAV/taEJG
 n7EzbPUTQADrfEP2oKaFiopiEpZ73s6xmgH6W/0LdqaBUULby60n6PlpqdPT8bkU8tI8p1A
 pwzrHchuzyrlP/a2/brbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2gEpzGA8Uk8=:+RyuJEb/ZbgqQEOGG+IiU2
 2LxzggBstvz6WFTA7kPKi7mp61nCtyh/1fFPweMh4Z7PeGbZX7z8kSY9hedXYz91rP3tm0Aum
 HE1PbAejKBxSjLZr4QBtJS5bK3uLCXNzIiK4+5pMzLs6Ts4LYtX+5xLVAaZoaVPHrBzQkaUzs
 wBWnIwk7/xLLDNjADf0JMddP/QVPGnKagTpMC02PRQa/ZnRLIKyIPcWlXQZtseUxns/2aGD7u
 pYWCFZ/VZPPyj445pE70jNS3ShyVUw2lm9vG5LtLcwYCh27t1Z68NhN+jIOgGam2ZgUkVNRjT
 9cyzozIXrl/WQdT1k6bDrKmE3kKCVaqiJ/yzVzcEFYrl8tFGWMAbhZY+ChkYxYYglC9grAIc8
 mOyvpzU/TQ/mD+O266ZIMrKKlMEZ6KE/7SlkkOiz+Poizl4lS7uVhTE8unELTipmqYvBv9g/u
 LpwZ1QrK32lUDfP5X09ekBKtnyNaKkeTeTTK0wJmruwxi4RKD+7PRtMvXF3L3lTI9uO8azjGZ
 MK7aVr77kkNtdbo4W5AhtsWgpOybn7MAqriK3CcoCshh07h+Et4YowKymn3MYnwbwjEXLYilO
 8nHQvfwDxDSqsiT3DUoWhAJ/eK9gApLHIkQAXE9ac+f+9s7Nwof2DlMFGEyQXNRcTFswk/F0D
 yC0LM2L7oM+d5vLBZ13eJ4073trm+4z66iQW+J4jj3GxH5QRStZgWx38tjevS97Fc1uauF+c/
 HiqefEaCLMWDjRrbZ3mugu5XSduZmAX4s2URyIw5HZJndOJs9ucr5XFPvOiOPGKRX6MmAu/CX
 Ho3/Ez9MmOJzQKCZqk819Oq7uF3+WLkcZqsMNZRtWXtLoUh5EY4hXaUg/DED/D0TNDgO4Se
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 5, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 04, 2020 at 08:15:03PM +0200, Arnd Bergmann wrote:
> > Is there a bigger plan for the rest? I can probably have a look at the Arm
> > OABI code if nobody else working on that yet.
>
> m68knommu seems mostly trivial and not interact much with m68k/mmu,
> so that woud be my next target.  All the other seems to share more
> code for the mmu and nommu case, so they'd have to be done per arch.

Ok.

> arm would be my first target because it is used widespread, and its
> current set_fs implemenetation is very strange.  But given thar you
> help maintaining arm SOCs and probably know the arch code much better
> than I do I'd be more than happy to leave that to you.

I would start with the syscall wrapper code that just needs a simple
set of changes to pass the arguments on as kernel pointers instead
of fake user pointers.

I'm also not too familiar with the domain handling on older Arm cores,
which I think is the main difference to other architectures. On modern
Armv6+, the set_fs() call is just an assignment to current_thread_info()->
addr_limit like on other architectures, whereas Armv5 and older
rely on special load/store instructions to perform get_user/put_user
as an unprivileged access. Removing set_fs() should allow to clean
that up nicely, but I'd worry about introducing regressions in the
process, and will probably stop short of that cleanup.

     Arnd
