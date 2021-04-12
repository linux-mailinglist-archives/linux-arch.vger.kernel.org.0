Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF035C323
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbhDLJ5p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 05:57:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbhDLJ4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 05:56:22 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrQR7-1lrm6z072V-00oWTe; Mon, 12 Apr 2021 11:55:58 +0200
Received: by mail-wm1-f48.google.com with SMTP id k128so6426596wmk.4;
        Mon, 12 Apr 2021 02:55:57 -0700 (PDT)
X-Gm-Message-State: AOAM533r1rofXj88LVWJfah19XlDU6BtZ0B1yeutMbGESfkPn1Et7hVf
        AIrdTACXZyzFyre5JlfjGvKg/BUppQ9zoWHcUJU=
X-Google-Smtp-Source: ABdhPJzTfxxaxsVCZqgwljY94HrF+v5FbHKG19HOl8IGqXY6e9UlqBjrbb/hk/qI5QxcbCRl2V2ekh7/KCvv8xos6no=
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr3077982wmi.75.1618221357638;
 Mon, 12 Apr 2021 02:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085545.2595431-1-hch@lst.de> <20210412085545.2595431-2-hch@lst.de>
In-Reply-To: <20210412085545.2595431-2-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Apr 2021 11:55:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MSJarPMfJ8RrSKDMXte3KQec=+GQ-LzV6HB7-Nm1FcQ@mail.gmail.com>
Message-ID: <CAK8P3a2MSJarPMfJ8RrSKDMXte3KQec=+GQ-LzV6HB7-Nm1FcQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64 define
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cQhKiyfxzUY6mYQRHUjOusziZyiZ2ECTHu0hWevLcqyEW8Ur3qo
 MJ8Fmc6YsrzdC+sHyrk/5t1UF52iImlAYS/KBm5dnbPE75XGl9a62cUTIVY5m3X4evCOA9s
 2PYnWr4aV8aDF2PLQJiYCmCQn5kErMbNxRpMCVhJURPr32Xo0oCxjT0IHaHTk3gynHsX3di
 lZdRgN3PWY0Wx8xYimvrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uC/Hyc4Vk1k=:+Wd3nZw1uJebz60gCPd265
 PXuT1mRaIPDr01XZCfSLjAmewK6VGt+vkboVDxrmNWkuNM7WKUT6ekADhcQpoBrtpVFzQ5DaX
 nrI9B/NbsL0qgkd00XB1NrDlteYOhm5HyLTMRIBMsruhea1AhkMqU3su44Tf0wyu1LhJElCkq
 /PTJTE2RF6IKklSSiNT5qHGxCIr7Jj2Z0ZAmbry53T3vSjslalVOdxE173frdOACMogM6gyjU
 dGKkNlN57I71RpJktBuo7y4g8Pc/ighN2BTVnofrcypcvbpAD2p4FunLpmHAWKznh76kAF+Gx
 2oflh5ys6Iv+HqsxCp8tRqS5NR0PXimFoVeJnXND0ZmKAOYixinfgHyhLYwvWnVRxvoFBVgyd
 S6yM5OzdX4Iqy6/vKQ5qbaq0NZEFx5K3TOS7BXqUwe8ZP0FsQwCtkGBnSYhyQByFlgdeEvAf6
 nDi9VMf9r4FwxNWuvrfFhG9Qd3ft5m5x0gg/ru/OPjEWHsYDjnjEOX3+O0SSVeJBK3aQINs7s
 cn8cD6gzO8mMi5kmpU7vOlOutdu0lH/mn/WG6Ga14TqNahfIEt6qlWeV7ZNDYvzVBksgiDrzl
 QHOIymPJGKy1z2A6UHrLeF/i0WmI3wlUUr
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 12, 2021 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch looks good, but I'd like to see a description for each one.
How about:

| The check was added when Stephen Rothwell created the file, but
| no architecture ever defined it.

        Arnd
