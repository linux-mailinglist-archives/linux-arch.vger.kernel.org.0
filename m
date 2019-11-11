Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B191F7186
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKKLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:11:21 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKKLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:11:21 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MY60L-1iOMQt1XnZ-00YS76; Mon, 11 Nov 2019 11:11:18 +0100
Received: by mail-qv1-f49.google.com with SMTP id g12so4612896qvy.12;
        Mon, 11 Nov 2019 02:11:17 -0800 (PST)
X-Gm-Message-State: APjAAAVw0WGVa93bX2rRIm+r96RX/85x++Y6Y+1THc5M39Nr7QXeXTz9
        FNDCsmaP71q+RB31ugbw6lq7BlY3FYpr83v54fA=
X-Google-Smtp-Source: APXvYqyPlYZ0IqFyt+F/Kw+2cGPdhPemO7nTBHjMV2hNTSSGSuWp0EuM7jgO4bHxqVV9VdMKLREBG37EpIWZ8cUBhPs=
X-Received: by 2002:a05:6214:2c2:: with SMTP id g2mr4941532qvu.210.1573467075908;
 Mon, 11 Nov 2019 02:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-18-hch@lst.de>
In-Reply-To: <20191029064834.23438-18-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:10:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0zfmup8DYQQnT3GNCkgcv9cWxejj2QAr+FmYWs46ZuHQ@mail.gmail.com>
Message-ID: <CAK8P3a0zfmup8DYQQnT3GNCkgcv9cWxejj2QAr+FmYWs46ZuHQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] lib: provide a simple generic ioremap implementation
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
X-Provags-ID: V03:K1:Jw6R9MgtvptgNXqV/w46V9xoWHwD8XE4Gouh0J/yWwM5otV+kEB
 7FSvlqisGkXoarQq9FFf3XFSjfP9Khv9CrlcIQDIkUSwECgEvjTVagVGR3QxPZgRg3l/GuQ
 8OUkBeqU9izVWQKnuUGe6AdIB/gzwRuFEcYqOXkH7nn3G2TyXwgwM5Aa+PTWKQRCxiPSwDu
 MOI9JFOzby7qtJJf103xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S8NSDlRnK1o=:vMqksgfFRp2mw5k/tQhbgV
 lcIyqgT3ki2FIY87+u2D27KifRyeL6ThUGNX+z7MhqRBYT30ekG9g9ObGFmZYrNhCLSU5JIi4
 8QegsEKJ++4cbA7zusaA5qWw8EYeM54yokC/uBbDTwNxFoPYBmFIRaDyYRi3sbvoJS0aa7SPu
 EEgGXecEUIb9p2vRpZj76b8gAKvZdxLpHHfgeJfcHQYBvC3xzw6YrQ/I5TLOgAmjswUEWoNVc
 O2E7mq8OsfFcUwB29XiNw4PkDISlajRGQjLPBesn7pMrecfwZXFthvD5s9vCD/FQ9UUVRvi1f
 g95QZpXTUPtqDH/KeUrh734/pxm4boI10A3DlmZNWEQE9kqVGzvtU9yLgzMHW1XfyN60r2NBv
 Dfh804PlU/WAsfEOzP5tPUULYHw3EvRj3cbteSU3mFgTi+OrLrlTgSgdZbDF9anAMzSZ90f6o
 SW6PEJ9IqSwzXQOVUd1YZArqfER7aBrrLblIgay+udsRoWRLP1JlMCNF92ESsTzAA6ZlOMnp2
 XqIfHoPIQ2Gurj1lz0M1nxy4NqswmYl0JPQ11J7XH7X6k4k5kcxPKttsXPL2G1pW/uKAjld17
 e6mFgvd6YLnYn1IHWKaW9aRCy3uXLuaGI9G59UlW2dUyrhwoxn3Pea4l2TZErVFeQx+Cl6EIb
 knSdZ1rCFRdbIW50xX839USHFCSoTk9LxqZQvZPKKNOK7Ttiy7i+/p9M/qUD13TkmQ4ZGl56Q
 EX4wiVhKo9JAU3CFkhOF3rpWiNyy+nxZmyL/rM+3kjfCpTgO5gtyavQJaF4GCfR0c3lYs9+N3
 QDaQTfW5fYZWeGYexqmlIJNk5GRYSgfZQ0ajmBqUxjPZtn/u7CEiY87+wGnf/ANO+Lugo5i1b
 M4G8dKUkBnc1NwtYJFrA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> A lot of architectures reuse the same simple ioremap implementation, so
> start lifting the most simple variant to lib/ioremap.c.  It provides
> ioremap_prot and iounmap, plus a default ioremap that uses prot_noncached,
> although that can be overridden by asm/io.h.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
