Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02703824B4
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 08:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEQGto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 02:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEQGtn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 02:49:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A53F61263;
        Mon, 17 May 2021 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621234107;
        bh=XwMg9QqAApvxACMmxOXgBWUrqiIh4WJcvsyjh85BX2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJt9dRt9/P1Oeb+0iWbP7PGy1GVoBntHTUDRSoynf/8phrjMncmBI/ggwMFlKlmA4
         uuwdcgFzPVyWcULWZZMV+PDvUGYAtGLZjcJeqxnAGFgXsSTbo1iqNuX9RovAK1NMog
         v5E3xwNbYKKDTqYEhc8XqxdiPvJx8qxsysv0JpQTmDcI5dtqsts3rcOkmicLWGs+LZ
         I3s4EXsVmmEK7pQkyBarkV2O524+ajYdjoiX+3tbSceN1/Ilqa5FIhlDMZxDYnNs2Y
         PSrfMm1aeEIRhIwAaAgAbu/Cnzpc0lWpV5FQ3orgCW60gOeRfFqR8rngxAhVGG2A3o
         DjkPheDPLSvvQ==
Received: by mail-wm1-f46.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so2291803wmk.0;
        Sun, 16 May 2021 23:48:27 -0700 (PDT)
X-Gm-Message-State: AOAM532RZZPvXknPccB4cd5rxOz5vnDZoLCmA5VCYKXE9Gc99hRshzUE
        pMaNQJavMKE/QnzkozRFDRCHfBlsJEQWcZnd4No=
X-Google-Smtp-Source: ABdhPJw5UzE+VLoPtUlE/tArhGvabDH4hlvlXDyeMCoxDrTy/spnQrm/S4VfHzJMMZdGgkigscZIoNK+LsoY0wqM4qk=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr21407803wmj.120.1621234106305;
 Sun, 16 May 2021 23:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-5-arnd@kernel.org>
 <20210517061656.GB23581@lst.de>
In-Reply-To: <20210517061656.GB23581@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 17 May 2021 08:47:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a12HtG7GZHikZa73SbKKr9QhDWgi6BcMwM-W=U1bpewGw@mail.gmail.com>
Message-ID: <CAK8P3a12HtG7GZHikZa73SbKKr9QhDWgi6BcMwM-W=U1bpewGw@mail.gmail.com>
Subject: Re: [PATCH 4/6] [v2] arc: use generic strncpy/strnlen from_user
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
> On Sat, May 15, 2021 at 12:18:01PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Most per-architecture versions of these functions are broken
> > in some form, and they are almost certainly slower than the
> > generic code as well.
> >
> > This version is fairly slow because it always does byte accesses
> > even for aligned data, and its checks for user_addr_max() differ
> > from the generic code.
> >
> > Remove the ones for arc and instead use the generic version.
>
> Same comment as for hexaon before.

Changed now.

     Arnd
