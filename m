Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4839CFB0
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFFPKl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 11:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhFFPKi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 11:10:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C7D46142F;
        Sun,  6 Jun 2021 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622992128;
        bh=AhywmWO1uW2jDKsvU3KSsBf1Kkmtd2FEg+HllYogrIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ajFGntH12SxVgKVVKpzQeZtSpkiTjX/QOPxqJYBiMexhd5GBqSgTszMH8SPS4i6YN
         wgLvCDNsKhQ83MOa9Q0ZTF2sD1n5g9o8qx+95bkODxsQLVnjPZUVIvsTJ1DGNTPktQ
         qRz98HVhIJLcZj1Qbh/SWHQ/lx+QyL2cgOyPXjyVqVMPEeAxSyvPn4B2wVV3h/5Ajc
         +htUD8GYTn8/3GZt+IagSizbjFJTt4L2y7F2UuKYVQO2oI4qwRvEU7fEk16km9GzW6
         HV8cgiXd4fVe8GPdRaW1MijdYbrWgGi6bfdmA6Z/AAGy+sHIi2SOJdykyz/BKKVS4X
         59gXs3u86+qSg==
Received: by mail-lf1-f51.google.com with SMTP id v8so21746168lft.8;
        Sun, 06 Jun 2021 08:08:48 -0700 (PDT)
X-Gm-Message-State: AOAM530Al6rD0bsbKXYaK9jjRIEJGat/I4uyePkpz6H9ulVImDXfMylu
        f2+iQAiLH+Pio+OWE0ixzxI1l7BxqVF3E8uHrD4=
X-Google-Smtp-Source: ABdhPJyN4zk4ZVANOV7l1jrNmtOScbBae+ijxon/C5Plq0iSayaFTJMxmyxUk9u52Aevqlf99inavVPw73IheJW5qYU=
X-Received: by 2002:a05:6512:3f02:: with SMTP id y2mr9426858lfa.355.1622992126503;
 Sun, 06 Jun 2021 08:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-10-git-send-email-guoren@kernel.org> <20210606143941.GA6032@lst.de>
In-Reply-To: <20210606143941.GA6032@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 6 Jun 2021 23:08:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSCqQkVEdGDuc3z_4XpDu0iSX-PZH-kYYUrVCMP7zuYcg@mail.gmail.com>
Message-ID: <CAJF2gTSCqQkVEdGDuc3z_4XpDu0iSX-PZH-kYYUrVCMP7zuYcg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/11] riscv: pgtable: Add DMA_COHERENT with custom
 PTE attributes
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, wens@csie.org,
        maxime@cerno.tech, Drew Fustini <drew@beagleboard.org>,
        liush@allwinnertech.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 6, 2021 at 10:39 PM Christoph Hellwig <hch@lst.de> wrote:
>
> NAK, no SOC must ever mess with pagetable attributes.

I don't think it messes with page table attributes. _PAGE_BASE
contains variable won't cause any problem.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
