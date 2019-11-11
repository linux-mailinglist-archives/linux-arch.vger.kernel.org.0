Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73CF7239
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKKKeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:34:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKKeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:34:11 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MAOa3-1iawdn3mtn-00BubF; Mon, 11 Nov 2019 11:34:09 +0100
Received: by mail-qk1-f171.google.com with SMTP id m125so10686797qkd.8;
        Mon, 11 Nov 2019 02:34:07 -0800 (PST)
X-Gm-Message-State: APjAAAXBLhPZlSPXhqcGeeCNRdMDtYj7c7RP3FBKTzorNwKWV9N6IY/h
        dsGYRHX/iMu9ieQ2kMEDeVvtcIjaW+7sm+yx5so=
X-Google-Smtp-Source: APXvYqzESzY62F14rsigxKLBXM91nKVjfO+E517KtV1rTG3fdeRCW+MOilAesC4Pz85XDKVkv4qCW/mxeD7p5CII2Ks=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr9320005qkb.138.1573468446947;
 Mon, 11 Nov 2019 02:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-2-hch@lst.de>
In-Reply-To: <20191029064834.23438-2-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:33:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3xk-mQic84Cv7CYhm2DqDCyu69+qH=i8M=JoE3xkpM=g@mail.gmail.com>
Message-ID: <CAK8P3a3xk-mQic84Cv7CYhm2DqDCyu69+qH=i8M=JoE3xkpM=g@mail.gmail.com>
Subject: Re: [PATCH 01/21] arm: remove ioremap_cached
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q7k81wFvoFE5E6wkXe8aVkg4UtIIhdO42eNTJCWF2OH8BAKNIYC
 ktqFVT/gUxHCzKTuvIteocEc6dCMNSblmwTqy1u69ZFn9QjpmWgW6PLcr3ijxS847YwhU+c
 GBYtgFx+LwY4VCvhh4uFz2h42SqTW/LXCUgI6o4ZQqjSZwKNrU2Hv7GTYzJItkd0nVZ06yn
 wJQX7E/0e7Av7MMyGkB9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oR2Ibl1tMpg=:Qch93j4jtU7v7an1WaRtUY
 uQTKMSgbmv0EPsSZPfTgOVFZIWbmvPIEaWQXjS5b3cpXTDONxq3NV1AFL+oCqQR3fYn2G93Pp
 wkFmNZV9cUErVOTSsNMD6c5v3f+lmaJvWvCuYuaQfTESl8FT84aX4OwSgqDkwbp03RC/qRwwd
 cQQgtjfeaSC08MOEdxEE2oCFqW2aNpdpKU8+eX0yMEtdAIfcWVJ4axf1VSY1wycvW3Dj1uUVS
 VCktrzuSKnryj1bRphPhi4P5N9iad/8cLMOMrSWr+cS1WDmwrOztyoB3d8S9+bC+uhkJmpEe7
 EcfZ8jKZP9/DD2n6C979ElHhh8ziwOJF5aCbu9FJ/3Hwccjix+idScCwc95ajahJo34ezl3lP
 EWrM/tGIP3Z1HimZqAorMW6Kd0QIrcoqwfGD5mT9Nnj1PcSurMuSLPyN2b2lT11Qw4p0ww6B+
 oeOcMJ3fbXiNaNzLDWPI87bji3C/R/KY7rBYn5JT0MpO5pM3315Lo0hfT1CpHuMvy/kUOaN/w
 kUJYL9rH7UR0Gs13qvxRBu+Qn5t/8Lp508AYjr+SO4FU4eR3D0c/bl0AXvq1GNfOF0BMPwn9g
 GBMFaNMpAJFF9p6TcCeT6TZK+gEp8bhzkARZyPnpy65YdnXsF7gvEu10r9nhH+RM+kkPrJ/yt
 3DoVsdY8pcVlWdCGz6eIAShOQwEvqzvLEa55zcqxLePkPrh1mYUk2JnAr8OAQp6sfgPU12HHR
 dH54ArhwI5PevKmKQK9Qx+VVtLUKVhXEm+VW2q47zxQaN3TliTK/bJYO0GJKfVqR/esKvLyQg
 2o9ETmvdOIgOoXxzJH6TW/6+NtkBymQJzfxn4BPT2LC5PT4/SAjAvWDWBQjkLmSGfmUGljMCd
 t9k/ZM/dYSmuz8qpNCWdLYv72qTheL6z9GztXaJ1tPMJ396fIiD9u+iOlZKl1/g3gse85yPrx
 isOPo/23/1q/RDLGEpv78pVtJzsJNS0CrsUW3c5uUe/PAMdEfxCPFEerurnYjhlHEMaRzDNOb
 DqZ1WkpzuyGejI8CcALxCNpPVoDWdS4P55/uMZZfngrqEXWbis11Wvy9mUQQiFVYzg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No users of ioremap_cached are left, remove it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
