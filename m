Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA603824AF
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 08:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhEQGsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 02:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231722AbhEQGs2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 02:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D43261285;
        Mon, 17 May 2021 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621234032;
        bh=pMN6O+M8sQ4Rj/zyx2sQy8ks3b4mlNWVU0NXEn+1Tp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=udvr1+VZ1vu+ehIbXixwtx0wBazcHjD0esq/EvN+f7kI8jiaTkOwJey7z5j9HLcGS
         7grDvd7r5x6/dXjg22Tc6JGuvSInBojF81TaLL3p4+qm2TRZr4l6q2ssJCWgtrJbIt
         b/yGCfMyJd+Xg1i+nGk5iiX3cm2C1hYrQNHIO//zxpRLJTGnWh6b+019jMyRVuTODP
         DtwnQUcRaiTuGt8wL4gql/dF2cv8dL/M/NXP11tF2EXzHGELtzUHZmf/RdLiZCXrHF
         xQxVFvGagUiMeirW4uWfJLAxnc8mpc0VwZK3qW9V5uVKs61R8WbA7jS6nm5xl9S3K3
         6YPJNdeeG1OVQ==
Received: by mail-wr1-f41.google.com with SMTP id j14so3390449wrq.5;
        Sun, 16 May 2021 23:47:12 -0700 (PDT)
X-Gm-Message-State: AOAM531tSYfz3m5/rwqiONJvM+VUu7btT6a7uAlD0KZSDF+Nqotl5S5f
        SaKq1yHZK8O+C4HwZK3ZCAnP1S6ozqLSevdgHhI=
X-Google-Smtp-Source: ABdhPJyrn4xFZhSiNWNYYjvVM2f1w22j28McNwZhsb6mSRFn1AgPXVcsEBX4LdWdWP/IVT2Gb7C9YpHbhQO6YC8l4Aw=
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr11437167wrx.99.1621234030583;
 Sun, 16 May 2021 23:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-4-arnd@kernel.org>
 <20210517061635.GA23581@lst.de>
In-Reply-To: <20210517061635.GA23581@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 17 May 2021 08:46:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a30+Y=9GGjP5ec-h6w9ZLqgzm_4YWpmwRimUjv8NdcuFA@mail.gmail.com>
Message-ID: <CAK8P3a30+Y=9GGjP5ec-h6w9ZLqgzm_4YWpmwRimUjv8NdcuFA@mail.gmail.com>
Subject: Re: [PATCH 3/6] [v2] hexagon: use generic strncpy/strnlen from_user
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17, 2021 at 8:16 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, May 15, 2021 at 12:18:00PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most per-architecture versions of these functions are broken in some form,
> > and they are almost certainly slower than the generic code as well.
> >
> > Remove the ones for hexagon and instead use the generic version.
> > This custom version reads the data twice for strncpy() by doing an extra
> > strnlen(), and it apparently lacks a check for user_addr_max().
>
> I'd be tempted to just remove the first paragraph and reword the second
> as:
>
> Remove the hexagon implementation of strncpy/strnlen and instead use the
> generic versions.  The hexago version of strncpy reads the data twice by
> doing an extra strnlen(), and it apparently lacks a check for
> user_addr_max().

Changed to your version now, thanks!

        Arnd
