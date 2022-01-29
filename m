Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A944A321C
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 22:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353236AbiA2V4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 16:56:45 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:34565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbiA2V4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 16:56:45 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MdeSn-1meJyd47Qv-00ZjUy; Sat, 29 Jan 2022 22:56:43 +0100
Received: by mail-wr1-f52.google.com with SMTP id k18so17797697wrg.11;
        Sat, 29 Jan 2022 13:56:42 -0800 (PST)
X-Gm-Message-State: AOAM533H7Jxfe5UxlVwj2iHtD1jMaph+hp2F3Aqb4LQG3TJvmjoNbX00
        AtP/OSLlo5qkmsGfse3WdmGyID9FXTvyZiV/BOs=
X-Google-Smtp-Source: ABdhPJwc5Xijmfuq1knxS/SFbXOQYffcGfosuG5ZO2lbKDIA+jheKOcNNo8uA5Z4TCV2skF+ogyeNdBrzcg4f0zq/zU=
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr12082870wrx.407.1643493402481;
 Sat, 29 Jan 2022 13:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-7-guoren@kernel.org>
In-Reply-To: <20220129121728.1079364-7-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Jan 2022 22:56:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_kVB78-26sxdsEjb3MMcco6U55tc7siCBFZbJjyH6Sw@mail.gmail.com>
Message-ID: <CAK8P3a3_kVB78-26sxdsEjb3MMcco6U55tc7siCBFZbJjyH6Sw@mail.gmail.com>
Subject: Re: [PATCH V4 06/17] riscv: compat: Add basic compat date type implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YYSBXlLtAbFyQzNW0wf6OKbJ3b0YrJASgN40CoU0LDTqWouiYSP
 dcaljw+E8B7o/HiUdsnzMTldpqNn86rqxd7ccsbXKXpIHE4WvuZwWj7I8VekzmVj3sUmLfr
 5C40QYJABtwN/MK6gHwQtaXlraboLkAkCSN7rRnF5FeMq4KjreePjgiTncwzFVoa0GYFANb
 YkVdSl0FxaLysUVMukjfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ViFM62Dmg0U=:5XUB1CnQMnTrsqpl1wC/1G
 6+8oLZKBA3nLNphrmN14wBXtE1fcCH4m/8raZKAsX/9oU1iw36TOhuxctP5R/k+jIVHBPX3i6
 4yWCStL6djtGZYm3O4q43n8g8yRC+/aP9ogtStm2H8Faa2/H+AnwPl3PkmRtjE6yPOg8XW8y7
 O4G6+9kwbMnydboeY0VjICaWtyYEX6m919qQztmV9cZUSK98PRAbTtt2Z34Oi/7CSdx3FvB3r
 KjwQimU6C5Oy4Rq6h/bxd2vsJTsNyu8t0SdClVM4OI38ucZANa1RwumyxxvCzdjyusjBL3kY3
 fu9qTLGVvRw9JlspF/DKbuROcdehiSigDBOt4KB+fllKnfajqGSZBh0lDFcO5nZbfgDoCohuf
 Ka61kNd2cVzOgSgzNJe5UWr5hcCCsIiDk+rK68SI1kznpeOM28tzqmgF5BGqRB9iKUaFhGQcz
 NafqowVZvRP8bCWz+DRVYSKa7m4mjRsrTMLMjLR47WCXa/tqjsk+TT0eWtTZPcy/NXLeOhqpj
 ZuS0AyE/BpW4buXcdKxphIsk1cv+zG5UOAQgV2wN8Lf8WHXV2I5nyFUqvV8YiCrSv6135Gu71
 oLyoj9TXEpGlVHZ8JuTieh15Wt20HNjmAfD8CvN/5icxAET7uqN8EL5hpzFu02OmrJEGM604Q
 pI7/NZ3+fIt5sVCVtnpJ+NTBLsbNTWcRyaeVUvbaDqgIe+0RBbN0l9a2l0U0QX7hTFJoHRHjq
 pXjIVm/YwpGKLXnkayl1jXKIMpOJFmk/7geLww0nQdN8S5vNGlEpeVoxAoRpbqB7i09KcmtGJ
 S7FdlsZ0cwY1ake3JHv0vvYxY8/wZpyuOEhNwZf2zUYfni44eg=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 29, 2022 at 1:17 PM <guoren@kernel.org> wrote:
> +
> +#define COMPAT_RLIM_INFINITY   0x7fffffff
>
> +#define F_GETLK64      12
> +#define F_SETLK64      13
> +#define F_SETLKW64     14

These now come from the generic definitions I think. The flock definitions
are just the normal ones, and AFAICT the RLIM_INIFINITY definition here
is actually wrong and should be the default 0xffffffffu to match the
native (~0UL) definition.

            Arnd
